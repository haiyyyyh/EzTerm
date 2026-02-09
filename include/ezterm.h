#ifndef EZTERM_H
#define EZTERM_H




// ================================= 终端属性设置相关 =================================

/*********************
*关于终端一些基础设置*
**********************/

// 此处的函数，关联终端基本属性设置以及读取，属于即时打印，不会干扰正常输出的字符缓冲流

//初始化终端
int initwin();
//恢复终端属性
void endwin();
//输入阻塞设置
int set_input_timeout(int _ms);
//得到终端的最大x和y值
unsigned short getsize_y();
unsigned short getsize_x();
#define getsize_yx(row,col) row=getsize_y(), col=getsize_x()
//返回终端大小是否更改的标志
bool size_ischange();



// ===================================== 光标操作 =====================================

/*************************
*包含光标的移动和属性设置*
**************************/

// 是否隐藏光标
void curser_hide(bool _is_hide);

// 光标样式
#define CUR_BLOCK_BLINK 1
#define CUR_BLOCK 2
#define CUR_UNDERLINE_BLINK 3
#define CUR_UNDERLINE 4
#define CUR_LINE_BLINK 5
#define CUR_LINE 6

// 设置光标样式
// @ _style : 使用"CUR_"前缀的宏
void curser_set_style(short _style);

//得到光标位置
void curs_get_yx(int& _cur_row, int& _cur_col);
//光标移动
void curs_mv_yx(int _y, int _x);
void curs_mv_up(int _step);
void curs_mv_down(int _step);
void curs_mv_right(int _step);
void curs_mv_left(int _step);
// 保存光标位置
void curs_yx_save();
// 恢复光标位置
void curs_yx_restore();



// =================================== 终端屏幕操作 ===================================

/***************************
*封装一些物理终端的快捷操作*
****************************/

//临时保存屏幕
void screen_save();
//恢复之前保存的屏幕
void screen_restore();

//清除屏幕
void screen_clear_all();//全部
void screen_clear_to_bot();//光标至左上角
void screen_clear_to_top();//光标至右下角

//清除行
void line_clear_all();//整行
void line_clear_to_start();//光标至开头
void line_clear_to_end();//光标至结尾



// ==================================== 打印输出 ======================================

/****************
*TUI库的核心之一*
*****************/

//刷新缓冲区
void refresh();

//格式化打印 (打印同时自动向后移动光标)
void printstr(const char* _msg, ...);
void printstr(int _y, int _x, const char* _msg, ...);

//格式化填充 (打印同时不移动光标)
void addstr(const char* _msg, ...);
void addstr(int _y, int _x, const char* _msg, ...);



// =================================== 输入事件处理 ===================================

/*******************************************
*包含读取用户输入的功能和按键事件支持			 *
*适配现代PC键盘的字符键,功能键,组合键的识别*
*每个功能键都有自己的ANSI序列					     *
********************************************/

// 以下，具体见文档(源码目录下 doc/KEY.md)
#define KEY_NULL "\0"
#define KEY_ESC "\033"
#define KEY_UP "\033OA"
#define KEY_DOWN "\033OB"
#define KEY_RIGHT "\033OC"
#define KEY_LEFT "\033OD"
#define KEY_HOME "\033OH"
#define KEY_END "\033OF"
#define KEY_INS "\033[2~"
#define KEY_DEL "\033[3~"
#define KEY_PGUP "\033[5~"
#define KEY_PGDN "\033[6~"
#define KEY_F1 "\033OP"
#define KEY_F2 "\033OQ"
#define KEY_F3 "\033OR"
#define KEY_F4 "\033OS"
#define KEY_F5 "\033[15~"
#define KEY_F6 "\033[17~"
#define KEY_F7 "\033[18~"
#define KEY_F8 "\033[19~"
#define KEY_F9 "\033[20~"
#define KEY_F10 "\033[21~"
#define KEY_F11 "\033[23~"
#define KEY_F12 "\033[24~"
#define KEY_SPACE " "
#define KEY_TAB "\t"
#define KEY_SHIFT_TAB "\033[Z"
#define KEY_BACKSPACE "\x7f"
#define KEY_ENTER_UNIX "\n"

// 以Ctrl和Alt为修饰的字符键
#define KEY_ALT(ch) ("\033"#ch)
#define KEY_CTRL(ch) ((ch) & 037)

/***************************
* 几个功能键的修饰键的mod值*
* Shift -> 2               *
* Alt -> 3                 *
* Alt-Shift -> 4           *
* Ctrl -> 5                *
* Ctrl-Alt -> 7            *
* Ctrl-Alt-Shift -> 8      *
* Ctrl-Shift 不受支持      *
***************************/

