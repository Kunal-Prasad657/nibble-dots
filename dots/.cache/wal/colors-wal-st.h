const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#12100d", /* black   */
  [1] = "#75A98D", /* red     */
  [2] = "#ADA0A0", /* green   */
  [3] = "#CBB19E", /* yellow  */
  [4] = "#86D69B", /* blue    */
  [5] = "#91E1A2", /* magenta */
  [6] = "#E2D2A2", /* cyan    */
  [7] = "#e7e4e2", /* white   */

  /* 8 bright colors */
  [8]  = "#a19f9e",  /* black   */
  [9]  = "#75A98D",  /* red     */
  [10] = "#ADA0A0", /* green   */
  [11] = "#CBB19E", /* yellow  */
  [12] = "#86D69B", /* blue    */
  [13] = "#91E1A2", /* magenta */
  [14] = "#E2D2A2", /* cyan    */
  [15] = "#e7e4e2", /* white   */

  /* special colors */
  [256] = "#12100d", /* background */
  [257] = "#e7e4e2", /* foreground */
  [258] = "#e7e4e2",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
