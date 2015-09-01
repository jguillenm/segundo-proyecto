`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: TEC
// Engineer: Rolen Coto/ Josue Guillen
// 
// Create Date:    16:50:27 08/09/2015 
// Design Name: 
// Module Name:    Proyecto1 
// Project Name: Maquina de Estados Compleja
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
module Proyecto1
#(parameter N = 4)
(
	input wire clk,rs, //	Clock y reset
	input wire interruptor,temp,humo,// Banderas de entrada
	input wire [N-1:0] cor,
	output wire LEDalerta,LEDprevencion,LEDnormal,alarma_alerta,alarma_prevencion,// Salidas
	output wire [3:0] cualdisplay,
	output wire [7:0] display
);

wire [3:0] h3,h2,h1,h0;


// Instantiate the module
Timemultiplexhexa panel (
    .clk(clk),
    .reset(rs),	 
    .hexa3(h3), 
    .hexa2(h2), 
    .hexa1(h1), 
    .hexa0(h0), 
    .puntos4(4'hf), 
    .cualdisplay(cualdisplay), 
    .sieteseg(display)
    );

// Instantiate the module
maquinaestados maquina (
    .clk(clk), 
    .reset(rs), 
    .interruptor(interruptor), 
    .temp(temp), 
    .humo(humo), 
    .corriente(cor), 
    .LEDalerta(LEDalerta), 
    .LEDprevencion(LEDprevencion), 
    .LEDnormal(LEDnormal), 
    .alarma_alerta(alarma_alerta), 
    .alarma_prevencion(alarma_prevencion), 
    .hexa3(h3), 
    .hexa2(h2), 
    .hexa1(h1), 
    .hexa0(h0)
    );

endmodule