// 带修饰的功能键
#define COMB_UP(mod) "\033[1;"#mod"A"
#define COMB_DOWN(mod) "\033[1;"#mod"B"
#define COMB_RIGHT(mod) "\033[1;"#mod"C"
#define COMB_LEFT(mod) "\033[1;"#mod"D"
#define COMB_HOME(mod) "\033[1;"#mod"H"
#define COMB_END(mod) "\033[1;"#mod"F"
#define COMB_INS(mod) "\033[2;"#mod"~"
#define COMB_DEL(mod) "\033[3;"#mod"~"
#define COMB_PGUP(mod) "\033[5;"#mod"~"
#define COMB_PGDN(mod) "\033[6;"#mod"~"
#define COMB_F1(mod) "\033[1;"#mod"P"
#define COMB_F2(mod) "\033[1;"#mod"Q"
#define COMB_F3(mod) "\033[1;"#mod"R"
#define COMB_F4(mod) "\033[1;"#mod"S"
#define COMB_F5(mod) "\033[15;"#mod"~"
#define COMB_F6(mod) "\033[17;"#mod"~"
#define COMB_F7(mod) "\033[18;"#mod"~"
#define COMB_F8(mod) "\033[19;"#mod"~"
#define COMB_F9(mod) "\033[20;"#mod"~"
#define COMB_F10(mod) "\033[21;"#mod"~"
#define COMB_F11(mod) "\033[23;"#mod"~"
#define COMB_F12(mod) "\033[24;"#mod"~"

// EzTerm中使用key结构体作为按键的数据结构
struct ezkey{
        char _msg[15];
};
// 读取一个按键
ezkey getkey();
bool operator==(const ezkey& _in_key, char _cmp_msg);//比较符号被重载
bool operator==(const ezkey& _in_key, const char* _cmp_msg);//比较符号被重载



// =================================== 鼠标事件支持 ====================================

/******************************
*鼠标的事件支持, 包括 :       *
*基本: 左击,右击,中键按下,滚轮*
*常用: 左中右键 按下拖拽,滚轮 *
*扩展: 包括无点击,悬浮滑动    *
*******************************/

#define LISTEN_CLICK_ONLY 1000         /* 最简单：仅监听点击事件 */
#define LISTEN_CLICK_DRAG 1002         /* 最常用：包含点击和拖拽事件 */
#define LISTEN_CLICK_DRAG_FLOAT 1003   /* 最全：包含点击、拖拽和悬浮滑动事件 */

// 启用鼠标基本事件支持
// @ _support_type : 使用"LISTEN_"前缀的宏
void use_mouse(bool _is_use, short _support_type=1002);

// 鼠标事件相关宏
#define MOUSE_LEFT_KEY_PRESS 0    /* 鼠标左键按下 */
#define MOUSE_MID_KEY_PRESS 1     /* 鼠标中键按下 */
#define MOUSE_RIGHT_KEY_PRESS 2   /* 鼠标右键按下 */
#define MOUSE_LEFT_KEY_FREE 3     /* 鼠标左键释放 */
#define MOUSE_MID_KEY_FREE 4      /* 鼠标中键释放 */
#define MOUSE_RIGHT_KEY_FREE 5    /* 鼠标右键释放 */
#define MOUSE_LEFT_KEY_DRAG 32    /* 鼠标左键按住拖曳 */
#define MOUSE_MID_KEY_DRAG 33     /* 鼠标中键按住拖曳 */
#define MOUSE_RIGHT_KEY_DRAG 34   /* 鼠标右键按住拖曳 */
#define MOUSE_FLOATING 35         /* 鼠标悬浮滑动 */
#define MOUSE_ROLL_UP 64          /* 鼠标滚轮上滚 */
#define MOUSE_ROLL_DOWN 65        /* 鼠标滚轮下滚 */

// 获取鼠标状态（事件）
// @ return : 返回为"MOUSE_"前缀的宏
int get_mouse_state(ezkey& _read_mouse_key, int& _mouse_y, int& _mouse_x);



// ================================= 颜色与字体样式支持 =================================

// 终端8-16基础色：专有ANSI转义序列输出，受终端主题影响

