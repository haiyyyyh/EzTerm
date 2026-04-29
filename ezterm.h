/*
* Ezterm的C语言版本, 为兼容C做了小的修改
* header-only, 不预编译, 当前测试兼容度最好的一个方式了
* 用法略有区别, 行为完全相同, 重要说明处注释 **Diff**
*/


#ifndef EZTERM_H
#define EZTERM_H


#ifdef __cplusplus
#error "this is ezterm for C, please use ezterm.cpp at main branch for C++"
#endif


/***************************************************************************
*                                 头文件                                   *
****************************************************************************/


// **Diff** : C头文件
#include <termios.h>     // 用于内核态的终端操作系统调用
#include <unistd.h>      // 用于系统的文件标志符
#include <stdio.h>       // 用于标准IO
#include <stdarg.h>      // 用于可变参数列表
#include <sys/ioctl.h>   // 用于终端设备查询的系统调用
#include <string.h>      // 用于key的序列长度测量的strlen函数
#include <signal.h>      // 用于窗口大小是否改变的监测



// **Diff** : C99及以前没有bool, 给它加上
#if defined (__STDC_VERSION__) && __STDC_VERSION__ < 202311L
#include <stdbool.h>
#endif



/***************************************************************************
*                              终端属性设置                                *
****************************************************************************/

static struct termios _old_termattr_; // 用于恢复终端的初始设置
static bool _term_isinit_ = false; // 记录终端是否已被初始化
static bool _screen_isinit_ = false; // 记录是否开启了虚拟屏幕(initwin才有)


static inline void _put_(const char* _msg, ...);
void refresh();


// 此处的函数，关联终端基本属性设置以及读取，属于即时打印，不会干扰正常输出的字符缓冲流


// 输入阻塞设置
int set_input_timeout(int _ms){
        struct termios _default_attr_;
        int _ret=tcgetattr(STDIN_FILENO, &_default_attr_);
        if(_ret==-1){
                return _ret;
        }
        struct termios _new_attr_=_default_attr_;
        if(_ms==-1){//阻塞的
                _new_attr_.c_cc[VMIN] = 1;
                _new_attr_.c_cc[VTIME] = 0;
        }
        else if(_ms==0){//无阻塞
                _new_attr_.c_cc[VMIN] = 0;
                _new_attr_.c_cc[VTIME] = 0;
        }
        else{//超时
                _new_attr_.c_cc[VMIN] = 0;
                _new_attr_.c_cc[VTIME] = (cc_t)_ms/100;//ms毫秒，VTIME设置为0.1*N秒，进率100
        }
        _ret=tcsetattr(STDIN_FILENO, TCSANOW, &_new_attr_);
        if(_ret==-1){
                return _ret;
        }
        return 0;
}


// 监视窗口大小是否发生改变
static bool _winsize_is_change_;

// 借鉴自vim源码 :-)
static void _sig_winch_(int) {
    // this is not required on all systems, but it doesn't hurt anybody
    signal(SIGWINCH, _sig_winch_);
    _winsize_is_change_ = true;
}

// 注册_sig_winch_回调函数，当SIGWINCH改变时会被调用
static void _set_signals_(void) {
    signal(SIGWINCH, _sig_winch_);
    _winsize_is_change_ = false;
}


int raw(){
        if(_term_isinit_ == true){
                return 0;
        }
        int _ret=tcgetattr(STDIN_FILENO, &_old_termattr_);
        if(_ret==-1){
                return _ret;
        }
        struct termios _new_termattr_ = _old_termattr_;
        /*
        * **Diff** : 
        * // cfmakeraw()    Use of undecleard identifier 'cfmakeraw()'
        * 很遗憾, 与C++版本不同, C并没有这个函数, 所以直接粘贴的实现, 效果相同
        * (依旧参考 https://www.man7.org/linux/man-pages/man3/termios.3.html)
        */
        _new_termattr_.c_iflag &= ~(IGNBRK | BRKINT | PARMRK | ISTRIP | INLCR | IGNCR | ICRNL | IXON);
        _new_termattr_.c_oflag &= ~OPOST;
        _new_termattr_.c_lflag &= ~(ECHO | ECHONL | ICANON | ISIG | IEXTEN);
        _new_termattr_.c_cflag &= ~(CSIZE | PARENB);
        _new_termattr_.c_cflag |= CS8;
        _ret=tcsetattr(STDIN_FILENO, TCSANOW, &_new_termattr_);
        if(_ret==-1){
                return _ret;
        }
        _put_("\033[?1h\033=");      // 开启应用模式（启用功能键）
        _term_isinit_ = true;
        return 0;
}


