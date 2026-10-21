`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/10/14 16:53:44
// Design Name: 
// Module Name: display_tb
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


module display_tb();
    reg clk;
    reg rst;
    reg [3:0] hex;
    reg RCO;
    wire [3:0] pos;
    wire [7:0] seg_out;

    display #(.COUNT_CLK(10)) u (
        .clk(clk),
        .rst(rst),
        .hex(hex),
        .RCO(RCO),
        .pos(pos),
        .seg_out(seg_out)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("display_tb.vcd");
        $dumpvars(0,display_tb);
        rst = 1;
        hex = 4'd0;
        RCO = 0;

        #20;
        rst = 0;

        #100;
        hex = 4'd9;
        RCO = 1;

        #500;
        hex = 4'd15;
        RCO = 0;

        #500;
        $finish;
    end

    initial begin
        $monitor("time=%0t clk=%d rst=%d hex=%d RCO=%d pos=%b seg_out=%b",
        $time,clk,rst,hex,RCO,pos,seg_out);
    end

endmodule
