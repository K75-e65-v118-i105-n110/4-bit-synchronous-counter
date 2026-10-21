`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/10/10 16:32:11
// Design Name: 
// Module Name: cp_div_tb
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


module cp_div_tb();
    reg cp;
    reg rst;
    wire cp_div;

    cp_div #(.TICK_DIV(10)) u (
        .cp(cp),
        .rst(rst),
        .cp_div(cp_div)
        );

    initial cp =1;
    always #5 cp = ~cp;

    initial begin
        $dumpfile("cp_div_tb.vcd");
        $dumpvars(0,cp_div_tb);
        rst = 0;

        #100;
        rst = 1;

        #20;
        rst = 0;

        #200;
        $finish;
    end

    initial begin
        $monitor("time=%0t cp=%d rst=%d cp_div=%d",$time,cp,rst,cp_div);
    end

endmodule