// 初始化终端
int initwin(){
        int ret = raw();
        if(ret!=0)
                return ret;
        if(_screen_isinit_)
                return 0;
        _put_("\033[?1049h");             // 开启备用缓冲区
        _put_("\033[?25l");               // 默认隐藏光标
        _put_("\033[H");                  // 将光标移到左上角
        _screen_isinit_ = true;
        _set_signals_();  // 注册信号处理函数
        refresh();
        return 0;
}


// 恢复终端属性
void endwin(){
        if(!_term_isinit_){
                return;
        }
        tcsetattr(STDIN_FILENO, TCSANOW, &_old_termattr_);
        if(_screen_isinit_){
                _put_("\033[?1049l");   // 退出备用缓冲区
                _put_("\033[?25h");     // 显示光标
                _put_("\033[?1l\033>"); // 关闭应用模式
                _put_("\033[0m");       // 重置所有颜色和文本样式属性
                // 保险起见终止所有鼠标相关的监听
                _put_("\033[?1000l");
                _put_("\033[?1002l");
                _put_("\033[?1003l");
                _put_("\033[?1006l");
                refresh();
        }
        return;
}


// 得到终端的最大x和y值
static struct winsize _get_term_ws_(){
        //当终端大小更改时，用户会查询终端大小，于是我们可以将标志位置为false
        if(_winsize_is_change_){
                _winsize_is_change_ = false;
        }
        struct winsize _winSZ_;
        //使用标准API查看终端设备属性
        ioctl(STDIN_FILENO, TIOCGWINSZ, &_winSZ_);
        return _winSZ_;
}
unsigned short getsize_y(){
        return _get_term_ws_().ws_row;
}
unsigned short getsize_x(){
        return _get_term_ws_().ws_col;
}
#define getsize_yx(row,col) row=getsize_y(), col=getsize_x()

// 返回终端大小是否更改的标志
bool size_ischange(){
        //用户已经知道了，所以我们将标志位重置
        if(_winsize_is_change_==true){
                _winsize_is_change_=false;
                return true;
        }
        return false;
}


// 得到光标位置
// **Diff**: C没有引用语法, 用指针
void curs_get_yx(int* _cur_row, int* _cur_col){
        char _send_msg[]={"\033[6n"};
        write(STDOUT_FILENO, _send_msg, 4); //向终端发送序列，请求一个表示光标位置的字符串
        char _in_buf_[30]={0};
        read(STDIN_FILENO, _in_buf_, 29); //读取终端返回的序列
        sscanf(_in_buf_, "\033[%d;%dR", _cur_row, _cur_col); //处理终端返回的字符串
}



/***************************************************************************
*                              光标样式和移动                              *
****************************************************************************/

// 是否隐藏光标
void curser_hide(bool _is_hide){
        if(_is_hide){
                _put_("\033[?25l");
        }
        else{
                _put_("\033[?25h");
        }
}

// 光标样式
#define CUR_DEFAULT 0
#define CUR_BLOCK_BLINK 1
#define CUR_BLOCK 2
#define CUR_UNDERLINE_BLINK 3
#define CUR_UNDERLINE 4
#define CUR_LINE_BLINK 5
#define CUR_LINE 6

// 设置光标样式
// @ _style : 使用"CUR_"前缀的宏
void curser_set_style(short _style){
        _put_("\033[%d q", _style);
}


