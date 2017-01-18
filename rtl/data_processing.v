// Universidade Estadual de Feira de Santana
// Module: data_processing.v
// Desc:   modulo que codifica a informacao utilizando round key e whitining key.
// Inputs: data: 256-bits
// Inputs: round_key: Chave fornecida pelo processo de expansão de chaves. 32-bits
// Inputs: WK0: Whitining Key 0 32-bit
// Inputs: WK1: Whitining Key 1 32-bits
// 		
// Outputs:
// Out: Saída de valor 32-bits pós processada pelo bloco F0 ou F1.

module data_processing(
	input[255:0] data, 
	input[31:0] round_key,
	input [31:0] WK0,
	input [31:0] WK1,
	input clk,
	//sinais de controle
	input [1:0] sel_mux_1,
	input sel_mux_2,
	input [1:0] sel_mux_3,
	input [2:0] sel_mux_4,
	input sel_mux_5,
	input selecao_f0_f1,
	//dado de saida
	output [255:0] result
	); 
	


	wire [31:0] R11_mux;
	wire [31:0] PDMUX_PDREG;
	wire [31:0] PDMUX_PDF0F1;
	wire [31:0] PDREG_PDF0F1_UP;
	wire [31:0] PDREG_PDF0F1_DOWN;
	wire [31:0] F0_F1_PDREG;
	wire [31:0] F0_F1_PDF0F1;
	
	
	PD_MUX pd_a(
	.X(data),
	.R11(R11_mux),  
	.WK0(WK0),
	.WK1(WK1),
	.sel1(sel_mux_1),
	.sel2(sel_mux_4),
	.out(PDMUX_PDREG),
	.out2(PDMUX_PDF0F1)
	);
	
	PD_REG pd_b(
	.in_mux2(PDMUX_PDREG),
	.sel1(sel_mux_3),
	.sel2(sel_mux_2),
	.in_R1(PDREG_PDF0F1_UP),
	.clk(clk),
	.out_R9(PDREG_PDF0F1_DOWN)
	);

	F0_F1 pd_c(
	.x(PDREG_PDF0F1_UP),
	.round_key(round_key),  
	.selecao_f0_f1(selecao_f0_f1), 
	.result(F0_F1_PDF0F1)
	);

	PD_INOUT_F0F1 pd_d(
	.in_R9(PDREG_PDF0F1_DOWN),
	.sel(sel_mux_5),
	.in_F0F1(F0_F1_PDF0F1),
	.in_pd_mux(PDMUX_PDF0F1),
	.clk(clk),
	.out_F0F1(PDREG_PDF0F1_UP),
	.out_mux_pd(R11_mux)
	);

endmodule 