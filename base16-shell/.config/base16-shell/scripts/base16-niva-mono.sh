#{
# Shell Color Setup Template
# Chris Kempson (http://chriskempson.com)
#}#!/bin/sh
# Base16 harmonic16 - Shell color setup script
# Jannik Siebert (https://github.com/janniks)

if [ "${TERM%%-*}" = 'linux' ]; then
    # This script doesn't support linux console (use 'vconsole' template instead)
    return 2>/dev/null || exit 0
fi

color00="12/17/19" # Base 00 - Black
color01="3f/56/5c" # Base 08 - Red
color02="5c/3f/56" # Base 0B - Green
color03="46/3f/5c" # Base 0A - Yellow
color04="56/5c/3f" # Base 0D - Blue
color05="3f/5c/46" # Base 0E - Magenta
color06="5c/46/3f" # Base 0C - Cyan
color07="9e/ab/af" # Base 05 - White
color08="50/5f/63" # Base 03 - Bright Black
color09=$color01 # Base 08 - Bright Red
color10=$color02 # Base 0B - Bright Green
color11=$color03 # Base 0A - Bright Yellow
color12=$color04 # Base 0D - Bright Blue
color13=$color05 # Base 0E - Bright Magenta
color14=$color06 # Base 0C - Bright Cyan
color15="db/e1/e3" # Base 07 - Bright White
color16="3f/47/5c" # Base 09
color17="3f/5c/54" # Base 0F
color18="25/2f/31" # Base 01
color19="3a/46/4a" # Base 02
color20="82/91/95" # Base 04
color21="bb/c6/c9" # Base 06
color_foreground="9e/ab/af" # Base 05
color_background="12/17/19" # Base 00
color_cursor="9e/ab/af" # Base 05

if [ -n "$TMUX" ]; then
  # tell tmux to pass the escape sequences through
  # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
  printf_template="\033Ptmux;\033\033]4;%d;rgb:%s\007\033\\"
  printf_template_var="\033Ptmux;\033\033]%d;rgb:%s\007\033\\"
  printf_template_custom="\033Ptmux;\033\033]%s%s\007\033\\"
elif [ "${TERM%%-*}" = "screen" ]; then
  # GNU screen (screen, screen-256color, screen-256color-bce)
  printf_template="\033P\033]4;%d;rgb:%s\007\033\\"
  printf_template_var="\033P\033]%d;rgb:%s\007\033\\"
  printf_template_custom="\033P\033]%s%s\007\033\\"
elif [ -n "${-##*i*}" ]; then
  # non-interactive
  alias printf=/bin/false
else
  printf_template="\033]4;%d;rgb:%s\033\\"
  printf_template_var="\033]%d;rgb:%s\033\\"
  printf_template_custom="\033]%s%s\033\\"
fi

# 16 color space
printf $printf_template 0  $color00
printf $printf_template 1  $color01
printf $printf_template 2  $color02
printf $printf_template 3  $color03
printf $printf_template 4  $color04
printf $printf_template 5  $color05
printf $printf_template 6  $color06
printf $printf_template 7  $color07
printf $printf_template 8  $color08
printf $printf_template 9  $color09
printf $printf_template 10 $color10
printf $printf_template 11 $color11
printf $printf_template 12 $color12
printf $printf_template 13 $color13
printf $printf_template 14 $color14
printf $printf_template 15 $color15

# 256 color space
printf $printf_template 16 $color16
printf $printf_template 17 $color17
printf $printf_template 18 $color18
printf $printf_template 19 $color19
printf $printf_template 20 $color20
printf $printf_template 21 $color21

# foreground / background / cursor color
if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  printf $printf_template_custom Pg 9eabaf # forground
  printf $printf_template_custom Ph 121719 # background
  printf $printf_template_custom Pi 9eabaf # bold color
  printf $printf_template_custom Pj 3a464a # selection color
  printf $printf_template_custom Pk 9eabaf # selected text color
  printf $printf_template_custom Pl 9eabaf # cursor
  printf $printf_template_custom Pm 121719 # cursor text
