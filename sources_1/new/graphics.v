`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/03/2024 04:11:10 PM
// Design Name: 
// Module Name: graphics
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module graphics(
    input clk,
    input [9:0] hc,
    input [9:0] vc,
    input [6:0] mouse_x,
	input [6:0] mouse_y,
    input wire mouse_click,
    input wire mode,
    input [2:0] color_select,
    input [2:0] brush_size,
    output reg [8:0] color
    );

    `include "globals.vh"
    `include "colors.vh"

    reg [1727:0] red_grid = 1728'b0;
    reg [1727:0] blue_grid = 1728'b0;
    reg [1727:0] green_grid = 1728'b0;


    wire [6:0] x;
    wire [6:0] y;
    assign x = hc/pixel_size;
    assign y = vc/pixel_size;

    wire [11:0] coord;
    assign coord = x - initial_x + 48*(y - initial_y);

    wire [11:0] mouse_coord;
    assign mouse_coord = mouse_x - initial_x + 48*(mouse_y - initial_y);

    always @(posedge clk) begin

        if (mouse_click) begin
            if (brush_size == 2'd0 || brush_size == 2'd3) begin // smallest size
                red_grid <= (red_grid & (~(1 << mouse_coord))) | ((!mode) * color_select[2] << mouse_coord);
                green_grid <= (green_grid & (~(1 << mouse_coord))) | ((!mode) * color_select[1] << mouse_coord);
                blue_grid <= (blue_grid & (~(1 << mouse_coord))) | ((!mode) * color_select[0] << mouse_coord);

            end else if (brush_size == 2'd1 || brush_size == 2'd2) begin // middle size
                red_grid <= (red_grid & (~(medium_size << mouse_coord - 49))) | ((!mode) * color_select[2] * medium_size << mouse_coord - 49);
                green_grid <= (green_grid & (~(medium_size << mouse_coord - 49))) | ((!mode) * color_select[1] * medium_size << mouse_coord - 49);
                blue_grid <= (blue_grid & (~(medium_size << mouse_coord - 49))) | ((!mode) * color_select[0] * medium_size << mouse_coord - 49);
            end 
            
        end

    end

    always @(*) begin

        if (x >= initial_x && x <= max_x && y >= initial_y && y <= max_y) begin
            if (x == mouse_x && y == mouse_y) begin // CURSOR
                color = 9'b111000000;
            end else begin
                if (red_grid[coord] == 0 && green_grid[coord] == 0 && blue_grid[coord] == 0) begin
                    color = WHITE;
                end else if (red_grid[coord] == 1 && green_grid[coord] == 1 && blue_grid[coord] == 1) begin
                    color = BLACK;
                end else begin
                    color = {
                        red_grid[coord],    red_grid[coord],    red_grid[coord], 
                        green_grid[coord],  green_grid[coord],  green_grid[coord],
                        blue_grid[coord],   blue_grid[coord],   blue_grid[coord]    
                        };
                end
            end

        end else if (x >= min_x && x <= max_x && y >= min_y && y < initial_y) begin // for untitled paint
            if (x >= 17 && x <= 61 && y >= 5 && y <= 9 && untitled_paint[x - 17 + 45*(y - 5)]) begin    // untitled paint
                color = WHITE;
            end else if (x >= 72 && x <= 76 && y >= 5 && y <= 9 && x_sign[x - 72 + 5*(y - 5)]) begin
                color = WHITE;
            end else begin
                color = GRAY;
            end
        end else if (x >= min_x && x < initial_x && y >= initial_y && y <= max_y) begin // for the color display

            if (y >= 12 && y <= 16 && x >= 16 && x <= 20) begin  // RED
                if (y > 12 && y < 16 && x > 16 && x < 20) begin
                    color = RED;
                end else begin
                    color = BLACK;
                end 
            end else if (y >= 19 && y <= 23 && x >= 16 && x <= 20) begin // YELLO
                if (y > 19 && y < 23 && x > 16 && x < 20) begin
                    color = YELLO;
                end else begin
                    color = BLACK;
                end 
            end else if (y >= 26 && y <= 30 && x >= 16 && x <= 20) begin // GREEN
                if (y > 26 && y < 30 && x > 16 && x < 20) begin
                    color = GREEN;
                end else begin
                    color = BLACK;
                end 
            end else if (y >= 33 && y <= 37 && x >= 16 && x <= 20) begin // CYAN
                if (y > 33 && y < 37 && x > 16 && x < 20) begin
                    color = CYAN;
                end else begin
                    color = BLACK;
                end 
            end else if (y >= 40 && y <= 44 && x >= 16 && x <= 20) begin // PAINT ICON
                if (y > 40 && y < 44 && x > 16 && x < 20) begin
                    if (mode == 0 && color_select == 3'b000) begin

                        color = WHITE;

                    end else if (mode == 0 && color_select == 3'b111) begin

                       color = BLACK; 
                        
                    end else if (mode == 0) begin
                        color = {
                            color_select[2],    color_select[2],    color_select[2], 
                            color_select[1],  color_select[1],  color_select[1],
                            color_select[0],   color_select[0],   color_select[0]    
                        };
                    end else begin
                        color = GRAY;
                    end
                end else begin
                    color = BLACK;
                end 
            end else if (y >= 12 && y <= 16 && x >= 23 && x <= 27) begin  // BLUE
                if (y > 12 && y < 16 && x > 23 && x < 27) begin
                    color = BLUE;
                end else begin
                    color = BLACK;
                end 
            end else if (y >= 19 && y <= 23 && x >= 23 && x <= 27) begin // PURPLE
                if (y > 19 && y < 23 && x > 23 && x < 27) begin
                    color = PURPLE;
                end else begin
                    color = BLACK;
                end 
            end else if (y >= 26 && y <= 30 && x >= 23 && x <= 27) begin // WHITE
                if (y > 26 && y < 30 && x > 23 && x < 27) begin
                    color = WHITE;
                end else begin
                    color = BLACK;
                end 
            end else if (y >= 33 && y <= 37 && x >= 23 && x <= 27) begin // BLACK
                if (y > 33 && y < 37 && x > 23 && x < 27) begin
                    color = BLACK;
                end else begin
                    color = BLACK;
                end 
            end else if (y >= 40 && y <= 44 && x >= 23 && x <= 27) begin // ERASER ICON
                if (y > 40 && y < 44 && x > 23 && x < 27) begin
                    if (mode == 1) begin
                        color = WHITE;
                    end else begin
                        color = GRAY;
                    end
                end else begin
                    color = BLACK;
                end 
            end else if (y == 47 && x >= 16 && x <= 27) begin // 1st line of SIZE BAR
                color = BLACK;
            end else begin
                color = GRAY;
            end
            
        end else if (y >= 48 && y <= 50 && x >= 16 && x <= 27) begin
            if (y >= 48 && y < 50 && x > 16 && x < 27) begin
                if (brush_size == 2'd3) begin // LARGE
                    color = PURPLE;
                end else if (brush_size == 2'd1 || brush_size == 2'd2) begin
                    if (x > 16 && x < 23) begin
                        color = PURPLE;
                    end else begin
                        color = GRAY;
                    end
                end else if (brush_size == 2'd0) begin
                    if (x > 16 && x < 20) begin
                        color = PURPLE;
                    end else begin
                        color = GRAY;
                    end
                end
            end else begin
                color = BLACK;
            end

        end else begin
            color = GRAY;
        end

    end


endmodule
