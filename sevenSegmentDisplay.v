`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:58:14 04/26/2017 
// Design Name: 
// Module Name:    sevenSegmentDisplay 
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
module sevenSegmentDisplay(
    input [15:0] A,
    input clk,
    output [7:0] segments,
    output reg [3:0] digitselect
    );

	reg [18:0] counter = 0;
	wire [1:0] toptwo;
	reg [3:0] value4bit;
	
	always @(posedge clk)
		counter <= counter + 1;
	
	assign toptwo[1:0] = counter[18:17];
	
	always @(*)
	case(toptwo)
		2'b00:begin
			digitselect = ~4'b0001;
			value4bit = A[3:0];
		end
		2'b01:begin
			digitselect = ~4'b0010;
			value4bit = A[7:4];
		end
		2'b10:begin
			digitselect = ~4'b0100;
			value4bit = A[11:8];
		end
		2'b11:begin
			digitselect = ~4'b1000;
			value4bit = A[15:12];
		end
	endcase
	
	HexTo7Seg myhexencoder(value4bit, segments);
	
endmodule
