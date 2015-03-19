module singleCycleImpl(input clk,reset,
				[31:0]lw0, [31:0]lw1, [31:0]lw2, [31:0]lw3,
				[31:0]lw4, [31:0]lw5, [31:0]lw6, [31:0]lw7,
				[31:0]lw8, [31:0]lw9, [31:0]lw10,[31:0]lw11,
				[31:0]lw12,[31:0]lw13,[31:0]lw14,[31:0]lw15,
				[31:0]lw16,[31:0]lw17,[31:0]lw18,[31:0]lw19,
				[31:0]lw20,[31:0]lw21,[31:0]lw22,[31:0]lw23,
				[31:0]lw24,[31:0]lw25,[31:0]lw26,[31:0]lw27,					  
				[31:0]lw28,[31:0]lw29,[31:0]lw30,[31:0]lw31);
  wire [31:0]InstrOut;
  wire [31:0] MBRA0out,PCOut,PCAdder0out,MDM0Out,outA,outB,signExtOut,MALU0Out;
  wire [31:0] ALU0out,shiftOut,add1out,dataOut,shiftOut1,Mjump0out;
  wire  branch,memRead,memToReg,memWrite,ALUSrc,regWrite,RegDest,zero,jump;
  wire [1:0]ALUOp;
  wire [3:0]ALUCtrOut;
  wire [4:0]MRF0Out;
