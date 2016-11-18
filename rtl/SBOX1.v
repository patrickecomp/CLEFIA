// Universidade Estadual de Feira de Santana
// Module: SBOX1.v
// Desc:   modulo S-box 1 com entrada de 8 bits para o CLEFIA
// Inputs: X: valor 8-bits
// 						
// Outputs:
// Out: Saída de valor 8-bits pós processada pela S-box 1.

module SBOX1(input [7:0] X, 
output reg [7:0] out);

reg [7:0] dados_s1 [0:255];

initial begin
    $readmemh("dados_s1.txt", dados_s1);
end


always @(X) begin
	out = dados_s1[X];
		
end
endmodule
