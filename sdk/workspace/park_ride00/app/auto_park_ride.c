#include "auto_park_ride.h"

typedef enum {
  INIT,  // モデルでは陽に扱っていない初期化用の状態
  WAITING_FOR_BOARDING,  //  乗車待ち
  TRANSPORTING, // 移動中
  WAITING_FOR_GETTING_OFF, // 降車待ち
  DURING_SIGHTSEEING, // 遊覧中
  MOVING_IN_SPOT, // 観光スポット内移動中
  WAITING_FOR_LEAVING // センター帰還中
} ride_state;
ride_state r_state = INIT;

const char *state_name[] = { "INIT",
  "WAITING_FOR_BOARDING", "TRANSPORTING",
  "WAITING_FOR_GETTING_OFF", "DURING_SIGHTSEEING",
  "MOVING_IN_SPOT", "WAITING_FOR_LEAVING"
};

void auto_park_ride_config(void) {
  line_tracer_config();
  bumper_config();
  seat_config();
  walldetector_config();
}

bool pr_is_entry = true;

void auto_park_ride_transport(void) {
  if( pr_is_entry ) {
    syslog(LOG_NOTICE, "state=%s", state_name[r_state]);
  }
  switch(r_state) {
  case INIT:
    auto_park_ride_config();
    r_state = WAITING_FOR_BOARDING;
    break;
  case WAITING_FOR_BOARDING:
    if( pr_is_entry ) {
      pr_is_entry = false;
      route_reader_read();
    }
    if (seat_passenger_is_seated()) {
      r_state = TRANSPORTING;
      pr_is_entry = true;
    }
    break;
  case TRANSPORTING:
    if( pr_is_entry ) {
      pr_is_entry = false;
    }
    line_tracer_run();
    if (walldetector_is_detected()) {
      char route_data = route_reader_get_data();
      syslog(LOG_NOTICE, "route data=%c", route_data);
      if(route_data == R_SKIP) {
        r_state = MOVING_IN_SPOT;
      } else if(route_data == R_CENTER) {
        r_state = WAITING_FOR_LEAVING;
      } else {
        r_state = WAITING_FOR_GETTING_OFF;
      }
      pr_is_entry = true;
    }
    if( pr_is_entry ) {
      line_tracer_stop();
    }
    break;
  case WAITING_FOR_GETTING_OFF:
    if( pr_is_entry ) {
      pr_is_entry = false;
    }
    if (!seat_passenger_is_seated()) {
      r_state = DURING_SIGHTSEEING;
      pr_is_entry = true;
    }
    break;
  case DURING_SIGHTSEEING:
    if( pr_is_entry ) {
      pr_is_entry = false;
    }
    if (seat_passenger_is_seated()) {
      r_state = MOVING_IN_SPOT;
      pr_is_entry = true;
    }
    break;
  case MOVING_IN_SPOT:
    if( pr_is_entry ) {
      timer_start(12000 * 1000);
      pr_is_entry = false;
    }
    line_tracer_run();
    if (timer_is_timedout()) {
      r_state = TRANSPORTING;
      pr_is_entry = true;
    }
    if( pr_is_entry ) {
      timer_stop();
    }
    break;
  case WAITING_FOR_LEAVING:
    if( pr_is_entry ) {
      pr_is_entry = false;
    }
    if (!seat_passenger_is_seated()) {
      r_state = WAITING_FOR_BOARDING;
      pr_is_entry = true;
    }
    break;
  }
}
