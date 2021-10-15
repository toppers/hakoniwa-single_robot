#include "carrier.h"

const int carrier_sensor = EV3_PORT_2;

void carrier_config(void) {
  ev3_sensor_config(carrier_sensor, TOUCH_SENSOR);
}

bool carrier_cargo_is_loaded(void) {
  static int val_old = 0;
  int16_t val = ev3_touch_sensor_is_pressed(carrier_sensor);
  if( val_old != val ) {
    fmt_f("carrier=%d", val, 3);
  }
  val_old = val;
  return ev3_touch_sensor_is_pressed(val);
}
