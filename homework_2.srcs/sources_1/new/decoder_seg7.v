`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/10/14 15:41:49
// Design Name: 
// Module Name: decoder_seg7
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


module decoder_seg7(        //七段译码器
    input [3:0] dec,
    output reg [7:0] seg
    );

    always @(*) begin
        case(dec)   
            4'd0: seg = 8'b00000011;
            4'd1: seg = 8'b10011111;
            4'd2: seg = 8'b00100101;
            4'd3: seg = 8'b00001101;
            4'd4: seg = 8'b10011001;
            4'd5: seg = 8'b01001001;
            4'd6: seg = 8'b01000001;
            4'd7: seg = 8'b00011111;
            4'd8: seg = 8'b00000001;
            4'd9: seg = 8'b00001001;
            default: seg = 8'b11111111;
        endcase
    end
endmodule