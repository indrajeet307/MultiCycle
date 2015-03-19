/*
	opcode 		5 bits
	rtype		000000
	lw			001000
	sw			010000
	addi		000010
	beq			000100
	j           100000     
	
*/
module FSMcontorlCircuit(input clk,reset,[5:0]instr,[6:0]stateIn,output reg PCwriteCond,PCWrite,memRead,memToReg,
											  memWrite,ALUsrcA,RegWrite,RegDest,IRWrite,IorD,[1:0]PCSource,
											  [1:0] ALUOp,[1:0]ALUsrcB,[6:0]stateOut);
always@(negedge clk)
	if(reset)
		begin
		stateOut = 6'd0;
		PCwriteCond=0;PCSource=2'b00;
		memRead=0;memToReg=0;memWrite=0;
		ALUsrcA=0;ALUsrcB=2'b00;RegWrite=0;
		RegDest=0;IRWrite=0;ALUOp=2'b00;
		IorD=0;stateOut=6'b00;PCWrite=0;
		end
	else
		case(stateIn)
		6'd0:  
			begin
			PCwriteCond=1;PCSource=2'b00;
			memRead=1;memToReg=0;memWrite=0;
			ALUsrcA=0;ALUsrcB=2'b01;RegWrite=0;
			RegDest=0;IRWrite=1;ALUOp=2'b00;
			IorD=0;stateOut=6'b01;PCWrite=1;
			end		
		6'd1: 
			begin
			ALUsrcA=0;ALUsrcB=2'b11;ALUOp=2'b00;
			PCwriteCond=1;PCSource=2'b00;
			PCWrite=0;IRWrite=0;memWrite=0;RegWrite=0;
			case(instr)
				6'b000000:stateOut=6'd6;//rtype				
				6'b000010:stateOut=6'd6;//i
				6'b000100:stateOut=6'd8;//beq
				6'b001000:stateOut=6'd2;//lw
				6'b010000:stateOut=6'd2;//sw
				6'b100000:stateOut=6'd9;//j
			endcase
			end
		6'd2: 
			begin
			ALUsrcA=1;ALUsrcB=2'b10;ALUOp=2'b00;
			PCWrite=0;IRWrite=0;memWrite=0;RegWrite=0;
			if(instr[3])
			stateOut=6'd3;
			else if(instr[4])
			stateOut=6'd5;
			end
		6'd3: 
			begin
			memRead =1;
			IorD=1;
			stateOut=6'd4;
			PCWrite=0;IRWrite=0;memWrite=0;RegWrite=0;
			end
		6'd4: 
			begin
			RegDest=1;
			RegWrite=1;
			memToReg=0;
			stateOut=6'd0;
			PCWrite=0;IRWrite=0;memWrite=0;
			end
		6'd5: 
			begin
			memWrite=1;
			IorD=1;
			stateOut=6'd0;
			PCWrite=0;IRWrite=0;RegWrite=0;
			end
		6'd6: 
			begin
			ALUsrcA=1;ALUsrcB=2'b00;ALUOp=2'b10;
			PCWrite=0;IRWrite=0;memWrite=0;RegWrite=0;
			stateOut=6'd7;
			end
		6'd7: 
			begin
			RegDest=1;RegWrite=1;memToReg=0;
			PCWrite=0;IRWrite=0;memWrite=0;
			stateOut=6'd0;
			end
		6'd8: 
			begin
			ALUsrcA=1;
			ALUsrcB=2'b00;
			ALUOp=2'b01;
			PCwriteCond=1;
			PCSource=01;
			stateOut=6'd0;
			PCWrite=0;IRWrite=0;memWrite=0;RegWrite=0;
			end
		6'd9: 
			begin
			PCWrite=1;
			PCSource=2'b10;
			stateOut=6'd0;
			IRWrite=0;memWrite=0;RegWrite=0;
			end
		endcase
endmodule
module ALUControl(input [1:0] ALUOp,[5:0] func,output reg [3:0]ALUCtrOut);
always@(ALUOp,func)
case(ALUOp)
	2'b00: ALUCtrOut=4'b0010;
	2'b01: ALUCtrOut=4'b0111;
	2'b11: ALUCtrOut=4'b0010;
	2'b10: 
		case(func[2:0])
			3'b000: ALUCtrOut=4'b0010;
			3'b010: ALUCtrOut=4'b0110;
			3'b100: ALUCtrOut=4'b0000;
			3'b101: ALUCtrOut=4'b0001;
		endcase
endcase
endmodule
module testControlCircuit();
reg clk,reset;
reg [5:0]instr;
wire PCwriteCond,PCWrite,memRead,memToReg;
wire memWrite,ALUsrcA,RegWrite,RegDest,IRWrite;
wire [1:0]ALUOp,PCSource,ALUsrcB;
wire [6:0]stateOut;
FSMcontorlCircuit uut(	clk,reset,instr,stateOut,PCwriteCond,PCWrite,memRead,memToReg,
						memWrite,ALUsrcA,RegWrite,RegDest,IRWrite,IorD,PCSource,
						ALUOp,ALUsrcB,stateOut);
always begin
	#5 clk = ~clk;
end
initial begin
	clk=0;
	reset = 1;
	#5 reset = 0;
	
end
endmodule