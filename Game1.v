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
module Game1(clk, vga_h_sync, vga_v_sync, vga_R, vga_G, vga_B, btnUp, btnDown, btnLeft, btnRight //FrogX, FrogY, CrocY1, CrocY2
    );
input clk;
output wire vga_h_sync, vga_v_sync;
output wire [2:0] vga_R, vga_G;
output wire [1:0] vga_B;
input btnUp, btnDown, btnLeft, btnRight;



	wire upClick, downClick, leftClick, rightClick;
	wire dclk, InFrog, InCroc;
	wire die;
	wire [9:0] FrogX , FrogY;
	

	
	//initial FrogX = 152;
	//initial FrogY = 240;	

	parameter CrocX1 = 300;
	parameter CrocX2 = 450;
	parameter CrocX3 = 600;
	wire [9:0] CrocY1,CrocY2,CrocY3;

	reg [18:0] counter = 0;
	reg count=0;
	 
	always @(posedge clk) 
		begin
			if(counter[18]==0) 
				begin
					counter <= counter+1;
				end
			else if(counter[18]==1)
				begin
					count <= ~count;
					counter <= 0;
				end
		end
	
	//clock conversion
	clockdiv U1(.clk(clk), .dclk(dclk));
	
	//Display in general
	//parameter defaultFrogX = 100;
	//parameter defaultFrogY = 240;
	
	debouncer debounceUp(
		.raw(btnUp),
		.clk(dclk),
		.clean(upClick)
	);
	
	debouncer debounceDown(
		.raw(btnDown),
		.clk(dclk),
		.clean(downClick)
	);
	
		debouncer debounceLeft(
		.raw(btnLeft),
		.clk(dclk),
		.clean(leftClick)
	);
	
		debouncer debounceRight(
		.raw(btnRight),
		.clk(dclk),
		.clean(rightClick)
	);

	
	 
	//position of frog
	
	frog userFrog(
		.clk(clk), 
		.die(die),
		.btnUp(upClick), 
		.btnDown(downClick), 
		.btnLeft(leftClick), 
		.btnRight(rightClick), 
		.FrogX(FrogX), 
		.FrogY(FrogY) 
		);

	//position of Croc1 
	croc Croc1(
		.clk(count),  
		.CrocY(CrocY1),
		.defaultY(108),
		.speed(1)
	);

	//position of Croc2
	croc Croc2(
		.clk(count), 
		.CrocY(CrocY2),
		.defaultY(207),
		.speed(2)
	);

	croc Croc3(
		.clk(count), 
		.CrocY(CrocY3),
		.defaultY(307),
		.speed(3)
	);
	
	actual actualp(
		.dclk(dclk), 
		.vga_h_sync(vga_h_sync),
		.vga_v_sync(vga_v_sync), 
		.vga_R(vga_R), 
		.vga_G(vga_G), 
		.vga_B(vga_B), 
		
		.FrogX(FrogX), 
		.FrogY(FrogY), 
		
		.CrocY1(CrocY1), 
		.CrocY2(CrocY2),
		.CrocY3(CrocY3),
		
		.InFrog(InFrog),
		.InCroc(InCroc)
   );
	
		eaten checkDead(
		.clk(clk),
		.InFrog(InFrog),
		.InCroc(InCroc),
		.dead(die)
	);
	/*
	always @(posedge dclk)
		die <= InFrog & InCroc;*/
	

	
endmodule
