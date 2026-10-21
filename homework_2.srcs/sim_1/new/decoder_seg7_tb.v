`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/10/14 16:42:00
// Design Name: 
// Module Name: decoder_seg7_tb
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


module decoder_seg7_tb();
    reg [3:0] dec;
    wire [7:0] seg;
    integer i;

    decoder_seg7 u (
        .dec(dec),
        .seg(seg)
    );

    initial begin
        $dumpfile("decoder_seg7_tb.vcd");
        $dumpvars(0,decoder_seg7_tb);

        for(i = 0; i < 16; i = i + 1) begin
            dec = i;
            #10;
        end

        $finish;
    end

    initial begin
        $monitor("time=%0t dec=%d seg=%b",$time,dec,seg);
    end

endmodule
