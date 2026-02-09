#include <ncurses.h>

int main(){
  initscr();
  refresh();
  WINDOW* new_win=newwin(10,20,10,20);
  box(new_win, 0,0);
  mvwprintw(new_win, 4,4,"hello\nworld");
  wrefresh(new_win);
  getch();
  endwin();
  return 0;
}