//光标移动
void curs_mv_yx(int _y, int _x){
        _put_("\033[%d;%dH",_y,_x);
}
void curs_mv_up(int _step){
        _put_("\033[%dA",_step);
}
void curs_mv_down(int _step){
        _put_("\033[%dB",_step);
}
void curs_mv_right(int _step){
        _put_("\033[%dC",_step);
}
void curs_mv_left(int _step){
        _put_("\033[%dD",_step);
}

// 全局记录光标还原点是否已有的变量
static bool _curs_position_is_saved_=false;

// 保存光标位置
void curs_yx_save(){
        _put_("\0337");
        _curs_position_is_saved_=true;
}
// 恢复光标位置
void curs_yx_restore(){
        if(_curs_position_is_saved_==false) return;
        _put_("\0338");
        _curs_position_is_saved_=false;
}


/***************************************************************************
*                                屏幕操作                                  *
****************************************************************************/


//临时保存屏幕
void screen_save(){
        _put_("\033[?24h");
}

//恢复之前保存的屏幕
void screen_restore(){
        _put_("\033[?24l");
}

//清除屏幕
void screen_clear_all(){//全部
        _put_("\033[2J");
}
void screen_clear_to_bot(){//光标至左上角
        _put_("\033[0J");
}
void screen_clear_to_top(){//光标至右下角
        _put_("\033[1J");
}

//清除行
void line_clear_all(){//整行
        _put_("\033[2K");
}
void line_clear_to_start(){//光标至开头
        _put_("\033[1K");
}
void line_clear_to_end(){//光标至结尾
        _put_("\033[0K");
}



/***************************************************************************
*                       输出操作(包含核心逻辑和特性)                       *
****************************************************************************/

// 缓冲区逻辑相关函数，核心优化

static char  _out_buffer_[8192];
static int _obuf_write_idx_=0;

static inline void _write_to_buffer_(char* _msg, size_t _length){
        size_t push_ptr=0;
        while(push_ptr < _length){
                // 如果缓冲区满，执行写入操作并归位写指针
                if(_obuf_write_idx_ >= 8192){
                        write(STDOUT_FILENO, _out_buffer_, 8192);
                        _obuf_write_idx_=0;
                }
                // 转义序列保留空间，防止截断，保险起见转义序列大小极限视为31
                else if(*(_msg+push_ptr)=='\033' && _obuf_write_idx_+31 >= 8192){
                        write(STDOUT_FILENO, _out_buffer_, _obuf_write_idx_);
                        _obuf_write_idx_=0;
                }
                *(_out_buffer_+_obuf_write_idx_) = *(_msg+push_ptr);
                _obuf_write_idx_++; push_ptr++;
        }
}

void refresh(){
        write(STDOUT_FILENO, _out_buffer_, _obuf_write_idx_);
        _obuf_write_idx_=0;
}


// 内部的打印函数，职责：高效发送转义序列
static inline void _put_(const char* _msg, ...){
        va_list args;
        va_start(args, _msg);
        char _outbuf_[31];
        ssize_t str_length = vsnprintf(_outbuf_, sizeof(_outbuf_), _msg, args);
        _write_to_buffer_(_outbuf_, str_length);
}


//格式化打印 (打印同时自动向后移动光标)
void printstr(const char* _msg, ...){
        va_list args;
        va_start(args, _msg);
        char _outbuf_[4096];
        ssize_t str_length = vsnprintf(_outbuf_, sizeof(_outbuf_), _msg, args);
        _write_to_buffer_(_outbuf_, str_length);
}

// **Diff**: 和C++不同, C没有函数重载, 由于是移到某个位置打印, 就加了个mv
void mvprintstr(int _y, int _x, const char* _msg, ...){
        _put_("\033[%d;%dH",_y,_x);
        va_list args;
        va_start(args, _msg);
        char _outbuf_[4096];
        ssize_t str_length = vsnprintf(_outbuf_, sizeof(_outbuf_), _msg, args);
        _write_to_buffer_(_outbuf_, str_length);
}


