#include <ezterm.h>

int main(){
  initwin();
  while(1){
    ezkey key=getkey();
    printstr(1,1,"^[%s          ",key._msg+1);
    refresh();
    if(key==KEY_ESC){
      break;
    }
  }
  endwin();
}
