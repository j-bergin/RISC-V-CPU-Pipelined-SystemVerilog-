//John Bergin
//002155500

`timescale 1ns / 1ps

module mux2to1#(parameter size = 32)(input logic [size-1:0] in1, in0, input logic sel, output logic [size-1:0] out);
assign out= sel? in1: in0; //sel is 1, in1 chosen, else in0
endmodule
