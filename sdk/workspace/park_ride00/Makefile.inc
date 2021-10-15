mkfile_path := $(dir $(lastword $(MAKEFILE_LIST)))

SRCLANG := c

APPL_ASMOBJS :=
ifdef USE_CXX
	APPL_CXXOBJS += 
	APPL_COBJS +=
else
	APPL_COBJS += auto_park_ride.o \
	bumper.o seat.o walldetector.o \
	line_tracer.o linemon.o driver.o \
	timer.o route_reader.o
endif

APPL_DIRS += $(mkfile_path)app $(mkfile_path)unit
INCLUDES += \
	-I$(mkfile_path)app \
	-I$(mkfile_path)unit
