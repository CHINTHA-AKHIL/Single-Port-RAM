module spram(clk,we,re,data,addr);
input clk,re,we;
inout [7:0] data;
input [3:0] addr;

reg [7:0]mem[15:0];
reg [7:0] data_out;

assign data =(!we&&re)?data_out:8'bz; 

always @(posedge clk)

	begin
		if(we&&!re)
			mem[addr]<=data;
		else if(!we&&re)
			data_out<=mem[addr];
		
	end
endmodule