`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:41:45 04/13/2017 
// Design Name: 
// Module Name:    Game 
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
module Game(clk, vga_h_sync, vga_v_sync, vga_R, vga_G, vga_B, btnUp, btnDown, btnLeft, btnRight
		 );

	input clk;
output vga_h_sync, vga_v_sync;
output reg [2:0] vga_R, vga_G;
output reg [1:0] vga_B;
input btnUp, btnDown, btnLeft, btnRight;

wire dclk;
reg [16:0] q;
always @(posedge clk)
	q = q+1;
assign dclk =q[0];

parameter hpixels = 800;// horizontal pixels per line
parameter vlines = 521; // vertical lines per frame
parameter hpulse = 96; 	// hsync pulse length
parameter vpulse = 2; 	// vsync pulse length
parameter hbp = 144; 	// end of horizontal back porch
parameter hfp = 784; 	// beginning of horizontal front porch
parameter vbp = 31; 		// end of vertical back porch
parameter vfp = 511; 	// beginning of vertical front porch

wire inDisplayArea;
wire [9:0] CounterX;
wire [8:0] CounterY;

hvsync_generator syncgen(.clk(clk), .vga_h_sync(vga_h_sync), .vga_v_sync(vga_v_sync), 
  .inDisplayArea(inDisplayArea), .CounterX(CounterX), .CounterY(CounterY));

//border  
wire border = (CounterX[9:3]==0) || (CounterX[9:3]==79) || (CounterY[8:3]==0) || (CounterY[8:3]==59);

//Frog
parameter [9:0] defaultFrogX = 10'b0000001000;
parameter [8:0] defaultFrogY = 9'b011110000;
reg [9:0] FrogX = defaultFrogX;
reg [8:0] FrogY = defaultFrogY;
reg Frog_inX, Frog_inY;

always @(posedge dclk)
if(Frog_inX==0) Frog_inX <= (CounterX==FrogX) & Frog_inY; else Frog_inX <= !(CounterX==FrogX+32);

always @(posedge dclk)
if(Frog_inY==0) Frog_inY <= (CounterY==FrogY); else Frog_inY <= !(CounterY==FrogY+32);

wire Frog = Frog_inX & Frog_inY;

//Croc1
reg [8:0] Croc1Y;
reg Croc1dir;

always @(posedge dclk)
begin
	if (|Croc1Y) Croc1dir <= 0;
	else if (~&Croc1Y) Croc1dir <= 1;
end

always @(posedge dclk)
begin
	if (Croc1dir) Croc1Y <= Croc1Y - 1;
	else Croc1Y <= Croc1Y + 1;
end

//Croc2
reg [8:0] Croc2Y;
reg Croc2dir;

always @(posedge dclk)
begin
	if (|Croc2Y) Croc2dir <= 0;
	else if (~&Croc2Y) Croc2dir <= 1;
end

always @(posedge dclk)
begin
	if (Croc2dir) Croc2Y <= Croc2Y - 1;
	else Croc2Y <= Croc2Y + 1;
end


//collision

wire Croc1 = (CounterY>=Croc1Y+8) && (CounterY<=Croc1Y+120) && (CounterX[9:4]==20);
wire Croc2 = (CounterY>=Croc2Y+8) && (CounterY<=Croc2Y+120) && (CounterX[9:4]==30);
wire BouncingObject = Croc1 | Croc2; 

reg [3:0] Collision;
always @(posedge dclk)
begin 
	if(BouncingObject & (CounterX==FrogX   ) & (CounterY==FrogY+ 8)) Collision[3]<=1;
	if(BouncingObject & (CounterX==FrogX+16) & (CounterY==FrogY+ 8)) Collision[2]<=1;
	if(BouncingObject & (CounterX==FrogX+ 8) & (CounterY==FrogY   )) Collision[1]<=1;
	if(BouncingObject & (CounterX==FrogX+ 8) & (CounterY==FrogY+16)) Collision[0]<=1;
end	

always @(posedge dclk)
if(btnUp ^ btnDown ^ btnLeft ^ btnRight)
begin

	if(btnDown)
	begin
		if (~&FrogY)
			FrogY <= FrogY + 1;
	end
	
	else if (btnUp)
	begin
		if(|FrogY)
			FrogY <= FrogY - 1;
	end
	
	else if (btnRight)
	begin
		if (FrogX < 10'b1011111111)
			FrogX <= FrogX + 1;
	end
	
	else if (btnLeft)
	begin
		if(|FrogX)
			FrogX <= FrogX - 1;
	end
	
	if(|Collision) 
	begin
		FrogX <= defaultFrogX;
		FrogY <= defaultFrogY;
	end
end

//RGB
reg R;
reg B;
reg G;
always @(posedge dclk)
	begin
 R = ~Frog | ~border;
 G = ~BouncingObject | ~border;
 B = ~BouncingObject | ~Frog | ~border;
	end 

always @(posedge dclk)
begin
	vga_R <= (R & inDisplayArea) ? 3'b111:3'b000;
	vga_G <= (G & inDisplayArea) ? 3'b111:3'b000;
	vga_B <= (B & inDisplayArea) ? 2'b11:2'b00;
end
endmodule
