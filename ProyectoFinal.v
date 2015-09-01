`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:33:14 08/29/2015 
// Design Name: 
// Module Name:    ProyectoFinal 
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
module ProyectoFinal(
	input wire rst, clk, ps2d, ps2c,interruptor,
	output wire LEDalerta,LEDprevencion,LEDnormal,alarma_alerta,alarma_prevencion,// Salidas
	output wire [3:0] cualdisplay,
	output wire datolisto,
	output wire [7:0] display
    );

wire temp,humo;
wire [3:0] cor;
wire reset;
reg [2:0] aux;

always @ (posedge clk)
aux <= {aux[1:0], rst};


assign reset = aux[0] & aux[1] & !aux[2];
				

// Instantiate the module
Proyecto1 maquina (
    .clk(clk), 
    .rs(reset), 
    .interruptor(interruptor), 
    .temp(temp), 
    .humo(humo), 
    .cor(cor), 
    .LEDalerta(LEDalerta), 
    .LEDprevencion(LEDprevencion), 
    .LEDnormal(LEDnormal), 
    .alarma_alerta(alarma_alerta), 
    .alarma_prevencion(alarma_prevencion), 
    .cualdisplay(cualdisplay), 
    .display(display)
    );

// Instantiate the module
Proyecto2 comunicacion (
    .reset(reset), 
    .clk(clk), 
    .ps2d(ps2d), 
    .ps2c(ps2c), 
    .datolisto(datolisto), 
    .tempenable(temp), 
    .humoenable(humo), 
    .cor(cor)
    );



endmodule
