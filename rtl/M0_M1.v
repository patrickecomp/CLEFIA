// Universidade Estadual de Feira de Santana
// Module: M0_M1.v
// Desc:   modulo que mescla o bloco de matrizes M0 e M1 do CLEFIA. A escolha da matriz depende da entrada de seleção.
// Inputs: X0: valor 8-bits
// Inputs: X1: valor 8-bits
// Inputs: X2: valor 8-bits
// Inputs: X3: valor 8-bits
// Inputs: sel: seletor de matriz; M0 ou M1. 1-bit
// 		
// Outputs:
// Out: Saída de valor 32-bits pós processada pela M0 ou M1.

module M0_M1(input [7:0] X0, input [7:0] X1, input [7:0] X2, input [7:0] X3, input sel, 
output reg [31:0] out);


reg [7:0]A0;
reg [7:0]A1;
reg [7:0]B0;
reg [7:0]B1;

reg [7:0]C0;
reg [7:0]C1;
reg [7:0]D0;
reg [7:0]D1;

reg [7:0]Y0;
reg [7:0]Y1;
reg [7:0]Y2;
reg [7:0]Y3;


always @(*) begin

	A0 = X0 ^ X1;
	A1 = X2 ^ X3;
	B0 = X0 ^ X2;
	B1 = X1 ^ X3;
	
	case (sel)
	  1'b0: begin 
			C0[7] = B0[6];
			C0[6] = B0[5];
			C0[5] = B0[4];
			C0[4] = B0[3]^B0[7];
			C0[3] = B0[2]^B0[7];
			C0[2] = B0[1]^B0[7];
			C0[1] = B0[0];
			C0[0] = B0[7];
			
			C1[7] = B1[6];
			C1[6] = B1[5];
			C1[5] = B1[4];
			C1[4] = B1[3]^B1[7];
			C1[3] = B1[2]^B1[7];
			C1[2] = B1[1]^B1[7];
			C1[1] = B1[0];
			C1[0] = B1[7];
			
			D0[7] = A0[5];
			D0[6] = A0[4];
			D0[5] = A0[3]^A0[7];
			D0[4] = A0[2]^A0[7]^A0[6];
			D0[3] = A0[1]^A0[7]^A0[6];
			D0[2] = A0[0]^A0[6];
			D0[1] = A0[7];
			D0[0] = A0[6];
			
			D1[7] = A1[5];
			D1[6] = A1[4];
			D1[5] = A1[3]^A1[7];
			D1[4] = A1[2]^A1[7]^A1[6];
			D1[3] = A1[1]^A1[7]^A1[6];
			D1[2] = A1[0]^A1[6];
			D1[1] = A1[7];
			D1[0] = A1[6];

			Y1 = C0 ^ D1 ^ X1;
			Y2 = C1 ^ D0 ^ X2;
			
	  end 
	  1'b1: begin 
			
			C0[7] = A0[6];
			C0[6] = A0[5];
			C0[5] = A0[4];
			C0[4] = A0[3]^A0[7];
			C0[3] = A0[2]^A0[7];
			C0[2] = A0[1]^A0[7];
			C0[1] = A0[0];
			C0[0] = A0[7];
			
			C1[7] = A1[6];
			C1[6] = A1[5];
			C1[5] = A1[4];
			C1[4] = A1[3]^A1[7];
			C1[3] = A1[2]^A1[7];
			C1[2] = A1[1]^A1[7];
			C1[1] = A1[0];
			C1[0] = A1[7];
			
			D0[7] = B0[4];
			D0[6] = B0[3]^B0[7];
			D0[5] = B0[2]^B0[7]^B0[6];
			D0[4] = B0[1]^B0[7]^B0[6]^B0[5];
			D0[3] = B0[0]^B0[6]^B0[5];
			D0[2] = B0[7]^B0[5];
			D0[1] = B0[6];
			D0[0] = B0[5];
			
			D1[7] = B1[4];
			D1[6] = B1[3]^B1[7];
			D1[5] = B1[2]^B1[7]^B1[6];
			D1[4] = B1[1]^B1[7]^B1[6]^B1[5];
			D1[3] = B1[0]^B1[6]^B1[5];
			D1[2] = B1[7]^B1[5];
			D1[1] = B1[6];
			D1[0] = B1[5];
	
			Y1 = C1 ^ D0 ^ X1;
			Y2 = C0 ^ D1 ^ X2;
	  end
	endcase 
	
	Y0 = C1 ^ D1 ^ X0;
	Y3 = C0 ^ D0 ^ X3;
	
	out[7:0] = Y3;
	out[15:8] = Y2;
	out[23:16] = Y1;
	out[31:24] = Y0;
	
end

endmodule