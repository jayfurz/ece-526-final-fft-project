`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/09/2023 10:16:58 PM
// Design Name: 
// Module Name: constant_multiplier_7071
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


module constant_multiplier_7071 (
    input wire signed [15:0] x,
    output wire signed [15:0] y
);

    wire signed [15:0] rsh1, rsh3, rsh4, rsh6, rsh8;
    wire signed [15:0] sum1, sum2;

    // Right shifts
    assign rsh1 = x >>> 1; // x / 2
    assign rsh3 = x >>> 3; // x / 8
    assign rsh4 = x >>> 4; // x / 16
    assign rsh6 = x >>> 6; // x / 64
    assign rsh8 = x >>> 8; // x / 256

    // Summation
    assign sum1 = rsh1 + rsh3;
    assign sum2 = rsh4 + rsh6;

    // Final result
    assign y = sum1 + sum2 + rsh8;

endmodule
