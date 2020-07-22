# RV32I_multicycle
ALU.v : 32 bit ALU with two input 32 bit data input , 4 bit ALU_control input and output as 32 bit data and branch control signal, enabled for both signed and unsigned operations.
ALU_controls : 2 bit alu_op as input from FSM controller and gives control to ALU for different arithmetic and logic operation.
Bus_controls.v : logic to latch the buses
FSM.v : opcode and bracnch control as input and generate next state and all control signals.
inst_decoder.v : Decoder logic to seperate diffrent fields of instruction and append bits in UI offset bit
sign_extennsion : to generate immidiate , jump and branch offset.
Register.txt : 32 registers of 32 bits each are written as text file, can be read or write to access register values using register_file.v
Data_memory.txt : can be accessed using Data_Memory.v file
Instruction_mem.txt:can be accessed using Instruction_mem.v file
CPU.v :  Top module to integarte all other module.
CPU_tb.v : test bench for top module


Processor support all integer type instructions of RISC-V .
Instructions can be loaded in instruction memory in little Endian format by editing  Instruction_mem.txt file and data can be loaded in Data_Memory.txt file.
Load CPU_tb.v module to simulate the working of processor.
