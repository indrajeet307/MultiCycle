module leftShifter(input [31:0]in1,output reg [31:0] shiftOut);
	always@(in1)
	shiftOut=in1<<2;
endmodule

module signExtender(input [15:0]in1,output reg [31:0] signExtOut);
	always@(in1)
	signExtOut={{16{in1[15]}},in1};
endmodule

module testBenchMiscCir();
reg [31:0]in1;
reg [15:0]in2;
wire [31:0]shiftOut,signExtOut;
signExtender se0(in2,signExtOut);
leftShifter ls0(in1, shiftOut);
initial begin
	in1=32'h0000_FFFF;
	in2=32'h0000_9FFF;
end
endmodule