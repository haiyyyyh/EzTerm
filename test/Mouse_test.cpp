#include <ezterm.h>

// 一个鼠标画方块小程序

inline void draw_square(int startx, int starty, int endx, int endy){
    screen_clear_all();
    for(int i=starty; i<=endy; i++){
        for(int j=startx; j<=endx; j++){
            printstr(i,j,"█");
        }
    }
}

int main(){
    initwin();
    use_mouse(true, LISTEN_CLICK_DRAG);
    refresh();
    // int start_y, start_x;
    // bool is_start=false;
    // while(1){
    //     ez_key key=getkey();
    //     if(key==KEY_ESC){
    //         break;
    //     }
    //     int y=0,x=0;
    //     int state=get_mouse_state(key, y,x);
    //     if(is_start==false && state==MOUSE_LEFT_KEY_PRESS){
    //         is_start=true;
    //         start_x=x; start_y=y;
    //         printstr(y,x,"█");
    //         continue;
    //     }
    //     if(state==MOUSE_LEFT_KEY_FREE){
    //         is_start=false;
    //         screen_clear_all();
    //         refresh();
    //         continue;
    //     }
    //     if(state==MOUSE_LEFT_KEY_DRAG){
    //         draw_square(start_x, start_y, x, y);
    //     }
    //     refresh();
    // }
    while(1){
        ezkey key=getkey();
        if(key==KEY_ESC){
            break;
        }
        if(key==' '){
            attr_reset_all();
            screen_clear_all();
            refresh();
            continue;
        }
        if(key==KEY_UP){
            attrset_color_usr_rawRGB(200,200,0, 0,0,0);
            refresh();
        }
        if(key==KEY_DOWN){
            // attrset_color_usr_rawRGB(200,200,0, 0,0,0);
            attr_reset_all();
            refresh();
        }
        int y,x,s;
        s=get_mouse_state(key, y, x);
        if(s==MOUSE_LEFT_KEY_PRESS || s==MOUSE_LEFT_KEY_DRAG){
            printstr(y,x,"█");
            refresh();
            continue;
        }
        if(s==MOUSE_RIGHT_KEY_PRESS || s==MOUSE_RIGHT_KEY_DRAG){
            printstr(y,x, " ");
            refresh();
            continue;
        }
        if(s==MOUSE_MID_KEY_PRESS){
            printstr(1,1,"y=%d, x=%d                 ", y,x);
            refresh();
        }
    }
    endwin();
}
