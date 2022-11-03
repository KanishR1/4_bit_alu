`include "def.v"

module alu(oe, command, a, b,d_out);
input oe;
input [7:0]a,b;
input [3:0]command;
output [15:0]d_out;

reg [15:0]tmp;

always @(a or b or command)
begin
  case (command)
  `ADD : tmp= a+b;
  `INC : tmp= a+1;
  `SUB : tmp= a-b;
  `DEC : tmp= a-1;
  `MUL : tmp= a*b;
  `DIV : tmp= a/b;
  `SHL : tmp= a<<b;
  `SHR : tmp= a>>b;
  `INV : tmp= ~a;
  `AND : tmp= a&b;
  `OR : tmp= a|b;
  `NAND: tmp= ~(a&b);
  `NOR : tmp= ~(a|b);
  `XOR : tmp= a^b;
  `XNOR: tmp= ~(a^b);
  `BUF : tmp= a;
  default : tmp = 16'hxxxx;
  endcase
end
assign d_out = oe ? tmp:16'hzzzz;

endmodule