#include <ezterm.h>
// #include <ncurses.h>
#include <chrono>
#include <iostream>

char arr[17];
// 00000000000000000

int main(){
    for(int i=0; i<16; i++){
        arr[i]='0';
    }
    arr[16]='\0';
    auto start = std::chrono::system_clock::now();
#ifdef EZTERM_H
    initwin();
    refresh();
#else
    initscr();
#endif
    for(int s=0; s<=65536; s++){
        arr[15]++;
        for(int i=15; i>0; i--){
            if(arr[i]=='2'){
                arr[i]='0';
                arr[i-1]++;
            }
        }
#ifdef EZTERM_H
        printstr(1, 1, "%s", arr);
        refresh();
#else
        mvprintw(1, 1, "%s", arr);
        refresh();
#endif
    }
    auto end = std::chrono::system_clock::now();
    double use_time = std::chrono::duration<double, std::milli>(end - start).count();
    std::cout<<use_time<<"ms";
    endwin();
    return 0;
}
