//John Bergin
//002155500

`timescale 1ns / 1ps

module cpu3(input logic [31:0] ibus, input logic clk, output logic [31:0] WD);

//create necessary logic for each interconnection between registers, modules, inputs/outputs
logic ID_ALUsrc, EX_ALUsrc, V, Z, Cout;
logic [2:0] ID_ALUop, EX_ALUop;
logic [4:0] ID_rd, ID_rt, ID_rs, WR, ID_WR, EX_WR;
logic [5:0] ID_Func, ID_OpCode;
logic [15:0] ID_immv16;
logic [31:0] ID_RD1, ID_RD2, ID_immv32, EX_RD1, EX_RD2, EX_WD, EX_imm, ALU_opB;

//Create IFID registers:
register #(5) IFID_rd (.clk(clk), .D(ibus[15:11]), .Q(ID_rd));//store rd signal
register #(5) IFID_rt (.clk(clk), .D(ibus[20:16]), .Q(ID_rt));//store rt signal
register #(5) IFID_rs (.clk(clk), .D(ibus[25:21]), .Q(ID_rs));//store rs signal
register #(6) IFID_OpCode (.clk(clk), .D(ibus[31:26]), .Q(ID_OpCode));//store OpCode signal
register #(6) IFID_Func (.clk(clk), .D(ibus[5:0]), .Q(ID_Func));//store Func, signal
register #(16) IFID_Imm16 (.clk(clk), .D(ibus[15:0]), .Q(ID_immv16));//store immv16 signal

//Create IDEX registers
register #(1) IDEX_ALUsrc(.clk(clk), .D(ID_ALUsrc), .Q(EX_ALUsrc)); //store ALUsrc signal
register #(3) IDEX_ALUop(.clk(clk), .D(ID_ALUop), .Q(EX_ALUop)); //store ALUop signal
register #(5) IDEX_WR(.clk(clk), .D(ID_WR), .Q(EX_WR)); //store WR signal
register #(32) IDEX_RD1(.clk(clk), .D(ID_RD1), .Q(EX_RD1)); // store RD1 signal
register #(32) IDEX_RD2(.clk(clk), .D(ID_RD2), .Q(EX_RD2)); // store RD2 signal
register #(32) IDEX_Imm32(.clk(clk), .D(ID_immv32), .Q(EX_imm)); //store imm signal

//Create EXMEM registers
register #(32) EXMEM_WD(.clk(clk), .D(EX_WD), .Q(WD)); //store WD signal
register #(5) EXMEM_WR(.clk(clk), .D(EX_WR), .Q(WR)); //store WR signal

//module instantiations for the ID stage
controller ctrl (.ID_OpCode(ID_OpCode), .ID_Func(ID_Func), .ID_ALUsrc(ID_ALUsrc), .ID_ALUop(ID_ALUop));//create controller module
mux2to1 #(5) ID_mux(.in0(ID_rd), .in1(ID_rt), .sel(ID_ALUsrc), .out(ID_WR)); //create EX mux
signext16to32 signExt (.in(ID_immv16), .out(ID_immv32)); //create sign extension module
regfile RegFile (.RR1(ID_rs) , .RR2(ID_rt), .WRM(WR), .WD(WD), .clk(clk), .RD1(ID_RD1), .RD2(ID_RD2)); //regfile instantiation

//module instantiations for the EX. stage
alu32 ALU (.a(EX_RD1), .b(ALU_opB), .ALUop(EX_ALUop), .d(EX_WD), .Cout(Cout), .V(V), .Z(Z)); //ALU assignment
mux2to1 #(32) EX_mux (.in0(EX_RD2), .in1(EX_imm), .sel(EX_ALUsrc), .out(ALU_opB)); //EX mux assignment (32 bits)
endmodule
