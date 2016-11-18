
`timescale 1ns / 1ps
`include "M0_M1.v"

module M0_M1Testbench();

	reg [31:0] X;
	reg sel;
    	wire [31:0] out;

    task checkOutput;
        input [31:0] dados, out;
        if ( dados !== out ) begin
            $display("Teste FALHOU: Resultado incorreto, Saída esperada: %h, Saída: %h", dados, out);
		$finish();
        end
        else begin
            $display("Teste PASSOU: Saída esperada %h, Saída %h", dados, out);
        end
    endtask
 
    M0_M1 matriz(.X0(X[31:24]),.X1(X[23:16]),.X2(X[15:8]),.X3(X[7:0]),.sel(sel),
        .out(out));


    initial begin


	 ///////////////////////////////
        // Hard coded tests
        ///////////////////////////////
	X = 32'h43c58e9e;
	sel = 0;
	#1
	checkOutput(32'hb5021a3b, out);

	X = 32'hf3d10ba4;
	sel = 0;
	#1;
	checkOutput(32'h9fba69c1, out);

	X = 32'h79ea66ed;
	sel = 0;
	#1;
	checkOutput(32'h61c21ea5, out);

	X = 32'hdaeda541;
	sel = 0;
	#1;
	checkOutput(32'h28a43c63, out);

	X = 32'hf26ad3e5;
	sel = 0;
	#1;
	checkOutput(32'h29f08afd, out);

	X = 32'hb39c8e58;
	sel = 0;
	#1;
	checkOutput(32'h5999a79e, out);

	X = 32'h8b737025;
	sel = 0;
	#1;
	checkOutput(32'h6ed11b09, out);

	X = 32'he7ee5a5f;
	sel = 0;
	#1;
	checkOutput(32'h8c9d011c, out);

	X = 32'h4e821daf;
	sel = 0;
	#1;
	checkOutput(32'he6d6501e, out);

	X = 32'h612d8f7b;
	sel = 0;
	#1;
	checkOutput(32'h3a1b0e97, out);

	X = 32'hf70f1144;
	sel = 0;
	#1;
	checkOutput(32'h28974052, out);

	X = 32'h6f7efd4f;
	sel = 0;
	#1;
	checkOutput(32'hffb5db32, out);

	X = 32'h3f751141;
	sel = 0;
	#1;
	checkOutput(32'h0a744c28, out);

	X = 32'hfe6db7e7;
	sel = 0;
	#1;
	checkOutput(32'haaa2c803, out);

	X = 32'h8d233818;
	sel = 0;
	#1;
	checkOutput(32'h7bd4cced, out);

	X = 32'h7c4a935b;
	sel = 0;
	#1;
	checkOutput(32'h598e6940, out);

	X = 32'he7e61de7;
	sel = 0;
	#1;
	checkOutput(32'h2ac01b0a, out);

	X = 32'hb44d648c;
	sel = 0;
	#1;
	checkOutput(32'hac7738f2, out);

	X = 32'h777de8e8;
	sel = 1;
	#1;
	checkOutput(32'habf12070, out);

	X = 32'h63a5edd2;
	sel = 1;
	#1;
	checkOutput(32'h82dfe347, out);

	X = 32'hbe59e10d;
	sel = 1;
	#1;
	checkOutput(32'he15ea81c, out);

	X = 32'h43bce638;
	sel = 1;
	#1;
	checkOutput(32'hb65c519a, out);

	X = 32'h62af9f1b;
	sel = 1;
	#1;
	checkOutput(32'hbe01d127, out);


	X = 32'h2dd1e9a2;
	sel = 1;
	#1;
	checkOutput(32'h0429b329, out);

	X = 32'h67a08eba;
	sel = 1;
	#1;
	checkOutput(32'hdfd3cd32, out);

	X = 32'h9e97f1a1;
	sel = 1;
	#1;
	checkOutput(32'h93684eec, out);

	X = 32'h59c56044;
	sel = 1;
	#1;
	checkOutput(32'h6d5839b4, out);

	X = 32'h0185a49c;
	sel = 1;
	#1;
	checkOutput(32'hb9b479c8, out);

	X = 32'hcb72a481;
	sel = 1;
	#1;
	checkOutput(32'h4a6700b1, out);

	X = 32'h72642dce;
	sel = 1;
	#1;
	checkOutput(32'h907d3820, out);

	X = 32'hab28e0da;
	sel = 1;
	#1;
	checkOutput(32'h1c3e38a3, out);

	X = 32'hfc0c25f6;
	sel = 1;
	#1;
	checkOutput(32'hc4315b8d, out);

	X = 32'h2904757b;
	sel = 1;
	#1;
	checkOutput(32'heac2f0fb, out);

	X = 32'h669b8953;
	sel = 1;
	#1;
	checkOutput(32'hc119609f, out);

	X = 32'h788c85b4;
	sel = 1;
	#1;
	checkOutput(32'hc755adfa, out);

	X = 32'h7e99ea2a;
	sel = 1;
	#1;
	checkOutput(32'h12d0c82d, out);
	
	
        $display("\n\nTODOS OS TESTES PASSARAM!");
        $finish();
	
end
endmodule