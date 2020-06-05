from powerline_shell.themes.default import DefaultColor

"colors are from https://jonasjacek.github.io/colors/"

class Color(DefaultColor):

    USERNAME_FG = 214
    USERNAME_BG = 235
    USERNAME_ROOT_BG = 0

    HOSTNAME_FG = 214 #sandy brown
    HOSTNAME_BG = 235 #navy
    HOME_SPECIAL_DISPLAY = False

    PATH_BG = 235
    PATH_FG = 214
    CWD_BG = 235
    CWD_FG = 214

    SEPARATOR_FG = 214
    SEPARATOR_BG = 235

    READONLY_BG = 1
    READONLY_FG = 15

    REPO_CLEAN_BG = 2   # green
    REPO_CLEAN_FG = 0   # black
    REPO_DIRTY_BG = 1   # red
    REPO_DIRTY_FG = 15  # white

    JOBS_FG = 4
    JOBS_BG = 8

    CMD_PASSED_BG = 115
    CMD_PASSED_FG = 15
    CMD_FAILED_BG = 168
    CMD_FAILED_FG = 0

    SVN_CHANGES_BG = REPO_DIRTY_BG
    SVN_CHANGES_FG = REPO_DIRTY_FG

    VIRTUAL_ENV_BG = 2
    VIRTUAL_ENV_FG = 0

    AWS_PROFILE_FG = 14
    AWS_PROFILE_BG = 8

    TIME_FG = 194
    TIME_BG = 7
