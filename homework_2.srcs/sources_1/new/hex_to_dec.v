`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/10/14 15:53:13
// Design Name: 
// Module Name: hex_to_dec
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


module hex_to_dec(      //十六进制转十进制
    input [3:0] hex,
    output reg [7:0] dec
    );

    always @(*) begin
        if(hex >=10) begin
            dec[7:4] = 4'd1;
            dec[3:0] = hex - 4'd10;
        end
        else begin
            dec[7:4] = 4'd10; //让高四位大于9，编码后为全灭
            dec[3:0] = hex;
        end
    end

endmodule
