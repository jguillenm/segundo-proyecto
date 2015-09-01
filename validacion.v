`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:03:28 08/29/2015 
// Design Name: 
// Module Name:    validacion 
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
module validacion(
	input wire clk,reset,
	input wire [7:0] teclaentrante,
	output reg tempenable,humoenable,
	output reg [3:0]cor
    );

localparam 
	enter = 1'b0,
	revisar = 1'b1;

reg estadoactual, estadosig;

always @(posedge clk, posedge reset)
begin
		if(reset)
				estadoactual <= enter;
		else
				estadoactual <= estadosig;
end
				
//Parte Combinacional
always@*
begin
	estadosig = estadoactual;
	tempenable = 1'b0;
	humoenable = 1'b0;
	cor = 4'b0000;
	case(estadoactual)
		enter:
			begin
			if(teclaentrante == 8'h5a)
				estadosig = revisar;
			end	
		revisar:
			begin
			if(teclaentrante == 8'h2c)//temperatura
				begin
				estadosig = revisar;
				tempenable = 1'b1;
				humoenable = 1'b0;
				cor = 4'h0;
				end
			else if (teclaentrante == 8'h16)//corriente = 10 
				begin
				estadosig = revisar;
				tempenable = 1'b0;
				humoenable = 1'b0;
				cor = 4'b0001;
				end
			else if (teclaentrante == 8'h1e)//corriente = 20 
				begin
				estadosig = revisar;
				tempenable = 1'b0;
				humoenable = 1'b0;
				cor = 4'b0010;
				end
			else if (teclaentrante == 8'h26)//corriente = 30 
				begin
				estadosig = revisar;
				tempenable = 1'b0;
				humoenable = 1'b0;
				cor = 4'b1111;
				end
else if (teclaentrante == 8'h25)//corriente = 40 
				begin
				estadosig = revisar;
				tempenable = 1'b0;
				humoenable = 1'b0;
				cor = 4'b1111;
				end
			else if (teclaentrante == 8'h2e)//corriente = 50 
				begin
				estadosig = revisar;
				tempenable = 1'b0;
				humoenable = 1'b0;
				cor = 4'b1111;
				end
			else if (teclaentrante == 8'h36)//corriente = 60 
				begin
				estadosig = revisar;
				tempenable = 1'b0;
				humoenable = 1'b0;
				cor = 4'b1111;
				end
			else if (teclaentrante == 8'h3d)//corriente = 70 
				begin
				estadosig = revisar;
				tempenable = 1'b0;
				humoenable = 1'b0;
				cor = 4'b1111;
				end
			else if (teclaentrante == 8'h3e)//corriente = 80 
				begin
				estadosig = revisar;
				tempenable = 1'b0;
				humoenable = 1'b0;
				cor = 4'b1111;
				end
			else if (teclaentrante == 8'h46)//corriente = 90 
				begin
				estadosig = revisar;
				tempenable = 1'b0;
				humoenable = 1'b0;
				cor = 4'b1111;
				end
			else if (teclaentrante == 8'h45)//corriente = 00 
				begin
				estadosig = revisar;
				tempenable = 1'b0;
				humoenable = 1'b0;
				cor = 4'b0000;
				end
			else if (teclaentrante == 8'h33)//humo
				begin
				estadosig = revisar;
				tempenable = 1'b0;
				humoenable = 1'b1;
				cor = 4'b0000;
				end
			else if (teclaentrante == 8'h29)//apagar
				begin
				estadosig = enter;
				tempenable = 1'b0;
				humoenable = 1'b0;
				cor = 4'b0000;
				end
			else begin
				estadosig = revisar;
				tempenable = tempenable;
				humoenable = humoenable;
				cor = cor;
				end
			end
		default:
			estadosig = enter;
	endcase
end


endmodule
