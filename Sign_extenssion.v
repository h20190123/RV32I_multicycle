module sign_extend_12(sign_in,extended_out);
output [31:0]extended_out ;
input [11:0]sign_in ;

assign extended_out= {{20{sign_in[11]}},sign_in[11:0]};
endmodule
 ////////////////////////////////
module sign_extend_13(sign_in,extended_out);
output [31:0]extended_out ;
input [11:0]sign_in ;
assign extended_out= {{20{sign_in[11]}},sign_in[11:0],1'b0};
endmodule
////////////////////////////////////
module sign_extend_20(sign_in,extended_out);
output [31:0]extended_out ;
input [19:0]sign_in ;

assign extended_out= {{12{sign_in[19]}},sign_in[19:0]};
endmodule