else
  printf $printf_template_var 10 $color_foreground
  printf $printf_template_var 11 $color_background
  printf $printf_template_custom 12 ";7" # cursor (reverse video)
fi

# clean up
unset printf_template
unset printf_template_var
unset color00
unset color01
unset color02
unset color03
unset color04
unset color05
unset color06
unset color07
unset color08
unset color09
unset color10
unset color11
unset color12
unset color13
unset color14
unset color15
unset color16
unset color17
unset color18
unset color19
unset color20
unset color21
unset color_foreground
unset color_background
unset color_cursor

#{
# Shell Color Setup Template
# Chris Kempson (http://chriskempson.com)
#}#!/bin/sh
# Base16 harmonic16 - Shell color setup script
# Jannik Siebert (https://github.com/janniks)

if [ "${TERM%%-*}" = 'linux' ]; then
    # This script doesn't support linux console (use 'vconsole' template instead)
    return 2>/dev/null || exit 0
fi

color00="01/0a/10" # Base 00 - Black
color01="f0/f4/f7" # Base 08 - Red
color02="f7/f0/f4" # Base 0B - Green
color03="f3/f0/f7" # Base 0A - Yellow
color04="f4/f7/f0" # Base 0D - Blue
color05="f0/f7/f3" # Base 0E - Magenta
color06="f7/f3/f0" # Base 0C - Cyan
color07="47/6b/86" # Base 05 - White
color08="13/2f/45" # Base 03 - Bright Black
color09=$color01 # Base 08 - Bright Red
color10=$color02 # Base 0B - Bright Green
color11=$color03 # Base 0A - Bright Yellow
color12=$color04 # Base 0D - Bright Blue
color13=$color05 # Base 0E - Bright Magenta
color14=$color06 # Base 0C - Bright Cyan
color15="93/ae/c2" # Base 07 - Bright White
color16="f0/f0/f7" # Base 09
color17="f0/f7/f7" # Base 0F
color18="04/15/21" # Base 01
color19="0a/21/33" # Base 02
color20="30/53/6f" # Base 04
color21="66/87/a1" # Base 06
color_foreground="47/6b/86" # Base 05
color_background="01/0a/10" # Base 00
color_cursor="47/6b/86" # Base 05

if [ -n "$TMUX" ]; then
  # tell tmux to pass the escape sequences through
  # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
  printf_template="\033Ptmux;\033\033]4;%d;rgb:%s\007\033\\"
  printf_template_var="\033Ptmux;\033\033]%d;rgb:%s\007\033\\"
  printf_template_custom="\033Ptmux;\033\033]%s%s\007\033\\"
elif [ "${TERM%%-*}" = "screen" ]; then
  # GNU screen (screen, screen-256color, screen-256color-bce)
  printf_template="\033P\033]4;%d;rgb:%s\007\033\\"
  printf_template_var="\033P\033]%d;rgb:%s\007\033\\"
  printf_template_custom="\033P\033]%s%s\007\033\\"
elif [ -n "${-##*i*}" ]; then
  # non-interactive
  alias printf=/bin/false
else
  printf_template="\033]4;%d;rgb:%s\033\\"
  printf_template_var="\033]%d;rgb:%s\033\\"
  printf_template_custom="\033]%s%s\033\\"
fi

# 16 color space
printf $printf_template 0  $color00
printf $printf_template 1  $color01
printf $printf_template 2  $color02
printf $printf_template 3  $color03
printf $printf_template 4  $color04
printf $printf_template 5  $color05
printf $printf_template 6  $color06
printf $printf_template 7  $color07
printf $printf_template 8  $color08
printf $printf_template 9  $color09
printf $printf_template 10 $color10
printf $printf_template 11 $color11
printf $printf_template 12 $color12
printf $printf_template 13 $color13
printf $printf_template 14 $color14
printf $printf_template 15 $color15

