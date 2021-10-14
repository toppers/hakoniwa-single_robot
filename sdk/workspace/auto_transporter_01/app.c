#include "app.h"
#include "auto_transporter.h"

void main_task(intptr_t unused) {
  auto_transporter_transport();
  ext_tsk();
}
