#include "util.h"

static char buf[50] = {0};

// 演習用のユーティリティ
const int8_t line_height = 20;

// 初期処理用
void init_f(const char *str) {
  // フォントの設定と0行目の表示
  ev3_lcd_set_font(EV3_FONT_MEDIUM);
  ev3_lcd_draw_string(str, 0, 0);
  syslog(LOG_NOTICE, str);
}

/**
 * 引数の行を消去
 * @param line 20ドットごとの行番号（1から5）
 */
void clear_f(const int32_t line) {
  ev3_lcd_fill_rect(0, line * line_height,
                    EV3_LCD_WIDTH, line_height,
                    EV3_LCD_WHITE);
}

/**
 * 行単位で引数の文字列を表示
 * @param str 表示する文字列
 * @param line 20ドットごとの行番号（1から5）
 */
void msg_f(const char *str, int32_t line) {
  clear_f(line);
  ev3_lcd_draw_string(str, 0, line * line_height);
  syslog(LOG_NOTICE, str);
}

/**
 * 行単位で引数の数値を表示
 * @param n 表示する数値
 * @param line 20ドットごとの行番号（1から5）
 */
void num_f(const int n, int32_t line) {
  sprintf(buf, "%d", n);
  clear_f(line);
  ev3_lcd_draw_string(buf, 0, line * line_height);
  syslog(LOG_NOTICE, buf);
}

/**
 * 行単位でコメント付きで引数の数値を表示
 * @param fmt 編集用文字列(１つだけ%dを含められる）
 * @param n 表示する数値
 * @param line 20ドットごとの行番号（1から5）
 */
void fmt_f(const char* fmt, const int n, int32_t line) {
  sprintf(buf, fmt, n);
  clear_f(line);
  ev3_lcd_draw_string(buf, 0, line * line_height);
  syslog(LOG_NOTICE, buf);
}
