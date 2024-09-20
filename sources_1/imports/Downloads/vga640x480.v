`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:30:38 03/19/2013 
// Design Name: 
// Module Name:    vga640x480 
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
module vga640x480(
	input wire dclk,			//pixel clock: 25MHz
	input wire clr,			//asynchronous reset
	input [8:0] color,
	output wire hsync,		//horizontal sync out
	output wire vsync,		//vertical sync out
	output reg [2:0] red,	//red vga output
	output reg [2:0] green, //green vga output
	output reg [2:0] blue,	//blue vga output
	output reg [9:0] hc,
	output reg [9:0] vc
	);

	`include "colors.vh"
	`include "globals.vh"


// // registers for storing the horizontal & vertical counters
// reg [9:0] hc;
// reg [9:0] vc;


// Horizontal & vertical counters --
// this is how we keep track of where we are on the screen.
// ------------------------
// Sequential "always block", which is a block that is
// only triggered on signal transitions or "edges".
// posedge = rising edge  &  negedge = falling edge
// Assignment statements can only be used on type "reg" and need to be of the "non-blocking" type: <=
always @(posedge dclk or posedge clr)
begin
	// reset condition
	if (clr == 1) begin
		hc <= 0;
		vc <= 0;
	end else begin
		// keep counting until the end of the line
		if (hc < hpixels - 1) begin
			hc <= hc + 1;
		end else
		// When we hit the end of the line, reset the horizontal
		// counter and increment the vertical counter.
		// If vertical counter is at the end of the frame, then
		// reset that one too.
		begin
			hc <= 0;
			if (vc < vlines - 1)
				vc <= vc + 1;
			else
				vc <= 0;
		end
		
	end
end

// generate sync pulses (active low)
// ----------------
// "assign" statements are a quick way to
// give values to variables of type: wire
assign hsync = (hc < hpulse) ? 0:1;
assign vsync = (vc < vpulse) ? 0:1;

// reg [9:0] h_black []

// display 100% saturation colorbars
// ------------------------
// Combinational "always block", which is a block that is
// triggered when anything in the "sensitivity list" changes.
// The asterisk implies that everything that is capable of triggering the block
// is automatically included in the sensitivty list.  In this case, it would be
// equivalent to the following: always @(hc, vc)
// Assignment statements can only be used on type "reg" and should be of the "blocking" type: =
always @(*) begin

	{red, green, blue} = color;
	
	// if (vc >= vbp && vc < vfp && hc >= hbp && hc < hfp) begin
	// 	{red, green, blue} = 9'b111111111;
	// end else begin
	// 	{red, green, blue} = 9'b0;
	// end

end
// 	if (vc >= vbp && vc < vfp)
// 	begin
// 		// now display different colors every 80 pixels
// 		// while we're within the active horizontal range
// 		// -----------------
// 		// display white bar
// 		if (hc >= hbp && hc < (hbp+80))
// 		begin
// 			red = 3'b111;
// 			green = 3'b111;
// 			blue = 3'b111;
// 		end
// 		// display yellow bar
// 		else if (hc >= (hbp+80) && hc < (hbp+160))
// 		begin
// 			red = 3'b111;
// 			green = 3'b111;
// 			blue = 3'b000;
// 		end
// 		// display cyan bar
// 		else if (hc >= (hbp+160) && hc < (hbp+240))
// 		begin
// 			red = 3'b000;
// 			green = 3'b111;
// 			blue = 3'b111;
// 		end
// 		// display green bar
// 		else if (hc >= (hbp+240) && hc < (hbp+320))
// 		begin
// 			red = 3'b000;
// 			green = 3'b111;
// 			blue = 3'b000;
// 		end
// 		// display magenta bar
// 		else if (hc >= (hbp+320) && hc < (hbp+400))
// 		begin
// 			red = 3'b111;
// 			green = 3'b000;
// 			blue = 3'b111;
// 		end
// 		// display red bar
// 		else if (hc >= (hbp+400) && hc < (hbp+480))
// 		begin
// 			red = 3'b111;
// 			green = 3'b000;
// 			blue = 3'b000;
// 		end
// 		// display blue bar
// 		else if (hc >= (hbp+480) && hc < (hbp+560))
// 		begin
// 			red = 3'b000;
// 			green = 3'b000;
// 			blue = 3'b111;
// 		end
// 		// display black bar
// 		else if (hc >= (hbp+560) && hc < (hbp+640))
// 		begin
// 			red = 4'b000;
// 			green = 4'b000;
// 			blue = 4'b000;
// 		end
// 		// we're outside active horizontal range so display black
// 		else
// 		begin
// 			red = 0;
// 			green = 0;
// 			blue = 0;
// 		end
// 	end
// 	// we're outside active vertical range so display black
// 	else
// 	begin
// 		red = 0;
// 		green = 0;
// 		blue = 0;
// 	end

endmodule
