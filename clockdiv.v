`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:40:53 04/14/2017 
// Design Name: 
// Module Name:    clockdiv 
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
module clockdiv( input wire clk, output dclk
    );

	reg [16:0] q;
	
	always @(posedge clk)
		q = q+1;
	
	assign dclk = q[0];
	
	
			
	
endmodule
