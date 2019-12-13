cmake_minimum_required(VERSION 2.8.8)
project(pmc)

set(PMC_SOURCE_FILES
        ${CMAKE_CURRENT_SOURCE_DIR}/pmc_heu.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/pmc_maxclique.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/pmcx_maxclique.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/pmcx_maxclique_basic.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/pmc_cores.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/pmc_utils.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/pmc_graph.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/pmc_clique_utils.cpp
        )

add_library(pmc STATIC ${PMC_SOURCE_FILES})

target_include_directories(pmc PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/include>
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
        )

#target_compile_options(pmc PRIVATE -fPIC -fopenmp)

add_executable(pmc_main pmc_driver.cpp)
target_link_libraries(pmc_main pmc)
#target_compile_options(pmc_main PRIVATE -fPIC -fopenmp)

find_package(OpenMP REQUIRED)
target_link_libraries(pmc OpenMP::OpenMP_CXX)
target_link_libraries(pmc_main OpenMP::OpenMP_CXX)

include(GNUInstallDirs)

install(TARGETS pmc
        EXPORT pmc-export
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
        ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
        )

install(EXPORT pmc-export
        DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/pmc
        NAMESPACE pmc::
        FILE pmcTargets.cmake
        )
