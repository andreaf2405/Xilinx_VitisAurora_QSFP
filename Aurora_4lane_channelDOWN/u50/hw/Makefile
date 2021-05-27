
all: app.exe vadd.xclbin

app.exe: ../../src/host.cpp
	g++ -Wall -g -std=c++14 ../../src/host.cpp -o app.exe \
		-I${XILINX_XRT}/include/ \
		-L${XILINX_XRT}/lib/ -lOpenCL -lpthread -lrt -lstdc++

# fakestreamer.xo: ../../src/fakestreamer.cpp
# 	v++ -c -t ${TARGET} -k fakestreamer --platform xilinx_u50_gen3x16_xdma_201920_3 -I../../src ../../src/fakestreamer.cpp -o fakestreamer.xo 
# gpioreader.xo: ../../src/gpioreader.cpp
# 	v++ -c -t ${TARGET} -k gpioreader --platform xilinx_u50_gen3x16_xdma_201920_3 -I../../src ../../src/gpioreader.cpp -o gpioreader.xo

	
str2mem.xo: ../../src/str2mem.cpp
	v++ -c -t ${TARGET} -k str2mem --platform xilinx_u50_gen3x16_xdma_201920_3 -I../../src ../../src/str2mem.cpp -o str2mem.xo
# v++ -c -t ${TARGET} --config ../../src/u50.cfg -k str2mem -I../../src ../../src/str2mem.cpp -o str2mem.xo 

vadd.xo: ../../src/vadd.cpp
	v++ -c -t ${TARGET} --platform xilinx_u50_gen3x16_xdma_201920_3 -k simple_hGradient -I../../src ../../src/vadd.cpp -o vadd.xo
# 	v++ -c -t ${TARGET} --platform xilinx_u50_gen3x16_xdma_201920_3 -k simple_hGradient -I../../src ../../src/vadd.cpp -o vadd.xo --hls.export_project ./hls_export 

vadd.xclbin: ./vadd.xo ./str2mem.xo
# 	v++ -l -t ${TARGET} --config ../../src/u50.cfg ./vadd.xo ./str2mem.xo -o vadd.xclbin --to_step vpl.create_bd
# 	v++ -l -t ${TARGET} --config ../../src/u50.cfg ./vadd.xo ./str2mem.xo -o vadd.xclbin --from_step vpl.create_bd
# 	v++ -l -t ${TARGET} --config ../../src/u50.cfg ./vadd.xo ./str2mem.xo -o vadd.xclbin --from_step vpl.generate_target
	v++ -l -t ${TARGET} --config ../../src/u50.cfg ./vadd.xo ./str2mem.xo -o vadd.xclbin 

clean:
	rm -rf vadd* str2mem* app.exe *json *csv *log *summary _x .run .Xil .ipcache *.jou

# Unless specified, use the current directory name as the v++ build target
TARGET ?= $(notdir $(CURDIR))
