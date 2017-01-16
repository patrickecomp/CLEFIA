// Universidade Estadual de Feira de Santana
// Module: PD_MUX.v
// Desc:   modulo com entrada de 256 bits que sera mutiplexada para um caminho de dados de 32 bits
// Inputs: X: valor 255-bits
//         WK0: Whitining Key 0
//         WK1: Whitining Key 1
// 		  R11: valor de 32 bits contidos no registrador
// Outputs:
// Out: out: 32 bits saida para o PD2.
//      out2: 32 bits saida para PD3.

module PD_MUX(input [255:0] X, input [31:0] R11, input [31:0] WK0, input [31:0] WK1,
input [1:0] sel1, input [2:0] sel2,
output reg [31:0] out, output reg [31:0] out2);

wire [31:0]P0;
wire [31:0]P1;
wire [31:0]P2;
wire [31:0]P3;
wire [31:0]C0;
wire [31:0]C1;
wire [31:0]C2;
wire [31:0]C3;

assign P0 = X[255:224];
assign P1 = X[223:192];
assign P2 = X[191:160];
assign P3 = X[159:128];
assign C0 = X[127:96];
assign C1 = X[95:64];
assign C2 = X[63:32];
assign C3 = X[31:0];

always @(*) begin 
	case (sel1)
	   2'b00: begin 
	     out = P1 ^ WK0; 
	   end 
	   2'b01: begin 
	     out = C1;
	   end
	   2'b10: begin 
	     out = C3;
	   end
	   2'b11: begin 
	     out = P3 ^ WK1;
	   end
	endcase 
end

always @(*) begin 
	case (sel2)
	   3'b000: begin 
	     out2 = P0; 
	   end 
	   3'b001: begin 
	     out2 = P2;
	   end
	   3'b010: begin 
	     out2 = C0;
	   end
	   3'b011: begin 
	     out2 = C2;
	   end
	   3'b100: begin 
	     out2 = R11;
	   end
	endcase 
end  


endmodule