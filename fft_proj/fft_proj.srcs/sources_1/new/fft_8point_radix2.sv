`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/09/2023 05:54:28 PM
// Design Name: 
// Module Name: fft_8point_radix2
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


module fft_8_point_radix2 (
    input wire clk,
    input wire reset,
    input wire [15:0] x_re [0:7],
    input wire [15:0] x_im [0:7],
    output wire [15:0] X_re [0:7],
    output wire [15:0] X_im [0:7]
);

// Intermediate registers for the outputs of fft0 and fft1
reg [15:0] fft0_out_re [0:3], fft0_out_im [0:3];
reg [15:0] fft1_out_re [0:3], fft1_out_im [0:3];

// Instantiate two 4-point radix-2 FFT modules
fft_radix2 fft0 (
    .clk(clk),
    .reset(reset),
    .x_re({x_re[0], x_re[2], x_re[4], x_re[6]}),
    .x_im({x_im[0], x_im[2], x_im[4], x_im[6]}),
    .X_re(fft0_out_re),
    .X_im(fft0_out_im)
);

fft_radix2 fft1 (
    .clk(clk),
    .reset(reset),
    .x_re({x_re[1], x_re[3], x_re[5], x_re[7]}),
    .x_im({x_im[1], x_im[3], x_im[5], x_im[7]}),
    .X_re(fft1_out_re),
    .X_im(fft1_out_im)
);

// Intermediate registers for after multiplication by twiddle factors of fft1
reg [15:0] fft1_out_re_mult [0:3], fft1_out_im_mult [0:3];
assign fft1_out_re_mult[0] = fft1_out_re[0];
assign fft1_out_im_mult[0] = fft1_out_im[0];
assign fft1_out_re_mult[2] = -fft1_out_im[2];
assign fft1_out_im_mult[2] = fft1_out_re[2];

complex_multiplier_7071 multiplier_1 (
    .real_in(fft1_out_re[1]),
    .imag_in(fft1_out_im[1]),
    .sign(0),
    .real_out(fft1_out_re_mult[1]),
    .imag_out(fft1_out_im_mult[1])
);

complex_multiplier_7071 multiplier_3 (
    .real_in(fft1_out_re[3]),
    .imag_in(fft1_out_im[3]),
    .sign(1),
    .real_out(fft1_out_re_mult[3]),
    .imag_out(fft1_out_im_mult[3])
);

// Combine the outputs of the two FFT modules using the twiddle factors
assign X_re[0] = fft0_out_re[0] + fft1_out_re_mult[0];
assign X_im[0] = fft0_out_im[0] + fft1_out_im_mult[0];
assign X_re[1] = fft0_out_re[1] + fft1_out_re_mult[1];
assign X_im[1] = fft0_out_im[1] + fft1_out_im_mult[1];
assign X_re[2] = fft0_out_re[2] + fft1_out_re_mult[2];
assign X_im[2] = fft0_out_im[2] + fft1_out_im_mult[2];
assign X_re[3] = fft0_out_re[3] + fft1_out_re_mult[3];
assign X_im[3] = fft0_out_im[3] + fft1_out_im_mult[3];
assign X_re[4] = fft0_out_re[0] - fft1_out_re_mult[0];
assign X_im[4] = fft0_out_im[0] - fft1_out_im_mult[0];
assign X_re[5] = fft0_out_re[1] - fft1_out_re_mult[1];
assign X_im[5] = fft0_out_im[1] - fft1_out_im_mult[1];
assign X_re[6] = fft0_out_re[2] - fft1_out_re_mult[2];
assign X_im[6] = fft0_out_im[2] - fft1_out_im_mult[2];
assign X_re[7] = fft0_out_re[3] - fft1_out_re_mult[3];
assign X_im[7] = fft0_out_im[3] - fft1_out_im_mult[3];

endmodule

