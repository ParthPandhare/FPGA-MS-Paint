`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/03/2024 01:31:08 PM
// Design Name: 
// Module Name: mouse
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


module mouse(
    input wire clk,
    input wire rst,
    input wire btnU,
    input wire btnD,
    input wire btnL,
    input wire btnR,
    output reg [6:0] mouse_x,
    output reg [6:0] mouse_y
    );

    `include "globals.vh"

    reg [6:0] mouse_x_d = initial_x;    
    reg [6:0] mouse_y_d = initial_y;

    reg [1:0] rst_sr = 2'b0; 

    always @(posedge clk) begin

        mouse_x <= mouse_x_d;
        mouse_y <= mouse_y_d;

        rst_sr <= { rst_sr[0], rst };

    end


    always @(*) begin

        if (rst_sr == 2'b01) begin

            mouse_x_d = initial_x;
            mouse_y_d = initial_y;

        end else begin 
        
            if (btnU == 1 && mouse_y > initial_y) begin
                mouse_y_d = mouse_y - 1;
            end else if (btnD == 1 && mouse_y < max_y) begin
                mouse_y_d = mouse_y + 1;
            end else begin
                mouse_y_d = mouse_y;
            end
            
            if (btnL == 1 && mouse_x > initial_x) begin
                mouse_x_d = mouse_x - 1;
            end else if (btnR == 1 && mouse_x < max_x) begin
                mouse_x_d = mouse_x + 1;
            end else begin
                mouse_x_d = mouse_x;
            end

        end
        
    end

endmodule
