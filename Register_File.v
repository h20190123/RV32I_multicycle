module RegisterFile(Op_A,Op_B,rs1,rs2,rd,writeData,Clk,Rst,write_en);
	output     reg[31:0] Op_A,Op_B;
	input 		[31:0] writeData;
	input      	[ 4:0] rs1,rs2,rd;
	input 	    	  Clk,write_en,Rst;

	reg       	 [31:0] registerbank [0:31];

	always @(posedge Clk) 
	begin
		if(~Rst) 
			begin
			 	$readmemh("Reg_File.txt",registerbank);
			 end
		Op_A = registerbank[rs1] ;
	 Op_B = registerbank[rs2];
	end
	

	 

	always @(negedge Clk) 
	begin
			registerbank[0] <= 32'd0;
		if(write_en)
			registerbank[rd] <= writeData;
	end
endmodule
