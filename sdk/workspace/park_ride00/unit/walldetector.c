#include "walldetector.h"

const int sonar_sensor = EV3_PORT_4;
#define WD_THRESHOLD 8
int wd_threshold = WD_THRESHOLD;

void walldetector_config(void) {
  ev3_sensor_config(sonar_sensor, ULTRASONIC_SENSOR);
}

bool walldetector_is_detected(void) {
  static int16_t val_old;
  int16_t val = ev3_ultrasonic_sensor_get_distance(sonar_sensor);
  if( val != val_old ) {
    syslog(LOG_NOTICE, "dist=%d", val);
  }
  val_old = val;
  return val < WD_THRESHOLD;
}