# 256 color space
printf $printf_template 16 $color16
printf $printf_template 17 $color17
printf $printf_template 18 $color18
printf $printf_template 19 $color19
printf $printf_template 20 $color20
printf $printf_template 21 $color21

# foreground / background / cursor color
if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  printf $printf_template_custom Pg 476b86 # forground
  printf $printf_template_custom Ph 010a10 # background
  printf $printf_template_custom Pi 476b86 # bold color
  printf $printf_template_custom Pj 0a2133 # selection color
  printf $printf_template_custom Pk 476b86 # selected text color
  printf $printf_template_custom Pl 476b86 # cursor
  printf $printf_template_custom Pm 010a10 # cursor text
else
  printf $printf_template_var 10 $color_foreground
  printf $printf_template_var 11 $color_background
  printf $printf_template_custom 12 ";7" # cursor (reverse video)
fi

# clean up
unset printf_template
unset printf_template_var
unset color00
unset color01
unset color02
unset color03
unset color04
unset color05
unset color06
unset color07
unset color08
unset color09
unset color10
unset color11
unset color12
unset color13
unset color14
unset color15
unset color16
unset color17
unset color18
unset color19
unset color20
unset color21
unset color_foreground
unset color_background
unset color_cursor

#{
# Shell Color Setup Template
# Chris Kempson (http://chriskempson.com)
#}#!/bin/sh
# Base16 harmonic16 - Shell color setup script
# Jannik Siebert (https://github.com/janniks)

if [ "${TERM%%-*}" = 'linux' ]; then
    # This script doesn't support linux console (use 'vconsole' template instead)
    return 2>/dev/null || exit 0
fi

color00="10/08/01" # Base 00 - Black
color01="72/8c/a1" # Base 08 - Red
color02="a1/72/8c" # Base 0B - Green
color03="86/72/a1" # Base 0A - Yellow
color04="8c/a1/72" # Base 0D - Blue
color05="72/a1/86" # Base 0E - Magenta
color06="a1/86/72" # Base 0C - Cyan
color07="47/6b/86" # Base 05 - White
color08="45/29/13" # Base 03 - Bright Black
color09=$color01 # Base 08 - Bright Red
color10=$color02 # Base 0B - Bright Green
color11=$color03 # Base 0A - Bright Yellow
color12=$color04 # Base 0D - Bright Blue
color13=$color05 # Base 0E - Bright Magenta
color14=$color06 # Base 0C - Bright Cyan
color15="93/ae/c2" # Base 07 - Bright White
color16="72/75/a1" # Base 09
color17="72/a1/9e" # Base 0F
color18="21/11/04" # Base 01
color19="33/1c/0a" # Base 02
color20="30/53/6f" # Base 04
color21="66/87/a1" # Base 06
color_foreground="47/6b/86" # Base 05
color_background="10/08/01" # Base 00
color_cursor="47/6b/86" # Base 05

if [ -n "$TMUX" ]; then
  # tell tmux to pass the escape sequences through
  # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
  printf_template="\033Ptmux;\033\033]4;%d;rgb:%s\007\033\\"
  printf_template_var="\033Ptmux;\033\033]%d;rgb:%s\007\033\\"
  printf_template_custom="\033Ptmux;\033\033]%s%s\007\033\\"
elif [ "${TERM%%-*}" = "screen" ]; then
  # GNU screen (screen, screen-256color, screen-256color-bce)
  printf_template="\033P\033]4;%d;rgb:%s\007\033\\"
  printf_template_var="\033P\033]%d;rgb:%s\007\033\\"
  printf_template_custom="\033P\033]%s%s\007\033\\"
elif [ -n "${-##*i*}" ]; then
  # non-interactive
  alias printf=/bin/false
else
  printf_template="\033]4;%d;rgb:%s\033\\"
  printf_template_var="\033]%d;rgb:%s\033\\"
  printf_template_custom="\033]%s%s\033\\"
fi

