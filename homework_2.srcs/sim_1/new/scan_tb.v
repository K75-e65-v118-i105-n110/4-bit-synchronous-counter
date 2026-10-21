`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2026/10/14 16:42:00
// Design Name:
// Module Name: scan_tb
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


module scan_tb();
    reg clk;
    reg rst;
    reg [7:0] dec;
    reg RCO;
    wire [3:0] pos;
    wire [7:0] seg_out;
    integer i;

    scan #(.COUNT_CLK(4)) u (
        .clk(clk),
        .rst(rst),
        .dec(dec),
        .RCO(RCO),
        .seg_out(seg_out),
        .pos(pos)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("scan_tb.vcd");
        $dumpvars(0,scan_tb);
        rst = 1;
        dec = 8'b00100001;
        RCO = 0;

        #10;
        rst = 0;

        #400;
        RCO = 1;

        #400;



        $finish;
    end

    initial begin
        $monitor("time=%0t rst=%d dec=%h RCO=%d pos=%b seg_out=%b",
        $time,rst,dec,RCO,pos,seg_out);
    end

endmodule
