`timescale 1ns / 1ps
`include "mux.v"
`include "SBOX0.v"
`include "SBOX1.v"
`include "M0_M1.v"
`include "F0_F1.v"

module F0_F1Testbench();

	reg [31:0] X;
	reg [31:0] round_key;
	reg sel;
    	wire [31:0] out;

    task checkOutput;
        input [31:0] dados, out;
        if ( dados !== out ) begin
            $display("Teste FALHOU: Resultado incorreto, Saída esperada: %h, Saída: %h", dados, out);
		$finish();
        end
        else begin
            $display("Teste PASSOU: Saída esperada:%h, Saída %h", dados, out);
        end
    endtask
 
    F0_F1 bloco_f(.x(X),.round_key(round_key),.selecao_f0_f1(sel),
        .result(out));


    initial begin


	 ///////////////////////////////
        // Hard coded tests
        ///////////////////////////////
	X = 32'h00010203;
	round_key=32'hf3e6cef9;
	sel = 0;
	#1
	checkOutput(32'h547a3193, out);

	X = 32'haf91ea58;
	round_key=32'h41c06256;
	sel = 0;
	#1
	checkOutput(32'hf51cebb3, out);

	X = 32'hfd15e1b8;
	round_key=32'h6a27e20a;
	sel = 0;
	#1
	checkOutput(32'hd8dfd8de, out);

	X = 32'hc4896f29;
	round_key=32'he8c528dc;
	sel = 0;
	#1
	checkOutput(32'hb5b28e96, out);
	
	X = 32'h376c6fd2;
	round_key=32'h59cd17c4;
	sel = 0;
	#1
	checkOutput(32'h29f08afd, out);

	X = 32'h673fc8b9;
	round_key=32'h312a37cc;
	sel = 0;
	#1
	checkOutput(32'h5999a79e, out);

	X = 32'h12d017bc;
	round_key=32'h7e8e7eec;
	sel = 0;
	#1
	checkOutput(32'h6ed11b09, out);

	X = 32'h1459a507;
	round_key=32'hd3f463d6;
	sel = 0;
	#1
	checkOutput(32'h8c9d011c, out);

	X = 32'hbfd8dde7;
	round_key=32'he75eb039;
	sel = 0;
	#1
	checkOutput(32'he6d6501e, out);

	X = 32'h5e3a5595;
	round_key=32'h018002e2;
	sel = 0;
	#1
	checkOutput(32'h3a1b0e97, out);

	X = 32'hbba357c7;
	round_key=32'h9f98d11e;
	sel = 0;
	#1
	checkOutput(32'h28974052, out);

	X = 32'h5196dce1;
	round_key=32'hb0369efa;
	sel = 0;
	#1
	checkOutput(32'hffb5db32, out);

	X = 32'hf9d97f1d;
	round_key=32'h3438f93b;
	sel = 0;
	#1
	checkOutput(32'h0a744c28, out);

	X = 32'h1e29190c;
	round_key=32'h68df9029;
	sel = 0;
	#1
	checkOutput(32'haaa2c803, out);

	X = 32'h817ca7e4;
	round_key=32'h24d6406d;
	sel = 0;
	#1
	checkOutput(32'h7bd4cced, out);

	X = 32'h367c28af;
	round_key=32'h41c28193;
	sel = 0;
	#1
	checkOutput(32'h598e6940, out);

	X = 32'h64664dd0;
	round_key=32'ha34a20f5;
	sel = 0;
	#1
	checkOutput(32'h2ac01b0a, out);

	X = 32'hde2bf2fd;
	round_key=32'hb19d0554;
	sel = 0;
	#1
	checkOutput(32'hac7738f2, out);

	X = 32'h08090a0b;
	round_key=32'h8df75e38;
	sel = 1;
	#1
	checkOutput(32'habf12070, out);

	X = 32'h1c56b7f7;
	round_key=32'h640ac51b;
	sel = 1;
	#1
	checkOutput(32'h82dfe347, out);

	X = 32'h82dee144;
	round_key=32'h5a791b90;
	sel = 1;
	#1
	checkOutput(32'he15ea81c, out);

	X = 32'h4ecf4244;
	round_key=32'h00336ea3;
	sel = 1;
	#1
	checkOutput(32'hb65c519a, out);

	X = 32'h4b49b022;
	round_key=32'h28565583;
	sel = 1;
	#1
	checkOutput(32'hbe01d127, out);

	X = 32'h7a88be0e;
	round_key=32'hc08abd77;
	sel = 1;
	#1
	checkOutput(32'h0429b329, out);

	X = 32'h3345dcfb;
	round_key=32'h8be7e949;
	sel = 1;
	#1
	checkOutput(32'hdfd3cd32, out);

	X = 32'hb8ec058b;
	round_key=32'ha0aad6aa;
	sel = 1;
	#1
	checkOutput(32'h93684eec, out);

	X = 32'h81b85950;
	round_key=32'h0d657eb9;
	sel = 1;
	#1
	checkOutput(32'h6d5839b4, out);

	X = 32'h79019cb3;
	round_key=32'h9117d009;
	sel = 1;
	#1
	checkOutput(32'hb9b479c8, out);

	X = 32'h066ca42f;
	round_key=32'hbabee8cf;
	sel = 1;
	#1
	checkOutput(32'h4a6700b1, out);

	X = 32'h145d5524;
	round_key=32'hd3aaef0d;
	sel = 1;
	#1
	checkOutput(32'h907d3820, out);

	X = 32'h2bde6fe7;
	round_key=32'hf9cea4a0;
	sel = 1;
	#1
	checkOutput(32'h1c3e38a3, out);

	X = 32'h4da8e442;
	round_key=32'hb869b4a7;
	sel = 1;
	#1
	checkOutput(32'hc4315b8d, out);

	X = 32'h3de82490;
	round_key=32'he74bc550;
	sel = 1;
	#1
	checkOutput(32'heac2f0fb, out);

	X = 32'hf4ebe9f7;
	round_key=32'h16de4795;
	sel = 1;
	#1
	checkOutput(32'hc119609f, out);

	X = 32'h4065c77b;
	round_key=32'h33265d14;
	sel = 1;
	#1
	checkOutput(32'hc755adfa, out);

	X = 32'hf1298555;
	round_key=32'h5142f434;
	sel = 1;
	#1
	checkOutput(32'h12d0c82d, out);
        $display("\n\nTODOS OS TESTES PASSARAM!");
        $finish();
	
end
endmodule