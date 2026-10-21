`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/10/14 16:42:00
// Design Name: 
// Module Name: hex_to_dec_tb
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


module hex_to_dec_tb();
    reg [3:0] hex;
    wire [7:0] dec;
    integer i;

    hex_to_dec u (
        .hex(hex),
        .dec(dec)
    );

    initial begin
        $dumpfile("hex_to_dec_tb.vcd");
        $dumpvars(0,hex_to_dec_tb);

        for(i = 0; i < 16; i = i + 1) begin
            hex = i;
            #10;
        end

        $finish;
    end

    initial begin
        $monitor("time=%0t hex=%d dec=%d",$time,hex,dec);
    end

endmodule
