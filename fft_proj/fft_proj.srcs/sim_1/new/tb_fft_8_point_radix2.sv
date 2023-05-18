`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/10/2023 07:38:55 AM
// Design Name: 
// Module Name: tb_fft_8_point_radix2
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


module tb_fft_8_point_radix2();
    reg clk;
    reg reset;
    reg [15:0] x_re [0:7];
    reg [15:0] x_im [0:7];
    wire [15:0] X_re [0:7];
    wire [15:0] X_im [0:7];

    // Clock generation
    always #5 clk = ~clk;

    // Instantiate the 8-point FFT module
    fft_8_point_radix2 fft (
        .clk(clk),
        .reset(reset),
        .x_re(x_re),
        .x_im(x_im),
        .X_re(X_re),
        .X_im(X_im)
    );

    // Stimulus and display function
    task stimulus_and_display(input [15:0] data_re [0:7], input [15:0] data_im [0:7]);
        // Apply input data
        x_re = data_re;
        x_im = data_im;

        // Apply reset
        #10 reset = 0;
        #10 reset = 1;

        // Observe output
        #50 $display("X_re = %h %h %h %h %h %h %h %h", X_re[0], X_re[1], X_re[2], X_re[3], X_re[4], X_re[5], X_re[6], X_re[7]);
        $display("X_im = %h %h %h %h %h %h %h %h", X_im[0], X_im[1], X_im[2], X_im[3], X_im[4], X_im[5], X_im[6], X_im[7]);
    endtask

    // Test cases
    initial begin
        // Initialize
        clk = 0;
        reset = 1;

        // Test Case 1: Original test case
        stimulus_and_display({16'h0, 16'h1000, 16'h0, 16'h1000, 16'h0, 16'h1000, 16'h0, 16'h1000}, {16'h0, 16'h0, 16'h0, 16'h0, 16'h0, 16'h0, 16'h0, 16'h0});

        // Test Case 2: All inputs are zero
        stimulus_and_display({16'h0, 16'h0, 16'h0, 16'h0, 16'h0, 16'h0, 16'h0, 16'h0}, {16'h0, 16'h0, 16'h0, 16'h0, 16'h0, 16'h0, 16'h0, 16'h0});

        // Test Case 3: Real inputs only, alternating values
        stimulus_and_display({16'h1000, 16'h0, 16'h1000, 16'h0, 16'h1000, 16'h0, 16'h1000, 16'h0}, {16'h0, 16'h0, 16'h0, 16'h0, 16'h0, 16'h0, 16'h0, 16'h0});

        // Test Case 4: Imaginary inputs only, alternating values
        stimulus_and_display({16'h0, 16'h0, 16'h0, 16'h0, 16'h0, 16'h0, 16'h0, 16'h0}, {16'h1000, 16'h0, 16'h1000, 16'h0, 16'h1000, 16'h0, 16'h1000, 16'h0});
        
        // Test Case 5: Real and imaginary inputs with maximum positive values
        stimulus_and_display({16'h7FFF, 16'h7FFF, 16'h7FFF, 16'h7FFF, 16'h7FFF, 16'h7FFF, 16'h7FFF, 16'h7FFF}, {16'h7FFF, 16'h7FFF, 16'h7FFF, 16'h7FFF, 16'h7FFF, 16'h7FFF, 16'h7FFF, 16'h7FFF});

        // Test Case 6: Real and imaginary inputs with maximum negative values
        stimulus_and_display({16'h8000, 16'h8000, 16'h8000, 16'h8000, 16'h8000, 16'h8000, 16'h8000, 16'h8000}, {16'h8000, 16'h8000, 16'h8000, 16'h8000, 16'h8000, 16'h8000, 16'h8000, 16'h8000});
    
        // Test Case 7: Real and imaginary inputs with mixed positive and negative values
        stimulus_and_display({16'h1000, 16'h8000, 16'h2000, 16'h7FFF, 16'h4000, 16'h8000, 16'h6000, 16'h7FFF}, {16'h8000, 16'h1000, 16'h7FFF, 16'h2000, 16'h8000, 16'h4000, 16'h7FFF, 16'h6000});
    
        // Test Case 8: Complex sinusoidal input signal
        stimulus_and_display({16'h0, 16'h6A0B, 16'hB505, 16'hF374, 16'h0, 16'h0C8C, 16'h4AFB, 16'h08C9}, {16'h0, 16'h81F6, 16'h7D93, 16'h324D, 16'h0, 16'h7E0A, 16'h826D, 16'hDBB3});
    
        #100 $finish;
    end
endmodule
