cmake_minimum_required(VERSION 2.8.8)

set(PMC_HEADER_FILES pmc.h
                     pmc_headers.h 
                     pmc_input.h 
                     pmc_utils.h 
                     pmc_heu.h 
                     pmc_maxclique.h 
                     pmcx_maxclique.h 
                     pmcx_maxclique_basic.h)

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

add_library(pmc SHARED ${PMC_HEADER_FILES} ${PMC_SOURCE_FILES})
target_compile_options(pmc PRIVATE -fPIC -fopenmp)

add_executable(pmc_main pmc_driver.cpp)
target_link_libraries(pmc_main pmc)
target_compile_options(pmc_main PRIVATE -fPIC -fopenmp)

find_package(OpenMP REQUIRED)
target_link_libraries(pmc OpenMP::OpenMP_CXX)
target_link_libraries(pmc_main OpenMP::OpenMP_CXX)

set_target_properties(pmc PROPERTIES PUBLIC_HEADER "${PMC_HEADER_FILES}")

install(FILES ${PMC_HEADER_FILES} 
        DESTINATION include/pmc)