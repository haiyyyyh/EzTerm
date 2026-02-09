#include <ezterm.h>

int main(){
  initwin();
  for(short i=0; i<=256; i++){
    attrset_color256(0,i);
    printstr(" ");
  }
  refresh();
  getkey();
  endwin();
}
