get_filename_component(PMC_CMAKE_DIR "${CMAKE_CURRENT_LIST_FILE}" PATH)

include(CMakeFindDependencyMacro)

find_dependency(OpenMP REQUIRED)

include("${PMC_CMAKE_DIR}/pmcTargets.cmake")
