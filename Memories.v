module Memory(input clk,reset,memRead,memWrite,[31:0] addr,
				in0, in1, in2, in3,
				in4, in5, in6, in7,
				in8, in9, in10,in11,
				in12,in13,in14,in15,
				in16,in17,in18,in19,
				in20,in21,in22,in23,
				in24,in25,in26,in27,					  
				in28,in29,in30,in31,
                data,output[31:0] dataOut);
wire    [31:0]wo0, wo1, wo2, wo3;
wire    [31:0]wo4, wo5, wo6, wo7;
wire    [31:0]wo8, wo9, wo10,wo11;
wire    [31:0]wo12,wo13,wo14,wo15;
wire    [31:0]wo16,wo17,wo18,wo19;
wire    [31:0]wo20,wo21,wo22,wo23;
wire    [31:0]wo24,wo25,wo26,wo27;
wire    [31:0]wo28,wo29,wo30,wo31,demuxOut,m0Out;
demux1to32 dm0(addr[4:0],demuxOut);
Reg reg00(clk,reset,(memWrite & demuxOut[0]),in0,data,wo0);
Reg reg01(clk,reset,(memWrite & demuxOut[1]),in1,data,wo1);
Reg reg02(clk,reset,(memWrite & demuxOut[2]),in2,data,wo2);
Reg reg03(clk,reset,(memWrite & demuxOut[3]),in3,data,wo3);
                                             
Reg reg04(clk,reset,(memWrite & demuxOut[4]),in4,data,wo4);
Reg reg05(clk,reset,(memWrite & demuxOut[5]),in5,data,wo5);
Reg reg06(clk,reset,(memWrite & demuxOut[6]),in6,data,wo6);
Reg reg07(clk,reset,(memWrite & demuxOut[7]),in7,data,wo7);
                                            
Reg reg08(clk,reset,(memWrite & demuxOut[8]),in8,data,wo8);
Reg reg09(clk,reset,(memWrite & demuxOut[9]),in9,data,wo9);
Reg reg10(clk,reset,(memWrite & demuxOut[10]),in10,data,wo10);
Reg reg11(clk,reset,(memWrite & demuxOut[11]),in11,data,wo11);
                                               
Reg reg12(clk,reset,(memWrite & demuxOut[12]),in12,data,wo12);
Reg reg13(clk,reset,(memWrite & demuxOut[13]),in13,data,wo13);
Reg reg14(clk,reset,(memWrite & demuxOut[14]),in14,data,wo14);
Reg reg15(clk,reset,(memWrite & demuxOut[15]),in15,data,wo15);
                                              
Reg reg16(clk,reset,(memWrite & demuxOut[16]),in16,data,wo16);
Reg reg17(clk,reset,(memWrite & demuxOut[17]),in17,data,wo17);
Reg reg18(clk,reset,(memWrite & demuxOut[18]),in18,data,wo18);
Reg reg19(clk,reset,(memWrite & demuxOut[19]),in19,data,wo19);
                                              
Reg reg20(clk,reset,(memWrite & demuxOut[20]),in20,data,wo20);
Reg reg21(clk,reset,(memWrite & demuxOut[21]),in21,data,wo21);
Reg reg22(clk,reset,(memWrite & demuxOut[22]),in22,data,wo22);
Reg reg23(clk,reset,(memWrite & demuxOut[23]),in23,data,wo23);
                                              
Reg reg24(clk,reset,(memWrite & demuxOut[24]),in24,data,wo24);
Reg reg25(clk,reset,(memWrite & demuxOut[25]),in25,data,wo25);
Reg reg26(clk,reset,(memWrite & demuxOut[26]),in26,data,wo26);
Reg reg27(clk,reset,(memWrite & demuxOut[27]),in27,data,wo27);
                                             
Reg reg28(clk,reset,(memWrite & demuxOut[28]),in28,data,wo28);
Reg reg29(clk,reset,(memWrite & demuxOut[29]),in29,data,wo29);
Reg reg30(clk,reset,(memWrite & demuxOut[30]),in30,data,wo30);
Reg reg31(clk,reset,(memWrite & demuxOut[31]),in31,data,wo31);
mux32to1 m0(wo0, wo1, wo2, wo3,
			wo4, wo5, wo6, wo7,
			wo8, wo9, wo10,wo11,
			wo12,wo13,wo14,wo15,
			wo16,wo17,wo18,wo19,
			wo20,wo21,wo22,wo23,
			wo24,wo25,wo26,wo27,					  
			wo28,wo29,wo30,wo31,					  
			addr[6:2],m0Out);
mux2to1_32bits m1(memRead,32'bZZZZ_ZZZZ,m0Out,dataOut);
endmodule




module testbenchMemory();
  reg    [31:0]in0,in1,in2,in3;
  reg    [31:0]in4, in5, in6, in7;
  reg    [31:0]in8, in9, in10,in11;
  reg    [31:0]in12,in13,in14,in15;
  reg    [31:0]in16,in17,in18,in19;
  reg    [31:0]in20,in21,in22,in23;
  reg    [31:0]in24,in25,in26,in27;
  reg    [31:0]in28,in29,in30,in31,addr,data;  
  reg    [4:0]sel;
  reg	clk,reset,memRead,memWrite;
  wire   [31:0]out1;
  Memory dm0(clk,reset,memRead,memWrite,addr,
				in0, in1, in2, in3,
				in4, in5, in6, in7,
				in8, in9, in10,in11,
				in12,in13,in14,in15,
				in16,in17,in18,in19,
				in20,in21,in22,in23,
				in24,in25,in26,in27,					  
				in28,in29,in30,in31,
                data,out1);
  always begin
	#5 clk=~clk;
  end
  initial begin
	reset=1'b1;clk=1'b0;
	in0=32'h0451_abcd; in1=32'h1451_abcf;in2=32'h0123_aefd;in3=32'h1456_edcf;
	in4=32'h0451_abcd; in5=32'h1451_abcf;in6=32'h0123_aefd;in7=32'h1456_edcf;
	in8=32'h0451_abcd; in9=32'h1451_abcf;in10=32'h0123_aefd;in11=32'h1456_edcf;
	in12=32'h0451_abcd;in13=32'h1451_abcf;in14=32'h0123_aefd;in15=32'h1456_edcf;
	in16=32'h0451_abcd;in17=32'h1451_abcf;in18=32'h0123_aefd;in19=32'h1456_edcf;
	in20=32'h0451_abcd;in21=32'h1451_abcf;in22=32'h0123_aefd;in23=32'h1456_edcf;
	in24=32'h0451_abcd;in25=32'h1451_abcf;in26=32'h0123_aefd;in27=32'h1456_edcf;
	in28=32'h0451_abcd;in29=32'h1451_abcf;in30=32'h0123_aefd;in31=32'h1456_edcf;
	#5 reset=1'b0;
	#5 addr=32'h0004;
	#5 memRead=1'b1;
	#5 addr=32'h0004;
	   memWrite=1'b1;memRead=1'b0;
	   data=32'habcd_dcba;
	#5 addr=32'h0004;
	#5 memRead=1'b1;
  end
endmodule
