/*
	opcode 		5 bits
	rtype		000000
	lw			001000
	sw			010000
	addi		000010
	beq			000100
	j           100000     
	
*/
module contorlCircuit(input [5:0]instr,output reg branch,memRead,memToReg,
											  memWrite,ALUsrc,RegWrite,RegDest,jump,
											  [1:0] ALUOp);
always@(instr)

case(instr)
	6'b000000 : //rtype	
		begin
			RegDest=1'b1;ALUsrc=1'b0;memToReg=1'b0;
			RegWrite=1'b1;memRead=1'b0;memWrite=1'b0;
			branch=1'b0;jump=0;ALUOp=2'b10;
		end
	6'b001000 :	//load word
		begin
			RegDest=1'b0;ALUsrc=1'b1;memToReg=1'b1;
			RegWrite=1'b1;memRead=1'b1;memWrite=1'b0;
			branch=1'b0;jump=0;ALUOp=2'b00;
		end
	6'b010000 : //store word
		begin
			RegDest=1'bx;ALUsrc=1'b1;memToReg=1'bx;
			RegWrite=1'b0;memRead=1'b0;memWrite=1'b1;
			branch=1'b0;jump=0;ALUOp=2'b00;
		end
	6'b000010 : //addi
		begin
			RegDest=1'b0;ALUsrc=1'b1;memToReg=1'bx;
			RegWrite=1'b1;memRead=1'b0;memWrite=1'b0;
			branch=1'b0;jump=0;ALUOp=2'b11;
		end
	6'b000100 : // branch
		begin
			RegDest=1'bx;ALUsrc=1'b0;memToReg=1'bx;
			RegWrite=1'b0;memRead=1'b0;memWrite=1'b0;
			branch=1'b1;jump=1'b0;ALUOp=2'b01;
		end	
	6'b100000 : //j
		begin
			RegDest=1'bx;ALUsrc=1'bx;memToReg=1'bx;
			RegWrite=1'bx;memRead=1'bx;memWrite=1'bx;
			branch=1'bx;jump=1'b1;ALUOp=2'bxx;
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