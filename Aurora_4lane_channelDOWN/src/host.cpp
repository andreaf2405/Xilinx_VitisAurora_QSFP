/**********
Copyright (c) 2018, Xilinx, Inc.
All rights reserved.
Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:
1. Redistributions of source code must retain the above copyright notice,
this list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright notice,
this list of conditions and the following disclaimer in the documentation
and/or other materials provided with the distribution.
3. Neither the name of the copyright holder nor the names of its contributors
may be used to endorse or promote products derived from this software
without specific prior written permission.
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
**********/

#define CL_HPP_CL_1_2_DEFAULT_BUILD
#define CL_HPP_TARGET_OPENCL_VERSION 120
#define CL_HPP_MINIMUM_OPENCL_VERSION 120
#define CL_HPP_ENABLE_PROGRAM_CONSTRUCTION_FROM_ARRAY_COMPATIBILITY 1
#define CL_USE_DEPRECATED_OPENCL_1_2_APIS

// #define DATA_SIZE 128
#define DATA_SIZE 128
// #define DATA_SIZE 4096

#include <vector>
#include <unistd.h>
#include <iostream>
#include <fstream>
#include <CL/cl2.hpp>

// #include "experimental/xrt_kernel.h"
// #include "experimental/xrt_aie.h"


// Forward declaration of utility functions included at the end of this file
std::vector<cl::Device> get_xilinx_devices();
char* read_binary_file(const std::string &xclbin_file_name, unsigned &nb);

