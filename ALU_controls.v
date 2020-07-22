module ALU_Control(func,alu_cntrl,alu_op); //out is the control signal to the alu which will tell it the operation to be performed
input [3:0]func;
input [1:0]alu_op;
output reg [3:0]alu_cntrl;

always@(func or alu_op)
begin
	case(alu_op)
	2'b00://for J-Type instruction ALU is in idle state
               alu_cntrl=4'bzzzz;
	2'b01: //LW,SW should perform ADD operation for address calculation
		alu_cntrl = 4'b0000;
	
	2'b10://for R-type and I-type instructions operation performed based on f7 and f3
		case(func)
			 4'b0000: // ALU should perform ADD
				alu_cntrl = 4'b1000;
			 4'b1000: // ALU should perform SUB
				alu_cntrl = 4'b1001;
			 4'b0001: // ALU should perform SLL
				alu_cntrl = 4'b0011;
			 4'b0010: // ALU should perform SLT
				alu_cntrl = 4'b1100;
			 4'b0011: // ALU should perform SLTU
				alu_cntrl = 4'b0100;
			 4'b0100: // ALU should perform XOR
				alu_cntrl = 4'b0110;
			 4'b0101: // ALU should perform SRL
				alu_cntrl = 4'b0010;
			 4'b1101: // ALU should perform SRA
				alu_cntrl = 4'b1010;
			 4'b0110: // ALU should perform OR
				alu_cntrl = 4'b0111;	
			 4'b0111: // ALU should perform AND
				alu_cntrl = 4'b1011;	
		endcase
	2'b11://for branch instructions alu should perform subtraction
		case(func[2:0])	
			3'b000 : alu_cntrl = 4'b1101 ;  //BEQ
			3'b001 : alu_cntrl = 4'b1111 ; //BNE
			3'b100 : alu_cntrl = 4'b1100 ; //BLT
			3'b101 : alu_cntrl = 4'b1101 ; //BGE
			3'b110 : alu_cntrl = 4'b0100 ; //BLTU
			3'b111 : alu_cntrl = 4'b0101 ; //BGEU 
		endcase
	endcase
end
endmodule
