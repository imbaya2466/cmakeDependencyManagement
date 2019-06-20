cmake_minimum_required (VERSION 3.12)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake")
include(AutoVcpkg)
vcpkg_install(boost-core boost-optional)
message(STATUS "CMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE}")

project (vcpkg_test CXX)
set(CMAKE_CXX_STANDARD 17)
find_package(Boost REQUIRED)

add_executable(driver src/driver.cpp)
target_include_directories(driver PUBLIC ${Boost_INCLUDE_DIRS} ${PROJECT_SOURCE_DIR}/include )
target_link_libraries(driver ${Boost_LIBRARIES})

message(STATUS "Boost_INCLUDE_DIRS=${Boost_INCLUDE_DIRS}")
message(STATUS "Boost_LIBRARIES=${Boost_LIBRARIES}")

enable_testing()
include(CTest)
add_executable(driver_test ${PROJECT_SOURCE_DIR}/test/driver_test.cpp)
add_test(NAME driver COMMAND driver_test)
