/////////////////////////////////////////////////////////////////////
////                                                             ////
////  Author: Eyal Hochberg                                      ////
////          eyal@provartec.com                                 ////
////                                                             ////
////  Downloaded from: http://www.opencores.org                  ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Copyright (C) 2010 Provartec LTD                            ////
//// www.provartec.com                                           ////
//// info@provartec.com                                          ////
////                                                             ////
//// This source file may be used and distributed without        ////
//// restriction provided that this copyright statement is not   ////
//// removed from the file and that any derivative work contains ////
//// the original copyright notice and the associated disclaimer.////
////                                                             ////
//// This source file is free software; you can redistribute it  ////
//// and/or modify it under the terms of the GNU Lesser General  ////
//// Public License as published by the Free Software Foundation.////
////                                                             ////
//// This source is distributed in the hope that it will be      ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied  ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR     ////
//// PURPOSE.  See the GNU Lesser General Public License for more////
//// details. http://www.gnu.org/licenses/lgpl.html              ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
//---------------------------------------------------------
//-- File generated by RobustVerilog parser
//-- Version: 1.0
//-- Invoked Fri Mar 25 23:33:00 2011
//--
//-- Source file: prgen_mux.v
//---------------------------------------------------------


  

module prgen_mux8(sel,ch_x,x);

   parameter                  WIDTH      = 8;
   
   
   input [3-1:0]     sel;
   input [8*WIDTH-1:0]     ch_x;
   output [WIDTH-1:0]           x;

   
   reg [WIDTH-1:0]              x;
   

   always @(/*AUTOSENSE*/ch_x or sel)
     begin
    case (sel)                                  
      3'd0 :x = ch_x[WIDTH-1+WIDTH*0:WIDTH*0];
      3'd1 :x = ch_x[WIDTH-1+WIDTH*1:WIDTH*1];
      3'd2 :x = ch_x[WIDTH-1+WIDTH*2:WIDTH*2];
      3'd3 :x = ch_x[WIDTH-1+WIDTH*3:WIDTH*3];
      3'd4 :x = ch_x[WIDTH-1+WIDTH*4:WIDTH*4];
      3'd5 :x = ch_x[WIDTH-1+WIDTH*5:WIDTH*5];
      3'd6 :x = ch_x[WIDTH-1+WIDTH*6:WIDTH*6];
      3'd7 :x = ch_x[WIDTH-1+WIDTH*7:WIDTH*7];
      
      default :                                 
        x = ch_x[WIDTH-1:0];      
    endcase                                     
     end

   
endmodule
   


