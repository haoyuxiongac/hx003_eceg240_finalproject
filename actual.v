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
module actual(input wire dclk, output wire vga_h_sync,output wire vga_v_sync, 
	output reg [2:0]vga_R, output reg [2:0]vga_G, output reg [1:0]vga_B, 
	input wire[9:0] FrogX,input wire[9:0] FrogY, input wire [8:0] CrocY1, input wire[8:0] CrocY2, input wire[8:0] CrocY3, 
	output reg InFrog, output reg InCroc
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
	
	parameter [9:0]x = 152;
	parameter [9:0]y = 240;
	
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
					|| (CounterX[9:3]==97 ) || 
					(CounterY>30&&CounterY<40) || 
					(CounterY[8:3]==63);

	reg Frog_inX, Frog_inY;
	


	always @(posedge dclk)
		begin
			if(Frog_inX==0) 
				Frog_inX <= (CounterX==FrogX) ;//& Frog_inY; 
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
	


//collision

	wire Croc1, BouncingObject, Croc2, Croc3;
	assign Croc1 = (CounterY>=CrocY1+8) && (CounterY<=CrocY1+100) && (CounterX[9:4]==25);
	assign Croc2 = (CounterY>=CrocY2+8) && (CounterY<=CrocY2+100) && (CounterX[9:4]==31);
	assign Croc3 = (CounterY>=CrocY3+8) && (CounterY<=CrocY3+100) && (CounterX[9:4]==38);
	
	assign BouncingObject = Croc1 | Croc2 | Croc3; 

	always @(posedge dclk)
		begin 	
				InFrog <= Frog;
				InCroc <= BouncingObject;
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

				else if(BouncingObject)
					begin
						red = 3'b111;
						green = 3'b000;
						blue = 2'b00;
					end	
				else if(Frog)
					begin 
						red = 3'b000;
						green = 3'b111;
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
