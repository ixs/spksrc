# Common definitions, shared by all makefiles

# all will be the default target, regardless of what is defined in the other
# makefiles.
default: all

# Stop on first error
SHELL := $(SHELL) -e

# Display message in a consistent way
MSG = echo "===> "

# Launch command in the working dir of the package source and the right environment
RUN = cd $(WORK_DIR)/$(PKG_DIR) && env $(ENV)

# Pip command
PIP ?= pip
# Why ask for the same thing twice? Always cache downloads
PIP_CACHE_OPT ?= --cache-dir $(PIP_DIR)
PIP_WHEEL_ARGS = wheel --no-binary :all: $(PIP_CACHE_OPT) --no-deps --requirement $(WORK_DIR)/wheelhouse/requirements.txt --wheel-dir $(WORK_DIR)/wheelhouse
PIP_WHEEL = $(PIP) $(PIP_WHEEL_ARGS)

# Available languages
LANGUAGES = chs cht csy dan enu fre ger hun ita jpn krn nld nor plk ptb ptg rus spn sve trk

# Available toolchains formatted as '{ARCH}-{TC}'
AVAILABLE_TOOLCHAINS = $(subst syno-,,$(sort $(notdir $(wildcard ../../toolchain/syno-*))))
AVAILABLE_TCVERSIONS = $(sort $(foreach arch,$(AVAILABLE_TOOLCHAINS),$(shell echo ${arch} | cut -f2 -d'-')))

# Global arch definitions
include ../../mk/spksrc.archs.mk

# Load local configuration
LOCAL_CONFIG_MK = ../../local.mk
ifneq ($(wildcard $(LOCAL_CONFIG_MK)),)
include $(LOCAL_CONFIG_MK)
endif

# Filter to exclude TC versions greater than DEFAULT_TC (from local configuration)
TCVERSION_DUPES = $(addprefix %,$(filter-out $(DEFAULT_TC),$(AVAILABLE_TCVERSIONS)))

# Archs that are supported by generic archs
ARCHS_DUPES_DEFAULT = $(addsuffix %,$(ARCHS_WITH_GENERIC_SUPPORT))
# remove unsupported (outdated) archs
ARCHS_DUPES_DEFAULT += $(addsuffix %,$(DEPRECATED_ARCHS))

# Filter for all-supported
ARCHS_DUPES = $(ARCHS_DUPES_DEFAULT) $(TCVERSION_DUPES)

# default: used for all-latest target
DEFAULT_ARCHS = $(sort $(filter-out $(ARCHS_DUPES_DEFAULT), $(AVAILABLE_TOOLCHAINS)))

# supported: used for all-supported target
SUPPORTED_ARCHS = $(sort $(filter-out $(ARCHS_DUPES), $(AVAILABLE_TOOLCHAINS)))

# legacy: used for all-legacy and when kernel support is used
#         all archs except generic archs
LEGACY_ARCHS = $(sort $(filter-out $(addsuffix %,$(GENERIC_ARCHS)), $(AVAILABLE_TOOLCHAINS)))

# Set parallel build mode
ifeq ($(PARALLEL_MAKE),)
# If not set but -j or -l argument passed, must
# manually specify the value of PARALLEL_MAKE
# as otherwise this will create too high load
ifneq ($(strip $(filter -j% -l%, $(shell ps T $$PPID))),)
PARALLEL_MAKE = nop
ENV += PARALLEL_MAKE=nop
# If not set, force max parallel build mode
else
PARALLEL_MAKE = max
ENV += PARALLEL_MAKE=max
endif
endif

# Set NCPUS based on PARALLEL_MAKE
ifeq ($(PARALLEL_MAKE),nop)
NCPUS = 1
else ifeq ($(PARALLEL_MAKE),max)
NCPUS = $(shell grep -c ^processor /proc/cpuinfo)
else
NCPUS = $(PARALLEL_MAKE)
endif

# Enable stats over parallel build mode
ifneq ($(filter 1 on ON,$(PSTAT)),)
PSTAT_TIME = time -o $(PSTAT_LOG) --append
else
PSTAT_TIME =
endif

# Always send PSTAT output to proper log file
# independantly from active Makefile location
ifeq ($(filter cross spk,$(shell basename $(dir $(abspath $(dir $$PWD))))),)
PSTAT_LOG = $(shell pwdx $$(ps -o ppid= $$(echo $$PPID)) | cut -f2 -d:)/build.stats.log
else ifneq ($(wildcard $(WORK_DIR)),)
PSTAT_LOG = $(WORK_DIR)/../build.stats.log
else
PSTAT_LOG = $(shell pwd)/build.stats.log
endif

# Terminal colors
RED=`tput setaf 1`
GREEN=`tput setaf 2`
NC=`tput sgr0`

# Version Comparison
version_le = $(shell if printf '%s\n' "$(1)" "$(2)" | sort -VC ; then echo 1; fi)
version_ge = $(shell if printf '%s\n' "$(1)" "$(2)" | sort -VCr ; then echo 1; fi)
version_lt = $(shell if [ "$(1)" != "$(2)" ] && printf "%s\n" "$(1)" "$(2)" | sort -VC ; then echo 1; fi)
version_gt = $(shell if [ "$(1)" != "$(2)" ] && printf "%s\n" "$(1)" "$(2)" | sort -VCr ; then echo 1; fi)
