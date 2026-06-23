`timescale 1ns / 1ps
module alu(
    input clk,rst,
    input [31:0] i_a,i_b,
    input opcode,
    input i_vld,
    output reg [31:0] o_res,
    output reg overflow,
    output reg o_res_vld
    );
    
    wire [31:0] add_o_res,mul_o_res;
    wire add_overflow,mul_overflow;
    wire add_o_res_vld,mul_o_res_vld;
    
    adder_32bit u1(.clk(clk),.rst(rst),
    .i_a(i_a),.i_b(i_b),
    .i_vld(i_vld),
    .o_res(add_o_res),
    .o_res_vld(add_o_res_vld),
    .overflow(add_overflow));
    
    multiplier_32bit u2(
    .clk(clk),.rst(rst),
    .i_a(i_a),.i_b(i_b),
    .i_vld(i_vld),
    .o_res(mul_o_res),
    .o_res_vld(mul_o_res_vld),
    .overflow(mul_overflow)
    );
    
    
    always@(*)begin
        case(opcode)
        1'b0:begin
            o_res=add_o_res;
            overflow=add_overflow;
            o_res_vld=add_o_res_vld;
         end
         1'b1:begin
            o_res=mul_o_res;
            overflow=mul_overflow;
            o_res_vld=mul_o_res_vld;
         end
         default:begin
            o_res=32'b0;
            overflow=1'b0;
            o_res_vld=1'b0;
          end
        endcase
     end
endmodule