//格式化填充 (打印同时不移动光标)
void addstr(const char* _msg, ...){
        va_list args;
        va_start(args, _msg);
        char _outbuf_[4096];
        ssize_t str_length = vsnprintf(_outbuf_, sizeof(_outbuf_), _msg, args);
        _put_("\0337");// 保存光标位置
        _write_to_buffer_(_outbuf_, str_length);
        _put_("\0338");// 移回
}

// **Diff**: 和C++不同, C没有函数重载, 由于是移到某个位置打印, 就加了个mv
void mvaddstr(int _y, int _x, const char* _msg, ...){
        _put_("\033[%d;%dH",_y,_x);
        va_list args;
        va_start(args, _msg);
        char _outbuf_[4096];
        ssize_t str_length = vsnprintf(_outbuf_, sizeof(_outbuf_), _msg, args);
        _put_("\0337");// 保存光标位置
        _write_to_buffer_(_outbuf_, str_length);
        _put_("\0338");// 移回
}



/***************************************************************************
*                                输入处理                                  *
****************************************************************************/


// 以下，具体见文档

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


// EzTerm中使用ezkey结构体作为按键的数据结构
struct ezkey{
        char _msg[15];
};
struct ezkey getkey(){
        struct ezkey _in_key_;
        ssize_t str_length = read(STDIN_FILENO, _in_key_._msg, 14);
        if(str_length!=-1) _in_key_._msg[str_length]='\0';
        else _in_key_._msg[0]='\0';
        return _in_key_;
}

// **Diff**: C没有运算符重载, 使用此函数替代. C没有引用语法, 用指针
bool key_cmp(const struct ezkey* _in_key, const char* _cmp_msg){//比较符号被重载
        if(strlen(_in_key->_msg) != strlen(_cmp_msg)){
                return false;
        }
        for(int _i=0; _in_key->_msg[_i] != '\0'; _i++){
                if(_in_key->_msg[_i] != _cmp_msg[_i]){
                        return false;
                }
        }
        return true;
}



/***************************************************************************
*                                鼠标事件                                  *
****************************************************************************/


#define LISTEN_CLICK_ONLY 1000         /* 最简单：仅监听点击事件 */
#define LISTEN_CLICK_DRAG 1002         /* 最常用：包含点击和拖拽事件 */
#define LISTEN_CLICK_DRAG_FLOAT 1003   /* 最全：包含点击、拖拽和悬浮滑动事件 */

// 启用鼠标基本事件支持
// @ _support_type : 使用"LISTEN_"前缀的宏
void use_mouse(bool _is_use, short _support_type){
        if(_is_use==false){
                // 保险起见全关掉
                _put_("\033[?1000l");
                _put_("\033[?1002l");
                _put_("\033[?1003l");
                _put_("\033[?1006l");
                return;
        }
        _put_("\033[?%dh", _support_type);
        _put_("\033[?1006h");        // 开启SGR格式序列的鼠标状态上报
        refresh();
}


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
// **Diff**: C没有引用语法, 用指针
int get_mouse_state(struct ezkey* _read_mouse_key, int* _mouse_y, int* _mouse_x){
        // 使用-1作为初始值，如果结束后值还是-1说明解析有问题
        *_mouse_y=-1;
        *_mouse_x=-1;
        int _mouse_msg_type=-1;
        char _last_char_Mm;
        sscanf(_read_mouse_key->_msg ,"\033[<%d;%d;%d%c", &_mouse_msg_type, _mouse_x, _mouse_y, &_last_char_Mm);
        if(_last_char_Mm=='m') _mouse_msg_type+=3;
        return _mouse_msg_type;
}





/***************************************************************************
*                             颜色与字体样式                               *
****************************************************************************/


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


// 文本样式定义
#define STYLE_BOLD 1       /* 加粗 */
#define STYLE_DIM 2        /* 暗淡 */
#define STYLE_ITALIC 3     /* 斜体 */
#define STYLE_UNDERLINE 4  /* 下划线 */
#define STYLE_BLINK 5      /* 闪烁的 */
#define STYLE_REVERSE 7    /* 前景背景反转 */
#define STYLE_HIDE 8       /* 隐藏的 */
#define STYLE_DELETELINE 9 /* 被删除线划掉的 */


