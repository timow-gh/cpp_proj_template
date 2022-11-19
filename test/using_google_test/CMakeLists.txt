function(create_test testName)
    add_executable(${testName} ${testName}.cpp)
    target_link_libraries(${testName} PRIVATE gtest_main example_library::example_library)
    add_test(NAME example_library.${testName} COMMAND ${testName})
endfunction()

create_test(google_test_usage)
