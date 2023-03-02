# Dependencies:
# sudo apt-get install gcc-multilib g++-multilib

PIN_ROOT = /home/lizhenghao/Tools/pin

CC=clang
CXX=clang++

LIBEXTFUN			= extfunc_src
LIBRHTOOL			= rhtool_src

.PHONY: all
all: extfunc rhtool

.PHONY: extfunc
extfunc: $(LIBEXTFUN)
	cd $< && make -j

rhtool: $(LIBRHTOOL)
	cd $< && TARGET=intel64 make -j

.PHONY: clean
clean:
	cd $(LIBEXTFUN) 	&& make clean
	cd $(LIBRHTOOL) 	&& make clean

.PHONY: test
test:
	$(PIN_ROOT)/pin -t $(LIBRHTOOL)/obj-intel64/MyPinTool.so -- ls -a
