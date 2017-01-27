// Universidade Estadual de Feira de Santana
// Module: PD_REG.v
// Desc:   modulo com entrada duas entradas de 32bits. Esse modulo funciona para armazenar os valores advindos da entrada e os processados pelo bloco F0_F1, para ser posteriormente utilizados.
// Inputs: in_mux2: valor 32-bits
//         in_R1: valor 32-bits
// Outputs:
// Out: out_R9: 32 bits saida para o PD3.

module PD_REG(input [31:0] in_mux2, input [1:0] sel1, input sel2, input [31:0] in_R1, input clk,
output reg [31:0] out_R9, output reg [31:0] R1, output reg [31:0] R2, output reg [31:0] R3);


reg [31:0] R4;
reg [31:0] R5;
reg [31:0] R6;
reg [31:0] R7;
reg [31:0] R8;
reg [31:0] out_mux;
reg [31:0] out_mux2;

always @(*) begin 
	case (sel1)
	   2'b00: begin 
	     out_mux = R7; 
	   end 
	   2'b01: begin 
	     out_mux = R3;
	   end
	   2'b10: begin 
	     out_mux = R1;
	   end
	endcase 
end

always @(*) begin 
	case (sel2)
	   1'b0: begin 
	     out_mux2 = in_mux2; 
	   end 
	   1'b1: begin 
	     out_mux2 = out_mux;
	   end
	endcase 
end  

always @ (posedge clk)
 begin
    R1 <= in_R1;
	 R2 <= R1;
	 R3 <= R2;
	 R4 <= R3;
	 R5 <= R4;
	 R6 <= R5;
	 R7 <= R6;
	 R8 <= out_mux2;
	 out_R9 <= R8;
	 
 end

endmodule