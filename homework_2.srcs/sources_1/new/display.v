`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/10/14 16:13:44
// Design Name: 
// Module Name: display
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


module display(     //显示模块
    input clk,
    input rst,
    input [3:0] hex,    //四位同步计数器的数据输出
    input RCO,          //四位同不计数器进位端输出
    output [3:0] pos,   
    output [7:0] seg_out
    );

    parameter COUNT_CLK = 10_000;   //动态扫描频率参数

    wire [7:0] dec;


    scan #(.COUNT_CLK(COUNT_CLK)) scan_u (      //动态扫描模块
        .clk(clk),
        .rst(rst),
        .dec(dec),
        .RCO(RCO),
        .seg_out(seg_out),
        .pos(pos)
    );

    hex_to_dec hex_to_dec_u(        //十六进制转十进制
        .hex(hex),
        .dec(dec)
    );


endmodule
