`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:28:19 04/26/2017 
// Design Name: 
// Module Name:    playsound 
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
module playsound(
    input clk,
	 input win,
	 input die,
	 output speaker
	 );

reg [16:0] counter;
			
always @(posedge clk)
	counter <= counter + 1;

assign speaker = (win) ? counter[16]:
			        (die) ? counter[15]:
						0;

endmodule
