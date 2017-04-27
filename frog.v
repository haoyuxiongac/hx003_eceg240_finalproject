`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:17:37 04/14/2017 
// Design Name: 
// Module Name:    frog 
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
module frog(clk, hc, vc, btnUp, btnDown, btnLeft, btnRight, FrogX, FrogY, FrogIn
    );
input clk;
input [9:0] hc, vc;
input btnUp, btnDown, btnLeft, btnRight;
output reg [9:0] FrogX, FrogY;
output FrogIn;

parameter defaultFrogX = 100;
parameter defaultFrogY = 240;

initial begin
	FrogX = defaultFrogX;
	FrogY = defaultFrogY;
end

reg Frog_inX, Frog_inY;

always @(posedge clk)
begin
	if (hc >= FrogX && hc <= FrogX+32) Frog_inX <= 1;
	else Frog_inX <= 0;
	if (vc >= FrogY && vc <= FrogY+32) Frog_inY <= 1;
	else Frog_inY <= 0;
end

always @(posedge clk)
begin
	if(btnDown)
	begin
		if (FrogY < 471)
			FrogY <= FrogY + 8;
	end
	
	if (btnUp)
	begin
		if(FrogY > 8)
			FrogY <= FrogY - 8;
	end
	
	if (btnRight)
	begin
		if (FrogX < 631)
			FrogX <= FrogX + 8;
	end
	
	if (btnLeft)
	begin
		if(FrogX > 8)
			FrogX <= FrogX - 8;
	end
end

assign FrogIn = Frog_inX & Frog_inY;

endmodule
