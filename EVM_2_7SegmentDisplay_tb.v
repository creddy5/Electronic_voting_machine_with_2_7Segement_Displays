`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.10.2025 00:36:17
// Design Name: 
// Module Name: EVM_2_7SegmentDisplay_tb
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


module EVM_2_7SegmentDisplay_tb;
    // Inputs
    reg P1, P2, P3, NOTA;
    reg CLK, CLEAR;

    // Outputs
    wire [6:0] P1_VOTES_tens, P2_VOTES_tens, P3_VOTES_tens, NOTA_VOTES_tens;
    wire [6:0] P1_VOTES_ones, P2_VOTES_ones, P3_VOTES_ones, NOTA_VOTES_ones;

    // Instantiate the Unit Under Test (UUT)
    EVM_2_7SegmentDisplay uut (
        .P1(P1),
        .P2(P2),
        .P3(P3),
        .NOTA(NOTA),
        .CLK(CLK),
        .CLEAR(CLEAR),
        .P1_VOTES_tens(P1_VOTES_tens),
        .P2_VOTES_tens(P2_VOTES_tens),
        .P3_VOTES_tens(P3_VOTES_tens),
        .NOTA_VOTES_tens(NOTA_VOTES_tens),
        .P1_VOTES_ones(P1_VOTES_ones),
        .P2_VOTES_ones(P2_VOTES_ones),
        .P3_VOTES_ones(P3_VOTES_ones),
        .NOTA_VOTES_ones(NOTA_VOTES_ones)
    );

    // Clock generation
    always #5 CLK = ~CLK; // 10ns clock period

    // Test sequence
    initial begin
        // Initialize
        CLK = 0;
        CLEAR = 1;
        P1 = 0; P2 = 0; P3 = 0; NOTA = 0;
        #10;
        CLEAR = 0;

        // Simulate voting
        // P1 votes 3 times
        repeat(3) begin
            @(posedge CLK); P1 = 1; #10; P1 = 0;
        end

        // P2 votes 2 times
        repeat(2) begin
            @(posedge CLK); P2 = 1; #10; P2 = 0;
        end

        // P3 votes once
        @(posedge CLK); P3 = 1; #10; P3 = 0;

        // NOTA votes twice
        repeat(2) begin
            @(posedge CLK); NOTA = 1; #10; NOTA = 0;
        end

        // Wait and then reset
        #50;
        CLEAR = 1; #10; CLEAR = 0;

        // End simulation
        #50;
        $stop;
    end
endmodule
