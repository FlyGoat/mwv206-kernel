include Makefile.in
#from kernel build
ifneq ($(KERNELRELEASE),)
#from shell build
else
	KERNELDIR	:= /lib/modules/$(shell uname -r)/build
	CWD			:= $(shell pwd)/mwv206linuxdev/
default:
	make -C $(KERNELDIR) M=$(CWD) modules
	#cp -f $(CWD)/*.ko $(CWD)/*.[ios] $(CWD)/.*.cmd $(CWD)/../mwv206hal/*.[ios] $(CWD)/../mwv206hal/.*.o.cmd .
	###copy mwv206.ko to `mwv206kernel_publish/lib`
	mkdir -p $(CWD)/../lib/$(platform)
	cp $(CWD)/mwv206.ko $(CWD)/../lib/$(platform)
ifeq ($(shell if [ -d $(GLJ206ROOTPATH)/../lib ]; then echo "yes"; else echo "no"; fi;),yes)
	###copy mwv206.ko to glj206/lib
	mkdir -p $(GLJ206ROOTPATH)/../lib/$(platform)
	cp $(CWD)/mwv206.ko $(GLJ206ROOTPATH)/../lib/$(platform)
endif
clean:
	rm -rf *.[iso] 
	rm -rf *.ko
	rm -rf .*.cmd
	rm -rf $(shell pwd)/mwv206hal/*.[iso]
	rm -rf $(shell pwd)/mwv206hal/.*.o.cmd
	make -C $(KERNELDIR) M=$(CWD) clean
depend:
	make -C $(KERNELDIR) M=$(CWD) depend 
install:

ifeq ($(OS), deepin)
	mkdir -p /lib/modules/$(shell uname -r)/kernel/drivers/gpu/jingjia
	sudo cp $(GLJ206OUTPUTLIBPATH)/mwv206.ko /lib/modules/$(shell uname -r)/kernel/drivers/gpu/jingjia/mwv206.ko
else	

	sudo cp $(GLJ206OUTPUTLIBPATH)/mwv206.ko /lib/modules/$(shell uname -r)/kernel/mwv206.ko
endif
	sudo depmod
	sync
endif
