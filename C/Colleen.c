#include <stdio.h>

/*
  10: newline, 34: double quote
*/
void quine() {
  const char *s = "#include <stdio.h>%c%c/*%c  10: newline, 34: double quote%c*/%cvoid quine() {%c  const char *s = %c%s%c;%c  printf(s,10,10,10,10,10,10,34,s,34,10,10,10,10,10,10,10,10,10,10,10);%c}%c%cint main(void) {%c  /*%c    comment in main%c  */%c  quine();%c  return 0;%c}%c";
  printf(s,10,10,10,10,10,10,34,s,34,10,10,10,10,10,10,10,10,10,10,10);
}

int main(void) {
  /*
    comment in main
  */
  quine();
  return 0;
}
