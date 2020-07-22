module Instruction_Mem_File(Address,Data,IorD);
	output    reg [31:0] Data;
	input 		[31:0]Address;
	input 	    	  	IorD;

	reg        	[ 7:0] 	imembank [0:63];  //  8x64  64B memory

initial begin 
$readmemh("Instruction_Mem.txt",imembank); end 
always@(*)
begin
if(IorD==1'b1)
	Data = {imembank[Address+3'b11],imembank[Address+2'b10],imembank[Address+2'b01],imembank[Address]} ;
	end
endmodule