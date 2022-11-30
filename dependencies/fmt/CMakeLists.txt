FetchContent_Declare(
        fmt
        GIT_REPOSITORY https://github.com/fmtlib/fmt.git
        GIT_TAG 9.0.0
        GIT_SHALLOW TRUE # when naming a branch, only download the tip
)
# fmt only generates an install target if it is the top-level project. If we want to install it alongside this project,
# the variable FMT_INSTALL must be set to ON or TRUE.
set(FMT_INSTALL ON)
FetchContent_MakeAvailable(fmt)