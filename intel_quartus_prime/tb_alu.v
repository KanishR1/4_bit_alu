`define ADD 4'b0000
`define INC 4'b0001
`define SUB 4'b0010
`define DEC 4'b0011
`define MUL 4'b0100
`define DIV 4'b0101
`define SHL 4'b0110
`define SHR 4'b0111
`define INV 4'b1000
`define AND 4'b1001
`define OR 4'b1010
`define NAND 4'b1011
`define NOR 4'b1100
`define XOR 4'b1101
`define XNOR 4'b1110
`define BUF 4'b1111

module tb_alu();
reg [7:0]a,b;
reg [3:0]command;
reg oe;

wire [15:0] d_out;
reg [32 : 0] str_cmd;

alu A1(.a(a), .b(b), .oe(oe), .command(command), .d_out(d_out));

task initialize;
begin
  a=8'b0;
  b=8'b0;
  oe=1'b0;
  command=4'b0;
end
endtask

task inputs(input [7:0]j,k);
begin
a=j;
b=k;
end
endtask

task cmd(input [3:0]l);
begin
command=l;
end
endtask

task en_oe(input i);
begin
oe=i;
end
endtask

task delay;
begin
#10;
end
endtask

always @(command)
begin
case(command)
`ADD : str_cmd = "ADD";
`INC : str_cmd = "INC";
`SUB : str_cmd = "SUB";
`DEC : str_cmd = "DEC";
`MUL : str_cmd = "MUL";
`DIV : str_cmd = "DIV";
`SHL : str_cmd = "SHL";
`SHR : str_cmd = "SHR";
`INV : str_cmd = "INV";
`AND : str_cmd = "AND";
`OR : str_cmd = "OR";
`NAND : str_cmd = "NAND";
`NOR : str_cmd = "NOR";
`XOR : str_cmd = "XOR";
`XNOR : str_cmd = "XNOR";
`BUF : str_cmd = "BUF";
endcase
end

integer o;

initial begin
    initialize();
    en_oe(1'b1);
    inputs(8'h2,8'h1);
    for(o=0;o<16;o=o+1)
    begin
        cmd(o);
        delay();    
    end

end

initial $monitor("command = %s, a = %d , b = %d , d_out = %d.",str_cmd,a,b,d_out);
initial #500 $finish();

endmodule