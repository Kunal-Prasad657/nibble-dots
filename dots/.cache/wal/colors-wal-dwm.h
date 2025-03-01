static const char norm_fg[] = "#e7e4e2";
static const char norm_bg[] = "#12100d";
static const char norm_border[] = "#a19f9e";

static const char sel_fg[] = "#e7e4e2";
static const char sel_bg[] = "#ADA0A0";
static const char sel_border[] = "#e7e4e2";

static const char urg_fg[] = "#e7e4e2";
static const char urg_bg[] = "#75A98D";
static const char urg_border[] = "#75A98D";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
