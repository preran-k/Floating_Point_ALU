`timescale 1ns / 1ps



module addition(
    input sign_a,sign_b,
    input [23:0] al_man_a,al_man_b,
    output reg [24:0] res,
    output reg sign_res
    );
    
    always@(*)begin
        if(sign_a==sign_b)begin
            res=al_man_a+al_man_b;
            sign_res = sign_a;
         end
         else begin
            if(al_man_a>al_man_b)begin
                res=al_man_a-al_man_b;
                sign_res=sign_a;
            end 
            else begin
                res=al_man_b-al_man_a;
                sign_res=sign_b;
            end       
         end
     end    
endmodule
