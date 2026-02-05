`timescale 1ns / 1ps

module regfile(
    input logic [4:0] RR1, RR2, WRM,
    input logic [31:0] WD,
    input  logic clk,
    output logic [31:0] RD1, RD2
    );
    
    //create 32x32 reg file storage 
    reg [31:0] register [31:0];
    
    
    initial begin
        int i;
        //loop through the registers, setting values to that of their index (reg[0]=0)
        for (i=0; i<32; i+=1) begin
            register[i] = i;
        end
    end
    
    always @ (negedge clk) begin //write on the negative edge of clk
        if (WRM!=0) //R0 not written to if WRM is zero (zero register)
            register[WRM] = WD; //write the data (wD) to the appropiate register
        RD1 = register [RR1]; //set data from RR1 index to RD1
        RD2 = register [RR2]; // set data from RR2 index to RD2
    end
endmodule
