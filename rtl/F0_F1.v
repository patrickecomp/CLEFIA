// Universidade Estadual de Feira de Santana
// Module: F0_F1.v
// Desc:   modulo que mescla o bloco F0 e F1 do CLEFIA. A escolha do bloco depende da entrada de seleção.
// Inputs: x: uma parte da palavra de entrada à ser codificada 32-bits
// Inputs: round_key: Chave fornecida pelo processo de expansão de chaves. 32-bits
// Inputs: selecao_f0_f1: bit de seleção de bloco; F0 ou F1. valor 1-bit
// 		
// Outputs:
// Out: Saída de valor 32-bits pós processada pelo bloco F0 ou F1.

module F0_F1(
	input[31:0] x, 
	input[31:0] round_key,
	input selecao_f0_f1,
	output [31:0] result
	); 

	wire [31:0] x_xor_round;
	wire [7:0] mux_a_temp;
	wire [7:0] mux_b_temp;
	wire [7:0] mux_c_temp;
	wire [7:0] mux_d_temp;
	wire [7:0] saida_sbox_a;
	wire [7:0] saida_sbox_b;
	wire [7:0] saida_sbox_c;
	wire [7:0] saida_sbox_d;
	wire [7:0] entrada_M0M1_X0;
	wire [7:0] entrada_M0M1_X1;
	wire [7:0] entrada_M0M1_X2;
	wire [7:0] entrada_M0M1_X3;
	
	assign x_xor_round = x ^ round_key;
	
	mux m_data_X0(
	.data_0(x_xor_round[31:24]),
	.data_1(x_xor_round[23:16]),  
	.sel(selecao_f0_f1), 
	.data(mux_a_temp)
	);
	
	SBOX0 sbox_a(
	.X(mux_a_temp),
	.out(saida_sbox_a)
	);
	
	mux m_data_X1(
	.data_0(x_xor_round[23:16]),
	.data_1(x_xor_round[31:24]),  
	.sel(selecao_f0_f1), 
	.data(mux_b_temp)
	);
	
	SBOX1 sbox_b(
	.X(mux_b_temp),
	.out(saida_sbox_b)
	);
	
	mux m_data_X2(
	.data_0(x_xor_round[15:8]),
	.data_1(x_xor_round[7:0]),  
	.sel(selecao_f0_f1), 
	.data(mux_c_temp)
	);
	
	SBOX0 sbox_c(
	.X(mux_c_temp),
	.out(saida_sbox_c)
	);

	mux m_data_X3(
	.data_0(x_xor_round[7:0]),
	.data_1(x_xor_round[15:8]),  
	.sel(selecao_f0_f1), 
	.data(mux_d_temp)
	);
	
	SBOX1 sbox_d(
	.X(mux_d_temp),
	.out(saida_sbox_d)
	);	
	
	mux m_data_Y0(
	.data_0(saida_sbox_a),
	.data_1(saida_sbox_b),  
	.sel(selecao_f0_f1), 
	.data(entrada_M0M1_X0)
	);
	
	mux m_data_Y1(
	.data_0(saida_sbox_b),
	.data_1(saida_sbox_a),  
	.sel(selecao_f0_f1), 
	.data(entrada_M0M1_X1)
	);
	
	mux m_data_Y2(
	.data_0(saida_sbox_c),
	.data_1(saida_sbox_d),  
	.sel(selecao_f0_f1), 
	.data(entrada_M0M1_X2)
	);
	
	mux m_data_Y3(
	.data_0(saida_sbox_d),
	.data_1(saida_sbox_c),  
	.sel(selecao_f0_f1), 
	.data(entrada_M0M1_X3)
	);
	
	M0_M1 matriz(
	.X0(entrada_M0M1_X0),
	.X1(entrada_M0M1_X1),
	.X2(entrada_M0M1_X2),
	.X3(entrada_M0M1_X3),
	.sel(selecao_f0_f1),
	.out(result)
	);	
	
endmodule 