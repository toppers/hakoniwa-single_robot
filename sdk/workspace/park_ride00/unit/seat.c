#include "seat.h"

const int seat_sensor = EV3_PORT_2;

void seat_config(void) {
  ev3_sensor_config(seat_sensor, TOUCH_SENSOR);
}

bool seat_passenger_is_seated(void) {
  return ev3_touch_sensor_is_pressed(seat_sensor);
}
