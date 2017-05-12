`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:38:12 04/14/2017 
// Design Name: 
// Module Name:    croc 
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
module croc(clk,  CrocY, defaultY, speed
    );
	input clk;
	input [9:0] defaultY;
	input [3:0] speed;
	output reg [9:0] CrocY;


	reg CrocDir;
	initial begin
		CrocDir = 0;
		CrocY = defaultY;
	end
	
	wire[3:0] crocSpeed ;
	assign crocSpeed = speed;

	always @(posedge clk)
		begin
			if (CrocY < 16) CrocDir <= 0;
			else if (CrocY > 400) CrocDir <= 1;
		end

	always @(posedge clk)
		begin
			if (CrocDir) CrocY <= CrocY - crocSpeed;
			else CrocY <= CrocY + crocSpeed;
		end


endmodule
