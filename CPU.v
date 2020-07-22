`include "FSM.v"
`include "Mux.v"
`include "Instruction_Mem_File.v"
`include "Inst_Decocer.v"
`include "Sign_extenssion.v"
`include "Register_File.v"
`include "BUS_Controls.v"
`include "ALU.v"
`include "ALU_controls.v"
`include "Data_Memory_File.v"
module CPU(Clk,Rst);
input Clk, Rst;
wire Write_en ,wrt_add_sel ,Mem_rd ,Mem_wr,operand_sel ,IorD,PC_Write,Flag; //Control signals
wire [ 1:0] wrt_data_sel,branch;
wire [1:0]ALU_Op;
wire [3:0]ALU_Cntrl;
wire [6:0]Opcode ;
wire [31:0] ALU_out,A,B,DI,busB,busC,extended_out,AO;
wire [31:0] PC_next,PC_offset,Jump_offset,Br_offset,IR,Imm_UI;
wire [4:0] Rs1,Rs2,Rd;
wire [11:0]Imm_12,Imm_B;
wire [19:0]Imm_J;
wire [2:0]F_3;
reg [31:0]PC;
always@(Rst)
begin
PC=32'd0;
end
always@(posedge Clk)
begin
if(PC_Write)
PC<=PC_next;
else 
PC<=PC;
end
FSM F1(Clk,Rst,Opcode[6:2],Flag,ALU_Op,Write_en ,wrt_add_sel,wrt_data_sel,operand_sel,branch ,Mem_rd ,Mem_wr ,IorD,PC_Write);
Mux  PCControl (PC_offset,32'd4,Br_offset,Jump_offset,32'd0,branch);
Instruction_Mem_File	Inst(PC,IR,IorD);
Add   PC_update(PC,PC_offset,PC_next);
Inst_Decoder   ID(IR,Rs1,Rs2,Rd,Opcode,Imm_12,Imm_B,Imm_J,Imm_UI,F_3);
sign_extend_12   SXT_I(Imm_12,extended_out);
sign_extend_20   SXT_J(Imm_J,Jump_offset);
sign_extend_13   SXT_B(Imm_B,Br_offset);
RegisterFile     RegFile(A,B,Rs1,Rs2,Rd,busC,Clk,Rst,Write_en);

	bus_B	BUSB (busB,operand_sel,B,extended_out,extended_out);

	bus_C   BUSC (busC,wrt_data_sel,ALU_out,DI,PC,Imm_UI);
ALU_Control   ALUcntrl({IR[30],F_3},ALU_Cntrl,ALU_Op);

ALU ALU0(ALU_Cntrl,A,busB,ALU_out, Flag);
assign AO=(wrt_add_sel)?PC_next: ALU_out;
DataMemoryFile  Datamem(DI,AO,busB,Mem_wr,Mem_rd,Clk,Rst);
endmodule
