`timescale 1ns / 1ps
`include "PD_MUX.v"
`include "PD_REG.v"
`include "PD_INOUT_F0F1.v"
`include "data_processing.v"
`include "mux.v"
`include "SBOX0.v"
`include "SBOX1.v"
`include "M0_M1.v"
`include "F0_F1.v"

module data_processingTestbench();

	reg[255:0] data;
	reg[31:0] round_key;
	reg [31:0] WK0;
	reg [31:0] WK1;
	reg clk;
	reg [127:0] checkdata;
	//sinais de controle
	reg [1:0] sel_mux_1;
	reg sel_mux_2;
	reg [1:0] sel_mux_3;
	reg [2:0] sel_mux_4;
	reg sel_mux_5;
	reg selecao_f0_f1;
	wire [31:0] R1;
	wire [31:0] R9;
        wire [31:0] outF0F1;
	wire [31:0] out_1;
	wire [31:0] out_2;
	wire [31:0] out_3;
	wire [31:0] out_4;
	//dado de saida
	//reg [255:0] result;
	
	task mud_fase;
		input [31:0] round, round2;
		begin
			#2
			sel_mux_5 = 1;
			sel_mux_3 = 2;
			sel_mux_2 = 1;
			round_key = round;
			selecao_f0_f1 = 0;
			$display("R1: %h, R9: %h, F0F1: %h", R1, R9, outF0F1);
			#2
			sel_mux_3 = 1;
			sel_mux_5 = 1;
			round_key = round2;
			selecao_f0_f1 = 1;
			sel_mux_2 = 1;
			$display("R1: %h, R9: %h, F0F1: %h", R1, R9, outF0F1);
		end
	endtask

		task mud_fase2;
		input [31:0] round, round2, round3, round4;
		begin
			#2
			sel_mux_4 = 4;
			sel_mux_5 = 0;
			sel_mux_3 = 1;
			sel_mux_2 = 1;
			round_key = round;
			selecao_f0_f1 = 0;
			$display("R1: %h, R9: %h, F0F1: %h", R1, R9, outF0F1);
			#2
			round_key = round2;
			selecao_f0_f1 = 1;
			$display("R1: %h, R9: %h, F0F1: %h", R1, R9, outF0F1);
			#2
			round_key = round3;
			selecao_f0_f1 = 0;
			$display("R1: %h, R9: %h, F0F1: %h", R1, R9, outF0F1);
			#2
			round_key = round4;
			sel_mux_3 = 0;
			selecao_f0_f1 = 1;
			$display("R1: %h, R9: %h, F0F1: %h", R1, R9, outF0F1);
		end
	endtask

    task checkOutput;
        input [127:0] dados, out;
        if ( dados !== out ) begin
            $display("Teste FALHOU: Resultado incorreto, Saída esperada: %h, Saída: %h", dados, out);
		$finish();
        end
        else begin
            $display("Teste PASSOU: Saída esperada:%h, Saída %h", dados, out);
        end
    endtask

    data_processing bloco_dataprocessing(.data(data),.round_key(round_key),.WK0(WK0),.WK1(WK1),.clk(clk),.sel_mux_1(sel_mux_1),.sel_mux_2(sel_mux_2),.sel_mux_3(sel_mux_3),.sel_mux_4(sel_mux_4),.sel_mux_5(sel_mux_5),.selecao_f0_f1(selecao_f0_f1),
    .Pino_R1(R1),.Pino_R9(R9),.Pino_outF0F1(outF0F1),.out_4(out_1),.R2(out_2),.R1(out_3),.R3(out_4)
//.result(result)
);

//Clock do bloco de registradores
  always 
  begin
    #1  clk =  ! clk;
 end

    initial begin
