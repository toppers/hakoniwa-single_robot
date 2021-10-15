#include "app.h"
#include "auto_park_ride.h"

void cyc0(intptr_t exinf) {
  act_tsk(MAIN_TASK);
}

void main_task(intptr_t unused) {
  auto_park_ride_transport();
  ext_tsk();
}
