#
# Makefile for PMC
#
# Ryan A. Rossi
# Copyright, 2012-2016
#

.KEEP_STATE:

all: pmc

#OPTFLAGS    = -g -D _GLIBCXX_DEBUG
OPTFLAGS    = -O3
CFLAGS      = $(OPTFLAGS) -fPIC
#CFLAGS 		+= -D_GLIBCXX_PARALLEL 
#CFLAGS 		+= -floop-parallelize-all -ftree-loop-distribution


CXX          = g++
H_FILES     = pmc.h


.cpp.o:
	$(CXX) $(CFLAGS) -c $<

IO_SRC 				   = pmc_utils.cpp \
						pmc_graph.cpp \
						pmc_clique_utils.cpp

PMC_SRC 			   = pmc_heu.cpp \
						pmc_maxclique.cpp \
						pmcx_maxclique.cpp \
						pmcx_maxclique_basic.cpp
	
BOUND_LIB_SRC 		   = pmc_cores.cpp 

PMC_MAIN			   = pmc_driver.cpp

OBJ_PMC	= $(PMC_MAIN:%.cpp=%.o) $(IO_SRC) $(PMC_SRC) $(BOUND_LIB_SRC)
$(OBJ_PMC): $(H_FILES) Makefile
pmc: $(OBJ_PMC) $(H_FILES)
	$(CXX) $(CFLAGS) -o pmc $(OBJ_PMC) -fopenmp
	
libpmc.so: $(IO_SRC) $(PMC_SRC) $(BOUND_LIB_SRC) $(H_FILES) pmc_lib.cpp
	$(CXX) -static-libstdc++ $(CFLAGS) -shared -o libpmc.so \
		$(IO_SRC) $(PMC_SRC) $(BOUND_LIB_SRC) pmc_lib.cpp -fopenmp
		
libpmc_test: libpmc.so libpmc_test.cpp
	$(CXX) libpmc_test.cpp ./libpmc.so  -o libpmc_test
	./libpmc_test	
	
clean:
	rm -rf *.o pmc libpmc.so
