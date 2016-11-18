// Universidade Estadual de Feira de Santana
// Module: SBOX0.v
// Desc:   modulo S-box 0 com entrada de 8 bits para o CLEFIA
// Inputs: X: valor 8-bits
// 						
// Outputs:
// Out: Saída de valor 8-bits pós processada pela S-box 0.

module SBOX0(input [7:0] X, 
output reg [7:0] out);

wire [3:0]X0;
wire [3:0]X1;
reg [3:0]u0;
reg [3:0]u1;
reg [3:0]t0;
reg [3:0]t1;

reg [3:0] SS1 [0:15];
reg [3:0] SS2 [0:15];
reg [3:0] SS3 [0:15];
reg [3:0] SS4 [0:15];

initial begin
    $readmemb("ss1.b", SS1);
	 $readmemb("ss2.b", SS2);
	 $readmemb("ss3.b", SS3);
	 $readmemb("ss4.b", SS4);
end


assign X0 = X[7:4];
assign X1 = X[3:0];

always @(X1 or X0) begin
	out[3:0] = SS2[X1];
	t0 = SS1[X0];
	t1 = SS2[X1];
	u0[0] = t0[0] ^ t1[3];
	u0[1] = (t1[3]^t1[0]) ^ t0[1];
	u0[2] = t0[2] ^ t1[1];
	u0[3] = t0[3] ^ t1[2];
	
	u1[0] = t0[3] ^ t1[0];
	u1[1] = (t0[3]^t0[0]) ^ t1[1];
	u1[2] = t0[1] ^ t1[2];
	u1[3] = t0[2] ^ t1[3];
	
	out[7:4] = SS3[u0];
	out[3:0] = SS4[u1];
	
	
end






endmodule

