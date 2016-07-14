
#include <pty.h>
#include <printf.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>
#include <stdio.h>

typedef struct {
  char ptyname[64];
  int master;
  int slave;
  char tmp_read;
} uartdpi_t;

void* uartdpi_create(const char *name) {
  uartdpi_t *obj = malloc(sizeof(uartdpi_t));

  struct termios tty;
  cfmakeraw(&tty);
  
  openpty(&obj->master, &obj->slave, 0, &tty, 0);
  int rv = ttyname_r(obj->slave, obj->ptyname, 64);
  (void) rv;
  printf("uartdpi: Create %s for %s\n", obj->ptyname, name);

  fcntl(obj->master, F_SETFL, fcntl(obj->master, F_GETFL, 0) | O_NONBLOCK);
  
  return (void*) obj;
}

int uartdpi_can_read(void* obj) {
  uartdpi_t *dpi = (uartdpi_t*) obj;

  int rv = read(dpi->master, &dpi->tmp_read, 1);
  return (rv == 1);
}

char uartdpi_read(void* obj) {
  uartdpi_t *dpi = (uartdpi_t*) obj;

  return dpi->tmp_read;
}

void uartdpi_write(void* obj, char c) {
  uartdpi_t *dpi = (uartdpi_t*) obj;

  int rv = write(dpi->master, &c, 1);
  (void) rv;
}
