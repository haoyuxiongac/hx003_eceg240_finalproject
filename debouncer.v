`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:25:36 04/26/2017 
// Design Name: 
// Module Name:    debouncer 
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
module debouncer(
	input raw,
	input clk,
	output reg clean
	);
	
	parameter N = 19;
	reg [N:0] count;
	
	always @(posedge clk) begin
		count <= (raw != clean) ? count+1 : 0;
		clean <= (count[N] == 1 && count[N-1]==1) ? raw : clean;
	end

endmodule
