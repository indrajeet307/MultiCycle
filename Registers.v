module Reg(input clk,reset,load,[31:0] RegIn1,[31:0] RegIn2,output[31:0] RegOut);
DFF_Regular dff00(clk,reset,load,RegIn1[0] ,RegIn2[0] ,RegOut[0]);
DFF_Regular dff01(clk,reset,load,RegIn1[1] ,RegIn2[1] ,RegOut[1]);
DFF_Regular dff02(clk,reset,load,RegIn1[2] ,RegIn2[2] ,RegOut[2]);
DFF_Regular dff03(clk,reset,load,RegIn1[3] ,RegIn2[3] ,RegOut[3]);
                                                
DFF_Regular dff04(clk,reset,load,RegIn1[4] ,RegIn2[4] ,RegOut[4]);
DFF_Regular dff05(clk,reset,load,RegIn1[5] ,RegIn2[5] ,RegOut[5]);
DFF_Regular dff06(clk,reset,load,RegIn1[6] ,RegIn2[6] ,RegOut[6]);
DFF_Regular dff07(clk,reset,load,RegIn1[7] ,RegIn2[7] ,RegOut[7]);
                                                
DFF_Regular dff08(clk,reset,load,RegIn1[8] ,RegIn2[8] ,RegOut[8]);
DFF_Regular dff09(clk,reset,load,RegIn1[9] ,RegIn2[9] ,RegOut[9]);
DFF_Regular dff10(clk,reset,load,RegIn1[10],RegIn2[10],RegOut[10]);
DFF_Regular dff11(clk,reset,load,RegIn1[11],RegIn2[11],RegOut[11]);
                                                
DFF_Regular dff12(clk,reset,load,RegIn1[12],RegIn2[12],RegOut[12]);
DFF_Regular dff13(clk,reset,load,RegIn1[13],RegIn2[13],RegOut[13]);
DFF_Regular dff14(clk,reset,load,RegIn1[14],RegIn2[14],RegOut[14]);
DFF_Regular dff15(clk,reset,load,RegIn1[15],RegIn2[15],RegOut[15]);
                                                
DFF_Regular dff16(clk,reset,load,RegIn1[16],RegIn2[16],RegOut[16]);
DFF_Regular dff17(clk,reset,load,RegIn1[17],RegIn2[17],RegOut[17]);
DFF_Regular dff18(clk,reset,load,RegIn1[18],RegIn2[18],RegOut[18]);
DFF_Regular dff19(clk,reset,load,RegIn1[19],RegIn2[19],RegOut[19]);
                                                
DFF_Regular dff20(clk,reset,load,RegIn1[20],RegIn2[20],RegOut[20]);
DFF_Regular dff21(clk,reset,load,RegIn1[21],RegIn2[21],RegOut[21]);
DFF_Regular dff22(clk,reset,load,RegIn1[22],RegIn2[22],RegOut[22]);
DFF_Regular dff23(clk,reset,load,RegIn1[23],RegIn2[23],RegOut[23]);
                                                
DFF_Regular dff24(clk,reset,load,RegIn1[24],RegIn2[24],RegOut[24]);
DFF_Regular dff25(clk,reset,load,RegIn1[25],RegIn2[25],RegOut[25]);
DFF_Regular dff26(clk,reset,load,RegIn1[26],RegIn2[26],RegOut[26]);
DFF_Regular dff27(clk,reset,load,RegIn1[27],RegIn2[27],RegOut[27]);
                                                
DFF_Regular dff28(clk,reset,load,RegIn1[28],RegIn2[28],RegOut[28]);
DFF_Regular dff29(clk,reset,load,RegIn1[29],RegIn2[29],RegOut[29]);
DFF_Regular dff30(clk,reset,load,RegIn1[30],RegIn2[30],RegOut[30]);
DFF_Regular dff31(clk,reset,load,RegIn1[31],RegIn2[31],RegOut[31]);
endmodule

module MemReg(input clk,reset,load,[31:0] RegIn1,[31:0] RegIn2,output[31:0] RegOut);
DFF_MEM dff00(clk,reset,load,RegIn1[0] ,RegIn2[0] ,RegOut[0]);
DFF_MEM dff01(clk,reset,load,RegIn1[1] ,RegIn2[1] ,RegOut[1]);
DFF_MEM dff02(clk,reset,load,RegIn1[2] ,RegIn2[2] ,RegOut[2]);
DFF_MEM dff03(clk,reset,load,RegIn1[3] ,RegIn2[3] ,RegOut[3]);
                                                
