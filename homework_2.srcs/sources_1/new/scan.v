`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/10/14 15:38:52
// Design Name: 
// Module Name: scan
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


module scan #(      //动态扫描模块
    parameter COUNT_CLK = 10_000
)
    (    //选位扫描，clk为100MHz，刷新率为250Hz
    input clk,
    input rst,
    input [7:0] dec,
    input RCO,
    output reg [7:0] seg_out,
    output reg [3:0] pos
    );

    wire [7:0] seg_1;
    wire [7:0] seg_2;
    reg [1:0] state;
    reg [1:0] pos_reg;      //选位寄存器
    reg [15:0] count;//计数器
    localparam S_IDLE = 2'd0,   //空状态：选位全无效
               S_SETSEG = 2'd1, //置段状态：将加载段选信号
               S_LATCH = 2'd2;  //显示状态：加载位选信号，显示内容

    decoder_seg7 seg_1_u (
        .dec(dec[3:0]),
        .seg(seg_1)
    );
    decoder_seg7 seg_2_u (      //将个位和十位分别进行七段译码
        .dec(dec[7:4]),
        .seg(seg_2)
    );

    always @(posedge clk) begin     //状态机
        if(rst) begin                       //复位
            state <= S_IDLE;
            pos_reg <= 2'd0;
            seg_out <= 8'b11111111;
            pos <= 4'b1111;
            count <= 16'd0;
        end else begin
            case(state)
                S_IDLE:begin    //空持续20个时钟周期，保证位选信号全无效，避免拖影
                    pos <= 4'b1111;
                    count <= count + 1'b1;
                    if(count >= 16'd20) begin
                        state <= S_SETSEG;
                    end
                end

                S_SETSEG:begin
                    case(pos_reg)       //根据位选寄存器的信号，决定七段显示内容
                        2'd0: seg_out <= seg_1;
                        2'd1: seg_out <= seg_2;
                        default: begin
                            if(RCO) seg_out <= 8'b11111101;
                            else seg_out <= 8'b11111111;
                        end
                    endcase
                    count <= count + 1'b1;  //持续3个时钟周期
                    if(count >= 16'd3) begin
                        count <= 16'd0;
                        state <= S_LATCH;
                    end
                end

                S_LATCH:begin
                    case(pos_reg)       //根据位选寄存器的信号，决定哪个位选有效
                        2'd0: pos <= 4'b1110;
                        2'd1: pos <= 4'b1101;
                        2'd2: pos <= 4'b1011;
                        2'd3: pos <= 4'b0111;
                    endcase
                    count <= count + 1'b1;      //持续COUNT_CLk个时钟周期
                    if(count >= COUNT_CLK) begin
                        count <= 16'd0;
                        pos_reg <= pos_reg + 2'd1;      //位选寄存器信号加一
                        pos <= 4'b1111;
                        state <= S_IDLE;
                    end
                end

                default: state <= S_IDLE;
            endcase
        end
    end


endmodule
