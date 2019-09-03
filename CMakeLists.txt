cmake_minimum_required(VERSION 2.8.8)

add_library(pmc STATIC 
               pmc.h
               pmc_heu.cpp
               pmc_maxclique.cpp
               pmcx_maxclique.cpp
               pmcx_maxclique_basic.cpp
               )

target_sources(pmc PUBLIC 
               ${CMAKE_CURRENT_SOURCE_DIR}/pmc_cores.cpp
               ${CMAKE_CURRENT_SOURCE_DIR}/pmc_utils.cpp 
			   ${CMAKE_CURRENT_SOURCE_DIR}/pmc_graph.cpp
			   ${CMAKE_CURRENT_SOURCE_DIR}/pmc_clique_utils.cpp
               )

target_compile_options(pmc PRIVATE -fPIC -fopenmp)

add_executable(pmc_main pmc_driver.cpp)
target_link_libraries(pmc_main pmc)
target_compile_options(pmc_main PRIVATE -fPIC -fopenmp)

find_package(OpenMP REQUIRED)
target_link_libraries(pmc OpenMP::OpenMP_CXX)
target_link_libraries(pmc_main OpenMP::OpenMP_CXX)

