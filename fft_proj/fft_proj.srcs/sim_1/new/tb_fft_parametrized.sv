`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/09/2023 05:36:53 PM
// Design Name: 
// Module Name: tb_fft_parametrized
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


module tb_fft_parametrized();
    reg clk;
    reg reset;
    reg signed [15:0] x_re [0:7];
    reg signed [15:0] x_im [0:7];
    wire signed [15:0] X_re [0:7];
    wire signed [15:0] X_im [0:7];

    // Instantiate the 8-point FFT module
    fft_parametrized #(.N(8), .LOG2N(3)) fft_inst (
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

    // Stimulus and monitoring
    initial begin
        clk = 0;
        reset = 1;
        x_re = '{0, 1, 2, 3, 4, 5, 6, 7};
        x_im = '{0, 0, 0, 0, 0, 0, 0, 0};

        #10 reset = 0;
        #100;

        $display("FFT Output:");
        for (integer i = 0; i < 8; i = i + 1) begin
            $display("X[%0d]: %6d + %6dj", i, X_re[i], X_im[i]);
        end

        $finish;
    end
endmodule