DFF_MEM dff04(clk,reset,load,RegIn1[4] ,RegIn2[4] ,RegOut[4]);
DFF_MEM dff05(clk,reset,load,RegIn1[5] ,RegIn2[5] ,RegOut[5]);
DFF_MEM dff06(clk,reset,load,RegIn1[6] ,RegIn2[6] ,RegOut[6]);
DFF_MEM dff07(clk,reset,load,RegIn1[7] ,RegIn2[7] ,RegOut[7]);
                                                
DFF_MEM dff08(clk,reset,load,RegIn1[8] ,RegIn2[8] ,RegOut[8]);
DFF_MEM dff09(clk,reset,load,RegIn1[9] ,RegIn2[9] ,RegOut[9]);
DFF_MEM dff10(clk,reset,load,RegIn1[10],RegIn2[10],RegOut[10]);
DFF_MEM dff11(clk,reset,load,RegIn1[11],RegIn2[11],RegOut[11]);
                                                
DFF_MEM dff12(clk,reset,load,RegIn1[12],RegIn2[12],RegOut[12]);
DFF_MEM dff13(clk,reset,load,RegIn1[13],RegIn2[13],RegOut[13]);
DFF_MEM dff14(clk,reset,load,RegIn1[14],RegIn2[14],RegOut[14]);
DFF_MEM dff15(clk,reset,load,RegIn1[15],RegIn2[15],RegOut[15]);
                                                
DFF_MEM dff16(clk,reset,load,RegIn1[16],RegIn2[16],RegOut[16]);
DFF_MEM dff17(clk,reset,load,RegIn1[17],RegIn2[17],RegOut[17]);
DFF_MEM dff18(clk,reset,load,RegIn1[18],RegIn2[18],RegOut[18]);
DFF_MEM dff19(clk,reset,load,RegIn1[19],RegIn2[19],RegOut[19]);
                                                
DFF_MEM dff20(clk,reset,load,RegIn1[20],RegIn2[20],RegOut[20]);
DFF_MEM dff21(clk,reset,load,RegIn1[21],RegIn2[21],RegOut[21]);
DFF_MEM dff22(clk,reset,load,RegIn1[22],RegIn2[22],RegOut[22]);
DFF_MEM dff23(clk,reset,load,RegIn1[23],RegIn2[23],RegOut[23]);
                                                
DFF_MEM dff24(clk,reset,load,RegIn1[24],RegIn2[24],RegOut[24]);
DFF_MEM dff25(clk,reset,load,RegIn1[25],RegIn2[25],RegOut[25]);
DFF_MEM dff26(clk,reset,load,RegIn1[26],RegIn2[26],RegOut[26]);
DFF_MEM dff27(clk,reset,load,RegIn1[27],RegIn2[27],RegOut[27]);
                                      
DFF_MEM dff28(clk,reset,load,RegIn1[28],RegIn2[28],RegOut[28]);
DFF_MEM dff29(clk,reset,load,RegIn1[29],RegIn2[29],RegOut[29]);
DFF_MEM dff30(clk,reset,load,RegIn1[30],RegIn2[30],RegOut[30]);
DFF_MEM dff31(clk,reset,load,RegIn1[31],RegIn2[31],RegOut[31]);
endmodule

module stateReg(input clk,reset,load,[6:0]RegIn1 ,[6:0]RegIn2,output [6:0]RegOut);
DFF_Regular dff00(clk,reset,load,RegIn1[0] ,RegIn2[0] ,RegOut[0]);
DFF_Regular dff01(clk,reset,load,RegIn1[1] ,RegIn2[1] ,RegOut[1]);
DFF_Regular dff02(clk,reset,load,RegIn1[2] ,RegIn2[2] ,RegOut[2]);
DFF_Regular dff03(clk,reset,load,RegIn1[3] ,RegIn2[3] ,RegOut[3]);
                                                
DFF_Regular dff04(clk,reset,load,RegIn1[4] ,RegIn2[4] ,RegOut[4]);
DFF_Regular dff05(clk,reset,load,RegIn1[5] ,RegIn2[5] ,RegOut[5]);
DFF_Regular dff06(clk,reset,load,RegIn1[6] ,RegIn2[6] ,RegOut[6]);
endmodule