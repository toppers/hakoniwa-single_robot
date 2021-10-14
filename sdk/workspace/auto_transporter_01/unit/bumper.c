#include "bumper.h"

const int bumper_sensor = EV3_PORT_1;

void bumper_config(void) {
  ev3_sensor_config(bumper_sensor, TOUCH_SENSOR);
}

bool bumper_is_pushed(void) {
  return ev3_touch_sensor_is_pressed(bumper_sensor);
}
