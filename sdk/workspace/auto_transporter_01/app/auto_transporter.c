#include "auto_transporter.h"

typedef enum { INIT,
  WAIT_FOR_LOADING1,   WAIT_FOR_LOADING2,  TRANSPORTING,
  WAIT_FOR_UNLOADING1, WAIT_FOR_UNLOADING2,
  RETURNING1, RETURNING2, ARRIVED
} porter_state;

static porter_state p_state = INIT;
static bool p_entry = true;

#define ENTRY if(p_entry){p_entry=false;
#define DO }{
#define EVTCHK(f,s) if((f)){p_state=(s);p_entry=true;fmt_f("p_state=%d",p_state,2);}
#define EXIT }if(p_entry){
#define END }

static void auto_transporter_config(void) {
  init_f("auto_transporter");
  walldetector_config();
  line_tracer_config();
  bumper_config();
  carrier_config();
}

void auto_transporter_transport(void) {

  switch(p_state) {
  case INIT:
    ENTRY
      auto_transporter_config();
    DO
    EVTCHK(true,WAIT_FOR_LOADING1)
    EXIT
    END
    break;
  case WAIT_FOR_LOADING1:
    ENTRY
      msg_f("WAIT_FOR_LOADING1:entry",2);
    DO
    EVTCHK(carrier_cargo_is_loaded(),WAIT_FOR_LOADING2)
    EXIT
    END
    break;
  case WAIT_FOR_LOADING2:
    ENTRY
    DO
    EVTCHK(!carrier_cargo_is_loaded(),WAIT_FOR_LOADING1)
    EVTCHK(bumper_is_pushed(),TRANSPORTING)
    EXIT
    END
    break;
  case TRANSPORTING:
    ENTRY
    DO
      line_tracer_run();
    EVTCHK(walldetector_is_detected(),WAIT_FOR_UNLOADING1)
    EXIT
      line_tracer_stop();
    END
    break;
  case WAIT_FOR_UNLOADING1:
    ENTRY
    DO
    EVTCHK(!carrier_cargo_is_loaded(),WAIT_FOR_UNLOADING2)
    EXIT
    END
    break;
  case WAIT_FOR_UNLOADING2:
    ENTRY
    DO
    EVTCHK(bumper_is_pushed(),RETURNING1)
    EXIT
    END
    break;
  case RETURNING1:
    ENTRY
    DO
      line_tracer_run();
    EVTCHK(!walldetector_is_detected(),RETURNING2)
    EXIT
    END
    break;
  case RETURNING2:
    ENTRY
    DO
      line_tracer_run();
    EVTCHK(walldetector_is_detected(),ARRIVED)
    EXIT
      line_tracer_stop();
    END
    break;
  case ARRIVED:
    break;
  }
}
