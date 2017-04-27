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
module croc(clk, hc, vc, CrocX, CrocY, CrocIn
    );
input clk;
input [9:0] hc, vc;
input [9:0] CrocX;
output reg [9:0] CrocY;
output CrocIn;

reg Croc_inX, Croc_inY;
reg CrocDir;
initial begin
	CrocDir <= 0;
end

always @(posedge clk)
begin
	if (CrocY == 8) CrocDir <= 0;
	else if (CrocY == 479) CrocDir <= 1;
end

always @(posedge clk)
begin
	if (CrocDir) CrocY <= CrocY - 4;
	else CrocY <= CrocY + 4;
end

always @(posedge clk)
begin
	if (vc >= CrocY && vc <= CrocY+150) Croc_inY <= 1;
	else Croc_inY <= 0;
	if (hc >= CrocX && hc <= CrocX+50) Croc_inX <= 1;
	else Croc_inX <= 0;
end

assign CrocIn = Croc_inX & Croc_inY;

endmodule
