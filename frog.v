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
module frog(clk, die, btnUp, btnDown, btnLeft, btnRight, FrogX, FrogY, score, win
    );
	input clk, die;
	input btnUp, btnDown, btnLeft, btnRight;
	output reg [15:0] score;
	output reg [9:0] FrogX, FrogY;
	
	initial begin
		FrogX = 152;
		FrogY = 240;
		end
		
	wire move;
	output win;
	assign move = btnUp | btnDown | btnLeft | btnRight | die;

	assign win = (FrogX>= 730);

	always @(posedge move)

		begin
			if(die)
				begin
					FrogX <= 152;
					FrogY <= 240;
					score <= 0;
				end
			else
				begin
					if(btnDown)
						begin
							if (FrogY < 471)
								FrogY <= FrogY + 16;
						end
				   else if (btnUp)
						begin
							if(FrogY > 40)
								FrogY <= FrogY - 16;
						end
					
					 else if (btnRight)
						begin
							if (FrogX < 730)
								FrogX <= FrogX + 16;
							else if(FrogX>= 730)
								begin 
									FrogX <= 152;
									FrogY <= 240;	
									score <= score+1;
								end
									
								
						end
					else if (btnLeft)
						begin
							if(FrogX > 152)
								FrogX <= FrogX - 16;
					   end

					else 
						begin
							FrogX <= FrogX;
							FrogY <= FrogY;	
						end
					


				end
		end



endmodule
