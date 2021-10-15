#include "walldetector.h"

const int sonar_sensor = EV3_PORT_4;
#define WD_THRESHOLD 8
int wd_threshold = WD_THRESHOLD;

void walldetector_config(void) {
  ev3_sensor_config(sonar_sensor, ULTRASONIC_SENSOR);
}

bool walldetector_is_detected(void) {
  static int16_t val_old = 0;
  static uint32_t detected = 0;
  static uint32_t detected_old = 0;

  int16_t val = ev3_ultrasonic_sensor_get_distance(sonar_sensor);
  if( val < WD_THRESHOLD ) {
    detected = (detected << 1) | 1;
  } else {
    detected = (detected << 1) | 0;
  }
  if( val_old != val ) {
    fmt_f("dist=%d", val, 4);
  }
  if( detected_old != detected ) {
    fmt_f("detected=%04X", detected, 5);
  }
  val_old = val;
  detected_old = detected;
  return detected;

}
