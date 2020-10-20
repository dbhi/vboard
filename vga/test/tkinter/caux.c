#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

extern int ghdl_main(int argc, void** argv);

void (*save_screenshot_cb)(int32_t*, uint32_t, uint32_t, int);
void save_screenshot(int32_t *ptr, uint32_t width, uint32_t height, int id) {
  save_screenshot_cb(ptr, width, height, id);
}

void (*sim_cleanup_cb)(void);
void sim_cleanup(void) {
  sim_cleanup_cb();
}

int py_main(
  int argc,
  void** argv,
  void (*fptr_save_screenshot)(int32_t*, uint32_t, uint32_t, int),
  void (*fptr_sim_cleanup)(void)
) {
  printf("fptr_save_screenshot is %p\n", (void*)fptr_save_screenshot);
  assert(fptr_save_screenshot != NULL);
  save_screenshot_cb = fptr_save_screenshot;

  printf("fptr_sim_cleanup is %p\n", (void*)fptr_sim_cleanup);
  assert(fptr_sim_cleanup != NULL);
  sim_cleanup_cb = fptr_sim_cleanup;

  return ghdl_main(argc, argv);
}
