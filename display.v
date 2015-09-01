`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:24:12 08/06/2015 
// Design Name: 
// Module Name:    Timemultiplexhexa 
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
module Timemultiplexhexa
	(
		input wire clk, reset,
		input wire [3:0] hexa3, hexa2, hexa1, hexa0, //numeros en hexa
		input wire [3:0] puntos4,//Los puntos de cada display
		output reg [3:0] cualdisplay, //Habilita el display que se ocupe
		output reg [7:0] sieteseg //Leds de display
    );
//Declaracion de contsnates 
//Rango de refresco de 800Hz
localparam N=18;
//Declaracion de señales internas
reg [N-1:0] estadoactual;
wire [N-1:0] estadosig;
reg [3:0] hexaentrante;
reg punto;

//Contador de N-bits
always @(posedge clk, posedge reset)
	if (reset)
		estadoactual <= 0;
	else
		estadoactual <= estadosig;
//Logica estado siguiente
assign estadosig = estadoactual+1'b1;
//Los 2 MSB's controlan el mux
always@*
	case(estadoactual[N-1:N-2])
		2'b00:
			begin
				cualdisplay = 4'b1110;
				hexaentrante = hexa0;
				punto = puntos4[0];
			end
		2'b01:
			begin
				cualdisplay = 4'b1101;
				hexaentrante = hexa1;
				punto = puntos4[1];
			end
		2'b10:
			begin
				cualdisplay = 4'b1011;
				hexaentrante = hexa2;
				punto = puntos4[2];
			end
		default:
			begin
				cualdisplay = 4'b0111;
				hexaentrante = hexa3;
				punto = puntos4[3];
			end
	endcase

//Hexa a 7 segmentos led display
always @*
begin 
	case (hexaentrante)
		4'h0: sieteseg [6:0] = 7'b1000000;
		4'h1: sieteseg [6:0] = 7'b0000111;
		4'h2: sieteseg [6:0] = 7'b0100100;
		4'h3: sieteseg [6:0] = 7'b0110000;
		4'h4: sieteseg [6:0] = 7'b0001100;
		4'h5: sieteseg [6:0] = 7'b0010010;
		4'h6: sieteseg [6:0] = 7'b1111111;
		4'h7: sieteseg [6:0] = 7'b0001001;
		4'h8: sieteseg [6:0] = 7'b1000001;
		4'h9: sieteseg [6:0] = 7'b0000100;
		4'ha: sieteseg [6:0] = 7'b0001000;
		4'hb: sieteseg [6:0] = 7'b1100000;
		4'hc: sieteseg [6:0] = 7'b0110001;
		4'hd: sieteseg [6:0] = 7'b1000010;
		4'he: sieteseg [6:0] = 7'b0000110;
		default: sieteseg [6:0] = 7'b0001110;			
	endcase
	sieteseg[7] = punto;
end
endmodule
