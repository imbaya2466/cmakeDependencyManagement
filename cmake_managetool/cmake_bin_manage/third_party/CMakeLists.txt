if (CMAKE_SYSTEM_NAME MATCHES "Linux")
  set(LINUX TRUE)
endif()
#get wget extract_archive
include(${PROJECT_SOURCE_DIR}/cmake/wget.cmake)
include (${PROJECT_SOURCE_DIR}/cmake/extract_archive.cmake)

message(STATUS  "weget:" ${CMAKE_WGET_EXEC})
#work path
set(DOWN_LOAD_DIR ${PROJECT_SOURCE_DIR}/third_party)
#count
set(success_count "0")
set(failed_count "0")

if (WIN32)
    file(STRINGS download-win.txt download)
elseif(APPLE)  
    if(OSX)
        file(STRINGS download-mac.txt download)
    elseif(IOS)
        file(STRINGS download-ios.txt download)
    endif()
elseif(ANDROID)      
    file(STRINGS download-android.txt download)
elseif(LINUX)  
    file(STRINGS download-linux.txt download)
endif()


foreach(row IN LISTS download)
    #message(STATUS ${row}) 
    string(REPLACE " " ";" len_node_list ${row})
    list(GET len_node_list 0 down_node_name)
    list(GET len_node_list 1 down_node_url)
    message(STATUS "download:${down_node_name} = ${down_node_url}")
    execute_process(COMMAND ${CMAKE_WGET_EXEC} -t 2 -q -O ${down_node_name} ${down_node_url}
        WORKING_DIRECTORY ${DOWN_LOAD_DIR}
        RESULT_VARIABLE DL_RESULT)

    if (DL_RESULT EQUAL 0)
        message(STATUS  "download ${down_node_name} success")
        math(EXPR success_count  "${success_count}+1")
    else()
        message(STATUS  "download ${down_node_name} failed")
        math(EXPR failed_count  "${failed_count}+1")
    endif()
endforeach(row)

#execute_process(COMMAND CMD /c ${CMAKE_WGET_EXEC} -O ffmpeg.zip https://raw.githubusercontent.com/SaveLibFile/ffmpeg-lib/master/windows/4.1.3/default/ffmpeg.zip 
#    WORKING_DIRECTORY ${DOWN_LOAD_DIR}
#    RESULT_VARIABLE DL_RESULT)

message(STATUS  "download ${success_count} success,${failed_count} failed")

# extract_archive zip
foreach(row IN LISTS download)
    #message(STATUS ${row})
    string(REPLACE " " ";" len_node_list ${row})
    list(GET len_node_list 0 down_node_name)
    message(STATUS "extract:${down_node_name}")
    extract_archive(
        ${down_node_name} 
        "${DOWN_LOAD_DIR}/${down_node_name}"
        ${DOWN_LOAD_DIR})
endforeach(row)