// **Diff**: C++版本这里用了一个vector存用户定义的颜色, C中便直接使用结构体ez_color存了


// 新建用户颜色
struct ez_color{
        short _r;
        short _g;
        short _b;
};



// 新建用户颜色，函数返回颜色ID
struct ez_color init_usr_color(short _r, short _g, short _b){
        struct ez_color _new_color_;
        _new_color_._r = _r;
        _new_color_._g = _g;
        _new_color_._b = _b;
        return _new_color_;
}


// 样式设置
// @ _style : 使用"STYLE_"前缀的宏
void attrset_style(short _style, bool _on_off){
        if(_on_off==true){
                _put_("\033[%dm", _style);
        }
        else{
                _put_("\033[2%dm", _style>1 ? _style : 2); // 加粗和暗淡的关闭序列都是22
        }
}

// 使用16颜色设置
// @ _color_front _color_back : 使用"COLOR_"前缀的宏
void attrset_color16(short _color_front, short _color_back){
        _put_("\033[%d;%dm", _color_front, _color_back+10);
}

#define COLOR_NONE -1

// 使用256颜色设置
// @ _color_front _color_back : 256colorID(0~255)，使用宏COLOR_NONE代表不做颜色设置
void attrset_color256(short _color_front, short _color_back){
        if(_color_front!=COLOR_NONE){
                _put_("\033[38;5;%dm", _color_front);
        }
        if(_color_back!=COLOR_NONE){
                _put_("\033[48;5;%dm", _color_back);
        }
}

// **Diff**: 和C++版本不同, 这里用ez_color做为参数, 而非用户颜色ID
// 使用用户自定义颜色设置
// @ _color_front _color_back : color，RGB任意一位为COLOR_NONE(-1)则不做设置
void attrset_color_usr(struct ez_color _usr_color_front, struct ez_color _usr_color_back){
        if(_usr_color_front._r!=COLOR_NONE && _usr_color_front._r!=COLOR_NONE && _usr_color_front._r!=COLOR_NONE){
                _put_("\033[38;2;%d;%d;%dm",
                       _usr_color_front._r, _usr_color_front._g, _usr_color_front._b );
        }
        if(_usr_color_back._r!=COLOR_NONE && _usr_color_back._r!=COLOR_NONE && _usr_color_back._r!=COLOR_NONE){
                _put_("\033[48;2;%d;%d;%dm",
                       _usr_color_back._r, _usr_color_back._g, _usr_color_back._b );
        }
}

// 使用RGB通道值设置
// @ _frontR _frontG _frontB  _backR _backG _backB : 使用通道值，为-1则代表不设置
void attrset_color_usr_rawRGB(short _frontR, short _frontG, short _frontB, short _backR, short _backG, short _backB){
        if(_frontR!=-1 && _frontG!=-1 && _frontB!=-1){
                _put_("\033[38;2;%d;%d;%dm",
                       _frontR, _frontG, _frontB );
        }
        if(_backR!=-1 && _backG!=-1 && _backB!=-1){
                _put_("\033[48;2;%d;%d;%dm",
                       _backR, _backG, _backB );
        }
}

// 重置所有属性（包括颜色和样式）
void attr_reset_all(){
        _put_("\033[0m");
}



/*
* **Diff**: 窗口相关操作被移除
* 原因: unicode不支持, 折行存在错乱情况, 已弃用
*/



#endif



// 仅测试使用
// int main(){
//         initwin();
//         use_mouse(true, LISTEN_CLICK_DRAG);
//         refresh();
//         int x,y;
//         while(1){
//                 struct ezkey key = getkey();
//                 if(key_cmp(&key, KEY_ESC)){
//                         break;
//                 }
//                 get_mouse_state(&key, &y, &x);
//                 mvprintstr(y,x, "@");
//                 refresh();
//         }
//         endwin();
//         return 0;
// }
