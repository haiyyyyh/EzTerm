// #include <ezterm.h>
#include <ncurses.h>
#include <string>
#include <unistd.h>
#include <iostream>
#include <chrono>

void conv_string_to_char_ptr(std::string _str, char *&_ret) {
    uint len = _str.size();
    _ret = (char *)malloc(sizeof(char) * len + sizeof(char));
    for (int i = 0; i < len; i++) {
        _ret[i] = _str[i];
    }
    _ret[len] = '\0';
}

int nxt(int len, int x){
    return (x + 1) % len;
}

int limit = 1000;

int main(){
    auto start = std::chrono::system_clock::now();
#ifdef EZTERM_H
    initwin();
    int x = getsize_x(), y = getsize_y();
    WINDOW* new_win=new_window(1, 1, y, x);
#else
    initscr();
    int x,y;
    getmaxyx(stdscr, y,x);
#endif
    //build strings
    std::string s = "*        ";
    for(int i = 8; i < x - 2; i++){
        s += s[i - 8];
    }
    s += s;
    char * screens[y - 1];
        for(int i = 0; i < y - 1; i++){
            conv_string_to_char_ptr(s.substr(i, x - 2), screens[i]);
          }
    //loop
    int idx = 0;
    while(idx < limit){
#ifdef EZTERM_H
        for(int i = 0; i < y - 1; i++){
            wprintstr(new_win, i + 2, 2, "%s", screens[nxt(y - 1, idx + i)]);
            // printstr(i+2, 2, "%s", screens[nxt(y-1, idx+1)]);
        }
        refresh();
#else
        for(int i = 0; i < y - 1; i++){
            mvprintw(i + 2, 2, "%s", screens[nxt(y - 1, idx + i)]);
        }
        refresh();
#endif
        idx++;
    }
    endwin();
    auto end = std::chrono::system_clock::now();
    double use_time = std::chrono::duration<double, std::milli>(end - start).count();
    std::cout<<use_time<<"ms";
    return 0;
}
