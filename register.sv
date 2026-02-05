//John Bergin
//002155500

`timescale 1ns / 1ps

module register #(parameter WIDTH = 32)(
    input logic clk,
    input logic [WIDTH-1:0] D,
    output logic [WIDTH-1:0] Q
);

always_ff @(posedge clk) begin
    Q <= D;
end

endmodule