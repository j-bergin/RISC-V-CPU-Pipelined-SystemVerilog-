//John Bergin
//002155500

`timescale 1ns / 1ps
module signext16to32(input logic [15:0] in, output logic [31:0] out);
    
    always_comb begin
        out = {{16{in[15]}}, in}; //append the input to 16 bits matching the MSB
    end
endmodule
