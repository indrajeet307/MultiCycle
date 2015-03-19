module DFF_Regular(input clk,reset,load,data1,data2,output reg q);
  always@(negedge clk)
	if (reset)
		q=data1;
	else
		if(load)
			q=data2;
endmodule
module DFF_MEM(input clk,reset,load,data1,data2,output reg q);
  always@(clk)
	if (reset)
		q=data1;
	else
		if(load)
			q=data2;
endmodule

