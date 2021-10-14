#ifndef MY_UNTL_H_
#define MY_UNTL_H_

#include "ev3api.h"

#define STR(var)   #var

extern void clear_f(const int32_t line);
extern void init_f(const char *str);
extern void msg_f(const char *str, int32_t line);
extern void num_f(const int n, int32_t line);
extern void fmt_f(const char* fmt, const int n, int32_t line);

#endif  // MY_UNTL_H_
