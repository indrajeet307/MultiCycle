module registerFile(input clk,reset,regWrite,[4:0]rs,[4:0]rt,[4:0]rd,[31:0]data,output [31:0] outA,outB);
wire    [31:0]wo0, wo1, wo2, wo3;
wire    [31:0]wo4, wo5, wo6, wo7;
wire    [31:0]wo8, wo9, wo10,wo11;
wire    [31:0]wo12,wo13,wo14,wo15;
wire    [31:0]wo16,wo17,wo18,wo19;
wire    [31:0]wo20,wo21,wo22,wo23;
wire    [31:0]wo24,wo25,wo26,wo27;
wire    [31:0]wo28,wo29,wo30,wo31,demuxOut;
demux1to32 dm0(rd,demuxOut);
Reg reg00(clk,reset,(regWrite & demuxOut[0]),32'b1,data,wo0);
Reg reg01(clk,reset,(regWrite & demuxOut[1]),32'b1,data,wo1);
Reg reg02(clk,reset,(regWrite & demuxOut[2]),32'b1,data,wo2);
Reg reg03(clk,reset,(regWrite & demuxOut[3]),32'b1,data,wo3);
                                            
Reg reg04(clk,reset,(regWrite & demuxOut[4]),32'b1,data,wo4);
Reg reg05(clk,reset,(regWrite & demuxOut[5]),32'b1,data,wo5);
Reg reg06(clk,reset,(regWrite & demuxOut[6]),32'b1,data,wo6);
Reg reg07(clk,reset,(regWrite & demuxOut[7]),32'b1,data,wo7);
                                            
Reg reg08(clk,reset,(regWrite & demuxOut[8]),32'b1,data,wo8);
Reg reg09(clk,reset,(regWrite & demuxOut[9]),32'b1,data,wo9);
Reg reg10(clk,reset,(regWrite & demuxOut[10]),32'b1,data,wo10);
Reg reg11(clk,reset,(regWrite & demuxOut[11]),32'b1,data,wo11);
                                             
Reg reg12(clk,reset,(regWrite & demuxOut[12]),32'b1,data,wo12);
Reg reg13(clk,reset,(regWrite & demuxOut[13]),32'b1,data,wo13);
Reg reg14(clk,reset,(regWrite & demuxOut[14]),32'b1,data,wo14);
Reg reg15(clk,reset,(regWrite & demuxOut[15]),32'b1,data,wo15);
                                             
Reg reg16(clk,reset,(regWrite & demuxOut[16]),32'b1,data,wo16);
Reg reg17(clk,reset,(regWrite & demuxOut[17]),32'b1,data,wo17);
Reg reg18(clk,reset,(regWrite & demuxOut[18]),32'b1,data,wo18);
Reg reg19(clk,reset,(regWrite & demuxOut[19]),32'b1,data,wo19);
                                             
Reg reg20(clk,reset,(regWrite & demuxOut[20]),32'b1,data,wo20);
Reg reg21(clk,reset,(regWrite & demuxOut[21]),32'b1,data,wo21);
Reg reg22(clk,reset,(regWrite & demuxOut[22]),32'b1,data,wo22);
Reg reg23(clk,reset,(regWrite & demuxOut[23]),32'b1,data,wo23);
                                             
Reg reg24(clk,reset,(regWrite & demuxOut[24]),32'b1,data,wo24);
Reg reg25(clk,reset,(regWrite & demuxOut[25]),32'b1,data,wo25);
Reg reg26(clk,reset,(regWrite & demuxOut[26]),32'b1,data,wo26);
Reg reg27(clk,reset,(regWrite & demuxOut[27]),32'b1,data,wo27);
                                             
Reg reg28(clk,reset,(regWrite & demuxOut[28]),32'b1,data,wo28);
Reg reg29(clk,reset,(regWrite & demuxOut[29]),32'b1,data,wo29);
Reg reg30(clk,reset,(regWrite & demuxOut[30]),32'b1,data,wo30);
Reg reg31(clk,reset,(regWrite & demuxOut[31]),32'b1,data,wo31);
mux32to1 m0(wo0, wo1, wo2, wo3,
			wo4, wo5, wo6, wo7,
			wo8, wo9, wo10,wo11,
			wo12,wo13,wo14,wo15,
			wo16,wo17,wo18,wo19,
			wo20,wo21,wo22,wo23,
			wo24,wo25,wo26,wo27,					  
			wo28,wo29,wo30,wo31,					  
			rs,outA);
mux32to1 m1(wo0, wo1, wo2, wo3,
			wo4, wo5, wo6, wo7,
			wo8, wo9, wo10,wo11,
			wo12,wo13,wo14,wo15,
			wo16,wo17,wo18,wo19,
			wo20,wo21,wo22,wo23,
			wo24,wo25,wo26,wo27,					  
			wo28,wo29,wo30,wo31,					  
			rt,outB);
endmodule
module TestbenchRegFile();
reg [4:0] rs,rt,rd;
reg regWrite,clk,reset;
reg [31:0]data;
wire [31:0]outA,outB;
registerFile rf0(clk,reset,regWrite,rs,rt,rd,data,outA,outB);
always begin
	#5 clk=~clk;
end
initial begin
	reset=1'b1;
	clk=1'b1;
	#5  reset=1'b0;
		regWrite=1'b1;
		rd=5'd4;
		data=32'h1234_1235;
	#10  rd=5'd6;
		data=32'h1234_1235;
	#10  rd=5'd1;
		data=32'h1234_1235;
	#10  rd=5'd2;
		data=32'h1234_1235;
	#10 regWrite=1'b0;
		rs=5'd6;
		rt=5'd1;
	#10 
		rd=5'd6;
		data=32'h5434_5675;
	#10 regWrite=1'b1;
	   rd=5'h6;
	   data=32'h5555_8888;
	
end
endmodule