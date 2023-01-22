CPMAddPackage(
        NAME fmt
        GITHUB_REPOSITORY "fmtlib/fmt"
        GIT_TAG master
        GIT_SHALLOW TRUE
        OPTIONS
        # fmt only generates an install target if it is the top-level project. If we want to install it alongside this project,
        # the variable FMT_INSTALL must be set to ON or TRUE.
        "FMT_INSTALL ${${PROJECT_NAME}_INSTALL}"
)