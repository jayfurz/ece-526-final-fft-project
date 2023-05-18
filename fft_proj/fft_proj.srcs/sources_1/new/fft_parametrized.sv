`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/09/2023 05:34:44 PM
// Design Name: 
// Module Name: fft_parametrized
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

module fft_parametrized #(parameter N = 4, parameter LOG2N = 2) (
    input wire clk,
    input wire reset,
    input wire signed [15:0] x_re [0:(N-1)],
    input wire signed [15:0] x_im [0:(N-1)],
    output wire signed [15:0] X_re [0:(N-1)],
    output wire signed [15:0] X_im [0:(N-1)]
);

// Bit reversal function
function [LOG2N-1:0] bit_reverse;
    input [LOG2N-1:0] index;
    integer i;
    begin
        bit_reverse = 0;
        for (i = 0; i < LOG2N; i = i + 1) begin
            bit_reverse = {bit_reverse[LOG2N-2:0], index[i]};
        end
    end
endfunction


// FFT stages
genvar i, j;
generate
    for (i = 0; i < LOG2N; i = i + 1) begin : FFT_STAGE
        for (j = 0; j < N/2; j = j + 1) begin : BUTTERFLY
            wire signed [15:0] twiddle_factor_re;
            wire signed [15:0] twiddle_factor_im;
            reg signed [15:0] twiddle_factor_re_reg;
            reg signed [15:0] twiddle_factor_im_reg;
            integer k;

            k = (j << (LOG2N - i - 1)) % N;
            assign twiddle_factor_re = 16'sd(1 << 15) * cos(2 * 3.14159265359 * k / N);
            assign twiddle_factor_im = -16'sd(1 << 15) * sin(2 * 3.14159265359 * k / N);

            always @* begin
                twiddle_factor_re_reg = twiddle_factor_re;
                twiddle_factor_im_reg = twiddle_factor_im;
            end

            butterfly #(
                .twiddle_factor_re(twiddle_factor_re_reg),
                .twiddle_factor_im(twiddle_factor_im_reg)
            ) B (
                .clk(clk),
                .reset(reset),
                .x_re0(x_re[j + (N >> (i + 1))]),
                .x_im0(x_im[j + (N >> (i + 1))]),
                .x_re1(x_re[j]),
                .x_im1(x_im[j]),
                .X_re0(X_re[bit_reverse[j + (N >> (i + 1))]]),
                .X_im0(X_im[bit_reverse[j + (N >> (i + 1))]]),
                .X_re1(X_re[bit_reverse[j]]),
                .X_im1(X_im[bit_reverse[j]])
            );
        end
    end
endgenerate


endmodule
