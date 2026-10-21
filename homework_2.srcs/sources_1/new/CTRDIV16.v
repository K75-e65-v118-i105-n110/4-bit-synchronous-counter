`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/10/09 20:35:00
// Design Name: 
// Module Name: CTRDIV16
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


module CTRDIV16(        //四位同步计数器
    input clr_n,
    input load_n,
    input ENT,
    input ENP,
    input cp,
    input [3:0] data,
    output RCO,
    output reg [3:0] Q
    );

    always @(posedge cp ) begin
        if(!clr_n) Q <= 4'd0;   //清零端低有效清零
        else begin
            if(!load_n) Q <= data;   //置数端低有效置数
            else begin
                if((ENT&ENP) == 1'b0) Q <= Q;   //使能端高有效
                else begin
                    if(Q == 4'd15) begin
                        Q <= 4'd0;
                    end
                    else begin
                        Q <= Q + 4'd1;      //计数
                    end
                end
            end
        end
    end 

    assign RCO = (&Q)&ENT;      //进位扩展端

endmodule
