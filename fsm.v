`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:01:25 08/03/2015 
// Design Name: 
// Module Name:    Maquina 
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
module maquinaestados
#(parameter N = 4)
(
	input wire clk, reset, //	Clock y reset
	input wire interruptor,temp,humo,// Banderas de entrada
	input wire [N-1:0] corriente,
	output reg LEDalerta,LEDprevencion,LEDnormal,alarma_alerta,alarma_prevencion,// Salidas, definidas como reg
	output reg [3:0] hexa3,hexa2,hexa1,hexa0 //numeros en hexa
);

//*********************************************************

localparam [2:0] // Codificacion de los estados o etiquetas 
	inicio = 3'b000,
	temp_normal = 3'b001,
	alerta_temp = 3'b010,
	corri_normal = 3'b011,
	alerta_corri = 3'b100,
	humo_normal = 3'b101,
	preven_humo = 3'b110;

reg [2:0] estado, estado_sig; // Reg, estado actual y siguiente 
reg corriente_25;



//*********************************************************

//Parte Secuencial

always@(posedge clk, posedge reset)
	if (reset)
		estado <= inicio;
	else
		estado <= estado_sig;


//*********************************************************

//Parte Combinacional
always@*
begin
   if (corriente >= 4'b1100)
      corriente_25 <= 1'b1;
   else
      corriente_25 <= 1'b0;
		
	estado_sig = estado;
	LEDalerta = 1'b0;
	LEDprevencion = 1'b0;
	LEDnormal = 1'b0;
	alarma_alerta = 1'b0;
	alarma_prevencion = 1'b0;
	hexa3 = 4'h5;
	hexa2 = 4'ha;
	hexa1 = 4'hf;
	hexa0 = 4'he;
	case(estado)

		inicio:
			begin
			LEDnormal = 1'b1;
			if(interruptor)
				estado_sig = temp_normal;
			else
				begin
				hexa3 = 4'h5;
				hexa2 = 4'ha;
				hexa1 = 4'hf;
				hexa0 = 4'he;
				end
			end
			
		temp_normal:
			if(temp)
				estado_sig = alerta_temp;
			else
				begin
					estado_sig = corri_normal; //REVISAR FORMATO
					LEDnormal = 1'b1;	
					hexa3 = 4'h5;
					hexa2 = 4'ha;
					hexa1 = 4'hf;
					hexa0 = 4'he;					//PARECE QUE CUANDO SE ACTIVA UNA 	
				end									//SEÑAL DE SALIDA SE PONE BEGIN Y END //es cuando se ponen mas de 2 instrucciones
				
		alerta_temp:
			begin
				LEDalerta = 1'b1;
				alarma_alerta = 1'b1;
				LEDnormal  = 1'b0;
				hexa3 = 4'h1;
				hexa2 = 4'he;
				hexa1 = 4'h3;
				hexa0 = 4'h4;
			if(!temp) //NO SE SI ESTE ES EL FORMATO CORRECTO//creo que es asi!
				begin
					estado_sig = corri_normal;
					LEDnormal = 1'b1; 
					LEDalerta = 1'b0;
					alarma_alerta = 1'b0;//NO SE QUE SIGNIFICA EXACTAMENTE EL 1'B1 Y EN QUE SE DIFERENCIA DE SOLO EL 1// es 1 bit de tipo binario con el valor de 1 creo que es el formato que se usa aqui
				end
			end
			
		corri_normal:
			if(corriente_25)
				estado_sig = alerta_corri;
			else
				begin
					hexa3 = 4'h5;
					hexa2 = 4'ha;
					hexa1 = 4'hf;
					hexa0 = 4'he;
					estado_sig = humo_normal;
					LEDnormal = 1'b1;
				end
		
		alerta_corri:
			begin
				LEDalerta = 1'b1;
				alarma_alerta = 1'b1;
				LEDnormal = 1'b0;
				hexa3 = 4'h2;
				hexa2 = 4'h5;
				hexa1 = 4'ha;
				hexa0 = 4'h6;
			if(!corriente_25)
				begin
					estado_sig = humo_normal;
					LEDnormal = 1'b1;
					LEDalerta = 1'b0;
					alarma_alerta = 1'b0;
				end
			end
			
		humo_normal:
			if (humo)
				estado_sig = preven_humo;
			else
				begin
					hexa3 = 4'h5;
					hexa2 = 4'ha;
					hexa1 = 4'hf;
					hexa0 = 4'he;
					estado_sig = inicio;
					LEDnormal = 1'b1;
				end
					
		preven_humo:
			begin
				LEDprevencion = 1'b1;
				alarma_prevencion = 1'b1;
				LEDnormal = 1'b0;
				hexa3 = 4'h7;
				hexa2 = 4'h8;
				hexa1 = 4'h3;
				hexa0 = 4'h0;
			if(!humo)
				begin
					estado_sig = inicio;
					LEDnormal = 1'b1;
					LEDprevencion = 1'b0;
					alarma_prevencion = 1'b0;
				end
			end
		default:
			begin
				hexa3 = 4'h6;
				hexa2 = 4'h6;
				hexa1 = 4'h6;
				hexa0 = 4'h6;
			end
	endcase
end
endmodule
