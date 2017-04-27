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
module eaten( clk, hc, vc, Croc, FrogX, FrogY, dead
    );
input clk, Croc;
input [9:0] hc, vc;
input [9:0] FrogX, FrogY;
output dead;

reg [3:0] Collision;

always @(posedge clk)
begin 
	if(Croc & (hc==FrogX   ) & (vc==FrogY+ 16)) Collision[3]<=1;
	if(Croc & (hc==FrogX+ 32) & (vc==FrogY+ 16)) Collision[2]<=1;
	if(Croc & (hc==FrogX+ 16) & (vc==FrogY   )) Collision[1]<=1;
	if(Croc & (hc==FrogX+ 16) & (vc==FrogY+32)) Collision[0]<=1;
end	

assign dead = (Collision[3] | Collision[2] | Collision[1] | Collision[0]);

endmodule