# 16 color space
printf $printf_template 0  $color00
printf $printf_template 1  $color01
printf $printf_template 2  $color02
printf $printf_template 3  $color03
printf $printf_template 4  $color04
printf $printf_template 5  $color05
printf $printf_template 6  $color06
printf $printf_template 7  $color07
printf $printf_template 8  $color08
printf $printf_template 9  $color09
printf $printf_template 10 $color10
printf $printf_template 11 $color11
printf $printf_template 12 $color12
printf $printf_template 13 $color13
printf $printf_template 14 $color14
printf $printf_template 15 $color15

# 256 color space
printf $printf_template 16 $color16
printf $printf_template 17 $color17
printf $printf_template 18 $color18
printf $printf_template 19 $color19
printf $printf_template 20 $color20
printf $printf_template 21 $color21

# foreground / background / cursor color
if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  printf $printf_template_custom Pg 476b86 # forground
  printf $printf_template_custom Ph 100801 # background
  printf $printf_template_custom Pi 476b86 # bold color
  printf $printf_template_custom Pj 331c0a # selection color
  printf $printf_template_custom Pk 476b86 # selected text color
  printf $printf_template_custom Pl 476b86 # cursor
  printf $printf_template_custom Pm 100801 # cursor text
else
  printf $printf_template_var 10 $color_foreground
  printf $printf_template_var 11 $color_background
  printf $printf_template_custom 12 ";7" # cursor (reverse video)
fi

# clean up
unset printf_template
unset printf_template_var
unset color00
unset color01
unset color02
unset color03
unset color04
unset color05
unset color06
unset color07
unset color08
unset color09
unset color10
unset color11
unset color12
unset color13
unset color14
unset color15
unset color16
unset color17
unset color18
unset color19
unset color20
unset color21
unset color_foreground
unset color_background
unset color_cursor

#{
# Shell Color Setup Template
# Chris Kempson (http://chriskempson.com)
#}#!/bin/sh
# Base16 harmonic16 - Shell color setup script
# Jannik Siebert (https://github.com/janniks)

if [ "${TERM%%-*}" = 'linux' ]; then
    # This script doesn't support linux console (use 'vconsole' template instead)
    return 2>/dev/null || exit 0
fi

color00="06/27/27" # Base 00 - Black
color01="bd/8f/8f" # Base 08 - Red
color02="8f/bd/8f" # Base 0B - Green
color03="bd/bd/8f" # Base 0A - Yellow
color04="8f/8f/bd" # Base 0D - Blue
color05="bd/8f/bd" # Base 0E - Magenta
color06="8f/bd/bd" # Base 0C - Cyan
color07="b7/d8/d8" # Base 05 - White
color08="4d/8c/8c" # Base 03 - Bright Black
color09=$color01 # Base 08 - Bright Red
color10=$color02 # Base 0B - Bright Green
color11=$color03 # Base 0A - Bright Yellow
color12=$color04 # Base 0D - Bright Blue
color13=$color05 # Base 0E - Bright Magenta
color14=$color06 # Base 0C - Bright Cyan
color15="f1/f8/f8" # Base 07 - Bright White
color16="bd/a6/8f" # Base 09
color17="bd/8f/a6" # Base 0F
color18="16/4b/4b" # Base 01
color19="2e/6d/6d" # Base 02
color20="94/c2/c2" # Base 04
color21="d7/ea/ea" # Base 06
color_foreground="b7/d8/d8" # Base 05
color_background="06/27/27" # Base 00
color_cursor="b7/d8/d8" # Base 05

if [ -n "$TMUX" ]; then
  # tell tmux to pass the escape sequences through
  # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
  printf_template="\033Ptmux;\033\033]4;%d;rgb:%s\007\033\\"
  printf_template_var="\033Ptmux;\033\033]%d;rgb:%s\007\033\\"
  printf_template_custom="\033Ptmux;\033\033]%s%s\007\033\\"
elif [ "${TERM%%-*}" = "screen" ]; then
  # GNU screen (screen, screen-256color, screen-256color-bce)
  printf_template="\033P\033]4;%d;rgb:%s\007\033\\"
  printf_template_var="\033P\033]%d;rgb:%s\007\033\\"
  printf_template_custom="\033P\033]%s%s\007\033\\"
