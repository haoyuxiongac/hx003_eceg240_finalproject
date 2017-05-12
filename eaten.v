`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    04:07:43 04/14/2017 
// Design Name: 
// Module Name:    eaten 
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
module eaten( clk, InFrog, InCroc, dead
    );
	input clk, InFrog, InCroc;
	output reg dead;

	reg [3:0] Collision;

	always @(posedge clk)
		dead <= (InFrog&&InCroc);

endmodule
