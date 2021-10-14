#include "linemon.h"

const int color_sensor = EV3_PORT_3;
#define LINEMON_THRESHOLD 50
int lm_threshold = LINEMON_THRESHOLD;

void linemon_config(void) {
  ev3_sensor_config(color_sensor, COLOR_SENSOR);
}

bool linemon_is_online(void) {
  return ev3_color_sensor_get_reflect(color_sensor) < LINEMON_THRESHOLD;  
}
