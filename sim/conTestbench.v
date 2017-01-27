`timescale 1ns / 1ps
`include "/home/patrickvieira/Projects/CLEFIA/rtl/con_i.v"

module conTestbench();

	reg [15:0] iv;
	reg [15:0] p, q;
	reg sel, sel2, clk;
    	wire [15:0] con;

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

    task con_even_odd;
        begin
	    #2
	    sel = 1;
	    $display("Valor de constante: %h", module_con.result);
	    #2
	    sel = 0;
            $display("Valor de constante: %h", module_con.result);
        end
    endtask

 
    con_i module_con(.iv(iv),.p(p),.q(q),.sel(sel),.sel2(sel2),.clk(clk),.con(con));

//Clock do bloco de registradores
  always 
  begin
    #1  clk =  ! clk;
 end


initial begin
	clk = 0;

	 ///////////////////////////////
        // Hard coded tests
        ///////////////////////////////

//constantes para 128 bits 
	iv = 16'h428a;
	p = 16'hb7e1;
	q = 16'h243f;
	sel2 = 0;
	sel = 0;
	#1
	$display("Valor de constante: %h", module_con.result);
	con_even_odd();
	sel2 = 1;
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();

//constantes para 192 bits 
	$display("---------------------------------------");
	iv = 16'h7137;
	p = 16'hb7e1;
	q = 16'h243f;
	sel2 = 0;
	sel = 0;
	#1
	$display("Valor de constante: %h", module_con.result);
	con_even_odd();
	sel2 = 1;
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
//constantes para 256 bits 
	$display("---------------------------------------");
	iv = 16'hb5c0;
	p = 16'hb7e1;
	q = 16'h243f;
	sel2 = 0;
	sel = 0;
	#1
	$display("Valor de constante: %h", module_con.result);
	con_even_odd();
	sel2 = 1;
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
	con_even_odd();
end
endmodule