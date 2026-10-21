`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/10/10 15:40:29
// Design Name: 
// Module Name: top_module
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


module top_module(
    input clr,
    input load,
    input [3:0] bin,
    input ENT_n,
    input ENP_n,
    input cp,
    input rst,
    output [3:0] seg_pos,   //输出位选
    output [7:0] seg_out    //输出段选
    );

    parameter TICK_DIV = 100_000_000;//分频器分频参数
    parameter COUNT_CLK = 10_000;//动态扫描分频参数

    wire cp_div;
    wire RCO;
    wire [3:0] Q;

    cp_div #(.TICK_DIV(TICK_DIV)) cp_div_u (    //分频模块
        .cp(cp),
        .rst(rst),
        .cp_div(cp_div)
    );

    CTRDIV16 CTRDIV16_u (   //四位同步计数器
        .clr_n(~clr),
        .load_n(~load),
        .ENT(~ENT_n),
        .ENP(~ENP_n),
        .cp(cp_div),
        .data(bin),
        .RCO(RCO),
        .Q(Q)
    );

    display #(.COUNT_CLK(COUNT_CLK)) 
    display_u (     //显示模块
        .clk(cp),
        .rst(rst),
        .hex(Q),
        .RCO(RCO),
        .pos(seg_pos),
        .seg_out(seg_out)
    );




endmodule
