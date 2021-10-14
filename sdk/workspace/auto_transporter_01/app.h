#ifdef __cplusplus
extern "C" {
#endif
#include "stdbool.h"
#include "target_test.h"
#include "ev3api.h"
#include "util.h"

#define MAIN_PRIORITY	5
#define HIGH_PRIORITY	9
#define MID_PRIORITY	10
#define LOW_PRIORITY	11

#ifndef STACK_SIZE
#define	STACK_SIZE	4096
#endif /* STACK_SIZE */

#ifndef TOPPERS_MACRO_ONLY
extern void main_task(intptr_t exinf);
#endif /* TOPPERS_MACRO_ONLY */
#ifdef __cplusplus
}
#endif
