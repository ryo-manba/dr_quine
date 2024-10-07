#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>

#define SELF "#include <stdio.h>%1$c#include <fcntl.h>%1$c#include <unistd.h>%1$c#include <stdlib.h>%1$c%1$c#define SELF %2$c%3$s%2$c%1$c%1$cint main(void) {%1$c  int i = %4$d;%1$c%1$c#ifdef CHILD%1$c  i--;%1$c#endif%1$c%1$c  if (i < 0) return 0;%1$c%1$c  char filename[20];%1$c  snprintf(filename, sizeof(filename), %2$cSully_%%d.c%2$c, i);%1$c%1$c  int fd = open(filename, O_CREAT | O_WRONLY | O_TRUNC, 0644);%1$c  if (fd < 0) return 1;%1$c  dprintf(fd, SELF, 10, 34, SELF, i);%1$c  close(fd);%1$c%1$c  char exec_name[20];%1$c  snprintf(exec_name, sizeof(exec_name), %2$cSully_%%d%2$c, i);%1$c%1$c  char compile_cmd[128];%1$c  snprintf(compile_cmd, sizeof(compile_cmd), %2$cclang -Wall -Wextra -Werror -D CHILD %%s -o %%s%2$c, filename, exec_name);%1$c  system(compile_cmd);%1$c%1$c  if (i > 0) {%1$c    char execute_cmd[128];%1$c    snprintf(execute_cmd, sizeof(execute_cmd), %2$c./%%s%2$c, exec_name);%1$c    system(execute_cmd);%1$c  }%1$c%1$c  return 0;%1$c}%1$c"

int main(void) {
  int i = 5;

#ifdef CHILD
  i--;
#endif

  if (i < 0) return 0;

  char filename[20];
  snprintf(filename, sizeof(filename), "Sully_%d.c", i);

  int fd = open(filename, O_CREAT | O_WRONLY | O_TRUNC, 0644);
  if (fd < 0) return 1;
  dprintf(fd, SELF, 10, 34, SELF, i);
  close(fd);

  char exec_name[20];
  snprintf(exec_name, sizeof(exec_name), "Sully_%d", i);

  char compile_cmd[128];
  snprintf(compile_cmd, sizeof(compile_cmd), "clang -Wall -Wextra -Werror -D CHILD %s -o %s", filename, exec_name);
  system(compile_cmd);

  if (i > 0) {
    char execute_cmd[128];
    snprintf(execute_cmd, sizeof(execute_cmd), "./%s", exec_name);
    system(execute_cmd);
  }

  return 0;
}
