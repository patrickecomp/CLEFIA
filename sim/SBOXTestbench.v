`timescale 1ns / 1ps
`include "SBOX0.v"

module SBOXTestbench();

	reg [7:0] X;
    	wire [7:0] out;
	reg [7:0] rand_X;
	reg [7:0] dados_s0 [0:255];


	integer count = 0;

    task checkOutput;
        input [7:0] dados, out;
        if ( dados !== out ) begin
			count = count + 1;
            $display("Teste FALHOU: Resultado incorreto, Tabela: %b, Saída: %b", dados, out);
		$finish();
        end
        else begin
            $display("Teste PASSOU: Tabela %b, Saída %b", dados, out);
        end
    endtask
 
    SBOX0 box0(.X(X),
        .out(out));

	integer i;
    localparam loops = 25;
    initial begin
	$readmemh("s0_dados.txt", dados_s0);
        for(i = 0; i < loops; i = i + 1)
        begin
            #1;
            rand_X = {$random};
		$display("Valor de X: %b", rand_X);
            X = rand_X;

            #1;
            checkOutput(dados_s0[X], out);

        end

	 ///////////////////////////////
        // Hard coded tests
        ///////////////////////////////

	X = 8'h00;
	#1;
	checkOutput(8'h57, out);

	X = 8'had;
	#1;
	checkOutput(8'h21, out);

	X = 8'hf0;
	#1;
	checkOutput(8'h9a, out);

	X = 8'hd6;
	#1;
	checkOutput(8'hd9, out);

	X = 8'h45;
	#1;
	checkOutput(8'h00, out);
	
        $display("\n\nTODOS OS TESTES PASSARAM!");
        $finish();
	
end
endmodule