elif [ -n "${-##*i*}" ]; then
  # non-interactive
  alias printf=/bin/false
else
  printf_template="\033]4;%d;rgb:%s\033\\"
  printf_template_var="\033]%d;rgb:%s\033\\"
  printf_template_custom="\033]%s%s\033\\"
fi

# 16 color space
printf $printf_template 0  $color00
printf $printf_template 1  $color01
printf $printf_template 2  $color02
printf $printf_template 3  $color03
printf $printf_template 4  $color04
printf $printf_template 5  $color05
printf $printf_template 6  $color06
printf $printf_template 7  $color07
printf $printf_template 8  $color08
printf $printf_template 9  $color09
printf $printf_template 10 $color10
printf $printf_template 11 $color11
printf $printf_template 12 $color12
printf $printf_template 13 $color13
printf $printf_template 14 $color14
printf $printf_template 15 $color15

# 256 color space
printf $printf_template 16 $color16
printf $printf_template 17 $color17
printf $printf_template 18 $color18
printf $printf_template 19 $color19
printf $printf_template 20 $color20
printf $printf_template 21 $color21

# foreground / background / cursor color
if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  printf $printf_template_custom Pg b7d8d8 # forground
  printf $printf_template_custom Ph 062727 # background
  printf $printf_template_custom Pi b7d8d8 # bold color
  printf $printf_template_custom Pj 2e6d6d # selection color
  printf $printf_template_custom Pk b7d8d8 # selected text color
  printf $printf_template_custom Pl b7d8d8 # cursor
  printf $printf_template_custom Pm 062727 # cursor text
else
  printf $printf_template_var 10 $color_foreground
  printf $printf_template_var 11 $color_background
  printf $printf_template_custom 12 ";7" # cursor (reverse video)
fi

# clean up
unset printf_template
unset printf_template_var
unset color00
unset color01
unset color02
unset color03
unset color04
unset color05
unset color06
unset color07
unset color08
unset color09
unset color10
unset color11
unset color12
unset color13
unset color14
unset color15
unset color16
unset color17
unset color18
unset color19
unset color20
unset color21
unset color_foreground
unset color_background
unset color_cursor

#{
# Shell Color Setup Template
# Chris Kempson (http://chriskempson.com)
#}#!/bin/sh
# Base16 harmonic16 - Shell color setup script
# Jannik Siebert (https://github.com/janniks)

if [ "${TERM%%-*}" = 'linux' ]; then
    # This script doesn't support linux console (use 'vconsole' template instead)
    return 2>/dev/null || exit 0
fi

color00="06/27/27" # Base 00 - Black
color01="bd/8f/8f" # Base 08 - Red
color02="8f/bd/8f" # Base 0B - Green
color03="bd/bd/8f" # Base 0A - Yellow
color04="8f/8f/bd" # Base 0D - Blue
color05="bd/8f/bd" # Base 0E - Magenta
color06="8f/bd/bd" # Base 0C - Cyan
color07="b7/d8/d8" # Base 05 - White
color08="4d/8c/8c" # Base 03 - Bright Black
color09=$color01 # Base 08 - Bright Red
color10=$color02 # Base 0B - Bright Green
color11=$color03 # Base 0A - Bright Yellow
color12=$color04 # Base 0D - Bright Blue
color13=$color05 # Base 0E - Bright Magenta
color14=$color06 # Base 0C - Bright Cyan
color15="f1/f8/f8" # Base 07 - Bright White
color16="bd/a6/8f" # Base 09
color17="bd/8f/a6" # Base 0F
color18="16/4b/4b" # Base 01
color19="2e/6d/6d" # Base 02
color20="94/c2/c2" # Base 04
color21="d7/ea/ea" # Base 06
color_foreground="b7/d8/d8" # Base 05
color_background="06/27/27" # Base 00
color_cursor="b7/d8/d8" # Base 05

