#include <cstdio>
#include <cstdlib>
#include <ezterm.h>
#include <vector>
#include <unistd.h>

#define do_for(time) for(auto _ohhhhh_=1; _ohhhhh_<=(time); _ohhhhh_++)
#define I_SIZE_X 19
#define I_SIZE_Y 10
#define I_SIDE_SIZE 9
#define PAD_BORD_WIDTH 4

/*
COLOR_BLACK 30    黑色
COLOR_RED 31      红色
COLOR_GREEN 32    绿色
COLOR_YELLOW 33   黄色
COLOR_BLUE 34     蓝色
COLOR_MAGENTA 35  品红色
COLOR_CYAN 36     青色
COLOR_WHITE 37    白色
*/

// 盘子(包含让自己动的函数)
class plate{

public:
    int mid_x, y;
    int size;

    plate(int x, int _y, int s):
        mid_x(x), y(_y), size(s)
    {
        for(int idx=mid_x-size; idx<=mid_x+size; idx++){
            printstr(y, idx, "█");
        }
        refresh();
    }

    void draw_self(const char* use_ch){
        for(int idx=mid_x-size; idx<=mid_x+size; idx++){
            printstr(y, idx, "%s", use_ch);
        }
    }

    void move_up(){
        draw_self(" ");
        y--;
        draw_self("█");
    }
    void move_down(){
        draw_self(" ");
        y++;
        draw_self("█");
    }
    void move_left(){
        draw_self(" ");
        mid_x--;
        draw_self("█");
    }
    void move_right(){
        draw_self(" ");
        mid_x++;
        draw_self("█");
    }

};


int SPEED;
int SPEED2;


// 使用象形文字：柱子
class I{

public:
    std::vector<plate> has_plate;
    int mid_x, top_y;

    // ┻┃━
    I(int y, int x):
        mid_x(x),top_y(y)
    {
        // 打印柱子的竖线
        for(int idx=0; idx<9; idx++){
            printstr(top_y+idx, mid_x, "┃");
        }
        curs_mv_yx(top_y+9, mid_x-9);
        printstr("━━━━━━━━━┻━━━━━━━━━");
        refresh();
    }
    
    void move_top_plate_to(I& next_I){
        // 从这边柱子拔出来
        do_for(I_SIZE_Y-1 - has_plate.size() + 1){
            attrset_color16(COLOR_BLACK+has_plate.back().size);
            has_plate.back().move_up();
            attr_reset_all();
            printstr(has_plate.back().y+1, mid_x, "┃");
            refresh();
            usleep(SPEED);
        }
        // 侧向移动
        // 如果目标柱子在左侧
        if(next_I.mid_x<mid_x){
            attrset_color16(COLOR_BLACK+has_plate.back().size);
            do_for(mid_x-next_I.mid_x){
                has_plate.back().move_left();
                refresh();
                usleep(SPEED2);
            }
            attr_reset_all();
        }
        // 如果目标柱子在右侧
        else{
            attrset_color16(COLOR_BLACK+has_plate.back().size);
            do_for(next_I.mid_x-mid_x){
                has_plate.back().move_right();
                refresh();
                usleep(SPEED2);
            }
            attr_reset_all();
        }
        // 那边柱子放进去
        has_plate.back().move_down();
        usleep(SPEED);
        do_for(I_SIZE_Y-1 - next_I.has_plate.size()-1){
            attrset_color16(COLOR_BLACK+has_plate.back().size);
            has_plate.back().move_down();
            attr_reset_all();
            printstr(has_plate.back().y-1, next_I.mid_x, "┃");
            refresh();
            usleep(SPEED);
        }
        next_I.has_plate.push_back(has_plate.back());
        next_I.has_plate.back().mid_x=next_I.mid_x;
        has_plate.pop_back();
    }
    
};

void init_plate(I& i, int num){
    if(num==0 || num>8) std::exit(0);
    for(int cou=num; cou>0; cou--){
        attrset_color16(COLOR_BLACK+cou);
        plate p_new(i.mid_x, i.top_y+I_SIZE_Y-1-i.has_plate.size()-1, cou);
        attr_reset_all();
        i.has_plate.push_back(p_new);
    }
}



void func(I& start, I& end, I& mid, int cou_move){
    if(getkey()==KEY_ESC){
        endwin();
        std::exit(0);
    }
    if(cou_move==1){
        start.move_top_plate_to(end);
        return;
    }
    func(start, mid, end, cou_move-1);
    start.move_top_plate_to(end);
    func(mid, end, start, cou_move-1);
    return;
}



int main(){
    const int use_window_size_x=I_SIZE_X*3+4+PAD_BORD_WIDTH*2+2;
    const int use_window_size_y=I_SIZE_Y+2+PAD_BORD_WIDTH*2+2;
    if(getsize_x()<use_window_size_x || getsize_y()<use_window_size_y){
        printf("console too small");
        return 0;
    }
    printf("动作速度(SLEEP时间)：");
    scanf("%d", &SPEED);
    SPEED2=SPEED/2;
    initwin();
    WINDOW* main_window = new_window(1,1, use_window_size_y, use_window_size_x);
    wbox_block(main_window);
    refresh();
    I i1(PAD_BORD_WIDTH+2, PAD_BORD_WIDTH+1+I_SIDE_SIZE+1);
    I i2(i1.top_y, i1.mid_x + I_SIZE_X+1);
    I i3(i2.top_y, i2.mid_x + I_SIZE_X+1);
    init_plate(i1, 8);
    refresh();
    getkey();
    set_input_timeout(0);
    func(i1, i3, i2, i1.has_plate.size());
    set_input_timeout(-1);
    getkey();
    endwin();
    return 0;
}
