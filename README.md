# RISC-V CPU 

This SystemVerilog implementation was completed for a course project, in the efforts of replicating a RISC-V processor with a 3 stage pipeline architecture. This project aims to demonstrate fundamental computer architecture concepts, as well as strengthen my SystemVerilog and HDL skills.

There are three pipeline stages: 
  IF (Instruction Fetch): Fetches instruction from instruction bus
  ID (Instruction Decode): Decodes instruction and reads register file
  EX (Execute): Performs ALU operations and writes back to register file. 

For the pipeline registers:
  IF/ID: Stores decoded instruction fields (OpCode, Function, rs, rt, rd, immediate)
  ID/EX: Stores control signals, register data, and immediate values
  EX/MEM: Stores ALU result and write register address

This supports both R and I-type instructions:
<img width="585" height="397" alt="image" src="https://github.com/user-attachments/assets/2edf9137-c060-4056-974e-1172503221ac" />
