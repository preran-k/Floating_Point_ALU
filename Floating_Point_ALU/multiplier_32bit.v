`timescale 1ns / 1ps

module multiplier_32bit(
    input clk,rst,
    input [31:0] i_a,i_b,
    input i_vld,
    output reg [31:0] o_res,
    output reg o_res_vld,
    output reg overflow
    );
    
    
    
    wire [7:0] exp_a,exp_b,exp_res;
    wire sign_a,sign_b,sign_res;
    wire [22:0] man_res;//final
    wire operation_overflow;
    
    wire [23:0] man_a,man_b;
    
    assign sign_a=i_a[31];
    assign sign_b=i_b[31];
    assign exp_a=i_a[30:23];
    assign exp_b=i_b[30:23];
    assign man_a=(exp_a==8'b0)?{1'b0,i_a[22:0]}:{1'b1,i_a[22:0]};
    assign man_b=(exp_b==8'b0)?{1'b0,i_b[22:0]}:{1'b1,i_b[22:0]};
    
    assign sign_res=sign_a^sign_b;
    
    
    wire is_zero_a=(i_a[30:0]==31'b0); //using original mantissa
    wire is_zero_b=(i_b[30:0]==31'b0);
    wire is_nan_a=((exp_a==8'b11111111)&&(i_a[22:0]!=23'b0));
    wire is_nan_b=((exp_b==8'b11111111)&&(i_b[22:0]!=23'b0));
    wire is_inf_a=((exp_a==8'b11111111)&&(i_a[22:0]==23'b0));
    wire is_inf_b=((exp_b==8'b11111111)&&(i_b[22:0]==23'b0));
    
    multiplication multiplication(.man_a(man_a),
    .man_b(man_b),
    .exp_a(exp_a),.exp_b(exp_b),
    .final_man(man_res),
    .final_exp(exp_res),
    .overflow(operation_overflow));
    
    
    always@(posedge clk or posedge rst)begin
        if(rst)begin
            o_res<=32'b0;
            o_res_vld<=1'b0;
            overflow<=1'b0;
         end
         else if(i_vld)begin
         
            if(is_nan_a||is_nan_b||((is_inf_a && is_zero_b) || (is_zero_a && is_inf_b)))begin
                o_res<=32'b01111111110000000000000000000000;
                o_res_vld<=1'b1;
                overflow<=1'b0;
            end
            else if(is_inf_a||is_inf_b)begin
                o_res<={sign_res,8'hFF,23'b0};
                o_res_vld<=1'b1;
                overflow<=1'b1;
            end
            else if(is_zero_a||is_zero_b)begin
                 o_res<={sign_res,31'b0};
                o_res_vld<=1'b1;
                overflow<=1'b0;
            end
            else if(operation_overflow)begin
                o_res <= {sign_res, 8'hFF, 23'b0}; // Overflow → Inf
                overflow <= 1'b1;
                o_res_vld<=1'b1;
            end
            else begin
                o_res<={sign_res,exp_res,man_res[22:0]};
                o_res_vld<=1'b1;
                overflow<=1'b0;
             end
            
         end 
         else o_res_vld<=1'b0;
     end
endmodule
