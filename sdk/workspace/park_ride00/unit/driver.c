#include "driver.h"

const int left_motor = EV3_PORT_A;
const int right_motor = EV3_PORT_C;

#define DR_POWER 40
int dr_power = DR_POWER;

void driver_config(void) {
  ev3_motor_config(left_motor, LARGE_MOTOR);
  ev3_motor_config(right_motor, LARGE_MOTOR);
}

void driver_turn_left(void) {
  ev3_motor_set_power(left_motor, 0);
  ev3_motor_set_power(right_motor, dr_power);
}

void driver_turn_right(void) {
  ev3_motor_set_power(left_motor, dr_power);
  ev3_motor_set_power(right_motor, 0);
}

void driver_stop(void) {
  ev3_motor_stop(left_motor, true);
  ev3_motor_stop(right_motor, true);
}