// 标准8色
#define COLOR_BLACK 30   /* 黑色 */ 
#define COLOR_RED 31     /* 红色 */
#define COLOR_GREEN 32   /* 绿色 */
#define COLOR_YELLOW 33  /* 黄色 */
#define COLOR_BLUE 34    /* 蓝色 */
#define COLOR_MAGENTA 35 /* 品红色 */
#define COLOR_CYAN 36    /* 青色 */
#define COLOR_WHITE 37   /* 白色 */
// 扩展8色
#define COLOR_BRIGHT_BLACK 90    /* 亮黑色 */ 
#define COLOR_BRIGHT_RED 91      /* 亮红色 */
#define COLOR_BRIGHT_GREEN 92    /* 亮绿色 */
#define COLOR_BRIGHT_YELLOW 93   /* 亮黄色 */
#define COLOR_BRIGHT_BLUE 94     /* 亮蓝色 */
#define COLOR_BRIGHT_MAGENTA 95  /* 亮品红色 */
#define COLOR_BRIGHT_CYAN 96     /* 亮青色 */
#define COLOR_BRIGHT_WHITE 97    /* 亮白色 */

#define COLOR_DEFAULT 39 /* 用于重置颜色 */

// 用户颜色结构体
struct color{
        short _r=0;
        short _g=0;
        short _b=0;
};
// 新建用户颜色，函数返回颜色ID
int init_usr_color(short _r, short _g, short _b);

// 使用16颜色设置
// @ _color_front _color_back : 使用"COLOR_"前缀的宏
void attrset_color16(short _color_front=COLOR_DEFAULT, short _color_back=COLOR_DEFAULT);

#define COLOR_NONE -1
// 使用256颜色设置
// @ _color_front _color_back : colorID(0~255)，使用宏COLOR_NONE代表不做颜色设置
void attrset_color256(short _IDfront, short _IDback);

// 使用用户自定义颜色设置
// @ _color_front _color_back : user_color_ID，使用宏NONE代表不做颜色设置
void attrset_color_usr(int _usrIDfront, int _usrIDback);

// 使用RGB通道值设置
// @ _frontR _frontG _frontB  _backR _backG _backB : 使用通道值，为-1则代表不设置
void attrset_color_usr_rawRGB(short _frontR, short _frontG, short _frontB, short _backR, short _backG, short _backB);


// 文本样式定义
#define STYLE_BOLD 1       /* 加粗 */
#define STYLE_DIM 2        /* 暗淡 */
#define STYLE_ITALIC 3     /* 斜体 */
#define STYLE_UNDERLINE 4  /* 下划线 */
#define STYLE_BLINK 5      /* 闪烁的 */
#define STYLE_REVERSE 7    /* 前景背景反转 */
#define STYLE_HIDE 8       /* 隐藏的 */
#define STYLE_DELETELINE 9 /* 被删除线划掉的 */

// 样式设置
// @ _style : 使用"STYLE_"前缀的宏
void attrset_style(short _style, bool _on_off);


// 重置所有属性（包括颜色和样式）
void attr_reset_all();



// ===================================== 窗口逻辑 =====================================

// 窗口结构体的不透明声明
struct WINDOW;

// 新建和销毁窗口
WINDOW* new_window(int _pos_Y, int _pos_X, int _size_Y, int _size_X);
void del_window(WINDOW* _del_win_);

// 得到窗口大小
int wgetsize_y(WINDOW* _window);
int wgetsize_x(WINDOW* _window);
#define wgetsize_yx(_window, _y, _x) (_y)=wgetsize_y((_window)), (_x)=wgetsize((_window))
// 得到窗口光标位置
int wgetcurs_y(WINDOW* _window);
int wgetcurs_x(WINDOW* _window);
#define wgetcurs_yx(_window, _y, _x) (_y)=wgetcurs_y(_window)), (_x)=wgetcurs_x((_window))
// 得到窗口位置(左上角)
int wget_position_y(WINDOW* _window);
int wget_position_x(WINDOW* _window);
#define wget_position_yx(_window, _y, _x) (_y)=wget_position_y(_window)), (_x)=wget_position_x((_window))
// 对于窗口的打印
void wprintstr(WINDOW* _window, const char* _msg, ...);
void wprintstr(WINDOW* _window, int _y, int _x, const char* _msg, ...);
void waddstr(WINDOW* _window, const char* _msg, ...);
void waddstr(WINDOW* _window, int _y, int _x, const char* _msg, ...);
// 加边框
void wborder(WINDOW* _window,
             const char* _l_top_corner, const char* _top_edge, const char* _r_top_corner,
             const char* _left_edge,                    const char* _right_edge,
             const char* _l_bot_corner, const char* _bot_edge, const char* _r_bot_corner );
// 快捷边框
#define wbox_block(_window)  wborder((_window), \
                                "█", "▀", "█", \
                                "█",      "█", \
                                "█", "▄", "█")
#define wbox_line(_window)  wborder((_window), \
                                "┌", "─", "┐", \
                                "│",      "│", \
                                "└", "─", "┘")




#endif