if [ -n "$TMUX" ]; then
  # tell tmux to pass the escape sequences through
  # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
  printf_template="\033Ptmux;\033\033]4;%d;rgb:%s\007\033\\"
  printf_template_var="\033Ptmux;\033\033]%d;rgb:%s\007\033\\"
  printf_template_custom="\033Ptmux;\033\033]%s%s\007\033\\"
elif [ "${TERM%%-*}" = "screen" ]; then
  # GNU screen (screen, screen-256color, screen-256color-bce)
  printf_template="\033P\033]4;%d;rgb:%s\007\033\\"
  printf_template_var="\033P\033]%d;rgb:%s\007\033\\"
  printf_template_custom="\033P\033]%s%s\007\033\\"
elif [ -n "${-##*i*}" ]; then
  # non-interactive
  alias printf=/bin/false
else
  printf_template="\033]4;%d;rgb:%s\033\\"
  printf_template_var="\033]%d;rgb:%s\033\\"
  printf_template_custom="\033]%s%s\033\\"
fi

# 16 color space
printf $printf_template 0  $color00
printf $printf_template 1  $color01
printf $printf_template 2  $color02
printf $printf_template 3  $color03
printf $printf_template 4  $color04
printf $printf_template 5  $color05
printf $printf_template 6  $color06
printf $printf_template 7  $color07
printf $printf_template 8  $color08
printf $printf_template 9  $color09
printf $printf_template 10 $color10
printf $printf_template 11 $color11
printf $printf_template 12 $color12
printf $printf_template 13 $color13
printf $printf_template 14 $color14
printf $printf_template 15 $color15

# 256 color space
printf $printf_template 16 $color16
printf $printf_template 17 $color17
printf $printf_template 18 $color18
printf $printf_template 19 $color19
printf $printf_template 20 $color20
printf $printf_template 21 $color21

# foreground / background / cursor color
if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  printf $printf_template_custom Pg b7d8d8 # forground
  printf $printf_template_custom Ph 062727 # background
  printf $printf_template_custom Pi b7d8d8 # bold color
  printf $printf_template_custom Pj 2e6d6d # selection color
  printf $printf_template_custom Pk b7d8d8 # selected text color
  printf $printf_template_custom Pl b7d8d8 # cursor
  printf $printf_template_custom Pm 062727 # cursor text
else
  printf $printf_template_var 10 $color_foreground
  printf $printf_template_var 11 $color_background
  printf $printf_template_custom 12 ";7" # cursor (reverse video)
fi

# clean up
unset printf_template
unset printf_template_var
unset color00
unset color01
unset color02
unset color03
unset color04
unset color05
unset color06
unset color07
unset color08
unset color09
unset color10
unset color11
unset color12
unset color13
unset color14
unset color15
unset color16
unset color17
unset color18
unset color19
unset color20
unset color21
unset color_foreground
unset color_background
unset color_cursor

#{
# Shell Color Setup Template
# Chris Kempson (http://chriskempson.com)
#}#!/bin/sh
# Base16 harmonic16 - Shell color setup script
# Jannik Siebert (https://github.com/janniks)

if [ "${TERM%%-*}" = 'linux' ]; then
    # This script doesn't support linux console (use 'vconsole' template instead)
    return 2>/dev/null || exit 0
fi

color00="12/17/19" # Base 00 - Black
color01="3f/56/5c" # Base 08 - Red
color02="5c/3f/56" # Base 0B - Green
color03="46/3f/5c" # Base 0A - Yellow
color04="56/5c/3f" # Base 0D - Blue
color05="3f/5c/46" # Base 0E - Magenta
color06="5c/46/3f" # Base 0C - Cyan
color07="9e/ab/af" # Base 05 - White
color08="50/5f/63" # Base 03 - Bright Black
color09=$color01 # Base 08 - Bright Red
color10=$color02 # Base 0B - Bright Green
color11=$color03 # Base 0A - Bright Yellow
color12=$color04 # Base 0D - Bright Blue
color13=$color05 # Base 0E - Bright Magenta
color14=$color06 # Base 0C - Bright Cyan
color15="db/e1/e3" # Base 07 - Bright White
color16="3f/47/5c" # Base 09
color17="3f/5c/54" # Base 0F
color18="25/2f/31" # Base 01
color19="3a/46/4a" # Base 02
color20="82/91/95" # Base 04
color21="bb/c6/c9" # Base 06
color_foreground="9e/ab/af" # Base 05
color_background="12/17/19" # Base 00
color_cursor="9e/ab/af" # Base 05

