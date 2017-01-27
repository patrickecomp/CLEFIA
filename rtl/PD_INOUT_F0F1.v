// Universidade Estadual de Feira de Santana
// Module: PD_INOUT_F0F1.v
// Desc:   modulo integrado ao bloco F0F1.
// Inputs: in_R9: valor 32-bits
//         in_F0F1: valor 32-bits
//         in_pd_mux: valor 32-bits
// Outputs:
// Out: out_F0F1: 32 bits saida.
//      out_mux_pd: 32 bits saida.

module PD_INOUT_F0F1(input [31:0] in_R9, input sel, input [31:0] in_F0F1, input [31:0] in_pd_mux, input clk,
output reg [31:0] out_F0F1, output reg [31:0] R11, output [31:0] R);


reg [31:0] R10;

assign R = in_R9 ^ in_F0F1;


always @(*) begin 
	case (sel)
	   1'b0: begin 
	     out_F0F1 = in_pd_mux; 
	   end 
	   1'b1: begin 
	     out_F0F1 = R;
	   end
	endcase 
end  

always @ (posedge clk)
 begin
    R10 <= R;
	 R11 <= R10;
	 
 end

endmodule