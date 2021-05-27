// extern "C" {
// 	void simple_hGradient(
// //	        const unsigned int *in1, // Read-Only Vector 1
// //	        const unsigned int *in2, // Read-Only Vector 2
// 	        unsigned int *out,       // Output Result
// 	        int size                 // Size in integer
// 	        )
// 	{
// //#pragma HLS INTERFACE m_axi port=in1 bundle=aximm1
// //#pragma HLS INTERFACE m_axi port=in2 bundle=aximm2
// #pragma HLS INTERFACE m_axi bundle=aximm1 port=out

// 	    for(int iv = 0; iv < size; ++iv)
// 	    {
// 	    	for(int ih = 0; ih < size; ++ih)
// 	    	{
// 	        out[ih+iv*size] = ih;
// 	    	}
// 	    }
// 	}
// }

#define AP_INT_MAX_W 4096
#include "ap_int.h"
#include "ap_fixed.h"
#include "ap_utils.h"
#include "hls_stream.h"
using namespace hls;


#include "ap_axi_sdata.h"

// hls::stream<ap_axiu<32,0,0,0> >

extern "C" {
	void simple_hGradient(
//	        const unsigned int *in1, // Read-Only Vector 1
//	        const unsigned int *in2, // Read-Only Vector 2
			hls::stream<ap_axiu<256,0,0,0> >& out,
	        // unsigned int *out,       // Output Result
	        
	        int Hsize ,                // Size in integer
	        int Vsize                 // Size in integer
	        )
	{
//#pragma HLS INTERFACE m_axi port=in1 bundle=aximm1
//#pragma HLS INTERFACE m_axi port=in2 bundle=aximm2
// #pragma HLS interface axis port=input 
#pragma HLS interface axis port=out
// #pragma HLS INTERFACE m_axi bundle=aximm1 port=out

ap_axiu<256,0,0,0> outWord;

int HsizeScaled = Hsize/16;

	    for(int iv = 0; iv < Vsize; ++iv)
	    {

	    	for(ap_uint<12> ih = 0; ih < HsizeScaled; ++ih)
	    	{
#pragma HLS PIPELINE II=1

	    	for(int ipix = 0; ipix < 16; ++ipix){
	    		#pragma HLS unroll

	    		outWord.data.range(( (ipix+1)*16)-1, ipix*16 ) = (ih*16) + ipix;

	    	}

	    	outWord.last = 0; 

	    	if(ih == HsizeScaled-1){
	    	outWord.last = 1; 
	    	}


	    	out.write(outWord);	
	        // out[ih+iv*size] = ih;

	    	}
	    }
	}
}