if [ -n "$TMUX" ]; then
  # tell tmux to pass the escape sequences through
  # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
  printf_template="\033Ptmux;\033\033]4;%d;rgb:%s\007\033\\"
  printf_template_var="\033Ptmux;\033\033]%d;rgb:%s\007\033\\"
  printf_template_custom="\033Ptmux;\033\033]%s%s\007\033\\"
elif [ "${TERM%%-*}" = "screen" ]; then
  # GNU screen (screen, screen-256color, screen-256color-bce)
  printf_template="\033P\033]4;%d;rgb:%s\007\033\\"
  printf_template_var="\033P\033]%d;rgb:%s\007\033\\"
  printf_template_custom="\033P\033]%s%s\007\033\\"
elif [ -n "${-##*i*}" ]; then
  # non-interactive
  alias printf=/bin/false
else
  printf_template="\033]4;%d;rgb:%s\033\\"
  printf_template_var="\033]%d;rgb:%s\033\\"
  printf_template_custom="\033]%s%s\033\\"
fi

# 16 color space
printf $printf_template 0  $color00
printf $printf_template 1  $color01
printf $printf_template 2  $color02
printf $printf_template 3  $color03
printf $printf_template 4  $color04
printf $printf_template 5  $color05
printf $printf_template 6  $color06
printf $printf_template 7  $color07
printf $printf_template 8  $color08
printf $printf_template 9  $color09
printf $printf_template 10 $color10
printf $printf_template 11 $color11
printf $printf_template 12 $color12
printf $printf_template 13 $color13
printf $printf_template 14 $color14
printf $printf_template 15 $color15

# 256 color space
printf $printf_template 16 $color16
printf $printf_template 17 $color17
printf $printf_template 18 $color18
printf $printf_template 19 $color19
printf $printf_template 20 $color20
printf $printf_template 21 $color21

# foreground / background / cursor color
if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  printf $printf_template_custom Pg 9eabaf # forground
  printf $printf_template_custom Ph 121719 # background
  printf $printf_template_custom Pi 9eabaf # bold color
  printf $printf_template_custom Pj 3a464a # selection color
  printf $printf_template_custom Pk 9eabaf # selected text color
  printf $printf_template_custom Pl 9eabaf # cursor
  printf $printf_template_custom Pm 121719 # cursor text
else
  printf $printf_template_var 10 $color_foreground
  printf $printf_template_var 11 $color_background
  printf $printf_template_custom 12 ";7" # cursor (reverse video)
fi

# clean up
unset printf_template
unset printf_template_var
unset color00
unset color01
unset color02
unset color03
unset color04
unset color05
unset color06
unset color07
unset color08
unset color09
unset color10
unset color11
unset color12
unset color13
unset color14
unset color15
unset color16
unset color17
unset color18
unset color19
unset color20
unset color21
unset color_foreground
unset color_background
unset color_cursor

#{
# Shell Color Setup Template
# Chris Kempson (http://chriskempson.com)
#}#!/bin/sh
# Base16 harmonic16 - Shell color setup script
# Jannik Siebert (https://github.com/janniks)

if [ "${TERM%%-*}" = 'linux' ]; then
    # This script doesn't support linux console (use 'vconsole' template instead)
    return 2>/dev/null || exit 0
fi

