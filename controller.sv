//John Bergin
//002155500

`timescale 1ns / 1ps

module controller(input logic [5:0] ID_OpCode, ID_Func, output logic ID_ALUsrc, output logic [2:0] ID_ALUop);


//SET DEFAULT VALS
always_comb begin
//handle default case
    ID_ALUsrc = 1'b0;
    ID_ALUop = 3'b000;
     
     case(ID_OpCode)
     
     //Case for ADD and I format
     6'b000011: begin 
        ID_ALUop = 3'b000;
        ID_ALUsrc = 1'b1;    
     end
     
     //Case for AND and I format
     6'b001111: begin 
        ID_ALUop = 3'b111;
        ID_ALUsrc = 1'b1;    
     end     
     
     
     //Case for R type Instrs.
     6'b000000: begin 
     ID_ALUsrc = 1'b0;//always zero when OpCode 000000
        case(ID_Func)
           6'b000011:
            ID_ALUop = 3'b000; //ADD
           6'b000010:
           ID_ALUop = 3'b001; //SLL
           6'b000111: 
            ID_ALUop = 3'b111; //AND
        endcase 
     end
     
     default: begin
        //NO OP
        ID_ALUsrc = 1'b0;
        ID_ALUop = 3'b000;
     
     end     
     endcase
end
endmodule
