/*
* 源码风格:
* 内部函数统一使用双下划线开头
* 内部的全局变量统一使用双下划线开头以及结尾
* 函数参数和将要返回到变量统一使用单下划线开头
* 内部的大型变量（如数组、termios结构体）统一使用单下划线开头和结尾
* 内部的局部变量正常书写
*/


/***************************************************************************
*                                 头文件                                   *
****************************************************************************/


#include <termios.h>     // 用于内核态的终端操作系统调用
#include <unistd.h>      // 用于系统的文件标志符
#include <cstdio>        // 用于标准IO
#include <cstdarg>       // 用于可变参数列表
#include <sys/ioctl.h>   // 用于终端设备查询的系统调用
#include <cstring>       // 用于key的序列长度测量的strlen函数
#include <vector>        // 用于用户颜色对存储的全局数组
#include <csignal>       // 用于窗口大小是否改变的监测





/***************************************************************************
*                              终端属性设置                                *
****************************************************************************/

static termios __old_termattr__;//用于恢复终端的初始设置
static bool __term_isinit__ = false;//记录终端是否已被初始化


static inline void __put(const char* _msg, ...);
void refresh();


// 此处的函数，关联终端基本属性设置以及读取，属于即时打印，不会干扰正常输出的字符缓冲流


// 输入阻塞设置
int set_input_timeout(int _ms){
        termios _default_attr_;
        int _ret=tcgetattr(STDIN_FILENO, &_default_attr_);
        if(_ret==-1){
                return _ret;
        }
        termios _new_attr_=_default_attr_;
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
static bool __winsize_is_change__;

// 借鉴自vim源码 :-)
static void __sig_winch(int) {
    // this is not required on all systems, but it doesn't hurt anybody
    signal(SIGWINCH, __sig_winch);
    __winsize_is_change__ = true;
}

// 注册__sig_winch回调函数，当SIGWINCH改变时会被调用
static void __set_signals(void) {
    signal(SIGWINCH, __sig_winch);
    __winsize_is_change__ = false;
}


// 初始化终端
int initwin(){
        if(__term_isinit__ == true){
                return 0;
        }
        int _ret=tcgetattr(STDIN_FILENO, &__old_termattr__);
        if(_ret==-1){
                return _ret;
        }
        termios _new_termattr_ = __old_termattr__;
        _new_termattr_.c_lflag &= (tcflag_t)~ICANON;  // 关闭行缓冲
        _new_termattr_.c_lflag &= (tcflag_t)~ECHO;    // 不回显
        _new_termattr_.c_lflag &= (tcflag_t)~ISIG;    // 禁用信号标志（Ctrl-C等将被作为普通字符读取）
        _new_termattr_.c_cc[VMIN] = 1;
        _new_termattr_.c_cc[VTIME] = 0;   // 这两行开启默认阻塞输入
        __put("\033[?1049h");             // 开启备用缓冲区
        __put("\033[?25l");               // 默认隐藏光标
        __put("\033[?1h\033=");           // 开启应用模式（统一功能键）,实际发现开不开没遇到区别
        __put("\033[H");                  // 将光标移到左上角
        _ret=tcsetattr(STDIN_FILENO, TCSANOW, &_new_termattr_);
        if(_ret==-1){
                return _ret;
        }
        __set_signals();  // 注册信号处理函数
        __term_isinit__ = true;
        refresh();
        return 0;
}


// 恢复终端属性
void endwin(){
        if(!__term_isinit__){
                return;
        }
        __put("\033[?1049l");
        __put("\033[?25h");
        __put("\033[?1l\033>");
        __put("\033[0m");      // 重置所有颜色和文本样式属性
        // 终止所有鼠标相关的监听
        __put("\033[?1000l");
        __put("\033[?1002l");
        __put("\033[?1003l");
        __put("\033[?1006l");
        tcsetattr(STDIN_FILENO, TCSANOW, &__old_termattr__);
        refresh();
        return;
}


// 得到终端的最大x和y值
static winsize __get_term_ws(){
        //当终端大小更改时，用户会查询终端大小，于是我们可以将标志位置为false
        if(__winsize_is_change__){
                __winsize_is_change__ = false;
        }
        winsize _winSZ_;
        //使用标准API查看终端设备属性
        ioctl(STDIN_FILENO, TIOCGWINSZ, &_winSZ_);
        return _winSZ_;
}
unsigned short getsize_y(){
        return __get_term_ws().ws_row;
}
unsigned short getsize_x(){
        return __get_term_ws().ws_col;
}
#define getsize_yx(row,col) row=getsize_y(), col=getsize_x()

// 返回终端大小是否更改的标志
bool size_ischange(){
        //用户已经知道了，所以我们将标志位重置
        if(__winsize_is_change__==true){
                __winsize_is_change__=false;
                return true;
        }
        return false;
}


// 得到光标位置
void curs_get_yx(int& _cur_row, int& _cur_col){
        char _send_msg[]={"\033[6n"};
        write(STDOUT_FILENO, _send_msg, 4); //向终端发送序列，请求一个表示光标位置的字符串
        char _in_buf_[30]={0};
        read(STDIN_FILENO, _in_buf_, 29); //读取终端返回的序列
        sscanf(_in_buf_, "\033[%d;%dR", &_cur_row, &_cur_col); //处理终端返回的字符串
}



/***************************************************************************
*                              光标样式和移动                              *
****************************************************************************/

// 是否隐藏光标
void curser_hide(bool _is_hide){
        if(_is_hide){
                __put("\033[?25l");
        }
        else{
                __put("\033[?25h");
        }
}

// 光标样式
#define CUR_BLOCK_BLINK 1
#define CUR_BLOCK 2
#define CUR_UNDERLINE_BLINK 3
#define CUR_UNDERLINE 4
#define CUR_LINE_BLINK 5
#define CUR_LINE 6

// 设置光标样式
// @ _style : 使用"CUR_"前缀的宏
void curser_set_style(short _style){
        __put("\033[%d q", _style);
}


//光标移动
void curs_mv_yx(int _y, int _x){
        __put("\033[%d;%dH",_y,_x);
}
void curs_mv_up(int _step){
        __put("\033[%dA",_step);
}
void curs_mv_down(int _step){
        __put("\033[%dB",_step);
}
void curs_mv_right(int _step){
        __put("\033[%dC",_step);
}
void curs_mv_left(int _step){
        __put("\033[%dD",_step);
}

// 全局记录光标还原点是否已有的变量
static bool __curs_position_is_saved=false;

// 保存光标位置
void curs_yx_save(){
        __put("\0337");
        __curs_position_is_saved=true;
}
// 恢复光标位置
void curs_yx_restore(){
        if(__curs_position_is_saved==false) return;
        __put("\0338");
        __curs_position_is_saved=false;
}


/***************************************************************************
*                                屏幕操作                                  *
****************************************************************************/


//临时保存屏幕
void screen_save(){
        __put("\033[?24h");
}

//恢复之前保存的屏幕
void screen_restore(){
        __put("\033[?24l");
}

//清除屏幕
void screen_clear_all(){//全部
        __put("\033[2J");
}
void screen_clear_to_bot(){//光标至左上角
        __put("\033[0J");
}
void screen_clear_to_top(){//光标至右下角
        __put("\033[1J");
}

//清除行
void line_clear_all(){//整行
        __put("\033[2K");
}
void line_clear_to_start(){//光标至开头
        __put("\033[1K");
}
void line_clear_to_end(){//光标至结尾
        __put("\033[0K");
}



/***************************************************************************
*                       输出操作(包含核心逻辑和特性)                       *
****************************************************************************/

// 缓冲区逻辑相关函数，核心优化

static char  __out_buffer__[8192];
static int __obuf_write_idx__=0;

static inline void __write_to_buffer(char* _msg, size_t _length){
        size_t push_ptr=0;
        while(push_ptr < _length){
                // 如果缓冲区满，执行写入操作并归位写指针
                if(__obuf_write_idx__ >= 8192){
                        write(STDOUT_FILENO, __out_buffer__, 8192);
                        __obuf_write_idx__=0;
                }
                // 转义序列保留空间，防止截断，保险起见转义序列大小极限视为31
                else if(*(_msg+push_ptr)=='\033' && __obuf_write_idx__+31 >= 8192){
                        write(STDOUT_FILENO, __out_buffer__, __obuf_write_idx__);
                        __obuf_write_idx__=0;
                }
                *(__out_buffer__+__obuf_write_idx__) = *(_msg+push_ptr);
                __obuf_write_idx__++; push_ptr++;
        }
}

void refresh(){
        write(STDOUT_FILENO, __out_buffer__, __obuf_write_idx__);
        __obuf_write_idx__=0;
}


// 内部的打印函数，职责：高效发送转义序列
static inline void __put(const char* _msg, ...){
        va_list args;
        va_start(args, _msg);
        char _outbuf_[31];
        ssize_t str_length = vsnprintf(_outbuf_, sizeof(_outbuf_), _msg, args);
        __write_to_buffer(_outbuf_, str_length);
}


//格式化打印 (打印同时自动向后移动光标)
void printstr(const char* _msg, ...){
        va_list args;
        va_start(args, _msg);
        char _outbuf_[4096];
        ssize_t str_length = vsnprintf(_outbuf_, sizeof(_outbuf_), _msg, args);
        __write_to_buffer(_outbuf_, str_length);
}

void printstr(int _y, int _x, const char* _msg, ...){
        __put("\033[%d;%dH",_y,_x);
        va_list args;
        va_start(args, _msg);
        char _outbuf_[4096];
        ssize_t str_length = vsnprintf(_outbuf_, sizeof(_outbuf_), _msg, args);
        __write_to_buffer(_outbuf_, str_length);
}


//格式化填充 (打印同时不移动光标)
void addstr(const char* _msg, ...){
        va_list args;
        va_start(args, _msg);
        char _outbuf_[4096];
        ssize_t str_length = vsnprintf(_outbuf_, sizeof(_outbuf_), _msg, args);
        __put("\0337");// 保存光标位置
        __write_to_buffer(_outbuf_, str_length);
        __put("\0338");// 移回
}

void addstr(int _y, int _x, const char* _msg, ...){
        __put("\033[%d;%dH",_y,_x);
        va_list args;
        va_start(args, _msg);
        char _outbuf_[4096];
        ssize_t str_length = vsnprintf(_outbuf_, sizeof(_outbuf_), _msg, args);
        __put("\0337");// 保存光标位置
        __write_to_buffer(_outbuf_, str_length);
        __put("\0338");// 移回
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


// EzTerm中使用key结构体作为按键的数据结构
struct ezkey{
        char _msg[15];
};
ezkey getkey(){
        ezkey _in_key_;
        ssize_t str_length = read(STDIN_FILENO, _in_key_._msg, 14);
        if(str_length!=-1) _in_key_._msg[str_length]='\0';
        else _in_key_._msg[0]='\0';
        return _in_key_;
}

bool operator==(const ezkey& _in_key, char _cmp_msg){//比较符号被重载
        if(strlen(_in_key._msg) != 1)
                return false;
        else if(_in_key._msg[0] != _cmp_msg)
                return false;
        return true;
}
bool operator==(const ezkey& _in_key, const char* _cmp_msg){//比较符号被重载
        if(strlen(_in_key._msg) != strlen(_cmp_msg)){
                return false;
        }
        for(int _i=0; _in_key._msg[_i] != '\0'; _i++){
                if(_in_key._msg[_i] != _cmp_msg[_i]){
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
void use_mouse(bool _is_use, short _support_type=1002){
        if(_is_use==false){
                // 保险起见全关掉
                __put("\033[?1000l");
                __put("\033[?1002l");
                __put("\033[?1003l");
                __put("\033[?1006l");
                return;
        }
        __put("\033[?%dh", _support_type);
        __put("\033[?1006h");        // 开启SGR格式序列的鼠标状态上报
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
int get_mouse_state(ezkey& _read_mouse_key, int& _mouse_y, int& _mouse_x){
        // 使用-1作为初始值，如果结束后值还是-1说明解析有问题
        _mouse_y=-1;
        _mouse_x=-1;
        int _mouse_msg_type=-1;
        char _last_char_Mm;
        sscanf(_read_mouse_key._msg ,"\033[<%d;%d;%d%c", &_mouse_msg_type, &_mouse_x, &_mouse_y, &_last_char_Mm);
        if(_last_char_Mm=='m') _mouse_msg_type+=3;
        return _mouse_msg_type;
}

/*希望通过硬解析提升性能，但由于稳定性等问题暂时弃用*/
// short get_mouse_state(ez_key& _read_mouse_key, short& _mouse_y, short& _mouse_x){
//         // 事件格式校验
//         if(*(_read_mouse_key._msg)!='\033' ||
//            strlen(_read_mouse_key._msg)<=3 ||
//            *(_read_mouse_key._msg+2)!='<'  ||
//            *(_read_mouse_key._msg+1)!='['  )
//         {
//                 return -1;
//         }
//         _mouse_y=0; _mouse_x=0;
//         short _mouse_msg_type=0;
//         char* read_ptr=_read_mouse_key._msg+3;
//         while(*read_ptr != ';'){
//                 _mouse_msg_type = (_mouse_msg_type<<3)+(_mouse_msg_type<<1)/*相当于x10*/ + (*read_ptr-'0');
//                 read_ptr++;
//         }
//         read_ptr++;
//         while(*read_ptr != ';'){
//                 _mouse_x = (_mouse_x<<3)+(_mouse_x<<1) + (*read_ptr-(short)'0');
//                 read_ptr++;
//         }
//         read_ptr++;
//         while(*read_ptr != '\0'){
//                 if(*read_ptr <= '9'){
//                         _mouse_y = (_mouse_y<<3)+(_mouse_y<<1) + (*read_ptr-'0');
//                 }
//                 else if(*read_ptr=='m'){
//                         _mouse_msg_type+=3;
//                         break;
//                 }
//                 read_ptr++;
//         }
//         return _mouse_msg_type;
// }


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


// 新建用户颜色

struct color{
        short _r=0;
        short _g=0;
        short _b=0;
};
static std::vector<color> __usr_color_list__;


// 新建用户颜色，函数返回颜色ID
int init_usr_color(short _r, short _g, short _b){
        color _new_color_;
        _new_color_._r = _r;
        _new_color_._g = _g;
        _new_color_._b = _b;
        __usr_color_list__.push_back(_new_color_);
        int _new_colorID = (int)__usr_color_list__.size()-1;
        return _new_colorID;
}


// 样式设置
// @ _style : 使用"STYLE_"前缀的宏
void attrset_style(short _style, bool _on_off){
        if(_on_off==true){
                __put("\033[%dm", _style);
        }
        else{
                __put("\033[2%dm", _style>1 ? _style : 2); // 加粗和暗淡的关闭序列都是22
        }
}

// 使用16颜色设置
// @ _color_front _color_back : 使用"COLOR_"前缀的宏
void attrset_color16(short _color_front=COLOR_DEFAULT, short _color_back=COLOR_DEFAULT){
        __put("\033[%d;%dm", _color_front, _color_back+10);
}

#define COLOR_NONE -1

// 使用256颜色设置
// @ _color_front _color_back : colorID(0~255)，使用宏COLOR_NONE代表不做颜色设置
void attrset_color256(short _IDfront, short _IDback){
        if(_IDfront!=COLOR_NONE){
                __put("\033[38;5;%dm", _IDfront);
        }
        if(_IDback!=COLOR_NONE){
                __put("\033[48;5;%dm", _IDback);
        }
}
// 使用用户自定义颜色设置
// @ _color_front _color_back : user_color_ID，使用宏COLOR_NONE代表不做颜色设置
void attrset_color_usr(int _usrIDfront, int _usrIDback){
        if(_usrIDfront!=COLOR_NONE){
                __put("\033[38;2;%d;%d;%dm",
                       __usr_color_list__[_usrIDfront]._r, __usr_color_list__[_usrIDfront]._g, __usr_color_list__[_usrIDfront]._b );
        }
        if(_usrIDback!=COLOR_NONE){
                __put("\033[48;2;%d;%d;%dm",
                       __usr_color_list__[_usrIDback]._r, __usr_color_list__[_usrIDback]._g, __usr_color_list__[_usrIDback]._b );
        }
}
// 使用RGB通道值设置
// @ _frontR _frontG _frontB  _backR _backG _backB : 使用通道值，为-1则代表不设置
void attrset_color_usr_rawRGB(short _frontR, short _frontG, short _frontB, short _backR, short _backG, short _backB){
        if(_frontR!=-1 && _frontG!=-1 && _frontB!=-1){
                __put("\033[38;2;%d;%d;%dm",
                       _frontR, _frontG, _frontB );
        }
        if(_backR!=-1 && _backG!=-1 && _backB!=-1){
                __put("\033[48;2;%d;%d;%dm",
                       _backR, _backG, _backB );
        }
}

// 重置所有属性（包括颜色和样式）
void attr_reset_all(){
        __put("\033[0m");
}




/***************************************************************************
*                                窗口逻辑                                  *
****************************************************************************/


struct WINDOW{
        // 大小信息
        int size_y;
        int size_x;
        // 位置信息
        int position_y;
        int position_x;
        // 光标位置信息
        int curs_y = 1;
        int curs_x = 1;
};


// ======================== 窗口创建和销毁 ========================

WINDOW* new_window(int _pos_Y, int _pos_X, int _size_Y, int _size_X){
        int raw_size_y, raw_size_x;
        getsize_yx(raw_size_y, raw_size_x);
        if(_pos_Y<1 || _pos_Y>raw_size_y || _pos_X<1 || _pos_X>raw_size_x){
                return nullptr;
        }
        if(_pos_Y+_size_Y-1 > raw_size_y || _pos_X+_size_X-1 > raw_size_x){
                return nullptr;
        }
        // 申请内存
        WINDOW* _newwin_ptr_=nullptr;
        _newwin_ptr_=new WINDOW;
        // 设置基本信息
        _newwin_ptr_->position_y=_pos_Y;
        _newwin_ptr_->position_x=_pos_X;
        _newwin_ptr_->size_y=_size_Y;
        _newwin_ptr_->size_x=_size_X;
        return _newwin_ptr_;
}
void del_window(WINDOW* _del_win_){
        if(_del_win_==nullptr) return;
        delete(_del_win_);
}


// ======================= 获取窗口基础信息 =======================

int wgetsize_y(WINDOW* _window){
        if(_window == nullptr) return 0;
        return _window->size_y;
}
int wgetsize_x(WINDOW* _window){
        if(_window == nullptr) return 0;
        return _window->size_x;
}
#define wgetsize_yx(_window, _y, _x) (_y)=wgetsize_y((_window)), (_x)=wgetsize((_window))

int wgetcurs_y(WINDOW* _window){
        if(_window == nullptr) return 0;
        return _window->curs_y;
}
int wgetcurs_x(WINDOW* _window){
        if(_window == nullptr) return 0;
        return _window->curs_x;
}
#define wgetcurs_yx(_window, _y, _x) (_y)=wgetcurs_y(_window)), (_x)=wgetcurs_x((_window))

int wget_position_y(WINDOW* _window){
        if(_window == nullptr) return 0;
        return _window->position_y;
}
int wget_position_x(WINDOW* _window){
        if(_window == nullptr) return 0;
        return _window->position_x;
}
#define wget_position_yx(_window, _y, _x) (_y)=wget_position_y(_window)), (_x)=wget_position_x((_window))

// ======================== 窗口光标移动 ========================

void wcurs_mv_yx(WINDOW* _window, int _y, int _x){
        if(_y > _window->size_y) _y = _window->size_y;
        else if(_y <= 0) _y = 1;
        if(_x > _window->size_x) _x = _window->size_x;
        else if(_x <= 0) _x = 1;
        _window->curs_y = _y;
        _window->curs_x = _x;
}

// ========================== 打印功能 ==========================

/*
* 最重要的函数，面向窗口的打印函数的共同内核
* 职责是实现当打印字符串超出窗口时的软换行(softwrap)
* 显然，对于窗口，打印操作开销极其庞大,
* 开发者应尽量使用缓冲等方法，避免频繁的打印
*/
static inline void __print_to_window_use_softwrap(WINDOW* _window, char _outbuf_[], int str_length, int soft_wrap_count){
        // 当触发了软换行，调用此函数
        int line_length;
        line_length = _window->size_x-_window->curs_x+1; // 初始长度为第一行从光标到软换行处(长度出界处前一位)的长度
        int write_idx=0;
        while(soft_wrap_count > 0){
                // 写入一行的内容
                __write_to_buffer(_outbuf_+write_idx, line_length);
                write_idx+=line_length; // 写入指针向后移动，偏移量为line_length
                str_length-=line_length; // 然后str_length中扣除line_length的长度
                // 进行换行
                if(_window->curs_y < _window->size_y){
                        // 当未超出窗口右下角，进行软换行操作
                        _window->curs_y++;
                        _window->curs_x=1;
                        __put("\033[%d;%dH",_window->position_y+_window->curs_y-1, _window->position_x);
                }else{
                        // 强行将光标移到窗口右下角，防止出现无法预测的情况造成格式混乱
                        __put("\033[%d;%dH",_window->position_y+_window->size_y-1, _window->position_x+_window->size_x-1);
                        _window->curs_y=_window->size_y;
                        _window->curs_x=_window->size_x;
                        return; // 然后直接退出即可
                }
                soft_wrap_count--; // 已经执行过一次换行，这个计数变量减一
                // 然后计算下一次循环周期（下一行）的偏移量
                if(soft_wrap_count == 0){
                        // 由于每个循环周期都会从字符串总长度变量中扣除这一行的长度，最后就剩下不到一行到没写入的字符串
                        line_length=str_length;
                        // 写入最后一行内容并退出
                        __write_to_buffer(_outbuf_+write_idx, line_length);
                        // 这里需要移动一下光标
                        _window->curs_x+=line_length;
                        // 再判断一次软换行
                        if(_window->curs_x > _window->size_x){
                                _window->curs_y++;
                                _window->curs_x=1;
                        }
                        break;
                }
                else {
                        line_length=_window->size_x;
                }
        }
}

void wprintstr(WINDOW* _window, const char* _msg, ...){
        if(_window == nullptr) return;
        // 将窗口光标位置映射为物理光标的位置
        __put("\033[%d;%dH", _window->position_y+_window->curs_y-1, _window->position_x+_window->curs_x-1);
        va_list args;
        va_start(args, _msg);
        char _outbuf_[4096];
        int str_length = vsnprintf(_outbuf_, sizeof(_outbuf_), _msg, args);
        // 窗口的软换行——如果输出字符串超出了窗口侧边，将进行软换行
        int soft_wrap_count = (_window->curs_x + str_length - 1) / _window->size_x;
        // 如果未发生软换行，直接打印
        if(soft_wrap_count==0){
                __write_to_buffer(_outbuf_, str_length);
                _window->curs_x+=str_length;
                return; // 退出即可
        }
        // 当打印内容未触发软换行，程序仅会执行到这里即退出，开销依然可控，仅多一次软换行计算和判断
        __print_to_window_use_softwrap(_window, _outbuf_, str_length, soft_wrap_count);
}
void wprintstr(WINDOW* _window, int _y, int _x, const char* _msg, ...){
        if(_window == nullptr) return;
        // 判断是否超出边界
        if(_y > _window->size_y) _y = _window->size_y;
        else if(_y <= 0) _y = 1;
        if(_x > _window->size_x) _x = _window->size_x;
        else if(_x <= 0) _x = 1;
        // 先移动窗口的逻辑光标，然后映射到物理光标的位置
        _window->curs_y = _y;
        _window->curs_x = _x;
        __put("\033[%d;%dH", _window->position_y+_window->curs_y-1, _window->position_x+_window->curs_x-1);
        va_list args;
        va_start(args, _msg);
        char _outbuf_[4096];
        int str_length = vsnprintf(_outbuf_, sizeof(_outbuf_), _msg, args);
        // 窗口的软换行——如果输出字符串超出了窗口侧边，将进行软换行
        int soft_wrap_count = (_window->curs_x + str_length - 1) / _window->size_x;
        // 如果未发生软换行，直接打印然后退出，最小化开销
        if(soft_wrap_count==0){
                __write_to_buffer(_outbuf_, str_length);
                return;
        }
        // 当发生软换行，依旧调用此函数完成打印
        __print_to_window_use_softwrap(_window, _outbuf_, str_length, soft_wrap_count);
}
void waddstr(WINDOW* _window, const char* _msg, ...){
        if(_window == nullptr) return;
        __put("\033[%d;%dH", _window->position_y+_window->curs_y-1, _window->position_x+_window->curs_x-1);
        va_list args;
        va_start(args, _msg);
        char _outbuf_[4096];
        int str_length = vsnprintf(_outbuf_, sizeof(_outbuf_), _msg, args);
        int soft_wrap_count = (_window->curs_x + str_length - 1) / _window->size_x;
        // 仅增加光标位置保存和恢复逻辑，其他代码完全相同
        if(soft_wrap_count==0){
                __put("\0337");// 保存光标位置
                __write_to_buffer(_outbuf_, str_length);
                __put("\0338");// 移回
                return;
        }
        __put("\0337");
        __print_to_window_use_softwrap(_window, _outbuf_, str_length, soft_wrap_count);
        __put("\0338");
}
void waddstr(WINDOW* _window, int _y, int _x, const char* _msg, ...){
        if(_window == nullptr) return;
        // 判断是否超出边界
        if(_y > _window->size_y) _y = _window->size_y;
        else if(_y <= 0) _y = 1;
        if(_x > _window->size_x) _x = _window->size_x;
        else if(_x <= 0) _x = 1;
        // 先设置窗口光标位置
        _window->curs_y = _y;
        _window->curs_x = _x;
        __put("\033[%d;%dH", _window->position_y+_window->curs_y-1, _window->position_x+_window->curs_x-1);
        va_list args;
        va_start(args, _msg);
        char _outbuf_[4096];
        int str_length = vsnprintf(_outbuf_, sizeof(_outbuf_), _msg, args);
        int soft_wrap_count = (_window->curs_x + str_length - 1) / _window->size_x;
        if(soft_wrap_count==0){
                __put("\0337");// 保存光标位置
                __write_to_buffer(_outbuf_, str_length);
                __put("\0338");// 移回
                return;
        }
        __put("\0337");
        __print_to_window_use_softwrap(_window, _outbuf_, str_length, soft_wrap_count);
        __put("\0338");
}


// ========================== 辅助功能 ==========================

// 加边框
void wborder(WINDOW* _window,
             const char* _l_top_corner, const char* _top_edge, const char* _r_top_corner,
             const char* _left_edge,                    const char* _right_edge,
             const char* _l_bot_corner, const char* _bot_edge, const char* _r_bot_corner )
        {
        if(_window == nullptr) return;
        curs_yx_save();
        // 移到左上角
        __put("\033[%d;%dH", _window->position_y, _window->position_x);
        // 绘制上横向边框\033[48;2;%d;%d;%dm
        for(int _idx=0; _idx<_window->size_x; _idx++){
                if(_idx==0) __put("%s", _l_top_corner);
                else if(_idx==_window->size_x-1) __put("%s", _r_top_corner);
                else __put("%s", _top_edge);
        }
        // 绘制侧边框
        for(int _idx=1; _idx<=_window->size_y-2; _idx++){
                // 光标移到左侧边框位置
                __put("\033[%d;%dH", _window->position_y+_idx, _window->position_x);
                __put("%s", _left_edge);
                // 光标移到右侧边框位置
                __put("\033[%dC",_window->size_x-2);
                __put("%s", _right_edge);
        }
        // 移到最后一行开头绘制底部线
        __put("\033[%d;%dH", _window->position_y+_window->size_y-1, _window->position_x);
        for(int _idx=0; _idx<_window->size_x; _idx++){
                if(_idx==0) __put("%s", _l_bot_corner);
                else if(_idx==_window->size_x-1) __put("%s", _r_bot_corner);
                else __put("%s", _bot_edge);
        }
        curs_yx_restore();
}
// 快捷边框
#define wbox_block(_window)  wborder((_window), \
                                "█", "▀", "█", \
                                "█",      "█", \
                                "█", "▄", "█")
#define wbox_line(_window)  wborder((_window), \
                                "┌", "─", "┐", \
                                "│",      "│", \
                                "└", "─", "┘")





// 仅测试使用
// int main(){
//         initwin();
//         use_mouse(true, LISTEN_CLICK_DRAG);
//         refresh();
//         int x,y;
//         while(1){
//                 ez_key key= getkey();
//                 if(key==KEY_ESC){
//                         break;
//                 }
//                 get_mouse_state(key, y,x);
//                 printstr(y,x, "@");
//                 refresh();
//         }
//         endwin();
//         return 0;
// }
