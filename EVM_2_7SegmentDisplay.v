`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.10.2025 23:18:09
// Design Name: 
// Module Name: EVM_2_7SegmentDisplay
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


module EVM_2_7SegmentDisplay(
    input P1,P2,P3,NOTA,CLK,CLEAR,
    output  [6:0] P1_VOTES_tens,P2_VOTES_tens,P3_VOTES_tens,NOTA_VOTES_tens,
    output  [6:0] P1_VOTES_ones,P2_VOTES_ones,P3_VOTES_ones,NOTA_VOTES_ones
    );
    
    reg [6:0] P1_VOTES,P2_VOTES,P3_VOTES,NOTA_VOTES; 
    
    always @(posedge CLK or posedge CLEAR)
    begin
    if(CLEAR) 
    begin
    P1_VOTES <= 0;
    P2_VOTES <= 0;
    P3_VOTES <= 0;
    NOTA_VOTES <= 0;
    end
    else
    begin
    if(P1) P1_VOTES <= P1_VOTES+1;
    else if(P2) P2_VOTES <= P2_VOTES+1;
    else if(P3) P3_VOTES <= P3_VOTES+1;
    else if(NOTA) NOTA_VOTES <= NOTA_VOTES+1;
    end
    end
    
    wire [3:0] P1_tens = P1_VOTES / 10;
    wire [3:0] P1_ones = P1_VOTES % 10;
    wire [3:0] P2_tens = P2_VOTES / 10;
    wire [3:0] P2_ones = P2_VOTES % 10;
    wire [3:0] P3_tens = P3_VOTES / 10;
    wire [3:0] P3_ones = P3_VOTES % 10;
    wire [3:0] N_tens  = NOTA_VOTES / 10;
    wire [3:0] N_ones  = NOTA_VOTES % 10;

    // Instantiate display decoders
    DisplayDecoder D1_tens (.in(P1_tens), .out(P1_VOTES_tens));
    DisplayDecoder D1_ones (.in(P1_ones), .out(P1_VOTES_ones));

    DisplayDecoder D2_tens (.in(P2_tens), .out(P2_VOTES_tens));
    DisplayDecoder D2_ones (.in(P2_ones), .out(P2_VOTES_ones));

    DisplayDecoder D3_tens (.in(P3_tens), .out(P3_VOTES_tens));
    DisplayDecoder D3_ones (.in(P3_ones), .out(P3_VOTES_ones));

    DisplayDecoder DN_tens (.in(N_tens),  .out(NOTA_VOTES_tens));
    DisplayDecoder DN_ones (.in(N_ones),  .out(NOTA_VOTES_ones));
      
endmodule

module DisplayDecoder(
    input [3:0] in,
    output reg [6:0] out
);
    always @(*) begin
    case (in)
            4'd0: out = 7'b0000001; // 0
            4'd1: out = 7'b1001111; // 1
            4'd2: out = 7'b0010010; // 2
            4'd3: out = 7'b0000110; // 3
            4'd4: out = 7'b1001100; // 4
            4'd5: out = 7'b0100100; // 5
            4'd6: out = 7'b0100000; // 6
            4'd7: out = 7'b0001111; // 7
            4'd8: out = 7'b0000000; // 8
            4'd9: out = 7'b0000100; // 9
            default: out = 7'b1111111; // blank/off
        endcase
    end
endmodule
