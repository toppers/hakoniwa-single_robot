#include "route_reader.h"

/* route data 'S': skip, 'W': whereabouts */
#define STATION_MAX 4
static char route_data[STATION_MAX + 1];
static int pos = 0;

void route_reader_reset(void) {
  pos = 0;
}

void route_reader_read(void) {
  FILE *fp = fopen( "route_data.txt", "r");
  fread(route_data,sizeof(STATION_MAX),1,fp);
  route_data[STATION_MAX] = '\0';
  syslog(LOG_NOTICE, "route_data updated: %s", route_data);
  fclose(fp);
  route_reader_reset();
}

char route_reader_get_data(void) {
  char ret;
  if(0 <= pos && pos < STATION_MAX) {
    ret = route_data[pos];
    pos++;
  } else {
    pos = 0;
    ret = R_CENTER;
  }
  return ret;
}

