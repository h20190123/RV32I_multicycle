module Mux(Out,I0,I1,I2,I3,Sel);

output reg [31:0] Out;
input  [31:0] I0,I1,I2,I3;
input  [1:0]Sel;
always@(*)
begin
case(Sel)
2'b00:
Out=I0;
2'b01:
Out=I1;
2'b10:
Out=I2;
2'b11:
Out = I3;
endcase
end
endmodule




module Add(A,B,C);
input [31:0]A,B;
output [31:0]C;
assign C = A+B;
endmodule
