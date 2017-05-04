`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:01:08 04/26/2017 
// Design Name: 
// Module Name:    HexTo7Seg 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module HexTo7Seg(
     input [3:0] A,
//    output reg [3:0] DispSelect = ~(4'b0001),
    output [7:0] SevenSegValue
    );

	assign SevenSegValue = ~( A == 4'h0 ? 8'b11111100  // Note inversion
									: A == 4'h1 ? 8'b01100000
									: A == 4'h2 ? 8'b11011010
									: A == 4'h3 ? 8'b11110010
									: A == 4'h4 ? 8'b01100110
									: A == 4'h5 ? 8'b10110110
									: A == 4'h6 ? 8'b10111110
									: A == 4'h7 ? 8'b11100000
									: A == 4'h8 ? 8'b11111110
									: A == 4'h9 ? 8'b11110110
									: A == 4'hA ? 8'b11101110
									: A == 4'hB ? 8'b00111110
									: A == 4'hC ? 8'b10011100
									: A == 4'hD ? 8'b01111010
									: A == 4'hE ? 8'b10011110
													: 8'b10001110 );
endmodule
