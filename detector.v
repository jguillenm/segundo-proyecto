`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Instituto Tecnológico de Costa Rica
// Engineer: 
// 
// Create Date:    14:48:28 08/29/2015 
// Design Name: 
// Module Name:    detector 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module detector(
	input reset, clk, ps2d, ps2c,
	output reg datolisto, //flanco negado para leer 
	output reg [7:0] tecla
    );
// ------------------------------------------------------------------------
// -- Declarar señales
// ------------------------------------------------------------------------
reg ps2daux, ps2caux;
reg datoff1, datoff2;
reg [10:0] ShiftReg1;
reg [10:1] ShiftReg2;
reg datolistotemp;
// ------------------------------------------------------------------------
// -- Implementacion
// ------------------------------------------------------------------------
// --Flip Flops para condicionar las señales del ps2--
always @ (posedge clk or posedge reset)
begin
	if (reset == 1) 
	begin
		datoff1 <= 0;
		datoff2 <= 0; 
		ps2daux <= 0; 
		ps2caux <= 0;
	end 
	else 
	begin
		datoff1 <= ps2d; 
		ps2daux <= datoff1; 
		datoff2 <= ps2c; 
		ps2caux <= datoff2;
	end
end
// --Desplazamiento de los datos entrantes--
always @(negedge ps2caux or posedge reset)
begin
	if (reset == 1) 
	begin
		ShiftReg1 <= 11'b00000000000;
		ShiftReg2 <= 10'b0000000000;
	end 
	else 
	begin
		ShiftReg1[10:0] <= {ps2daux, ShiftReg1[10:1]};
		ShiftReg2[10:1] <= {ShiftReg1[0],ShiftReg2[10:2]};
	end
end
// --Detección de dato y F0
always @(posedge reset or posedge ps2caux)
begin
	if(reset == 1) 
	begin
		tecla <= 8'b00000000;
		datolistotemp <= 0;
	end 
	else if (ShiftReg2[9:2] == 8'hf0) 
	begin
		tecla <= tecla;
		datolistotemp <= 1;
	end 
	else if (ShiftReg2[8:1] == 8'hf0) 
	begin
	tecla <= ShiftReg1[8:1];
	datolistotemp <= 0;
	end
end

always @(negedge clk)
datolisto <= datolistotemp;

endmodule
