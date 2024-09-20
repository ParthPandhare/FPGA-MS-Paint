`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:28:25 03/19/2013 
// Design Name: 
// Module Name:    NERP_demo_top 
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
module NERP_demo_top(
	input wire clk,			//master clock = 100MHz
	input wire btnU,			
	input wire btnD,			
	input wire btnL,			
	input wire btnR,			
	input wire btnC,
	input wire rst,		
	input wire mode,	
	input wire [2:0] color_select,
	input wire [1:0] brush_size,
//	output wire [6:0] seg,	//7-segment display LEDs
//	output wire [3:0] an,	//7-segment display anode enable
//	output wire dp,			//7-segment display decimal point
	output wire [2:0] red,	//red vga output - 3 bits
	output wire [2:0] green,//green vga output - 3 bits
	output wire [2:0] blue,	//blue vga output - 3 bits
	output wire hsync,		//horizontal sync out
	output wire vsync			//vertical sync out
	);
	

// 7-segment clock interconnect
wire segclk;

// VGA display clock interconnect
wire dclk;

// disable the 7-segment decimal points
assign dp = 1;

// mouse clock
wire mouseclk;
wire paintclk;

// generate 7-segment clock & display clock
clockdiv U1(
	.clk(clk),
	.clr(rst),
	.segclk(segclk),
	.dclk(dclk),
	.mouseclk(mouseclk),
	.paintclk(paintclk)
	);

// 7-segment display controller
// segdisplay U2(
// 	.segclk(segclk),
// 	.clr(clr),
// 	.seg(seg),
// 	.an(an)
// 	);

wire [6:0] mouse_x;
wire [6:0] mouse_y;

wire [8:0] color;

// Mouse module
mouse U2(
	.clk(mouseclk),
	.rst(rst),
	.btnU(btnU),
	.btnD(btnD),
	.btnL(btnL),
	.btnR(btnR),
	.mouse_x(mouse_x),
	.mouse_y(mouse_y)
);

wire [9:0] hc;
wire [9:0] vc;

// VGA controller
vga640x480 U3(
	.dclk(dclk),
	.clr(rst),
	.color(color),
	.hsync(hsync),
	.vsync(vsync),
	.red(red),
	.green(green),
	.blue(blue),
	.hc(hc),
	.vc(vc)
	);

graphics U4(
	.clk(paintclk),
	.hc(hc),
	.vc(vc),
	.mouse_x(mouse_x),
	.mouse_y(mouse_y),
	.mouse_click(btnC),
	.mode(mode),
	.color_select(color_select),
	.brush_size(brush_size),
	.color(color)
	);
 

endmodule
