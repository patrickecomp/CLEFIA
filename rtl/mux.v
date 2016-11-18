// Universidade Estadual de Feira de Santana
// Module: mux.v
// Desc:   Multiplexador de duas estradas de 8 bits. O modulo faz a seleção entre as duas para a sua saída.
// Inputs: data_0: primeira entrada 8-bits
// Inputs: data_1: segunda entrada 8-bits
// Inputs: sel: entrada de seleção 1-bit
// 						
// Outputs:
// Out: Saída de valor 8-bits data_0 ou data_1.
module mux(
input [7:0] data_0,
input [7:0] data_1,
input sel, 
output reg[7:0] data
);

always @(*) begin 
	case (sel)
	   1'b0: begin 
	     data = data_0; 
	   end 
	   1'b1: begin 
	     data = data_1;
	   end
	endcase 
end 
endmodule 