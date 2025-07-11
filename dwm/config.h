#include <X11/XF86keysym.h>
static const int status_mon = 0;   	            // <=-1: follows focused monitor, >=0: static on given mon number
static const int fallback_status_mon = 1;       // fallback monitor when a fullscreen window occupies the previous mon (only when static status is on)
static const unsigned int refresh_rate = 120;
static const unsigned int enable_noborder = 0;
static const unsigned int borderpx  = 1;        // border pixel of windows
static const unsigned int gappx     = 8;       	// gaps between windows
static const unsigned int snap      = 32;       // snap pixel
static const unsigned int systrayonleft = 0;   	// 0: systray in the right corner, >0: systray on left of status text
static const unsigned int systrayspacing = 2;   // systray spacing
static const int systraypinningfailfirst = 1;   // 1: if pinning fails, display systray on the first monitor, False: display systray on the last monitor
static const int showsystray        = 1;     // 0 means no systray
static const int showbar            = 0;     // 0 means no bar
static const int topbar             = 0;     // 0 means bottom bar
static const char *fonts[]          = { "JetBrainsMono Nerd Font:size=13" };
static const char col_bg[]          = "#2c3640";
static const char col_fg[]          = "#818181";
static const char col_red[]         = "#f8fbfd";
static const char col_bg_dim[]      = "#1b1b1b";
static const char *colors[][3]      = {
    /*               fg         bg         border   */
    [SchemeNorm] = { col_fg, col_bg, col_bg_dim },
    [SchemeSel]  = { col_red, col_bg,  col_fg },
}; 

static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[0];
// static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor */
//	{ "Gimp",     NULL,       NULL,       0,            1,           -1 },
//	{ "Firefox",  NULL,       NULL,       1 << 8,       0,           -1 },
// };

// layout(s)
static const float mfact     = 0.55; // factor of master area size [0.05..0.95]
static const int nmaster     = 1;    // number of clients in master area
static const int resizehints = 1;    // 1 means respect size hints in tiled resizals
static const int lockfullscreen = 1; // 1 will force focus on the fullscreen window

 static const Layout layouts[] = {
	// symbol     arrange function
	{ "[]=",      tile },    // first entry is default
	{ "><>",      NULL },    // no layout function means floating behavior
	{ "[M]",      monocle },
};

// key definitions
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

// helper for spawning shell commands in the pre dwm-5.0 fashion
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

// commands
static const char *launchercmd[] = { "rofi", "-show", "drun", NULL };
static const char *termcmd[]  = { "alacritty", NULL };
static const char *up_vol[]   = { "pactl", "set-sink-volume", "@DEFAULT_SINK@", "+5%",   NULL };
static const char *down_vol[] = { "pactl", "set-sink-volume", "@DEFAULT_SINK@", "-5%",   NULL };
static const char *mute_vol[] = { "pactl", "set-sink-mute",   "@DEFAULT_SINK@", "toggle", NULL };
static const char *brighter[] = { "brightnessctl", "set", "1%+", NULL };
static const char *dimmer[]   = { "brightnessctl", "set", "1%-", NULL };
static const char *flamecmd[] = { "flameshot", "gui", NULL };

static const Key keys[] = {
	// modifier                     key        function        argument
	{ 0, XF86XK_MonBrightnessDown,		   spawn,	   {.v = dimmer } },
	{ 0, XF86XK_MonBrightnessUp,		   spawn,	   {.v = brighter } },
	{ 0, XF86XK_AudioMute,			   spawn,	   {.v = mute_vol } },
    	{ 0, XF86XK_AudioLowerVolume,		   spawn,	   {.v = down_vol } },
	{ 0, XF86XK_AudioRaiseVolume,		   spawn,	   {.v = up_vol } },
	{ MODKEY,                       XK_space,  spawn,          {.v = launchercmd} },
	{ MODKEY,                       XK_Return, spawn,          {.v = termcmd} },
	{ MODKEY,                       XK_s,      spawn,   	   {.v = flamecmd } },
	{ MODKEY|ShiftMask,             XK_s,      spawn,          SHCMD("maim -s -u | xclip -selection clipboard -t image/png -i") },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY|ShiftMask,             XK_j,      rotatestack,    {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_k,      rotatestack,    {.i = -1 } },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY,                       XK_c,      killclient,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,             		XK_v, 	   togglefloating, {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },
};

// button definitions
// click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin
static const Button buttons[] = {
	// click                event mask      button          function        argument
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};
