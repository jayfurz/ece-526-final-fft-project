`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/08/2023 07:16:19 PM
// Design Name: 
// Module Name: fft4_radix2
// Project Name: FFT Final
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


module fft_radix2 (
    input wire clk,
    input wire reset,
    input wire [15:0] x_re [0:3],
    input wire [15:0] x_im [0:3],
    output reg [15:0] X_re [0:3],
    output reg [15:0] X_im [0:3]
);

    reg [15:0] temp_re [0:3];
    reg [15:0] temp_im [0:3];

    always @(posedge clk or negedge reset) begin
        if (!reset) begin
            temp_re[0] <= 16'b0;
            temp_im[0] <= 16'b0;
            temp_re[1] <= 16'b0;
            temp_im[1] <= 16'b0;
            temp_re[2] <= 16'b0;
            temp_im[2] <= 16'b0;
            temp_re[3] <= 16'b0;
            temp_im[3] <= 16'b0;
        end else begin
            // First stage
            temp_re[0] <= x_re[0] + x_re[2];
            temp_im[0] <= x_im[0] + x_im[2];
            temp_re[1] <= x_re[1] + x_re[3];
            temp_im[1] <= x_im[1] + x_im[3];
            temp_re[2] <= x_re[0] - x_re[2];
            temp_im[2] <= x_im[0] - x_im[2];
            temp_re[3] <= x_re[1] - x_re[3];
            temp_im[3] <= x_im[1] - x_im[3];

            // Second stage
            X_re[0] <= temp_re[0] + temp_re[1];
            X_im[0] <= temp_im[0] + temp_im[1];
            X_re[1] <= temp_re[2] - temp_im[3];
            X_im[1] <= temp_im[2] + temp_re[3];
            X_re[2] <= temp_re[0] - temp_re[1];
            X_im[2] <= temp_im[0] - temp_im[1];
            X_re[3] <= temp_re[2] + temp_im[3];
            X_im[3] <= temp_im[2] - temp_re[3];
        end
    end

endmodule

