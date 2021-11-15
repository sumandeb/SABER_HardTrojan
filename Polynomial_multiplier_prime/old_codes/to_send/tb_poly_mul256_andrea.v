`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:42:53 12/11/2019
// Design Name:   poly_mul256_parallel_in
// Module Name:   /home/andrea/Saber/saber_mult_RAM/tb_poly_mul256_andrea.v
// Project Name:  saber_mult
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: poly_mul256_parallel_in
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_poly_mul256_andrea;

	// Inputs
	reg clk;
	reg rst;
	reg acc_clear;
	reg pol_load_coeff4x;
	wire [63:0] pol_64bit_in;
	wire [63:0] s_vec_64;
	reg read;
	
	reg [8:0] i;
	reg [3327:0] pol_value; 

	// Outputs
	wire [6:0] bram_address_relative;
	wire [7:0] s_address;
	wire [63:0] coeff4x_out;
	wire [63:0] polmul_result64_out;
	wire pol_mul_done;

	// Instantiate the Unit Under Test (UUT)
	poly_mul256_parallel_in uut (
		.clk(clk), 
		.rst(rst), 
		.acc_clear(acc_clear), 
		.pol_load_coeff4x(pol_load_coeff4x), 
		.bram_address_relative(bram_address_relative), 
		.pol_64bit_in(pol_64bit_in), 
		.s_address(s_address), 
		.s_vec_64(s_vec_64),
		.read(read), 
		.coeff4x_out(coeff4x_out),
		.pol_mul_done(pol_mul_done)
	);

    s_rom rom(.clk(clk), .s_address(s_address), .s_vec_64(s_vec_64));
    pol_rom pr(.clk(clk), .bram_address_relative(bram_address_relative), .pol_64bit_in(pol_64bit_in));

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;
		acc_clear = 1;
		pol_load_coeff4x = 0;
		read = 0;

		// Wait 100 ns for global reset to finish
		#100;
        


		@(posedge clk)
			begin
				acc_clear = 0;
				rst = 0;
			end
			
		wait(pol_mul_done);
		
		@(posedge clk)
			begin
				read = 1;
			end
			
			
			

	end
    
	always #5 clk = ~clk;
	
	
	/*
	always @(posedge clk)
		begin
			case(s_address)
			7'd0: s_vec_64 = 64'b1010000110011001001100100011001010100011100110111011101100110011;
            7'd1: s_vec_64 = 64'b0001000000011001000100110010001100000010000010100010000110110001;
            7'd2: s_vec_64 = 64'b1011101010101010000110100001000000001001000010011011001110111001;
            7'd3: s_vec_64 = 64'b0001001000000011000010100001001000011001000100011010101010011010;
            7'd4: s_vec_64 = 64'b0001001000000010001000000011101000000011100110010001001110010011;
            7'd5: s_vec_64 = 64'b0001001000011001000000000010100100110011000100010000100100001010;
            7'd6: s_vec_64 = 64'b1001100100000011100100011010001100100011100110100010000000000010;
            7'd7: s_vec_64 = 64'b0001000010100010100100000001000100100001000100010001001100100011;
            7'd8: s_vec_64 = 64'b0010000110111011001010100011101100101001001100111011000100101001;
            7'd9: s_vec_64 = 64'b0000101110100011101010010011101000010011101100101010000110011011;
            7'd10: s_vec_64 = 64'b0010101110111011101110111011001010101010100110011011101100110010;
            7'd11: s_vec_64 = 64'b1010001110110001000010110010000110100010101000111010100110011011;
            7'd12: s_vec_64 = 64'b0001000010011011000010011001101100100010001000011001101110111010;
            7'd13: s_vec_64 = 64'b0010001010111010000010100010000100110000001110011011001000010011;
            7'd14: s_vec_64 = 64'b1010100100010000000000110001000110100011001100001011101100111001;
            7'd15: s_vec_64 = 64'b1010101110011011001010100001001010110010000000011001100110010011;

			default: s_vec_64 = 64'h0;
			endcase
		end	
	   */
	   
	    /*
    	always @(posedge clk)
		begin
//			$display("bram: %b\n\n",bram_address_relative);
			case(bram_address_relative)
			7'd0: pol_64bit_in = 64'b1110110100111110100000100001100010001001010111011000101001010000;
            7'd1: pol_64bit_in = 64'b1001011010111100011101010111011100000011111100101000010000000100;
            7'd2: pol_64bit_in = 64'b0001101100101110000011101110100110100010100100101100000000110000;
            7'd3: pol_64bit_in = 64'b0010001010100110101011000000100111110001110101101101100010010100;
            7'd4: pol_64bit_in = 64'b1001111000111000111010101001000001110100010100011000100111110001;
            7'd5: pol_64bit_in = 64'b0100001000010100010000110011000100011010000101011110110101000101;
            7'd6: pol_64bit_in = 64'b1110000000110010000011011110100100110101110110111011010001010111;
            7'd7: pol_64bit_in = 64'b1001001101100110001100001010001100111101001011101000011001110110;
            7'd8: pol_64bit_in = 64'b0000000110100011100001010111011101100111101110111100001001101011;
            7'd9: pol_64bit_in = 64'b1111011101101111111101011010100110000000000101110011001110101100;
            7'd10: pol_64bit_in = 64'b1010111110100101001010001000101110111010000111100101100000100111;
            7'd11: pol_64bit_in = 64'b0001101011100000110011110011101001100010000010011100010011101110;
            7'd12: pol_64bit_in = 64'b0001111010110111001110010000001000000010110010110010100111001010;
            7'd13: pol_64bit_in = 64'b0100101110000110101010011111011010011111111000110001101001001000;
            7'd14: pol_64bit_in = 64'b0111001001010111110111010000110001011100100011001000000010101110;
            7'd15: pol_64bit_in = 64'b1101101000011000100111111111011000110111000000110001001110011010;
            7'd16: pol_64bit_in = 64'b0000100110100011110000111011010010111001000100101011111100101001;
            7'd17: pol_64bit_in = 64'b1101111000111110010111000001000100001111100101011001010010001011;
            7'd18: pol_64bit_in = 64'b0111110011011001000111001000001111010101101000001010010011100111;
            7'd19: pol_64bit_in = 64'b0110111111111011110000101100001111110000110100000110010100001101;
            7'd20: pol_64bit_in = 64'b1011010111111111100100100001101111010100000010110111000101001010;
            7'd21: pol_64bit_in = 64'b1110111110111111011010110100001111010010000111101111110110001001;
            7'd22: pol_64bit_in = 64'b0101111101001000010100000001001110110100101100101000010100101111;
            7'd23: pol_64bit_in = 64'b0100100100011010011000100100001010110010111011010111101000010011;
            7'd24: pol_64bit_in = 64'b1001000100011111010101011000100101100000010110100010110110110010;
            7'd25: pol_64bit_in = 64'b1100011111111100101111011101000001110010001001100111001011000001;
            7'd26: pol_64bit_in = 64'b0010010111100101100001010111000001011010101000101010111011010100;
            7'd27: pol_64bit_in = 64'b1010000101100110001001111101100011110010011111110000111001011001;
            7'd28: pol_64bit_in = 64'b0110000000010100001010001010110110101000001110110011111110100110;
            7'd29: pol_64bit_in = 64'b1110111010100101000011101101111001011001110111010111100000001111;
            7'd30: pol_64bit_in = 64'b0010010001011100011001100010000111000011110000111100001111001110;
            7'd31: pol_64bit_in = 64'b0111100110011110101010001100010001111011100000000110110110111001;
            7'd32: pol_64bit_in = 64'b1101011010100101010101110000101111110001111011101001100000100000;
            7'd33: pol_64bit_in = 64'b1111011000011110111100111000110011000000011001110011001100010100;
            7'd34: pol_64bit_in = 64'b1011010110101101011101110101111110110111011101000000011100000101;
            7'd35: pol_64bit_in = 64'b0101100010110000011011101101111001110010010000100011000001100000;
            7'd36: pol_64bit_in = 64'b0110001100011110110011000101110001111010100110011011010110111001;
            7'd37: pol_64bit_in = 64'b0110111100110100000100010110100011010010111110101100001100010000;
            7'd38: pol_64bit_in = 64'b0110100011110111011110010001011000110111000000111100111101101101;
            7'd39: pol_64bit_in = 64'b0100001100001111100010001000000011000110110011010100010010101001;
            7'd40: pol_64bit_in = 64'b1010111010110001000101011110101100101101010110111011111000010100;
            7'd41: pol_64bit_in = 64'b0111100011010110001110110110001111110010100011011000011100001111;
            7'd42: pol_64bit_in = 64'b1111101110101001100111000110111011001000101000011000001010110110;
            7'd43: pol_64bit_in = 64'b1010101001001111110011001011011110111011011110011000011011011111;
            7'd44: pol_64bit_in = 64'b0101101101110111010000000000111011110111101001100100001011100000;
            7'd45: pol_64bit_in = 64'b1000111001110111101011010001010111100010101101100001111000000100;
            7'd46: pol_64bit_in = 64'b0001000100111010001001101011111111101111011001000100010011111111;
            7'd47: pol_64bit_in = 64'b0110100111111101010101010110111001101110111101000000100110000100;
            7'd48: pol_64bit_in = 64'b1000100110010010110010000100001101011110100010111110010110010010;
            7'd49: pol_64bit_in = 64'b1011101010010000111011101000000101001111110011101101110010110110;
            7'd50: pol_64bit_in = 64'b1001110010101000111001010010001111101011100011100001001110110110;
            7'd51: pol_64bit_in = 64'b1011011001010101000110000001101101011011011101010101110000100010;
            default: pol_64bit_in = 64'b0;
			endcase
		end	
        */
        
        
endmodule