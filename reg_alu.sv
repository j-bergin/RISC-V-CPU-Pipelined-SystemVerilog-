`timescale 1ns / 1ps

module regalu(
    input logic [4:0] RR1, RR2, WR,
    input logic clk,
    input logic [2:0] INop,
    output logic [31:0] RD1, RD2, WD    
    );
    
    //instantiate two 5 bit logic blocks for X and M
    logic [4:0] WRX, WRM;
    regfile Regfile(.*); //instantiate Regfile with corresponding params from this file
    alupipe ALUpipe (.*); //instantiate ALUpipe with corresponding params from this file
    
    
    //create Register X
    register #(5) X (.clk(clk), .D(WR), .Q (WRX));
    
    //create Register M
    register #(5) M (.clk(clk), .D(WRX), .Q (WRM));
endmodule
