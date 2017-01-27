// Universidade Estadual de Feira de Santana
// Module: con_i.v
// Desc:   modulo responsavel por criar as constantes utilizadas no calculo das round keys
// Inputs: X: valor 8-bits
// 						
// Outputs:
// Out: Saída de valor 8-bits pós processada pela S-box 0.

module con_i(input [15:0] iv, input [15:0] p, input [15:0] q, input sel, input sel2, input clk,
output reg [31:0] con);

reg [15:0] ti;
reg [15:0] ti_next;
wire [15:0] not_ti;
wire [15:0] pq;
wire [15:0] mux_ti;
wire [15:0] t_1, t_8, con_high, con_low, mux_i;
wire [31:0] result;

assign enab_clk = clk & sel;
assign not_ti = ~ti;
assign pq = (sel) ? p : q;
assign mux_ti = (sel) ? ti : not_ti;
assign t_1 = {not_ti[14:0], not_ti[15:15]};
assign t_8 = {ti[7:0], ti[15:8]};
assign con_high = pq ^ mux_ti;
assign con_low = (sel) ? t_1 : t_8;
assign result = {con_high, con_low};
assign mux_i = (sel2) ? ti_next : iv;

always @(*) begin
	ti_next[0] = ti[1];
	ti_next[1] = ti[2];
	ti_next[2] = ti[3];
	ti_next[3] = ti[4] ^ ti[0];
	ti_next[4] = ti[5] ^ ti[0];
	ti_next[5] = ti[6];
	ti_next[6] = ti[7];
	ti_next[7] = ti[8];
	ti_next[8] = ti[9];
	ti_next[9] = ti[10];
	ti_next[10] = ti[11] ^ ti[0];
	ti_next[11] = ti[12];
	ti_next[12] = ti[13] ^ ti[0];
	ti_next[13] = ti[14] ;
	ti_next[14] = ti[15] ^ ti[0];
	ti_next[15] = ti[0] ;
		
end

always @ (posedge enab_clk)
 begin
    ti <= mux_i;
 end
 






endmodule

