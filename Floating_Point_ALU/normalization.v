`timescale 1ns / 1ps

module normalization(
    input [24:0] res,
    input [7:0] exp_base,
    output reg [23:0] man_res,
    output reg [7:0] exp_res,
    output reg overflow
    );
    
    reg [24:0] normalized_res;
    integer i;
    always@(*)begin
        normalized_res=res;
        exp_res=exp_base;
        if(normalized_res[24])begin
            normalized_res=normalized_res>>1;
            exp_res=exp_base+1;
        end
        else begin
            for(i=0; i<24; i=i+1) begin
            if(normalized_res[23]==0 && exp_res>0) begin
                normalized_res = normalized_res << 1;
                exp_res = exp_res - 1;
            end
            end
        end
        
        man_res=normalized_res[23:0];
        overflow=(exp_res==8'b11111111);
    end
endmodule
