module spram_tb();
parameter T=100;
reg clk;
reg we;
reg re;
reg [3:0] addr;
reg [7:0] data_temp;
wire [7:0] data;
integer i;
integer k;
spram dut(clk,we,re,data,addr);
task initialize();
begin
clk=0;
we=0;
re=0;
addr=0;
data_temp=0;
#(T/2);
end
endtask
always
begin
clk=0;
#(T/20);
clk=1;
#(T/20);
end
task write(input [7:0] x,input [3:0] y);
begin
@(posedge clk)
we=1;
re=0;
data_temp=x;
addr=y;
#(T/2);
we=0;
end
endtask
task read(input [3:0] a);
begin
@(posedge clk)
re=1;
we=0;
addr=a;
#(T/2);
re=0;
end
endtask
assign data=(we && !re)?data_temp:8'bz;
initial
begin
initialize();
for(i=0;i<16;i=i+1)
	write(i,i);
for(k=0;k<16;k=k+1)
	read(k);
end
endmodule