//128 bits
	clk = 0;
	 ///////////////////////////////
        // Hard coded tests
        ///////////////////////////////
	data = 256'h000102030405060708090a0b0c0d0e0f00000000000000000000000000000000;
	round_key = 32'hf3e6cef9;
	WK0 = 32'hffeeddcc;
	WK1 = 32'hbbaa9988;
	selecao_f0_f1 = 0;
	//sinais de controle
	sel_mux_1 = 0;
	sel_mux_2 = 0;
	sel_mux_4 = 0;
	sel_mux_5 = 0;
	$display("data: %h, R9: %h, F0F1: %h", data, R9, outF0F1);
	#1
	sel_mux_1 = 3;
	sel_mux_2 = 0;
	sel_mux_4 = 1;
	round_key = 32'h8df75e38;
	sel_mux_5 = 0;
	selecao_f0_f1 = 1;
	$display("R1: %h, R9: %h, F0F1: %h", R1, R9, outF0F1);
	mud_fase(32'h41c06256,32'h640ac51b);
	mud_fase(32'h6a27e20a, 32'h5a791b90);
	mud_fase(32'he8c528dc, 32'h00336ea3);
	mud_fase(32'h59cd17c4,32'h28565583);
	mud_fase(32'h312a37cc,32'hc08abd77);
	mud_fase(32'h7e8e7eec,32'h8be7e949);
	mud_fase(32'hd3f463d6,32'ha0aad6aa);
	mud_fase(32'he75eb039,32'h0d657eb9);
	mud_fase(32'h018002e2,32'h9117d009);
	mud_fase(32'h9f98d11e,32'hbabee8cf);
	mud_fase(32'hb0369efa,32'hd3aaef0d);
	mud_fase(32'h3438f93b,32'hf9cea4a0);
	mud_fase(32'h68df9029,32'hb869b4a7);
	mud_fase(32'h24d6406d,32'he74bc550);
	mud_fase(32'h41c28193,32'h16de4795);
	mud_fase(32'ha34a20f5,32'h33265d14);
	mud_fase(32'hb19d0554,32'h5142f434);
	#5
	
	checkdata[127:96] = out_4;
	checkdata[95:64] = out_3;
	checkdata[63:32] = out_2;
	checkdata[31:0] = out_1;
	checkOutput(128'hde2bf2fdec12ff89f129855576b685fd, checkdata);
	$display("Ciphertext sem whitining key no final: %h %h %h %h", out_4, out_3, out_2, out_1);
	//chave L 128 bits
	#1
	data = 256'hffeeddccbbaa99887766554433221100f0e0d0c0b0a090807060504030201000;
	round_key = 32'hf56b7aeb;
	WK0 = 32'h00000000;
	WK1 = 32'h00000000;
	selecao_f0_f1 = 0;
	//sinais de controle
	sel_mux_1 = 0;
	sel_mux_2 = 0;
	sel_mux_3 = 0;
	sel_mux_4 = 0;
	sel_mux_5 = 0;
	$display("data: %h, R9: %h, F0F1: %h", data, R9, outF0F1);
	#2
	sel_mux_1 = 3;
	sel_mux_2 = 0;
	sel_mux_4 = 1;
	round_key = 32'h994a8a42;
	sel_mux_5 = 0;
	selecao_f0_f1 = 1;
	$display("R1: %h, R9: %h, F0F1: %h", R1, R9, outF0F1);
	mud_fase(32'h96a4bd75,32'hfa854521);
	mud_fase(32'h735b768a, 32'h1f7abac4);
	mud_fase(32'hd5bc3b45, 32'hb99d5d62);
	mud_fase(32'h52d73592,32'h3ef636e5);
	mud_fase(32'hc57a1ac9,32'ha95b9b72);
	mud_fase(32'h5ab42554,32'h369555ed);
	mud_fase(32'h1553ba9a,32'h7972b2a2);
	mud_fase(32'he6b85d4d,32'h8a995951);
	mud_fase(32'h4b550696,32'h2774b4fc);
	mud_fase(32'hc9bb034b,32'ha59a5a7e);
	mud_fase(32'h88cc81a5,32'he4ed2d3f);
	#5
	checkdata[127:96] = out_4;
	checkdata[95:64] = out_3;
	checkdata[63:32] = out_2;
	checkdata[31:0] = out_1;
	checkOutput(128'h8f89a61b9db9d0f393e65627da0d027e, checkdata);
	$display("Chave L 128 bits: %h %h %h %h", out_4, out_3, out_2, out_1);

	//chave L 192 bits
	#1
	data = 256'hffeeddccbbaa99887766554433221100f0e0d0c0b0a090800011223344556677;
	round_key = 32'hc6d61d91;
	WK0 = 32'h00000000;
	WK1 = 32'h00000000;
	selecao_f0_f1 = 0;
	//sinais de controle
	sel_mux_1 = 0;
	sel_mux_2 = 0;
	sel_mux_3 = 0;
	sel_mux_4 = 0;
	sel_mux_5 = 0;
	$display("data: %h, R9: %h, F0F1: %h", data, R9, outF0F1);
	#2
	sel_mux_4 = 1;
	sel_mux_1 = 3;
	sel_mux_2 = 0;
	round_key = 32'haaf73771;
	sel_mux_5 = 0;
	selecao_f0_f1 = 1;
	$display("R1: %h, R9: %h, F0F1: %h", R1, R9, outF0F1);
	#2
	sel_mux_4 = 2;
	sel_mux_5 = 0;
	sel_mux_1 = 1;
	sel_mux_2 = 0;
	selecao_f0_f1 = 0;
	round_key = 32'h5b6226f8;
	$display("R1: %h, R9: %h, F0F1: %h", R1, R9, outF0F1);
	#2
	sel_mux_4 = 3;
	sel_mux_5 = 0;
	sel_mux_1 = 2;
	sel_mux_2 = 0;
	selecao_f0_f1 = 1;
	round_key = 32'h374383ec;
	$display("R1: %h, R9: %h, F0F1: %h", R1, R9, outF0F1);
	mud_fase2(32'h15b8bb4c,32'h799959a2,32'h32d5f596,32'h5ef43485);
	mud_fase2(32'hf57b7acb,32'h995a9a42,32'h96acbd65,32'hfa8d4d21);
	mud_fase2(32'h735f7682,32'h1f7ebec4,32'hd5be3b41,32'hb99f5f62);
	mud_fase2(32'h52d63590,32'h3ef737e5,32'h1162b2f8,32'h7d4383a6);
	mud_fase2(32'h30b8f14c,32'h5c995987,32'h2055d096,32'h4c74b497);
	mud_fase2(32'hfc3b684b,32'h901ada4b,32'h920cb425,32'hfe2ded25);
	mud_fase2(32'h710f7222,32'h1d2eeec6,32'hd4963911,32'hb8b77763);
	mud_fase2(32'h524234b8,32'h3e63a3e5,32'h1128b26c,32'h7d09c9a6);
	mud_fase2(32'h309df106,32'h5cbc7c87,32'hf45f7883,32'h987ebe43);
	#9
	checkdata[127:96] = bloco_dataprocessing.pd_b.R7;
	checkdata[95:64] = bloco_dataprocessing.pd_b.R3;
	checkdata[63:32] = bloco_dataprocessing.pd_b.R6;
	checkdata[31:0] = bloco_dataprocessing.pd_b.R2;
	checkOutput(128'hdb05415a800082db7cb8186cd788c5f3, checkdata);
	
	$display("Chave LL: %h %h %h %h", bloco_dataprocessing.pd_b.R7, bloco_dataprocessing.pd_b.R3, bloco_dataprocessing.pd_b.R6, bloco_dataprocessing.pd_b.R2);
	$display("Chave LR: %h %h %h %h", bloco_dataprocessing.pd_b.R5, bloco_dataprocessing.pd_b.R1, bloco_dataprocessing.pd_b.R4, bloco_dataprocessing.pd_d.R11);

	checkdata[127:96] = bloco_dataprocessing.pd_b.R5;
	checkdata[95:64] = bloco_dataprocessing.pd_b.R1;
	checkdata[63:32] = bloco_dataprocessing.pd_b.R4;
	checkdata[31:0] = bloco_dataprocessing.pd_d.R11;
	checkOutput(128'h1ca9b2e1b4606829c92dd35e2258a432, checkdata);

	//chave L 256 bits
	#1
	data = 256'hffeeddccbbaa99887766554433221100f0e0d0c0b0a090807060504030201000;
	round_key = 32'h0221947e;
	WK0 = 32'h00000000;
	WK1 = 32'h00000000;
	selecao_f0_f1 = 0;
	//sinais de controle
	sel_mux_1 = 0;
	sel_mux_2 = 0;
	sel_mux_3 = 0;
	sel_mux_4 = 0;
	sel_mux_5 = 0;
	$display("data: %h, R9: %h, F0F1: %h", data, R9, outF0F1);
	#2
	sel_mux_4 = 1;
	sel_mux_1 = 3;
	sel_mux_2 = 0;
	round_key = 32'h6e00c0b5;
	sel_mux_5 = 0;
	selecao_f0_f1 = 1;
	$display("R1: %h, R9: %h, F0F1: %h", R1, R9, outF0F1);
	#2
	sel_mux_4 = 2;
	sel_mux_5 = 0;
	sel_mux_1 = 1;
	sel_mux_2 = 0;
	selecao_f0_f1 = 0;
	round_key = 32'hed014a3f;
	$display("R1: %h, R9: %h, F0F1: %h", R1, R9, outF0F1);
	#2
	sel_mux_4 = 3;
	sel_mux_5 = 0;
	sel_mux_1 = 2;
	sel_mux_2 = 0;
	selecao_f0_f1 = 1;
	round_key = 32'h8120e05a;
	$display("R1: %h, R9: %h, F0F1: %h", R1, R9, outF0F1);
	mud_fase2(32'h9a91a51f,32'hf6b0702d,32'ha159d28f,32'hcd78b816);
	mud_fase2(32'hbcbde947,32'hd09c5c0b,32'hb24ff4a3,32'hde6eae05);
	mud_fase2(32'hb536fa51,32'hd917d702,32'h62925518,32'h0eb373d5);
	mud_fase2(32'h094082bc,32'h6561a1be,32'h3ca9e96e,32'h5088488b);
	mud_fase2(32'hf24574b7,32'h9e64a445,32'h9533ba5b,32'hf912d222);
	mud_fase2(32'ha688dd2d,32'hcaa96911,32'h6b4d46a6,32'h076cacdc);
	mud_fase2(32'hd9b72353,32'hb596566e,32'h80ca91a9,32'heceb2b37);
	mud_fase2(32'h786c60e4,32'h144d8dcf,32'h043f9842,32'h681edeb3);
	mud_fase2(32'hee0e4c21,32'h822fef59,32'h4f0e0e20,32'h232feff8);
	#9
	checkdata[127:96] = bloco_dataprocessing.pd_b.R7;
	checkdata[95:64] = bloco_dataprocessing.pd_b.R3;
	checkdata[63:32] = bloco_dataprocessing.pd_b.R6;
	checkdata[31:0] = bloco_dataprocessing.pd_b.R2;
	checkOutput(128'h477e8f0966ee53782cc2be04bf55e28f, checkdata);
	$display("Chave LL: %h %h %h %h", bloco_dataprocessing.pd_b.R7, bloco_dataprocessing.pd_b.R3, bloco_dataprocessing.pd_b.R6, bloco_dataprocessing.pd_b.R2);
	
	$display("Chave LR: %h %h %h %h", bloco_dataprocessing.pd_b.R5, bloco_dataprocessing.pd_b.R1, bloco_dataprocessing.pd_b.R4, bloco_dataprocessing.pd_d.R11);
	
	checkdata[127:96] = bloco_dataprocessing.pd_b.R5;
	checkdata[95:64] = bloco_dataprocessing.pd_b.R1;
	checkdata[63:32] = bloco_dataprocessing.pd_b.R4;
	checkdata[31:0] = bloco_dataprocessing.pd_d.R11;
	checkOutput(128'hd6c10b894eeab57584bd5663cc933940, checkdata);
end
endmodule