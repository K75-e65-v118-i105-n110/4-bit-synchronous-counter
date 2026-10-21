`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/10/10 16:32:11
// Design Name: 
// Module Name: top_module_tb
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


module top_module_tb();
    reg clr;
    reg load;
    reg [3:0] bin;
    reg ENT_n;
    reg ENP_n;
    reg cp;
    reg rst;
    wire [3:0] seg_pos;
    wire [7:0] seg_out;

    top_module #(.TICK_DIV(10),
        .COUNT_CLK(2)) u (
        .clr(clr),
        .load(load),
        .bin(bin),
        .ENT_n(ENT_n),
        .ENP_n(ENP_n),
        .cp(cp),
        .rst(rst),
        .seg_pos(seg_pos),
        .seg_out(seg_out)
    );

    initial cp = 0;
    always #5 cp = ~cp;

    initial begin
        $dumpfile("top_module_tb.vcd");
        $dumpvars(0,top_module_tb);
        clr = 0;
        load = 0;
        bin = 4'd10;
        ENT_n = 1;
        ENP_n = 1;
        rst = 1;

        #20;
        rst = 0;

        //加载功能
        #20;
        load = 1;

        #300;
        load = 0;

        //计数功能
        ENT_n = 0;
        ENP_n = 0;

        #500;
        //保持功能
        ENP_n = 1;
        #100;

        //清零功能
        clr = 1;
        #100;
        clr = 0;

        #100;
        $finish;
    end

    initial begin
        $monitor("time=%0t clr=%d load=%d bin=%d ENT_n=%d ENP_n=%d cp=%d rst=%d seg_pos=%b seg_out=%b",
        $time,clr,load,bin,ENT_n,ENP_n,cp,rst,seg_pos,seg_out);
    end

endmodule
