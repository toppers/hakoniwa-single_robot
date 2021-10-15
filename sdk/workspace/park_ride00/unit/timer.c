#include "timer.h"

static SYSTIM timer_start_count;
static SYSTIM timer_timedout_count;
static SYSTIM timer_current_count;

void timer_config(void) {
}

void timer_start(int delay_ms) {
  get_tim(&timer_start_count);
  timer_timedout_count
    = timer_start_count + (SYSTIM)delay_ms;
}

void timer_stop(void) {
  timer_start_count = (SYSTIM)0;
}

int timer_is_started(void) {
  return ( timer_start_count > (SYSTIM)0 );
}

int timer_is_timedout(void) {
  if( timer_start_count <= 0 ) {
    return 0;
  }

  get_tim(&timer_current_count);
  if( timer_current_count
      >= timer_timedout_count ) {
    return 1;
  } else {
    return 0;
  }
}
