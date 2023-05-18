`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/08/2023 07:22:56 PM
// Design Name: 
// Module Name: tb_fft_radix2
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



module tb_fft_radix2();
    reg clk;
    reg reset;
    reg signed [15:0] x_re [0:3];
    reg signed [15:0] x_im [0:3];
    wire signed [15:0] X_re [0:3];
    wire signed [15:0] X_im [0:3];

    // Instantiate the FFT module
    fft_radix2 fft (
        .clk(clk),
        .reset(reset),
        .x_re(x_re),
        .x_im(x_im),
        .X_re(X_re),
        .X_im(X_im)
    );

    // Clock generation
    always begin
        #5 clk = ~clk;
    end

    // Stimulus and checking
    initial begin
        clk = 0;
        reset = 1;
        x_re[0] = 16'sd1;
        x_re[1] = 16'sd2;
        x_re[2] = 16'sd3;
        x_re[3] = 16'sd4;
        x_im[0] = 16'sd0;
        x_im[1] = 16'sd0;
        x_im[2] = 16'sd0;
        x_im[3] = 16'sd0;

        #10 reset = 0;
        #20 reset = 1;
        #30 reset = 0;
        #40;

        // Check the computed FFT against the expected output
        if (X_re[0] == 16'sd10 && X_im[0] == 16'sd0 &&
            X_re[1] == -16'sd2 && X_im[1] == -16'sd2 &&
            X_re[2] == -16'sd2 && X_im[2] == 16'sd0 &&
            X_re[3] == -16'sd2 && X_im[3] == 16'sd2) begin
            $display("PASSED: FFT output matches the expected result.");
        end else begin
            $display("FAILED: FFT output does not match the expected result.");
            $display("FFT Output:");
            $display("X[0]: %d + %dj", X_re[0], X_im[0]);
            $display("X[1]: %d + %dj", X_re[1], X_im[1]);
            $display("X[2]: %d + %dj", X_re[2], X_im[2]);
            $display("X[3]: %d + %dj", X_re[3], X_im[3]);
        end

        $finish;
    end
endmodule

