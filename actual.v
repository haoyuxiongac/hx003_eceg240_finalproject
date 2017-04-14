`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:49:16 04/14/2017 
// Design Name: 
// Module Name:    actual 
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
module actual(input wire dclk, output wire vga_h_sync,output wire vga_v_sync, output reg [2:0]vga_R, output reg [2:0]vga_G, output reg [1:0]vga_B, 
	input wire btnUp, input wire btnDown, input wire btnLeft, input wire btnRight 
    );
	
	parameter hpixels = 800;// horizontal pixels per line
	parameter vlines = 521; // vertical lines per frame
	parameter hpulse = 96; 	// hsync pulse length
	parameter vpulse = 2; 	// vsync pulse length
	parameter hbp = 144; 	// end of horizontal back porch
	parameter hfp = 784; 	// beginning of horizontal front porch
	parameter vbp = 31; 		// end of vertical back porch
	parameter vfp = 511; 	// beginning of vertical front porch
	
	reg[9:0] CounterX;
	reg[9:0] CounterY;
	
	always @(posedge dclk)
		begin 
			if(CounterX<hpixels -1)
				CounterX<=CounterX+1;
			else 
				begin 
					CounterX<=0;
					if(CounterY<vlines -1)
						CounterY <= CounterY+1;
					else
						CounterY<=0;
				end
		end
	
	wire border = (CounterX[9:3]==18) 
					|| (CounterX[9:3]==77 ) || 
					(CounterY[8:3]==4) || 
					(CounterY[8:3]==63);
					
	parameter [9:0] defaultFrogX = 152;
	parameter [8:0] defaultFrogY = 240;
	reg [9:0] FrogX = defaultFrogX;
	reg [8:0] FrogY = defaultFrogY;
	reg Frog_inX, Frog_inY;

	always @(posedge dclk)
		begin
			if(Frog_inX==0) 
				Frog_inX <= (CounterX==FrogX) & Frog_inY; 
			else 
				Frog_inX <= !(CounterX==FrogX+32);
		end

	always @(posedge dclk)
		begin 
			if(Frog_inY==0) 
				Frog_inY <= (CounterY==FrogY); 
			else 
				Frog_inY <= !(CounterY==FrogY+32);
		end

	wire Frog = Frog_inX & Frog_inY;
	
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
	
	assign vga_h_sync = (CounterX<hpulse) ? 1:0;
	assign vga_v_sync = (CounterY<vpulse) ? 1:0;
	
	reg[2:0] red;
	reg[2:0] green;
	reg[1:0] blue;
	
	always@(posedge dclk)
		begin
			vga_R <= red;
			vga_G <= green;
			vga_B <= blue;
		end
	
	always@(*)
	begin 
		if(CounterX<144||CounterX>=784||CounterY<31||CounterY>=511)
			begin 
				red = 3'b000;
				green = 3'b000;
				blue = 2'b00;
			end
		else
			begin 
				if (border)
					begin
						red = 3'b111;
						green = 3'b000;
						blue = 2'b11;
					end
				else if(Frog)
					begin 
						red = 3'b000;
						green = 3'b111;
						blue = 2'b00;
					end	
				else if(BouncingObject)
					begin
						red = 3'b111;
						green = 3'b000;
						blue = 2'b00;
					end	
				else
					begin
						red = 3'b111;
						green = 3'b111;
						blue = 2'b11;						
					end
			end
				
	end
						
	

endmodule
