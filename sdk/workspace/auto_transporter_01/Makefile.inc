mkfile_path := $(dir $(lastword $(MAKEFILE_LIST)))

SRCLANG := c

APPL_ASMOBJS :=
ifdef USE_CXX
	APPL_CXXOBJS +=
	APPL_COBJS +=
else
	APPL_COBJS += auto_transporter.o \
	bumper.o carrier.o walldetector.o \
	line_tracer.o linemon.o driver.o util.o
endif

APPL_DIRS += $(mkfile_path)app $(mkfile_path)unit $(mkfile_path)../util
INCLUDES += \
	-I$(mkfile_path)app \
	-I$(mkfile_path)unit \
	-I$(mkfile_path)../util