PCReg PC0(clk,reset,1'b1,Mjump0out,PCOut);
adder PCAdder0(32'h0000_0004,PCOut,PCAdder0out);
InstrMem IRM0(clk,reset,
				lw0, lw1, lw2, lw3,
				lw4, lw5, lw6, lw7,
				lw8, lw9, lw10,lw11,
				lw12,lw13,lw14,lw15,
				lw16,lw17,lw18,lw19,
				lw20,lw21,lw22,lw23,
				lw24,lw25,lw26,lw27,					  
				lw28,lw29,lw30,lw31,
                PCOut,InstrOut);
contorlCircuit CC0(InstrOut[31:26],branch,memRead,memToReg,
					  memWrite,ALUSrc,regWrite,RegDest,jump,ALUOp);
mux2to1_5bits MRF0(RegDest,InstrOut[20:16],InstrOut[15:11],MRF0Out);
registerFile RF0(clk,reset,regWrite,InstrOut[25:21],InstrOut[20:16],MRF0Out,MDM0Out,outA,outB);
signExtender SE0(InstrOut[15:0],signExtOut);
mux2to1 MALU0(ALUSrc,outB,signExtOut,MALU0Out);
ALUControl ALUCtrl0(ALUOp,InstrOut[5:0],ALUCtrOut);
ALU ALU0(ALUCtrOut,outA,MALU0Out,zero,ALU0out);
leftShifter lfs0(signExtOut,shiftOut);
leftShifter lfs1(InstrOut,shiftOut1);
adder add1(PCAdder0out,shiftOut,add1out);
mux2to1 MBRA0((branch & zero),PCAdder0out,add1out,MBRA0out);
mux2to1 Mjump0(jump,MBRA0out,{PCAdder0out[31:28],shiftOut1[27:0]},Mjump0out);
DataMem DM0(clk,reset,memRead,memWrite,ALU0out,
                outB,dataOut);
mux2to1 MDM0(memToReg,ALU0out,dataOut,MDM0Out);
endmodule

module testbench();
	reg clk,reset;
	reg [31:0]lw0, lw1, lw2, lw3;
	reg [31:0]lw4, lw5, lw6, lw7;
	reg	[31:0]lw8, lw9, lw10,lw11;
	reg [31:0]lw12,lw13,lw14,lw15;
	reg	[31:0]lw16,lw17,lw18,lw19;
	reg	[31:0]lw20,lw21,lw22,lw23;
	reg	[31:0]lw24,lw25,lw26,lw27;					  
	reg [31:0]lw28,lw29,lw30,lw31;
	singleCycleImpl sci0(clk,reset,lw0, lw1, lw2, lw3,
				lw4, lw5, lw6, lw7,
				lw8, lw9, lw10,lw11,
				lw12,lw13,lw14,lw15,
				lw16,lw17,lw18,lw19,
				lw20,lw21,lw22,lw23,
				lw24,lw25,lw26,lw27,					  
				lw28,lw29,lw30,lw31);
always begin
	#5 clk=~clk;
end
initial begin
	clk=1'b0;
	reset=1'b1;
	/*
		aadi r0,r2,#0005;
		32'b00010_00001_00010_0000_0000_0000_0101
		aadi r1,r3,#0005;
		32'b00010_00001_00011_0000_0000_0000_0101
		sw r3,r0,#0005;
		32'b10000_00000_00011_0000_0000_0000_0101
		0100 0000 0110 0000 0000 0000 0000 0101
		add r2,r3,r4;
		32'b00000_00010_00011_00100_00000_000000
		sub r4,r3,r5;
		32'b00000_00100_00011_00101_00000_000010
		lw r6,r0,#0005;
		32'b01000_00110_00000_0000_0000_0000_0101
		beq r2,r3,#0000
		32'b00100_00010_00011_1111_1111_1111_1001

		addi r0,r1,0
		32'b000010_00001_00000_0000_0000_0000_0000
		addi r2,r1,0
		32'b000010_00000_00010_0000_0000_0000_0000
		addi r3,r1,0
		32'b000010_00000_00011_0000_0000_0000_0000
		addi r4,r1,0
		32'b000010_00000_0100_0000_0000_0000_0000
		addi r5,r1,0
		32'b000010_00000_0101_0000_0000_0000_0000
		j r0,r0,#-12
		32'b100000_00000_00000_1111_1111_1110_0100
		10000000000000001111111111100100
	*/
	lw0=32'b000010_00000_00010_0000_0000_0000_0101;
	lw1=32'b000010_00001_00011_0000_0000_0000_0101;
	//lw2=32'b10000_00011_00000_0000_0000_0000_0101;
	lw2=32'b010000_00000_00011_0000_0000_0000_0101;
	lw3=32'b000000_00010_00011_00100_00000_000000;
	
	lw4=32'b000000_00100_00011_00101_00000_000010;
	lw5=32'b001000_00110_00000_0000_0000_0000_0101;
	lw6=32'b000100_00010_00011_1111_1111_1111_1001;	
	lw7=32'b000010_00001_00000_0000_0000_0000_0000;
	
	lw8=32'b000010_00000_00010_0000_0000_0000_0000;	
	lw9=32'b000010_00000_00011_0000_0000_0000_0000;	
	lw10=32'b000010_00000_00100_0000_0000_0000_0000;
	lw11=32'b000010_00000_00101_0000_0000_0000_0000;
	
	lw12=32'b100000_00000_00000_1111_1111_1110_0100;
	lw13=32'b0000_0000_0000_0000_0000_0000_0000_0000;
	lw14=32'b0000_0000_0000_0000_0000_0000_0000_0000;
	lw15=32'b0000_0000_0000_0000_0000_0000_0000_0000;
	  
	lw16=32'b0000_0000_0000_0000_0000_0000_0000_0000;
	lw17=32'b0000_0000_0000_0000_0000_0000_0000_0000;
	lw18=32'b0000_0000_0000_0000_0000_0000_0000_0000;
	lw19=32'b0000_0000_0000_0000_0000_0000_0000_0000;
	  
	lw20=32'b0000_0000_0000_0000_0000_0000_0000_0000;
	lw21=32'b0000_0000_0000_0000_0000_0000_0000_0000;
	lw22=32'b0000_0000_0000_0000_0000_0000_0000_0000;
	lw23=32'b0000_0000_0000_0000_0000_0000_0000_0000;
	  
	lw24=32'b0000_0000_0000_0000_0000_0000_0000_0000;
	lw25=32'b0000_0000_0000_0000_0000_0000_0000_0000;
	lw26=32'b0000_0000_0000_0000_0000_0000_0000_0000;
	lw27=32'b0000_0000_0000_0000_0000_0000_0000_0000;
	  
	lw28=32'b0000_0000_0000_0000_0000_0000_0000_0000;
	lw29=32'b0000_0000_0000_0000_0000_0000_0000_0000;
	lw30=32'b0000_0000_0000_0000_0000_0000_0000_0000;
	lw31=32'b0000_0000_0000_0000_0000_0000_0000_0000;
	
	#5 reset=1'b0;
end
endmodule