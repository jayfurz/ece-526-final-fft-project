`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/09/2023 10:24:52 PM
// Design Name: 
// Module Name: complex_multiplier
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


module complex_multiplier_7071 (
    input wire [15:0] real_in,
    input wire [15:0] imag_in,
    input wire sign, // 0: multiply by (+0.7071 - 0.7071j), 1: multiply by (-0.7071 - 0.7071j)
    output wire [15:0] real_out,
    output wire [15:0] imag_out
);

    wire [15:0] real_in_mult, imag_in_mult;

    constant_multiplier_7071 multiplier_real (
        .x(real_in),
        .y(real_in_mult)
    );

    constant_multiplier_7071 multiplier_imag (
        .x(imag_in),
        .y(imag_in_mult)
    );

    assign real_out = (sign == 0) ? real_in_mult - imag_in_mult : real_in_mult + imag_in_mult;
    assign imag_out = (sign == 0) ? real_in_mult + imag_in_mult : real_in_mult - imag_in_mult;

endmodule
