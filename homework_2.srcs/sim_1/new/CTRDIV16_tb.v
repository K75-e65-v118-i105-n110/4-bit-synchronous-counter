`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/10/09 20:46:56
// Design Name: 
// Module Name: CTRDIV16_tb
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


module CTRDIV16_tb();
    reg clr_n;
    reg load_n;
    reg ENT;
    reg ENP;
    reg cp;
    reg [3:0] data;
    wire RCO;
    wire [3:0] Q;

    CTRDIV16 u1 (
        .clr_n(clr_n),
        .load_n(load_n),
        .ENT(ENT),
        .ENP(ENP),
        .cp(cp),
        .data(data),
        .RCO(RCO),
        .Q(Q)
    );

    initial cp = 0;
    always #5 cp = ~cp;

    initial begin
        $dumpfile("CTRDIV16_tb.vcd");
        $dumpvars(0,CTRDIV16_tb);

        data = 6;
        clr_n = 1;
        load_n = 1;
        ENT = 0;
        ENP = 0;


        //加载功能
        #10;
        load_n = 0;

        #10;
        load_n = 1;

        //清零功能
        #10;
        clr_n = 0;

        #10;
        clr_n = 1;

        //加法计数功能及进位扩展功能
        #10;
        ENT = 1;
        ENP = 1;

        #250;
        //保持功能
        ENT = 0;
        #20;
        ENP = 0;
        ENT = 1;

        #20;
        ENP = 1;

        #20;

        $finish;

    end

    initial begin
        $monitor("time=%0t clr_n=%d load_n=%d ENT=%d ENP=%d cp=%d data=%d RCO=%d Q=%d",
        $time,clr_n,load_n,ENT,ENP,cp,data,RCO,Q);
    end

endmodule
