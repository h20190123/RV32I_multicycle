`include "CPU.v"
module CPU_tb();

	reg Clk,Rst;

	CPU  Multicycle_CPU(Clk,Rst);

initial 
	begin
			Clk=1'b1;
			Rst=1'b1;
			#1 Rst=1'b0;

			forever #1 Clk=~Clk;
	end

initial
	begin
		$dumpfile("Test.vcd");
		$dumpvars(0,CPU_tb);
		
		
		//#40 Rst=1'b0;

	end
endmodule