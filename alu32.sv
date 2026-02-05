//John Bergin
//002155500

`timescale 1ns / 1ps

module alu32(
    input logic [31:0] a, b,
    input logic [2:0] ALUop,
    output logic [31:0] d,
    output logic Cout, V, Z
);

always_comb begin
    Cout = 1'b0;
    V = 1'b0;
    
    case(ALUop)
        3'b000: {Cout, d} = a + b;           //ADD
        3'b001: d = a << b[4:0];             //SLL (shift left logical)
        3'b111: d = a & b;                   //AND
        default: d = 32'b0;
    endcase
    
    Z = (d == 32'b0);                        //Zero flag
end

endmodule