module Inst_Decoder(I_Reg,rs1,rs2,rd,opcode,imm_12,imm_B,imm_j,imm_ui,f_3);

input [31:0]I_Reg;
output reg [4:0] rs1,rs2,rd;
output reg [6:0]opcode;
output reg [11:0]imm_12,imm_B;
output reg [19:0]imm_j;
output reg [2:0]f_3;
output reg [31:0]imm_ui;

parameter R=7'b0110011 ;
parameter I= 7'b0010011 ;
parameter S=7'b0100011 ;
parameter L=7'b0000011 ;
parameter B=7'b1100011 ;
parameter J=7'b1101111 ;
parameter LUI=7'b0110111 ;
parameter AUIPC = 7'b0010111;

always@(*)
begin
opcode = I_Reg[6:0];
if(opcode == R)
begin 
 rd = I_Reg[11:7];
 rs1= I_Reg[19:15];
 rs2= I_Reg[24:20];
 f_3= I_Reg[14:12];
end
if(opcode ==I|L)
begin
 rd = I_Reg[11:7];
 rs1= I_Reg[19:15];
 f_3= I_Reg[14:12];
 imm_12 = I_Reg[31:20];
end
if(opcode ==S )
begin 
rd = I_Reg[11:7];
rs1= I_Reg[19:15];
rs2= I_Reg[24:20];
imm_12 = {I_Reg[31:25],I_Reg[11:7]};
end
if(opcode == B)
begin
rs1 = I_Reg[19:15];
rs2 = I_Reg[24:20];
f_3 = I_Reg[14:12];
imm_B = {I_Reg[31],I_Reg[7],I_Reg[30:25],I_Reg[11:8]};
end
if(opcode==J)
begin
rd = I_Reg[11:7];
imm_j = {I_Reg[31],I_Reg[19:12],I_Reg[20],I_Reg[30:21]};
end
if (opcode == LUI||AUIPC)
begin
rd= I_Reg[11:7];
imm_ui =  {I_Reg[31:12],12'b0};
end
end
endmodule
