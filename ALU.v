module ALU(
input [3:0]Alu_cntrl ,       //control signal generated from ALU controller
input [31:0]Op_A,
input [31:0]Op_B,
output reg [31:0]ALU_Out , 
output reg Flag );   // Flag registers
reg signed [31:0]s_Op_A;
reg signed [31:0]s_Op_B;


always@(Alu_cntrl,Op_A,Op_B)
begin
Flag=0;
s_Op_A = Op_A;
s_Op_B = Op_B;
case (Alu_cntrl)
	4'b0000: ALU_Out <= Op_A+Op_B; // unsigned add for load store
	4'b1000: ALU_Out <= s_Op_A+s_Op_B; //signed ADD
	4'b1001: ALU_Out <= s_Op_A-s_Op_B;	//SUB
	4'b0011: ALU_Out <= Op_A<<Op_B ;	//SLL
	4'b1100:ALU_Out <= s_Op_A < s_Op_B  ;	//SLT
	4'b0100:ALU_Out <= Op_A<Op_B ;	//SLTU
	4'b0110:ALU_Out <= Op_A^Op_B;	//XOR
	4'b0111:ALU_Out <= Op_A|Op_B;	//OR
	4'b0101:ALU_Out <= Op_A&Op_B;	//AND
        4'b0010:ALU_Out <= Op_A>>Op_B ;	//SRL
	4'b1010:ALU_Out <= s_Op_A>>s_Op_B ;     //SRA

	4'b1101 : begin if(s_Op_A-s_Op_B == 0)  //BEQ
			Flag = 1; 
			end
	4'b1111 : begin if(s_Op_A-s_Op_B != 0)  //BNE
			Flag = 1;
			end
	4'b1100 : begin if(s_Op_A<s_Op_B)    //BLT
			 Flag = 1;
			end 
	4'b1101 : begin if (s_Op_A>=s_Op_B) 
			Flag = 1;     //BGE
			end
	4'b0100 :begin  if (Op_A<Op_B)
			 Flag = 1 ;//BLTU
			 end
	4'b1011 : begin if (Op_A>Op_B)
			 Flag = 1;   //BGEU
			end
default ALU_Out <= 32'd0 ; 
endcase
end
endmodule
      
	
   
    