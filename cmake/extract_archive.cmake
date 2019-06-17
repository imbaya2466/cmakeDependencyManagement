
function (extract_archive ARCHIVE_NAME ARCHIVE_PATH EXTRACT_DIR)
  file(TIMESTAMP ${ARCHIVE_PATH} CURRENT_ARCHIVE_TS UTC)
  set(CACHED_ARCHIVE_TS ${CACHED_${ARCHIVE_NAME}_ARCHIVE_TS})
  if (NOT ("${CACHED_ARCHIVE_TS}" STREQUAL "${CURRENT_ARCHIVE_TS}"))
    message(STATUS "extract ${ARCHIVE_NAME}")
    execute_process(
      COMMAND ${CMAKE_COMMAND} -E tar xzf ${ARCHIVE_PATH}
      WORKING_DIRECTORY ${EXTRACT_DIR}
      RESULT_VARIABLE EXTRACT_RESULT
    )
   if (EXTRACT_RESULT EQUAL 0)
     set(CACHED_${ARCHIVE_NAME}_ARCHIVE_TS "${CURRENT_ARCHIVE_TS}" CACHE INTERNAL "for update ${ARCHIVE_NAME}" FORCE)
     message(STATUS "extract ${ARCHIVE_NAME} success")
   else()
     message(STATUS "extract ${ARCHIVE_NAME} failed, archive:${ARCHIVE_PATH} extract:${EXTRACT_DIR}")
   endif()
  else()
    #message(STATUS "CURRENT_ARCHIVE_TS=${CURRENT_ARCHIVE_TS}")
    #message(STATUS "CACHED_ARCHIVE_TS=${CACHED_ARCHIVE_TS}")
    message(STATUS "${ARCHIVE_NAME} already up to date")
  endif()
endfunction()
