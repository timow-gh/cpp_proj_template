function(create_test testName)
    add_executable(${testName} ${testName}.cpp)
    target_link_libraries(${testName} PRIVATE gtest_main example_library::example_library)
    add_test(NAME Geometry.${testName} COMMAND ${testName})
endfunction()

create_test(test_example_library)