// ------------------------------------------------------------------------------------
// Main program
// ------------------------------------------------------------------------------------
int main(int argc, char** argv)
{

    int opt;
    while ((opt = getopt(argc, argv, "h")) != -1){
        switch (opt) {
            case 'h' : std::cout << " The application takes two integer arguments in the following order: {frame_size} and {number_of_frames}, plus an optional xclbin " << "'\n";
            std::cout << " Example './app.exe 128 10' to run with a sequence of 10 128x128 frames" << "'\n";
            return 0;
            case 'default':
            std::cout << " No options specified" << "'\n";
        }
    }

    if(argc < 3){
        fprintf(stderr,"Missing integer arguments. Check help (-h option)");
        exit(EXIT_FAILURE);
    }


// ------------------------------------------------------------------------------------
// Step 1: Initialize the OpenCL environment 
// ------------------------------------------------------------------------------------ 
    int frame_size = std::stoi(argv[1]);
    int number_of_frames = std::stoi(argv[2]);

    // unsigned int dev_index = 0;
    //  auto device = xrt::device(dev_index);
    //  auto xclbin_uuid = device.load_xclbin("vadd.xclbin");

    //  getchar();
    //  system("pause");

    cl_int err;
    std::string binaryFile = ( (argc - optind) != 4) ? "vadd.xclbin" : argv[3];
    unsigned fileBufSize;    
    std::vector<cl::Device> devices = get_xilinx_devices();
    devices.resize(1);
    cl::Device device = devices[0];
    cl::Context context(device, NULL, NULL, NULL, &err);
    char* fileBuf = read_binary_file(binaryFile, fileBufSize);
    cl::Program::Binaries bins{{fileBuf, fileBufSize}};
    cl::Program program(context, devices, bins, NULL, &err);
    cl::CommandQueue q(context, device, CL_QUEUE_PROFILING_ENABLE | CL_QUEUE_OUT_OF_ORDER_EXEC_MODE_ENABLE, &err);
    cl::CommandQueue q2(context, device, CL_QUEUE_PROFILING_ENABLE | CL_QUEUE_OUT_OF_ORDER_EXEC_MODE_ENABLE, &err);
    cl::Kernel krnl_vector_add0(program,"simple_hGradient", &err);
    cl::Kernel krnl_str2mem0(program,"str2mem", &err);
    
    
    std::cout << "INFO: BIN loaded and Kernels created '" << "'\n";

    // to enable pausing
    // unsigned int microsecond = 1000000;
    // usleep(10*microsecond);

    // std::cout << "int = " << sizeof(int) <<" bytes" << "'\n" ;

    // std::cout << "long = " << sizeof(long) <<" bytes" << "'\n" ;

    // std::cout << "short = " << sizeof(short) <<" bytes" << "'\n" ;

    // mdev = pcidev::get_dev()

    // mUserHandle = mdev->open("",O_RDWR);

    // void *p = mdev->mmap(mUserHandle, 128, PROT_READ | PROT_WRITE, MAP_SHARED, 1 * getpagesize());

    // std::cout << "pagesize = " << getpagesize() <<" bytes" << "'\n" ;

// ------------------------------------------------------------------------------------
// Step 2: Create buffers and initialize test values
// ------------------------------------------------------------------------------------
    // Create the buffers and allocate memory   
    // cl::Buffer in1_buf(context, CL_MEM_ALLOC_HOST_PTR | CL_MEM_READ_ONLY,  sizeof(int) * DATA_SIZE, NULL, &err);
    // cl::Buffer in2_buf(context, CL_MEM_ALLOC_HOST_PTR | CL_MEM_READ_ONLY,  sizeof(int) * DATA_SIZE, NULL, &err);
    // cl::Buffer out_buf(context, CL_MEM_ALLOC_HOST_PTR | CL_MEM_WRITE_ONLY, sizeof(int) * (2*DATA_SIZE) * DATA_SIZE, NULL, &err);

    //working original
    // cl::Buffer out_buf(context, CL_MEM_ALLOC_HOST_PTR | CL_MEM_WRITE_ONLY,  sizeof(long) * (frame_size/4) * frame_size, NULL, &err);
    // cl::Buffer out_buf2(context, CL_MEM_ALLOC_HOST_PTR | CL_MEM_WRITE_ONLY,  sizeof(long) * (frame_size/4) * frame_size, NULL, &err);

    //approach with "short"
    cl::Buffer out_buf0(context, CL_MEM_ALLOC_HOST_PTR | CL_MEM_WRITE_ONLY,  sizeof(short) * (frame_size) * frame_size, NULL, &err);
    // cl::Buffer out_buf2(context, CL_MEM_ALLOC_HOST_PTR | CL_MEM_WRITE_ONLY,  sizeof(short) * (frame_size) * frame_size, NULL, &err);


    // // cl::Buffer out_buf(context, CL_MEM_ALLOC_HOST_PTR | CL_MEM_WRITE_ONLY, sizeof(int) * DATA_SIZE * DATA_SIZE, NULL, &err);

    // // Map buffers to kernel arguments, thereby assigning them to specific device memory banks
    // // krnl_vector_add.setArg(0, in1_buf);
    // // krnl_vector_add.setArg(1, in2_buf);
    krnl_str2mem0.setArg(1, out_buf0);

    // // xuid_t xclbin_uuid2;
    // // xrtXclbinGetUUID(xclbin,xclbin_uuid2);

    // auto krnl = xrt::kernel(device, xclbin_uuid, "gpioreader", true);
    // auto offset = krnl.offset(1);
    // // xrtKernelHandle kernel = xrtPLKernelOpenExclusive(device, xclbin_uuid, "str2mem:{str2mem_1}");
    // // uint32_t arg_c_offset = xrtKernelArgOffset(krnl, 2);

    // // int write_data = 32;
    // int read_data;


    // std::cout << "offset = " << offset << " \n" ;


    // // krnl.write_register(offset,write_data);
    // read_data = krnl.read_register(offset);

    // std::cout << "read data  = " << read_data << " \n" ;

    // Map host-side buffer memory to user-space pointers
    // int *in1 = (int *)q.enqueueMapBuffer(in1_buf, CL_TRUE, CL_MAP_WRITE, 0, sizeof(int) * DATA_SIZE);
    // int *in2 = (int *)q.enqueueMapBuffer(in2_buf, CL_TRUE, CL_MAP_WRITE, 0, sizeof(int) * DATA_SIZE); 
    // int *out = (int *)q.enqueueMapBuffer(out_buf, CL_TRUE, CL_MAP_WRITE | CL_MAP_READ, 0, sizeof(int) * (2*DATA_SIZE) * DATA_SIZE);



    //working original
    // long *out = (long *)q.enqueueMapBuffer(out_buf, CL_TRUE, CL_MAP_WRITE | CL_MAP_READ, 0,  sizeof(long) * (frame_size/4) * frame_size);
    // long *out2 = (long *)q.enqueueMapBuffer(out_buf2, CL_TRUE, CL_MAP_WRITE | CL_MAP_READ, 0,  sizeof(long) * (frame_size/4) * frame_size);


//     //approach with "short"
    short *out0 = (short *)q.enqueueMapBuffer(out_buf0, CL_TRUE, CL_MAP_WRITE | CL_MAP_READ, 0,  sizeof(short) * (frame_size) * frame_size);
//     // short *out2 = (short *)q.enqueueMapBuffer(out_buf2, CL_TRUE, CL_MAP_WRITE | CL_MAP_READ, 0,  sizeof(short) * (frame_size) * frame_size);

//     // Initialize the vectors used in the test
//     // for(int i = 0 ; i < (2*DATA_SIZE)*DATA_SIZE ; i++){
//     for(int i = 0 ; i <  (frame_size)*frame_size ; i++){
//         // in1[i] = rand() % DATA_SIZE;
//         // in2[i] = rand() % DATA_SIZE;
//         out[i] = 0; 
//         // out2[i] = 0; 
//     }

// // ------------------------------------------------------------------------------------
// // Step 3: Run the kernel
// // ------------------------------------------------------------------------------------
//     // Set kernel arguments
//     // krnl_vector_add.setArg(0, in1_buf);
//     // krnl_vector_add.setArg(1, in2_buf);
//     // krnl_vector_add.setArg(0, out_buf);

//     //not running for Aurora test
//     // krnl_vector_add.setArg(1, DATA_SIZE);


    // krnl_vector_add.setArg(1, 8);
    // krnl_vector_add.setArg(2, 4);
    krnl_vector_add0.setArg(1, frame_size);  //running at 16pixels/clock but /16 is accounted for inside the kernel IPs
    krnl_vector_add0.setArg(2, frame_size);


    krnl_str2mem0.setArg(1, out_buf0);

    krnl_str2mem0.setArg(2, frame_size); //HSize -- with 16H 
    krnl_str2mem0.setArg(3, frame_size); //VSize



    std::cout << "All arguments are set '" << "'\n";

//     // Schedule transfer of inputs to device memory, execution of kernel, and transfer of outputs back to host memory
//     // q.enqueueMigrateMemObjects({in1_buf, in2_buf}, 0 /* 0 means from host*/); 



    q2.enqueueTask(krnl_str2mem0);


    // unsigned int microsecond = 1000000;
    // usleep(2*microsecond);

    q.enqueueTask(krnl_vector_add0);

//     // q.enqueueTask(krnl_str2mem);

    q.finish();
    // unsigned int microsecond2 = 10000;
    // usleep(10*microsecond2);
    q2.finish();

    std::cout << "Generator completed '" << "'\n";


    // q.finish();  // wait for completion of queued tasks... one could also use the event flags

    q.enqueueMigrateMemObjects({out_buf0}, CL_MIGRATE_MEM_OBJECT_HOST);


    // krnl_str2mem.setArg(1, out_buf2);


    // q.enqueueTask(krnl_vector_add);
    // q.enqueueTask(krnl_str2mem);

    // Wait for all scheduled operations to finish
    q.finish();
    // usleep(10*microsecond2);

    // // wait for completion of queued tasks... one could also use the event flags
    // q.enqueueMigrateMemObjects({out_buf2}, CL_MIGRATE_MEM_OBJECT_HOST);

    // Wait for all scheduled operations to finish
    // q.finish();

// ------------------------------------------------------------------------------------
// Step 4: Check Results and Release Allocated Resources
// ------------------------------------------------------------------------------------
    // FILE *file = fopen("Aurora_simpleHGrad_128x128.raw","wb") ;

    std::string framefilename0 = "Aurora4lane0_simpleHGrad_"+std::to_string(frame_size)+"x"+std::to_string(frame_size)+"_uint16_nframes"+std::to_string(number_of_frames)+".raw";
    std::vector<char> writable0(framefilename0.begin(),framefilename0.end());
    writable0.push_back('\0');

    FILE *file0 = fopen(&writable0[0],"wb") ;
    fwrite(out0, sizeof(short), (frame_size) * frame_size, file0);
    fclose(file0);


    std::cout << "Size of int = " << sizeof(int) << std::endl;


    // q2.finish();

    bool match = true;

    //casting into an array of short (16bit representing a pixel)
    short *outPixels = (short *)out0;


    // // short *outPixels;
    // // outPixels = &out[0];
    // // for (int i = 0 ; i < (2*DATA_SIZE)*DATA_SIZE ; i++){
    for (int i = 0 ; i < frame_size*frame_size ; i++){
        // int expected = i%(2*DATA_SIZE);
        // int expected = i%(DATA_SIZE*DATA_SIZE);
        int expected = i%(frame_size);
        if (outPixels[i] != expected){



            std::cout << "Error: Result mismatch" << std::endl;
            std::cout << "i = " << i << " CPU result = " << expected << " Device result = " << out0[i] << std::endl;
            match = false;
            break;
        }
    }

    // delete[] fileBuf;

    std::cout << "TEST " << (match ? "PASSED" : "FAILED") << std::endl; 
    return (match ? EXIT_SUCCESS : EXIT_FAILURE);
}


