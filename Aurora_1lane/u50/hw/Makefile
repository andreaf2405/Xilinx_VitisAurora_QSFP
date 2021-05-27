
all: app.exe vaurora.xclbin

app.exe: ../../src/host.cpp
	g++ -Wall -g -std=c++14 ../../src/host.cpp -o app.exe \
		-I${XILINX_XRT}/include/ \
		-L${XILINX_XRT}/lib/ -lOpenCL -lpthread -lrt -lstdc++
	
str2mem.xo: ../../src/str2mem.cpp
	v++ -c -t ${TARGET} -k str2mem --platform xilinx_u50_gen3x16_xdma_201920_3 -I../../src ../../src/str2mem.cpp -o str2mem.xo 
# v++ -c -t ${TARGET} --config ../../src/u50.cfg -k str2mem -I../../src ../../src/str2mem.cpp -o str2mem.xo 

simple_hGradient.xo: ../../src/simple_hGradient.cpp
	v++ -c -t ${TARGET} --platform xilinx_u50_gen3x16_xdma_201920_3 -k simple_hGradient -I../../src ../../src/simple_hGradient.cpp -o simple_hGradient.xo 

vaurora.xclbin: ./simple_hGradient.xo ./str2mem.xo
# 	v++ -l -t ${TARGET} --config ../../src/u50.cfg ./simple_hGradient.xo ./str2mem.xo -o vaurora.xclbin --to_step vpl.create_bd
# 	v++ -l -t ${TARGET} --config ../../src/u50.cfg ./simple_hGradient.xo ./str2mem.xo -o vaurora.xclbin --from_step vpl.create_bd
	v++ -l -t ${TARGET} --config ../../src/u50.cfg ./simple_hGradient.xo ./str2mem.xo -o vaurora.xclbin

clean:
	rm -rf simple_hGradient* str2mem* vaurora* app.exe *json *csv *log *summary _x .run .Xil .ipcache *.jou

# Unless specified, use the current directory name as the v++ build target
TARGET ?= $(notdir $(CURDIR))