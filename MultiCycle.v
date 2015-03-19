module MultiCycle(input clk,reset,
		[31:0]in0, in1, in2, in3,
		in4, in5, in6, in7,
		in8, in9, in10,in11,
		in12,in13,in14,in15,
		in16,in17,in18,in19,
		in20,in21,in22,in23,
		in24,in25,in26,in27,					  
		in28,in29,in30,in31
		);
wire  [31:0]IDMux0Out,PC0Out,Mem0Out,IR0Out,MDR0Out,WR0Out,RF0OutA,RF0OutB;
wire  [31:0]REGAOut,REGBOut,SE0Out,LS0Out,ALUM0Out,ALUM1Out,MBRA0Out,ALUOut0Out;
wire  [31:0]LS1Out,ALU0Out;
wire  PCwriteCond,PCWrite,memRead,memToReg,
		  memWrite,ALUsrcA,RegWrite,RegDest,IRWrite,IorD;
wire  [1:0]PCSource,ALUOp,ALUsrcB;
wire  [3:0]ALUCtrl;
wire  [4:0]RT0Out;
wire  [6:0]stateOut,SR0Out;
wire   Z;

Reg PC0(.clk(clk),.reset(reset),.load(PCWrite),.RegIn1(32'b0),.RegIn2(MBRA0Out),.RegOut(PC0Out));
mux2to1_32bits IDMux0(.sel(IorD),.in1(PC0Out),.in2(ALUOut0Out),.muxOut(IDMux0Out));

Memory Mem0(.clk(clk),.reset(reset),.memRead(memRead),.memWrite(memWrite),.addr(IDMux0Out),
				.in0(in0)  ,.in1(in1)  ,.in2(in2)  ,.in3(in3),
				.in4(in4)  ,.in5(in5)  ,.in6(in6)  ,.in7(in7),
				.in8(in8)  ,.in9(in9)  ,.in10(in10),.in11(in11),
				.in12(in12),.in13(in13),.in14(in14),.in15(in15),
				.in16(in16),.in17(in17),.in18(in18),.in19(in19),
				.in20(in20),.in21(in21),.in22(in22),.in23(in23),
				.in24(in24),.in25(in25),.in26(in26),.in27(in27),					  
				.in28(in28),.in29(in29),.in30(in30),.in31(in31),
                .data(REGBOut),.dataOut(Mem0Out));

InstrReg IR0(.clk(clk),.reset(reset),.load(IRWrite),.RegIn1(32'hffff_ffff),.RegIn2(Mem0Out),.RegOut(IR0Out));
Reg MDR0(.clk(clk),.reset(reset),.load(1'b1),.RegIn1(32'b0),.RegIn2(Mem0Out),.RegOut(MDR0Out));


FSMcontorlCircuit CC0(.clk(clk),.reset(reset),.instr(IR0Out[31:26]),.stateIn(stateOut),.PCwriteCond(PCwriteCond),
                   .PCWrite(PCWrite),.memRead(memRead),.memToReg(memToReg),.memWrite(memWrite),
               		.ALUsrcA(ALUsrcA),.ALUsrcB(ALUsrcB),.RegWrite(RegWrite),.RegDest(RegDest),
                   .IRWrite(IRWrite),.IorD(IorD),.PCSource(PCSource),.ALUOp(ALUOp),
               		.stateOut(stateOut));


//stateReg SR0(.clk(clk),.reset(reset),.load(1'b1),.RegIn1(7'b1),.RegIn2(stateOut),.RegOut(SR0Out));
							
mux2to1_5bits RT0(.sel(RegDest),.in1(IR0Out[20:16]),.in2(IR0Out[15:11]),.muxOut(RT0Out));
mux2to1_32bits WR0(.sel(memToReg),.in1(ALUOut0Out),.in2(MDR0Out),.muxOut(WR0Out));

signExtender SE0(.in1(IR0Out[15:0]),.signExtOut(SE0Out));
leftShifter LS0(.in1(SE0Out),.shiftOut(LS0Out));

registerFile RF0(.clk(clk),.reset(reset),.regWrite(RegWrite),.rs(IR0Out[25:21]),
                 .rt(IR0Out[20:16]),.rd(RT0Out),.data(WR0Out),.outA(RF0OutA),.outB(RF0OutB));

Reg REGA(.clk(clk),.reset(reset),.load(1'b1),.RegIn1(32'b0),.RegIn2(RF0OutA),.RegOut(REGAOut));
Reg REGB(.clk(clk),.reset(reset),.load(1'b1),.RegIn1(32'b0),.RegIn2(RF0OutB),.RegOut(REGBOut));
				 
mux2to1_32bits ALUM0(.sel(ALUsrcA),.in1(PC0Out),.in2(REGAOut),.muxOut(ALUM0Out));
mux4to1_32bits ALUM1(.sel(ALUsrcB),.in1(REGBOut),.in2(32'h0000_0004),.in3(SE0Out),.in4(LS0Out),.muxOut(ALUM1Out));

ALUControl ALUC0(.ALUOp(ALUOp),.func(IR0Out[5:0]),.ALUCtrOut(ALUCtrl));  

ALU ALU0(.ALUOp(ALUCtrl),.in1(ALUM0Out),.in2(ALUM1Out),.zero(Z),.ALUout(ALU0Out));

Reg ALUOut0(.clk(clk),.reset(reset),.load(1'b1),.RegIn1(32'd0),.RegIn2(ALU0Out),.RegOut(ALUOut0Out));

leftShifter LS1(.in1({{6{1'b1}},IR0Out[25:0]}),.shiftOut(LS1Out));

mux4to1_32bits MBRA0(.sel(PCSource),.in1(ALU0Out),.in2(ALUOut0Out),.in3({PC0Out[31:29],LS1Out[28:0]}),.in4(32'd0),.muxOut(MBRA0Out));
endmodule

module testBenchMultiCycle();
reg clk,reset;
reg [31:0]in0, in1, in2, in3;
reg [31:0]in4, in5, in6, in7;
reg [31:0]in8, in9, in10,in11;
reg [31:0]in12,in13,in14,in15;
reg [31:0]in16,in17,in18,in19;
reg [31:0]in20,in21,in22,in23;
reg [31:0]in24,in25,in26,in27;					  
reg [31:0]in28,in29,in30,in31;
		
MultiCycle uut(.clk(clk),.reset(reset),
		.in0(in0), .in1(in1), .in2 (in2), .in3 (in3),
		.in4(in4), .in5(in5), .in6 (in6), .in7 (in7),
		.in8(in8), .in9(in9), .in10(in10), .in11(in11),
		.in12(in12),.in13(in13),.in14(in14),.in15(in15),
		.in16(in16),.in17(in17),.in18(in18),.in19(in19),
		.in20(in20),.in21(in21),.in22(in22),.in23(in23),
		.in24(in24),.in25(in25),.in26(in26),.in27(in27),					  
		.in28(in28),.in29(in29),.in30(in30),.in31(in31)
		);
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
		in r6,r0,#0005;
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
	//in0=32'b000010_00000_00010_0000_0000_0000_0101;
	//in1=32'b000010_00001_00011_0000_0000_0000_0101;
	in0=32'b010000_00000_00011_0000_0000_0000_1000;
	in1=32'b010000_00000_00011_0000_0000_0000_1000;
	//in2=32'b10000_00011_00000_0000_0000_0000_0101;
	in2=32'b010000_00000_00011_0000_0000_0000_1000;
	in3=32'b000000_00010_00011_00100_00000_000000;
	
	in4=32'b000000_00100_00011_00101_00000_000010;
	in5=32'b001000_00110_00000_0000_0000_0000_0101;
	in6=32'b000100_00010_00011_1111_1111_1111_1001;	
	in7=32'b000010_00001_00000_0000_0000_0000_0000;
	
	in8=32'b000010_00000_00010_0000_0000_0000_0000;	
	in9=32'b000010_00000_00011_0000_0000_0000_0000;	
	in10=32'b000010_00000_00100_0000_0000_0000_0000;
	in11=32'b000010_00000_00101_0000_0000_0000_0000;
	
	in12=32'b100000_00000_00000_1111_1111_1110_0100;
	in13=32'b0000_0000_0000_0000_0000_0000_0000_0000;
	in14=32'b0000_0000_0000_0000_0000_0000_0000_0000;
	in15=32'b0000_0000_0000_0000_0000_0000_0000_0000;
	  
	in16=32'b0000_0000_0000_0000_0000_0000_0000_0000;
	in17=32'b0000_0000_0000_0000_0000_0000_0000_0000;
	in18=32'b0000_0000_0000_0000_0000_0000_0000_0000;
	in19=32'b0000_0000_0000_0000_0000_0000_0000_0000;
	  
	in20=32'b0000_0000_0000_0000_0000_0000_0000_0000;
	in21=32'b0000_0000_0000_0000_0000_0000_0000_0000;
	in22=32'b0000_0000_0000_0000_0000_0000_0000_0000;
	in23=32'b0000_0000_0000_0000_0000_0000_0000_0000;
	  
	in24=32'b0000_0000_0000_0000_0000_0000_0000_0000;
	in25=32'b0000_0000_0000_0000_0000_0000_0000_0000;
	in26=32'b0000_0000_0000_0000_0000_0000_0000_0000;
	in27=32'b0000_0000_0000_0000_0000_0000_0000_0000;
	  
	in28=32'b0000_0000_0000_0000_0000_0000_0000_0000;
	in29=32'b0000_0000_0000_0000_0000_0000_0000_0000;
	in30=32'b0000_0000_0000_0000_0000_0000_0000_0000;
	in31=32'b0000_0000_0000_0000_0000_0000_0000_0000;
	
	#10 reset=1'b0;
end
endmodule