// ------------------------------------------------------------------------------------
// Utility functions
// ------------------------------------------------------------------------------------
std::vector<cl::Device> get_xilinx_devices() 
{
    size_t i;
    cl_int err;
    std::vector<cl::Platform> platforms;
    err = cl::Platform::get(&platforms);
    cl::Platform platform;
    for (i  = 0 ; i < platforms.size(); i++){
        platform = platforms[i];
        std::string platformName = platform.getInfo<CL_PLATFORM_NAME>(&err);
        if (platformName == "Xilinx"){
            std::cout << "INFO: Found Xilinx Platform" << std::endl;
            break;
        }
    }
    if (i == platforms.size()) {
        std::cout << "ERROR: Failed to find Xilinx platform" << std::endl;
        exit(EXIT_FAILURE);
    }
   
    //Getting ACCELERATOR Devices and selecting 1st such device 
    std::vector<cl::Device> devices;
    err = platform.getDevices(CL_DEVICE_TYPE_ACCELERATOR, &devices);
    return devices;
}
   
char* read_binary_file(const std::string &xclbin_file_name, unsigned &nb) 
{
    if(access(xclbin_file_name.c_str(), R_OK) != 0) {
        printf("ERROR: %s xclbin not available please build\n", xclbin_file_name.c_str());
        exit(EXIT_FAILURE);
    }
    //Loading XCL Bin into char buffer 
    std::cout << "INFO: Loading '" << xclbin_file_name << "'\n";
    std::ifstream bin_file(xclbin_file_name.c_str(), std::ifstream::binary);
    bin_file.seekg (0, bin_file.end);
    nb = bin_file.tellg();
    bin_file.seekg (0, bin_file.beg);
    char *buf = new char [nb];
    bin_file.read(buf, nb);
    return buf;
}
