`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:40:00 04/14/2017 
// Design Name: 
// Module Name:    Game1 
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
module Game1(clk, vga_h_sync, vga_v_sync, vga_R, vga_G, vga_B, btnUp, btnDown, btnLeft, btnRight
    );
input clk;
output wire vga_h_sync, vga_v_sync;
output wire [2:0] vga_R, vga_G;
output wire [1:0] vga_B;
input btnUp, btnDown, btnLeft, btnRight;



	wire dclk;
	clockdiv U1(.clk(clk), .dclk(dclk));
	
	actual actualp(.dclk(dclk), .vga_h_sync(vga_h_sync),.vga_v_sync(vga_v_sync), 
	.vga_R(vga_R), .vga_G(vga_G), .vga_B(vga_B), 
	.btnUp(btnUp), .btnDown(btnDown), .btnLeft(btnLeft), .btnRight(btnRight) 
    );
	 
	 
endmodule
