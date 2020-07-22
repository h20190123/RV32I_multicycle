module FSM(input clock,
input reset,
input[4:0] opcode ,
input Flag,
//reg[3:0] next_state;
output reg[1:0] ALU_Op,
output reg wrt_en ,
output reg wrt_add_sel,
output reg[1:0]wrt_data_sel,
output reg operand_sel,
output reg [1:0]branch , 
output reg Mem_rd ,
output reg Mem_wr ,
output reg IorD,
output reg PC_Write);
reg [3:0] next_state;
reg [3:0] present_state;
parameter  IF = 4'd0;
parameter  ID = 4'd1;
parameter  EX_S =4'd2;
parameter  EX_R =4'd3;
parameter  EX_I =4'd4;
parameter  EX_B =4'd5;
parameter  EX_J =4'd6;
parameter  MEM_load =4'd7;
parameter  MEM_store =4'd8;
parameter  WB_load =4'd9;
parameter  WB_reg =4'd10;
parameter  WB_UI = 4'd11;
always@(present_state,Flag)
begin
case(present_state)

	IF : 
		begin
		ALU_Op = 00;  
		wrt_en = 0;
		wrt_add_sel = 0;
		wrt_data_sel = 00;
		operand_sel = 0;
		branch = 00;  
		Mem_rd = 0;
		Mem_wr = 0;
		PC_Write = 0;
		next_state = ID;
		IorD= 1;
		end

		
	ID : 
		begin		
		ALU_Op = 00;  
		wrt_en = 0;
		wrt_add_sel = 0;
		wrt_data_sel = 00;
		operand_sel = 0;
		branch = 00;  
		Mem_rd = 0;
		Mem_wr = 0;
		PC_Write = 0;
		if(opcode==5'b01100)
		next_state = EX_R;
		if(opcode==5'b00100)
		next_state = EX_I;
		if(opcode==5'b01000| opcode ==5'b00000)
		next_state = EX_S;
		if(opcode==5'b11000)
		next_state = EX_B;
		if(opcode==5'b11011)
		next_state = EX_J;
		if(opcode==5'b00101 | opcode == 5'b01101)
                next_state = WB_UI ;
		IorD=0;
		end

	EX_R: 
		begin		
		ALU_Op = 10;      //for arithmetic operations
		wrt_en = 0;
		wrt_add_sel = 0;
		wrt_data_sel = 00;
		operand_sel = 1'b0 ;    // operand B from Reg file
		branch = 00;  
		Mem_rd = 0;
		Mem_wr = 0;
		PC_Write = 0;
		IorD=0;
		next_state = WB_reg;
		end
	EX_I : 
		begin		
		ALU_Op = 2'b10;  // for arithmetic operations
		wrt_en = 0;
		wrt_add_sel = 0;
		wrt_data_sel = 0;
		operand_sel = 1'b1;  //for operand B from immediate generator
		branch = 00;  
		Mem_rd = 0;
		Mem_wr = 0;
		PC_Write = 0;
		IorD=0;
		next_state = WB_reg;
		end
	EX_S :                   //Load and Store 
		begin		
		ALU_Op = 2'b01;    //for address calculation  
		wrt_en = 0;
		wrt_add_sel = 0;
		wrt_data_sel = 0;
		operand_sel = 1'b1;  //from immediate generator
		branch = 00;  
		Mem_rd = 0;
		Mem_wr = 0;
		PC_Write = 0;
		IorD=0;
		if(opcode == 5'b00000)
		next_state = MEM_load;
		else
		next_state = MEM_store;
		end
	EX_B : 
		begin
		IorD=0;
		ALU_Op = 11;    //branch condition check
		wrt_en = 0;
		wrt_add_sel = 0;
		wrt_data_sel = 2'b00;
		operand_sel = 0;
		Mem_rd = 0;
		Mem_wr = 0;
		if(Flag==1)
		begin
		branch = 2'b01;
		//PC_Write = 1;
		end
		else
		begin
		branch = 2'b00;
		//PC_Write = 0;
		end
		PC_Write = 1;
		next_state = IF;
		end
	EX_J : 
		begin
		ALU_Op = 2'b00;  
		wrt_en = 1;
		wrt_add_sel = 0;
		wrt_data_sel = 11;  //Rd<-PC+offset
		operand_sel = 0;
		branch = 2'b10;
		Mem_rd = 0;
		Mem_wr = 0;
		PC_Write =1'b1;
		IorD=0;
		next_state = IF;
		end
	MEM_load : 
		begin
		ALU_Op = 01;  
		wrt_en = 0;
		wrt_add_sel = 1'b1;  //selecting data memory
		wrt_data_sel = 00;
		operand_sel = 0;
		branch = 00;  
		Mem_rd = 1'b1;
		Mem_wr = 0;
		PC_Write =0;
		IorD=0;
		next_state = WB_load ;
		end
	MEM_store : 
		begin	
		ALU_Op =00;  
		wrt_en = 0;
		wrt_add_sel = 1'b1; //selecting data memory in Address out bus
		wrt_data_sel = 00;
		operand_sel = 0;
		branch = 00;  
		Mem_rd = 0;
		Mem_wr = 1'b1;
		PC_Write = 1;
		IorD=0;
		next_state = IF;
		end
	WB_load : 
		begin
		ALU_Op = 00;  
		wrt_en = 1;
		wrt_add_sel = 1;
		wrt_data_sel =01 ;  //Rd<- DI
		operand_sel = 0;
		branch = 00;  
		Mem_rd = 0;
		Mem_wr =0;
		PC_Write = 1;
		IorD=0;
		next_state = IF;
		end
	WB_reg : 
		begin
		ALU_Op = 00;  
		wrt_en =1;
		wrt_add_sel = 0;
		wrt_data_sel =00;   //Rd<-ALU_Out
		operand_sel = 0;
		branch = 00;  
		Mem_rd = 0;
		Mem_wr = 0;
		PC_Write = 1;
		IorD=0;
		next_state = IF ;
		end
	WB_UI : begin
		ALU_Op = 00;  
		wrt_en =1;
		wrt_add_sel = 0;
		operand_sel = 0;
		branch = 00;     
		Mem_rd = 0;
		Mem_wr = 0;
		PC_Write = 1;
		IorD=0;
		if(opcode==5'b01101)    //LUI Rd<-imm_20;
		wrt_data_sel = 10;
		else
		wrt_data_sel =11;   //AUIPC Rd<-PC+offset
		next_state = IF ;
		end
		
	default :next_state = IF;
endcase
end
always@(posedge clock)
begin
if(reset == 1'b1)
 present_state = IF;
else
 present_state = next_state;
end
endmodule

