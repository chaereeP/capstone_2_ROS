# generated from catkin/cmake/template/pkgConfig.cmake.in

# append elements to a list and remove existing duplicates from the list
# copied from catkin/cmake/list_append_deduplicate.cmake to keep pkgConfig
# self contained
macro(_list_append_deduplicate listname)
  if(NOT "${ARGN}" STREQUAL "")
    if(${listname})
      list(REMOVE_ITEM ${listname} ${ARGN})
    endif()
    list(APPEND ${listname} ${ARGN})
  endif()
endmacro()

# append elements to a list if they are not already in the list
# copied from catkin/cmake/list_append_unique.cmake to keep pkgConfig
# self contained
macro(_list_append_unique listname)
  foreach(_item ${ARGN})
    list(FIND ${listname} ${_item} _index)
    if(_index EQUAL -1)
      list(APPEND ${listname} ${_item})
    endif()
  endforeach()
endmacro()

# pack a list of libraries with optional build configuration keywords
# copied from catkin/cmake/catkin_libraries.cmake to keep pkgConfig
# self contained
macro(_pack_libraries_with_build_configuration VAR)
  set(${VAR} "")
  set(_argn ${ARGN})
  list(LENGTH _argn _count)
  set(_index 0)
  while(${_index} LESS ${_count})
    list(GET _argn ${_index} lib)
    if("${lib}" MATCHES "^(debug|optimized|general)$")
      math(EXPR _index "${_index} + 1")
      if(${_index} EQUAL ${_count})
        message(FATAL_ERROR "_pack_libraries_with_build_configuration() the list of libraries '${ARGN}' ends with '${lib}' which is a build configuration keyword and must be followed by a library")
      endif()
      list(GET _argn ${_index} library)
      list(APPEND ${VAR} "${lib}${CATKIN_BUILD_CONFIGURATION_KEYWORD_SEPARATOR}${library}")
    else()
      list(APPEND ${VAR} "${lib}")
    endif()
    math(EXPR _index "${_index} + 1")
  endwhile()
endmacro()

# unpack a list of libraries with optional build configuration keyword prefixes
# copied from catkin/cmake/catkin_libraries.cmake to keep pkgConfig
# self contained
macro(_unpack_libraries_with_build_configuration VAR)
  set(${VAR} "")
  foreach(lib ${ARGN})
    string(REGEX REPLACE "^(debug|optimized|general)${CATKIN_BUILD_CONFIGURATION_KEYWORD_SEPARATOR}(.+)$" "\\1;\\2" lib "${lib}")
    list(APPEND ${VAR} "${lib}")
  endforeach()
endmacro()


if(tt_map_gen_CONFIG_INCLUDED)
  return()
endif()
set(tt_map_gen_CONFIG_INCLUDED TRUE)

# set variables for source/devel/install prefixes
if("TRUE" STREQUAL "TRUE")
  set(tt_map_gen_SOURCE_PREFIX /home/naverlabs/ros/TT_final/src/tt3_motion/tt_map_gen)
  set(tt_map_gen_DEVEL_PREFIX /home/naverlabs/ros/TT_final/devel)
  set(tt_map_gen_INSTALL_PREFIX "")
  set(tt_map_gen_PREFIX ${tt_map_gen_DEVEL_PREFIX})
else()
  set(tt_map_gen_SOURCE_PREFIX "")
  set(tt_map_gen_DEVEL_PREFIX "")
  set(tt_map_gen_INSTALL_PREFIX /home/naverlabs/ros/TT_final/install)
  set(tt_map_gen_PREFIX ${tt_map_gen_INSTALL_PREFIX})
endif()

# warn when using a deprecated package
if(NOT "" STREQUAL "")
  set(_msg "WARNING: package 'tt_map_gen' is deprecated")
  # append custom deprecation text if available
  if(NOT "" STREQUAL "TRUE")
    set(_msg "${_msg} ()")
  endif()
  message("${_msg}")
endif()

# flag project as catkin-based to distinguish if a find_package()-ed project is a catkin project
set(tt_map_gen_FOUND_CATKIN_PROJECT TRUE)

