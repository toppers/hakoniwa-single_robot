// SimpleTimer
// include "timer.h" で自分のコードに取り込む

#include "ev3api.h"

SYSTIM timer_start_count;
SYSTIM timer_timedout_count;
SYSTIM timer_current_count;

extern void timer_start(int delay_ms) ;

extern void timer_stop(void);

extern int timer_is_started(void) ;

extern int timer_is_timedout(void);