color00="01/13/13" # Base 00 - Black
color01="bd/93/93" # Base 08 - Red
color02="93/bd/93" # Base 0B - Green
color03="bd/bd/93" # Base 0A - Yellow
color04="93/93/bd" # Base 0D - Blue
color05="bd/93/bd" # Base 0E - Magenta
color06="93/bd/bd" # Base 0C - Cyan
color07="59/96/96" # Base 05 - White
color08="19/50/50" # Base 03 - Bright Black
color09=$color01 # Base 08 - Bright Red
color10=$color02 # Base 0B - Bright Green
color11=$color03 # Base 0A - Bright Yellow
color12=$color04 # Base 0D - Bright Blue
color13=$color05 # Base 0E - Bright Magenta
color14=$color06 # Base 0C - Bright Cyan
color15="ab/d1/d1" # Base 07 - Bright White
color16="bd/a8/93" # Base 09
color17="bd/93/a8" # Base 0F
color18="06/27/27" # Base 01
color19="0e/3b/3b" # Base 02
color20="3e/7e/7e" # Base 04
color21="7c/b1/b1" # Base 06
color_foreground="59/96/96" # Base 05
color_background="01/13/13" # Base 00
color_cursor="59/96/96" # Base 05

if [ -n "$TMUX" ]; then
  # tell tmux to pass the escape sequences through
  # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
  printf_template="\033Ptmux;\033\033]4;%d;rgb:%s\007\033\\"
  printf_template_var="\033Ptmux;\033\033]%d;rgb:%s\007\033\\"
  printf_template_custom="\033Ptmux;\033\033]%s%s\007\033\\"
elif [ "${TERM%%-*}" = "screen" ]; then
  # GNU screen (screen, screen-256color, screen-256color-bce)
  printf_template="\033P\033]4;%d;rgb:%s\007\033\\"
  printf_template_var="\033P\033]%d;rgb:%s\007\033\\"
  printf_template_custom="\033P\033]%s%s\007\033\\"
elif [ -n "${-##*i*}" ]; then
  # non-interactive
  alias printf=/bin/false
else
  printf_template="\033]4;%d;rgb:%s\033\\"
  printf_template_var="\033]%d;rgb:%s\033\\"
  printf_template_custom="\033]%s%s\033\\"
fi

# 16 color space
printf $printf_template 0  $color00
printf $printf_template 1  $color01
printf $printf_template 2  $color02
printf $printf_template 3  $color03
printf $printf_template 4  $color04
printf $printf_template 5  $color05
printf $printf_template 6  $color06
printf $printf_template 7  $color07
printf $printf_template 8  $color08
printf $printf_template 9  $color09
printf $printf_template 10 $color10
printf $printf_template 11 $color11
printf $printf_template 12 $color12
printf $printf_template 13 $color13
printf $printf_template 14 $color14
printf $printf_template 15 $color15

# 256 color space
printf $printf_template 16 $color16
printf $printf_template 17 $color17
printf $printf_template 18 $color18
printf $printf_template 19 $color19
printf $printf_template 20 $color20
printf $printf_template 21 $color21

# foreground / background / cursor color
if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  printf $printf_template_custom Pg 599696 # forground
  printf $printf_template_custom Ph 011313 # background
  printf $printf_template_custom Pi 599696 # bold color
  printf $printf_template_custom Pj 0e3b3b # selection color
  printf $printf_template_custom Pk 599696 # selected text color
  printf $printf_template_custom Pl 599696 # cursor
  printf $printf_template_custom Pm 011313 # cursor text
else
  printf $printf_template_var 10 $color_foreground
  printf $printf_template_var 11 $color_background
  printf $printf_template_custom 12 ";7" # cursor (reverse video)
fi

# clean up
unset printf_template
unset printf_template_var
unset color00
unset color01
unset color02
unset color03
unset color04
unset color05
unset color06
unset color07
unset color08
unset color09
unset color10
unset color11
unset color12
unset color13
unset color14
unset color15
unset color16
unset color17
unset color18
unset color19
unset color20
unset color21
unset color_foreground
unset color_background
unset color_cursor

