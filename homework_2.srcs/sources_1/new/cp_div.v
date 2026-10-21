`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/10/09 21:28:24
// Design Name: 
// Module Name: cp_div
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


module cp_div (     //分频器
    input cp,
    input rst,
    output reg cp_div
    );

    parameter TICK_DIV = 100_000_000;   //分频计数参数
    reg [31:0] count;

    always @ (posedge cp) begin
        if(rst) begin 
            count <= 32'd0;
            cp_div <= 1'b0;
        end
        else begin
            if(count == TICK_DIV/2 - 1) begin   //每计数到参数的一半就翻转，实现分频
                count <= 32'd0;
                cp_div <= ~cp_div;
            end
            else begin
                count <= count + 1;
            end
        end
    end

endmodule
