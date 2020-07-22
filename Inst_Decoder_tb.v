module Inst_Decoder_tb();
reg [31:0]I_Reg;
reg PC_write;
wire [4:0] rs1,rs2,rd;
reg[6:0]opcode;
wire [11:0]imm_12,imm_B;
wire [19:0]imm_20;
wire [2:0]f_3;
initial
begin
I_Reg = 32'h00000233;
PC_write=1'b1;
#10 PC_write = 0;
#20 I_Reg = 32'h002182B3;
#30 PC_write = 1'b1;
#35 PC_write = 0;
end
initial
	begin
		
		$dumpfile("Test.vcd");
		$dumpvars(0,Inst_Decoder_tb);
end
endmodule
