#include "app.h"

extern void timer_config(void);
extern void timer_start(int delay_ms);
extern void timer_stop(void);
extern int timer_is_started(void);
extern int timer_is_timedout(void);
