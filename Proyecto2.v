`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:08:14 08/29/2015 
// Design Name: 
// Module Name:    Proyecto2 
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
module Proyecto2(
	input wire reset, clk, ps2d, ps2c,
	output wire datolisto,
	output wire tempenable,humoenable,
	output wire [3:0]cor
    );
	 
wire [7:0] tecla;

// Instantiate the module
detector comunicacion (
    .reset(reset), 
    .clk(clk), 
    .ps2d(ps2d), 
    .ps2c(ps2c), 
    .datolisto(datolisto), 
    .tecla(tecla)
    );

// Instantiate the module
validacion validar (
    .clk(clk), 
    .reset(reset), 
    .teclaentrante(tecla), 
    .tempenable(tempenable), 
    .humoenable(humoenable), 
    .cor(cor)
    );


endmodule
