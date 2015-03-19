module mux2to1_5bits(input sel,[4:0]in1,[4:0]in2,output reg [4:0]muxOut);
always@(in1,in2,sel)
if(sel)
muxOut=in2;
else
muxOut=in1;
endmodule

module mux2to1_32bits(input sel,[31:0]in1,[31:0]in2,output reg [31:0]muxOut);
always@(in1,in2,sel)
if(sel)
muxOut=in2;
else
muxOut=in1;
endmodule

module mux4to1_32bits(input [1:0]sel,[31:0]in1,[31:0]in2,[31:0]in3,[31:0]in4,output reg [31:0]muxOut);
always@(in1,in2,sel)
case(sel)
	2'b00: muxOut=in1;
	2'b01: muxOut=in2;
	2'b10: muxOut=in3;
	2'b11: muxOut=in4;
endcase
endmodule

module mux32to1(input [31:0]in0,[31:0]in1,[31:0]in2,[31:0]in3,
					  [31:0]in4,[31:0]in5,[31:0]in6,[31:0]in7,
					  [31:0]in8,[31:0]in9,[31:0]in10,[31:0]in11,
					  [31:0]in12,[31:0]in13,[31:0]in14,[31:0]in15,
					  [31:0]in16,[31:0]in17,[31:0]in18,[31:0]in19,
					  [31:0]in20,[31:0]in21,[31:0]in22,[31:0]in23,
					  [31:0]in24,[31:0]in25,[31:0]in26,[31:0]in27,					  
					  [31:0]in28,[31:0]in29,[31:0]in30,[31:0]in31,					  
					  [4:0]sel,output reg [31:0]muxOut);
always@(in0,in1,in2,in3,
		in4,in5,in6,in7,
		in8,in9,in10,in11,
		in12,in13,in14,in15,
		in16,in17,in18,in19,
		in20,in21,in22,in23,
		in24,in25,in26,in27,					  
		in28,in29,in30,in31,					  
		sel)
case(sel)
	5'd0: muxOut=in0;
	5'd1: muxOut=in1;
	5'd2: muxOut=in2;
	5'd3: muxOut=in3;
	
	5'd4: muxOut=in4;
	5'd5: muxOut=in5;
	5'd6: muxOut=in6;
	5'd7: muxOut=in7;
	
	5'd8:  muxOut=in8;
	5'd9:  muxOut=in9;
	5'd10: muxOut=in10;
	5'd11: muxOut=in11;
	
	5'd12: muxOut=in12;
	5'd13: muxOut=in13;
	5'd14: muxOut=in14;
	5'd15: muxOut=in15;
	                  
	5'd16: muxOut=in16;
	5'd17: muxOut=in17;
	5'd18: muxOut=in18;
	5'd19: muxOut=in19;
	
	5'd20: muxOut=in20;
	5'd21: muxOut=in21;
	5'd22: muxOut=in22;
	5'd23: muxOut=in23;
	                  
	5'd24: muxOut=in24;
	5'd25: muxOut=in25;
	5'd26: muxOut=in26;
	5'd27: muxOut=in27;
	                  
	5'd28: muxOut=in28;
	5'd29: muxOut=in29;
	5'd30: muxOut=in30;
	5'd31: muxOut=in31;
	
endcase
endmodule
module demux1to32(input [4:0]sel,output reg [31:0] demuxOut);
always@(sel)
	begin
	demuxOut=0;
	demuxOut[sel]=1;
	end
endmodule
module tesetBenchMuxes();
  reg    [31:0]in0,in1,in2,in3;
  reg    [31:0]in4, in5, in6, in7;
  reg    [31:0]in8, in9, in10,in11;
  reg    [31:0]in12,in13,in14,in15;
  reg    [31:0]in16,in17,in18,in19;
  reg    [31:0]in20,in21,in22,in23;
  reg    [31:0]in24,in25,in26,in27;
  reg    [31:0]in28,in29,in30,in31;  
  reg    [4:0]sel2;
  reg	sel1;
  wire   [31:0]out1,out2;
  mux32to1 m1(in0,in1,in2,in3,
		in4,in5,in6,in7,
		in8,in9,in10,in11,
		in12,in13,in14,in15,
		in16,in17,in18,in19,
		in20,in21,in22,in23,
		in24,in25,in26,in27,					  
		in28,in29,in30,in31,					  
		sel2,out2);
	mux2to1_32bits m2(sel1,in0,in2,out1);
	initial begin
	in0=31'h0451_abcd; in1=31'h1451_abcf;in2=31'h0123_aefd;in3=31'h1456_edcf;
	in4=31'h0451_abcd; in5=31'h1451_abcf;in6=31'h0123_aefd;in7=31'h1456_edcf;
	in8=31'h0451_abcd; in9=31'h1451_abcf;in10=31'h0123_aefd;in11=31'h1456_edcf;
	in12=31'h0451_abcd;in13=31'h1451_abcf;in14=31'h0123_aefd;in15=31'h1456_edcf;
	in16=31'h0451_abcd;in17=31'h1451_abcf;in18=31'h0123_aefd;in19=31'h1456_edcf;
	in20=31'h0451_abcd;in21=31'h1451_abcf;in22=31'h0123_aefd;in23=31'h1456_edcf;
	in24=31'h0451_abcd;in25=31'h1451_abcf;in26=31'h0123_aefd;in27=31'h1456_edcf;
	in28=31'h0451_abcd;in29=31'h1451_abcf;in30=31'h0123_aefd;in31=31'h1456_edcf;
	#5 sel2=5'd0;#5 sel2=5'd7;#5 sel2=5'd14;#5 sel2=5'd21;
	#5 sel2=5'd1;#5 sel2=5'd8; sel1=1'b0;
	#5 sel2=5'd15;#5 sel2=5'd22;sel1=1'b1;
	#5 sel2=5'd2;#5 sel2=5'd9;#5 sel2=5'd16;#5 sel2=5'd23;
	#5 sel2=5'd3;#5 sel2=5'd10;#5 sel2=5'd17;#5 sel2=5'd24;
	#5 sel2=5'd4;#5 sel2=5'd11;#5 sel2=5'd18;#5 sel2=5'd25;
	#5 sel2=5'd5;#5 sel2=5'd12;#5 sel2=5'd19;#5 sel2=5'd26;
	#5 sel2=5'd6;#5 sel2=5'd13;#5 sel2=5'd20;#5 sel2=5'd27;
	#5 sel2=5'd28;#5 sel2=5'd29;#5 sel2=5'd30;#5 sel2=5'd31;
	end
endmodule