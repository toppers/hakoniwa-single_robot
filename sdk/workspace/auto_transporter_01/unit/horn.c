// horn
#include "horn.h"

void horn_warning(void) {
  const int duration = 100;
  ev3_speaker_set_volume(10);

  for(int i = 0; i < 4; i++) {
    ev3_speaker_play_tone(NOTE_F4, duration); /* ミ */
    dly_tsk(duration);
    ev3_speaker_play_tone(NOTE_C4, duration); /* ド */
    dly_tsk(duration); 
  }
}

void horn_confirmation(void) {
  const int duration = 100;
  ev3_speaker_set_volume(10);

  for(int i = 0; i < 2; i++) {
    ev3_speaker_play_tone(NOTE_C4, duration); /* ド */
    dly_tsk(duration);
    ev3_speaker_play_tone(NOTE_F4, duration); /* ファ */
    dly_tsk(duration);
  }
}

void horn_arrived(void) {
  const int duration = 100;
  ev3_speaker_set_volume(10);

  ev3_speaker_play_tone(NOTE_F4, duration); /* ファ */
  dly_tsk(duration * 3);
  ev3_speaker_play_tone(NOTE_F4, duration * 3 ); /* ファ */
  dly_tsk(duration);
}
