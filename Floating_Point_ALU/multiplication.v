`timescale 1ns / 1ps

module multiplication(
    input [23:0] man_a,
    input [23:0] man_b,
    input [7:0] exp_a,exp_b,
    output [22:0] final_man,
    output [7:0] final_exp,
    output overflow
    );
    
    wire [47:0] product=man_a*man_b;
    
    wire norm=product[47];
    
    wire [22:0] norm_man=norm?product[46:24]:product[45:23];
    //round up
    wire gaurd=norm?product[23]:product[22];
    wire sticky=norm?|product[22:0]:|product[21:0];
    wire round=gaurd&norm;
    
    wire [23:0] rounded_man={1'b0,norm_man}+round;
    wire carry=rounded_man[23];
    assign final_man=carry?rounded_man[23:1]:rounded_man[22:0];
    wire [9:0] exp_temp=exp_a+exp_b-8'd127+norm+carry;
    assign final_exp=exp_temp[7:0];
    assign overflow=(exp_temp>8'd254);
    
endmodule