if(NOT "/home/naverlabs/ros/TT_final/src/tt3_motion/tt_map_gen/include " STREQUAL " ")
  set(tt_map_gen_INCLUDE_DIRS "")
  set(_include_dirs "/home/naverlabs/ros/TT_final/src/tt3_motion/tt_map_gen/include")
  if(NOT " " STREQUAL " ")
    set(_report "Check the issue tracker '' and consider creating a ticket if the problem has not been reported yet.")
  elseif(NOT " " STREQUAL " ")
    set(_report "Check the website '' for information and consider reporting the problem.")
  else()
    set(_report "Report the problem to the maintainer 'ryough <ryou.gh@navercorp.com>' and request to fix the problem.")
  endif()
  foreach(idir ${_include_dirs})
    if(IS_ABSOLUTE ${idir} AND IS_DIRECTORY ${idir})
      set(include ${idir})
    elseif("${idir} " STREQUAL "include ")
      get_filename_component(include "${tt_map_gen_DIR}/../../../include" ABSOLUTE)
      if(NOT IS_DIRECTORY ${include})
        message(FATAL_ERROR "Project 'tt_map_gen' specifies '${idir}' as an include dir, which is not found.  It does not exist in '${include}'.  ${_report}")
      endif()
    else()
      message(FATAL_ERROR "Project 'tt_map_gen' specifies '${idir}' as an include dir, which is not found.  It does neither exist as an absolute directory nor in '/home/naverlabs/ros/TT_final/src/tt3_motion/tt_map_gen/${idir}'.  ${_report}")
    endif()
    _list_append_unique(tt_map_gen_INCLUDE_DIRS ${include})
  endforeach()
endif()

set(libraries "map_gen")
foreach(library ${libraries})
  # keep build configuration keywords, target names and absolute libraries as-is
  if("${library}" MATCHES "^(debug|optimized|general)$")
    list(APPEND tt_map_gen_LIBRARIES ${library})
  elseif(TARGET ${library})
    list(APPEND tt_map_gen_LIBRARIES ${library})
  elseif(IS_ABSOLUTE ${library})
    list(APPEND tt_map_gen_LIBRARIES ${library})
  else()
    set(lib_path "")
    set(lib "${library}-NOTFOUND")
    # since the path where the library is found is returned we have to iterate over the paths manually
    foreach(path /home/naverlabs/ros/TT_final/devel/lib;/home/naverlabs/ros/capstone_design/devel/lib;/opt/ros/kinetic/lib)
      find_library(lib ${library}
        PATHS ${path}
        NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
      if(lib)
        set(lib_path ${path})
        break()
      endif()
    endforeach()
    if(lib)
      _list_append_unique(tt_map_gen_LIBRARY_DIRS ${lib_path})
      list(APPEND tt_map_gen_LIBRARIES ${lib})
    else()
      # as a fall back for non-catkin libraries try to search globally
      find_library(lib ${library})
      if(NOT lib)
        message(FATAL_ERROR "Project '${PROJECT_NAME}' tried to find library '${library}'.  The library is neither a target nor built/installed properly.  Did you compile project 'tt_map_gen'?  Did you find_package() it before the subdirectory containing its code is included?")
      endif()
      list(APPEND tt_map_gen_LIBRARIES ${lib})
    endif()
  endif()
endforeach()

set(tt_map_gen_EXPORTED_TARGETS "")
# create dummy targets for exported code generation targets to make life of users easier
foreach(t ${tt_map_gen_EXPORTED_TARGETS})
  if(NOT TARGET ${t})
    add_custom_target(${t})
  endif()
endforeach()

set(depends "roscpp;std_msgs;sensor_msgs;tt_core_msgs;geometry_msgs;image_transport")
foreach(depend ${depends})
  string(REPLACE " " ";" depend_list ${depend})
  # the package name of the dependency must be kept in a unique variable so that it is not overwritten in recursive calls
  list(GET depend_list 0 tt_map_gen_dep)
  list(LENGTH depend_list count)
  if(${count} EQUAL 1)
    # simple dependencies must only be find_package()-ed once
    if(NOT ${tt_map_gen_dep}_FOUND)
      find_package(${tt_map_gen_dep} REQUIRED NO_MODULE)
    endif()
  else()
    # dependencies with components must be find_package()-ed again
    list(REMOVE_AT depend_list 0)
    find_package(${tt_map_gen_dep} REQUIRED NO_MODULE ${depend_list})
  endif()
  _list_append_unique(tt_map_gen_INCLUDE_DIRS ${${tt_map_gen_dep}_INCLUDE_DIRS})

  # merge build configuration keywords with library names to correctly deduplicate
  _pack_libraries_with_build_configuration(tt_map_gen_LIBRARIES ${tt_map_gen_LIBRARIES})
  _pack_libraries_with_build_configuration(_libraries ${${tt_map_gen_dep}_LIBRARIES})
  _list_append_deduplicate(tt_map_gen_LIBRARIES ${_libraries})
  # undo build configuration keyword merging after deduplication
  _unpack_libraries_with_build_configuration(tt_map_gen_LIBRARIES ${tt_map_gen_LIBRARIES})

  _list_append_unique(tt_map_gen_LIBRARY_DIRS ${${tt_map_gen_dep}_LIBRARY_DIRS})
  list(APPEND tt_map_gen_EXPORTED_TARGETS ${${tt_map_gen_dep}_EXPORTED_TARGETS})
endforeach()

set(pkg_cfg_extras "")
foreach(extra ${pkg_cfg_extras})
  if(NOT IS_ABSOLUTE ${extra})
    set(extra ${tt_map_gen_DIR}/${extra})
  endif()
  include(${extra})
endforeach()
