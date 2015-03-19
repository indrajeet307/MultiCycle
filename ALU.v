module ALU(input [3:0]ALUOp,[31:0]in1,[31:0]in2,output reg zero,output reg[31:0] ALUout);
always@(in1,in2,ALUOp)
case(ALUOp)
	4'b0000: ALUout=in1 & in2;
	4'b0001: ALUout=in1 | in2;
	4'b0010: ALUout=in1 + in2;
	4'b0110: ALUout=in1 - in2;
	4'b0111:
		begin
			ALUout=in1 - in2;
			if(ALUout == 32'h0000_0000)
				zero=1'b1;
			else
				zero=1'b0;
		end
	endcase
endmodule
module adder(input [31:0]in1,[31:0]in2, output reg [31:0]Adderout);
always@(in1,in2)
	Adderout=in1+in2;
endmodule
module testBenchALUAdder();
reg [31:0]in1,in2;
reg[3:0] ALUOp;
wire [31:0]Adderout,ALUout;
wire zero;
adder alu1(in1,in2,Adderout);
ALU alu0(ALUOp,in1,in2,zero,ALUout);
initial begin
	in1=32'h1234_1234;
	in2=32'h1234_1234;
	#5 ALUOp = 4'd0;
	#5 ALUOp = 4'd1;
	#5 ALUOp = 4'd2;
	#5 ALUOp = 4'd6;
	#5 ALUOp = 4'd7;
end
endmodule