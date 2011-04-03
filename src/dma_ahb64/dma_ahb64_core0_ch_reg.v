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
//-- Invoked Fri Mar 25 23:33:01 2011
//--
//-- Source file: dma_ch_reg.v
//---------------------------------------------------------



  
module dma_ahb64_core0_ch_reg(clk,clken,pclken,reset,psel,penable,paddr,pwrite,pwdata,prdata,pslverr,timeout_bus,wdt_timeout,ch_start,load_addr,load_in_prog,load_req_in_prog,load_wr,load_wr_cycle,load_wdata,load_cmd,rd_ch_end,wr_ch_end,wr_clr_last,rd_slverr,rd_decerr,wr_slverr,wr_decerr,int_all_proc,ch_rd_active,ch_wr_active,ch_in_prog,rd_x_offset,rd_y_offset,wr_x_offset,wr_y_offset,wr_fullness,rd_gap,fifo_overflow,fifo_underflow,ch_update,rd_start_addr,wr_start_addr,x_size,y_size,rd_burst_max_size,wr_burst_max_size,block,allow_line_cmd,frame_width,width_align,rd_periph_delay,rd_periph_block,wr_periph_delay,wr_periph_block,rd_tokens,wr_tokens,rd_port_num,wr_port_num,rd_outs_max,wr_outs_max,rd_outs,wr_outs,outs_empty,rd_wait_limit,wr_wait_limit,rd_incr,wr_incr,rd_periph_num,wr_periph_num,wr_outstanding,rd_outstanding,ch_retry_wait,joint_mode,joint_remote,joint_cross,page_cross,joint,joint_flush,end_swap);

   parameter              DATA_SHIFT    = 0 ? 32 : 0;
   
   
   input                  clk;
   input              clken;
   input              pclken;
   input              reset;
   
   input              psel;
   input              penable;
   input [7:0]              paddr;
   input              pwrite;
   input [31:0]          pwdata;
   output [31:0]          prdata;
   output              pslverr;

   input [4:0]              timeout_bus;
   input              wdt_timeout;

   input              ch_start;
   
   output [32-1:0]      load_addr;
   output              load_in_prog;
   output              load_req_in_prog;
   input              load_wr;
   input [1:0]              load_wr_cycle;
   input [64-1:0]      load_wdata;
   input              load_cmd;
   
   input              rd_ch_end;
   input              wr_ch_end;
   input              wr_clr_last;
   input              rd_slverr;
   input              rd_decerr;
   input              wr_slverr;
   input              wr_decerr;
   output [1-1:0]         int_all_proc;
   
   output              ch_rd_active;
   output              ch_wr_active;
   output              ch_in_prog;

   input [10-1:0]      rd_x_offset;
   input [10-`X_BITS-1:0]          rd_y_offset;    
   input [10-1:0]      wr_x_offset;
   input [10-`X_BITS-1:0]          wr_y_offset;    
   input [5:0]          wr_fullness;
   input [5:0]          rd_gap;
   input              fifo_overflow;
   input              fifo_underflow;
   
   output              ch_update;
   output [32-1:0]      rd_start_addr;
   output [32-1:0]      wr_start_addr;
   output [10-1:0]      x_size;
   output [10-`X_BITS-1:0]          y_size;
   
   output [8-1:0]      rd_burst_max_size;
   output [8-1:0]      wr_burst_max_size;
   output              block;
   input              allow_line_cmd;
   output [`FRAME_BITS-1:0]      frame_width;
   output [3-1:0]      width_align;
   output [`DELAY_BITS-1:0]      rd_periph_delay;
   output              rd_periph_block;
   output [`DELAY_BITS-1:0]      wr_periph_delay;
   output              wr_periph_block;
   output [`TOKEN_BITS-1:0]      rd_tokens;
   output [`TOKEN_BITS-1:0]      wr_tokens;
   output              rd_port_num;
   output              wr_port_num;
   output [`OUT_BITS-1:0]      rd_outs_max;
   output [`OUT_BITS-1:0]      wr_outs_max;
   input [`OUT_BITS-1:0]      rd_outs;
   input [`OUT_BITS-1:0]      wr_outs;
   input              outs_empty;
   output [`WAIT_BITS-1:0]      rd_wait_limit;
   output [`WAIT_BITS-1:0]      wr_wait_limit;
   output              rd_incr;
   output              wr_incr;
   output [4:0]          rd_periph_num;
   output [4:0]          wr_periph_num;
   output              wr_outstanding;
   output              rd_outstanding;
   output              ch_retry_wait;
   input              joint_mode;
   input              joint_remote;
   input              joint_cross;
   input              page_cross;
   output              joint;
   input              joint_flush;
   output [1:0]          end_swap;
      
   
`include "dma_ahb64_ch_reg_params.v"

   
  parameter     INT_NUM = 8; 
   
   
   wire [7:0]              gpaddr;
   wire              gpwrite;
   wire              gpread;
   reg [31:0]              prdata_pre;
   reg                  pslverr_pre;
   reg [31:0]              prdata;
   reg                  pslverr;
   
   reg                  ch_enable;
   reg                  ch_in_prog;
   reg                  rd_ch_in_prog;
   reg                  wr_ch_in_prog;
   reg                  load_in_prog_reg;
   reg                  load_req_in_prog_reg;
   
   //current cmd
   reg [32-1:0]          rd_start_addr;
   reg [32-1:0]          wr_start_addr;
   reg [10-1:0]          buff_size;
   wire [10-1:0]      x_size;
   wire [10-`X_BITS-1:0]          y_size;

   reg [`FRAME_BITS-1:0]      frame_width_reg;  
   reg                  block_reg;
   reg                  joint_reg;
   reg                  simple_mem;
   wire              joint;
   wire              joint_mux;
   reg                  auto_retry_reg;
   wire              auto_retry;
   reg [1:0]              end_swap_reg;
   
   //static
   wire [8-1:0]      rd_burst_max_size_rd;
   wire [8-1:0]      rd_burst_max_size_pre;
   reg [8-1:0]      rd_burst_max_size_reg;
   reg [`DELAY_BITS-1:0]      rd_periph_delay_reg;
   reg                  rd_periph_block_reg;
   reg [`TOKEN_BITS-1:0]      rd_tokens_reg;
   reg [`OUT_BITS-1:0]          rd_outs_max_reg;
   reg                  rd_port_num_reg;
   reg                  cmd_port_num_reg;
   wire              rd_port_num_cfg;
   wire              cmd_port_num;
   reg                  rd_outstanding_reg;
   wire              rd_outstanding_cfg;
   reg                  rd_incr_reg;
   reg [4:0]              rd_periph_num_reg;
   reg [`WAIT_BITS-1:4]      rd_wait_limit_reg;
   
   wire [8-1:0]      wr_burst_max_size_rd;
   wire [8-1:0]      wr_burst_max_size_pre;
   reg [8-1:0]      wr_burst_max_size_reg;
   reg [`DELAY_BITS-1:0]      wr_periph_delay_reg;
   reg                  wr_periph_block_reg;
   reg [`TOKEN_BITS-1:0]      wr_tokens_reg;
   reg [`OUT_BITS-1:0]          wr_outs_max_reg;
   reg                  wr_port_num_reg;
   reg                  wr_outstanding_reg;
   wire              wr_outstanding_cfg;
   reg                  wr_incr_reg;
   reg [4:0]              wr_periph_num_reg;
   reg [`WAIT_BITS-1:4]      wr_wait_limit_reg;

   wire              rd_allow_full_fifo;
   wire              wr_allow_full_fifo;
   wire              allow_full_fifo;
   wire              allow_full_burst;
   wire              allow_joint_burst;
   wire              burst_max_size_update_pre;
   wire              burst_max_size_update;
      
   reg                  cmd_set_int_reg;
   reg                  cmd_last_reg;
   reg [32-1:2]          cmd_next_addr_reg;
   reg [`CMD_CNT_BITS-1:0]      cmd_counter_reg;    
   reg [`INT_CNT_BITS-1:0]      int_counter_reg;
   wire              cmd_set_int;
   wire              cmd_last;
   wire [32-1:2]      cmd_next_addr;
   wire [`CMD_CNT_BITS-1:0]      cmd_counter;
   wire [`INT_CNT_BITS-1:0]      int_counter;
   
   //interrupt
   wire              ch_end;
   wire              ch_end_set;
   wire              ch_end_clear;
   wire              ch_end_int;
   wire [2:0]              int_proc_num;              
   reg [2:0]              int_proc_num_reg;    
   wire [INT_NUM-1:0]          int_bus;    
   wire [INT_NUM-1:0]          int_rawstat;
   reg [INT_NUM-1:0]          int_enable;         
   wire [INT_NUM-1:0]          int_status;
   wire [7:0]                    int_all_proc_bus;
   
   wire              wr_cmd_line0;
   wire              wr_cmd_line1;
   wire              wr_cmd_line2;
   wire              wr_cmd_line3;
   wire              wr_static_line0;
   wire              wr_static_line1;
   wire              wr_static_line2;
   wire              wr_static_line3;
   wire              wr_static_line4;
   wire              wr_ch_enable;
   wire              wr_ch_start;
   wire              wr_int_rawstat;
   wire              wr_int_clear;
   wire              wr_int_enable;
   wire              wr_frame_width;
   
   reg [31:0]              rd_cmd_line0;
   reg [31:0]              rd_cmd_line1;
   reg [31:0]              rd_cmd_line2;
   reg [31:0]              rd_cmd_line3;
   reg [31:0]              rd_static_line0;
   reg [31:0]              rd_static_line1;
   reg [31:0]              rd_static_line2;
   reg [31:0]              rd_static_line3;
   reg [31:0]              rd_static_line4;
   reg [31:0]              rd_restrict;
   reg [31:0]              rd_rd_offsets;
   reg [31:0]              rd_wr_offsets;
   reg [31:0]              rd_fifo_fullness;
   reg [31:0]              rd_cmd_outs;
   reg [31:0]              rd_ch_enable;
   reg [31:0]              rd_ch_active;
   reg [31:0]              rd_cmd_counter;
   reg [31:0]              rd_int_rawstat;
   reg [31:0]              rd_int_enable;
   reg [31:0]              rd_int_status;
   
   wire              load_wr_cycle0;
   wire              load_wr_cycle1;
   wire              load_wr_cycle2;
   wire              load_wr_cycle3;
   wire              load_wr0;
   wire              load_wr1;
   wire              load_wr2;
   wire              load_wr3;
   wire              load_wr_last;
   wire              load_req;

   wire              timeout_aw;
   wire              timeout_w;
   wire              timeout_b;
   wire              timeout_ar;
   wire              timeout_r;
   
   wire              ch_retry_wait_pre;
   reg                  ch_retry_wait_reg;
   wire              ch_retry_wait;
   wire              ch_retry;
   wire              ch_update_pre;
   reg                  ch_update;
   wire              ch_update_d;
   
   wire              ch_int;
   
   
   //---------------------- gating -------------------------------------
   
   
   //assign             gpaddr      = {8{psel}} & paddr;
   assign             gpaddr      = paddr; //removed for timing
   assign             gpwrite     = psel & (~penable) & pwrite;
   assign             gpread      = psel & (~penable) & (~pwrite);

   
   //---------------------- Write Operations ----------------------------------
   assign             wr_cmd_line0      = gpwrite & gpaddr == CMD_LINE0;
   assign             wr_cmd_line1      = gpwrite & gpaddr == CMD_LINE1;
   assign             wr_cmd_line2      = gpwrite & gpaddr == CMD_LINE2;
   assign             wr_cmd_line3      = gpwrite & gpaddr == CMD_LINE3;
   assign             wr_static_line0   = gpwrite & gpaddr == STATIC_LINE0;
   assign             wr_static_line1   = gpwrite & gpaddr == STATIC_LINE1;
   assign             wr_static_line2   = gpwrite & gpaddr == STATIC_LINE2;
   assign             wr_static_line3   = gpwrite & gpaddr == STATIC_LINE3;
   assign             wr_static_line4   = gpwrite & gpaddr == STATIC_LINE4;
   assign             wr_ch_enable      = gpwrite & gpaddr == CH_ENABLE;
   assign             wr_ch_start       = (gpwrite & gpaddr == CH_START) | ch_start;
   assign             wr_int_rawstat    = gpwrite & gpaddr == INT_RAWSTAT;
   assign             wr_int_clear      = gpwrite & gpaddr == INT_CLEAR;
   assign             wr_int_enable     = gpwrite & gpaddr == INT_ENABLE;
   
   assign             load_wr_cycle0 = load_wr & load_wr_cycle == 2'd0;
   assign             load_wr_cycle1 = load_wr & load_wr_cycle == 2'd1;
   assign             load_wr_cycle2 = load_wr & load_wr_cycle == 2'd2;
   assign             load_wr_cycle3 = load_wr & load_wr_cycle == 2'd3;

   assign             load_wr0 = 0 ? load_wr_cycle0 : load_wr_cycle0;
   assign             load_wr1 = 0 ? load_wr_cycle1 : load_wr_cycle0;
   assign             load_wr2 = 0 ? load_wr_cycle2 : load_wr_cycle1;
   assign             load_wr3 = 0 ? load_wr_cycle3 : load_wr_cycle1;
   
   assign             load_wr_last       = 0 ? load_wr3 : load_wr_cycle3; //AHB 64 uses 2 false cycles (INCR4) 

   
   
   
   always @(posedge clk or posedge reset)
     if (reset)
       begin
      rd_start_addr <= #1 {32{1'b0}};
       end
     else if (wr_cmd_line0)
       begin
      rd_start_addr <= #1 pwdata[32-1:0];
       end
     else if (load_wr0)
       begin
      rd_start_addr <= #1 load_wdata[32-1:0];
       end
   
   always @(posedge clk or posedge reset)
     if (reset)
       begin
      wr_start_addr <= #1 {32{1'b0}};
       end
     else if (wr_cmd_line1)
       begin
      wr_start_addr <= #1 pwdata[32-1:0];
       end
     else if (load_wr1)
       begin
      wr_start_addr <= #1 load_wdata[32+32-DATA_SHIFT-1:32-DATA_SHIFT];
       end

   always @(posedge clk or posedge reset)
     if (reset)
       begin
      buff_size <= #1 {10{1'b0}};
       end
     else if (wr_cmd_line2)
       begin
      buff_size <= #1 pwdata[10-1:0];
       end
     else if (load_wr2)
       begin
      buff_size <= #1 load_wdata[10-1:0];
       end

   always @(posedge clk or posedge reset)
     if (reset)
       begin
     cmd_set_int_reg   <= #1 1'b0;
     cmd_last_reg      <= #1 1'b0;
     cmd_next_addr_reg <= #1 {30{1'b0}};
       end
     else if (wr_cmd_line3)
       begin
      cmd_set_int_reg   <= #1 pwdata[0];
      cmd_last_reg      <= #1 pwdata[1];
      cmd_next_addr_reg <= #1 pwdata[32-1:2];
       end
     else if (load_wr3)
       begin
      cmd_set_int_reg   <= #1 load_wdata[32-DATA_SHIFT];
      cmd_last_reg      <= #1 load_wdata[33-DATA_SHIFT];
      cmd_next_addr_reg <= #1 load_wdata[32+32-DATA_SHIFT-1:34-DATA_SHIFT];
       end

   always @(posedge clk or posedge reset)
     if (reset)
       cmd_counter_reg <= #1 {`CMD_CNT_BITS{1'b0}};
     else if (wr_ch_start)
       cmd_counter_reg <= #1 {`CMD_CNT_BITS{1'b0}};
     else if (ch_end & clken)
       cmd_counter_reg <= #1 cmd_counter_reg + 1'b1;
  
   
   always @(posedge clk or posedge reset)
     if (reset)
       int_counter_reg <= #1 {`INT_CNT_BITS{1'b0}};
     else if (wr_ch_start)
       int_counter_reg <= #1 {`INT_CNT_BITS{1'b0}};
     else if ((ch_end_int & clken) | ch_end_clear)
       int_counter_reg <= #1 int_counter_reg + (ch_end_int & clken) - ch_end_clear;

   assign cmd_set_int   = cmd_set_int_reg;
   assign cmd_last      = cmd_last_reg;
   assign cmd_next_addr = cmd_next_addr_reg;
      
   assign cmd_counter   = cmd_counter_reg;
   assign int_counter   = int_counter_reg;
   
   
   assign x_size = block ? {{10-`X_BITS{1'b0}}, buff_size[`X_BITS-1:0]} : buff_size;
   assign y_size = block ? buff_size[10-1:`X_BITS] : 'd1;
   
   
   always @(posedge clk or posedge reset)
     if (reset)
       begin
            rd_burst_max_size_reg <= #1 'd0;
   rd_tokens_reg         <= #1 'd1; 
            rd_incr_reg           <= #1 'd1;
       end
     else if (wr_static_line0)
       begin
            rd_burst_max_size_reg <= #1 pwdata[8-1:0];
  rd_tokens_reg         <= #1 pwdata[`TOKEN_BITS+16-1:16]; 
            rd_incr_reg           <= #1 pwdata[31];
       end
   
   
   always @(posedge clk or posedge reset)
     if (reset)
       begin
            wr_burst_max_size_reg <= #1 'd0;
  wr_tokens_reg         <= #1 'd1; 
      wr_incr_reg           <= #1 'd1;
       end
     else if (wr_static_line1)
       begin
      wr_burst_max_size_reg <= #1 pwdata[8-1:0];
  wr_tokens_reg         <= #1 pwdata[`TOKEN_BITS+16-1:16]; 
      wr_incr_reg           <= #1 pwdata[31];
       end

   assign rd_incr = rd_incr_reg;
   assign wr_incr = wr_incr_reg;
   
   assign rd_outstanding_cfg = 1'b0;
   assign wr_outstanding_cfg = 1'b0;
   assign rd_outstanding     = 1'b0;
   assign wr_outstanding     = 1'b0;

   assign rd_tokens = rd_tokens_reg;
   assign wr_tokens = joint_mux ? rd_tokens_reg : wr_tokens_reg;

   assign rd_outs_max = 'd0;
   assign wr_outs_max = 'd0;
   

   assign rd_allow_full_fifo = rd_start_addr[5-1:0] == 'd0;
   assign wr_allow_full_fifo = wr_start_addr[5-1:0] == 'd0;
   
   assign allow_full_fifo    = rd_allow_full_fifo & wr_allow_full_fifo;

   assign rd_burst_max_size  = rd_burst_max_size_pre;
   assign wr_burst_max_size  = joint_mux ? rd_burst_max_size_pre : wr_burst_max_size_pre;
   
   assign allow_joint_burst  = joint & (~joint_flush) & (~page_cross) & (~joint_cross);

  assign allow_full_burst   = allow_joint_burst & allow_full_fifo; 
   
   assign burst_max_size_update_pre = ch_update | ch_update_d | joint;

   prgen_delay #(1) delay_max_size_update (.clk(clk), .reset(reset), .din(burst_max_size_update_pre), .dout(burst_max_size_update));

   dma_ahb64_core0_ch_reg_size
   dma_ahb64_core0_ch_reg_size_rd (
                .clk(clk),
                .reset(reset),
                .update(burst_max_size_update),
                .start_addr(rd_start_addr),
                .burst_max_size_reg(rd_burst_max_size_reg),
                .burst_max_size_other(wr_burst_max_size_rd),
                .allow_full_burst(allow_full_burst),
                .allow_full_fifo(allow_full_fifo),
                .joint_flush(joint_flush),
                .burst_max_size(rd_burst_max_size_pre)
                );


   dma_ahb64_core0_ch_reg_size
   dma_ahb64_core0_ch_reg_size_wr (
                .clk(clk),
                .reset(reset),
                .update(burst_max_size_update),
                .start_addr(wr_start_addr),
                .burst_max_size_reg(wr_burst_max_size_reg),
                .burst_max_size_other(rd_burst_max_size_reg),
                .allow_full_burst(1'b0),
                .allow_full_fifo(allow_full_fifo),
                .joint_flush(joint_flush),
                .burst_max_size(wr_burst_max_size_pre)
                );
   
   
   always @(posedge clk or posedge reset)
     if (reset)
       begin
                 joint_reg        <= #1 1'b1;
         end_swap_reg     <= #1 2'b00; 
       end
     else if (wr_static_line2)
       begin
                 joint_reg        <= #1 pwdata[16];
         end_swap_reg     <= #1 pwdata[29:28]; 
       end

   
   always @(posedge clk or posedge reset)
     if (reset)
       simple_mem <= #1 1'b0;
     else if (ch_update)
       simple_mem <= #1 (rd_periph_num == 'd0) & (wr_periph_num == 'd0) & (~allow_line_cmd);

   assign joint     = joint_mode & joint_reg & simple_mem & 1'b1;
   
   assign joint_mux = joint;
   


   assign cmd_port_num     = 1'b0;
   assign rd_port_num_cfg  = 1'b0;
   assign wr_port_num      = 1'b0;
   assign rd_port_num      = 1'b0;
   
   
   assign frame_width = {`FRAME_BITS{1'b0}};
   assign block       = 1'b0;
   
   assign width_align = frame_width[3-1:0];
   

   assign rd_wait_limit = {`WAIT_BITS-4{1'b0}};
   assign wr_wait_limit = {`WAIT_BITS-4{1'b0}};
   
   
   
   always @(posedge clk or posedge reset)
     if (reset)
       begin
          rd_periph_num_reg   <= #1 'd0; //0 is memory
          rd_periph_delay_reg <= #1 'd0; //0 is memory
            wr_periph_num_reg   <= #1 'd0; //0 is memory
          wr_periph_delay_reg <= #1 'd0; //0 is memory
       end
     else if (wr_static_line4)
       begin
          rd_periph_num_reg   <= #1 pwdata[4:0];
          rd_periph_delay_reg <= #1 pwdata[`DELAY_BITS+8-1:8];
          wr_periph_num_reg   <= #1 pwdata[20:16];
          wr_periph_delay_reg <= #1 pwdata[`DELAY_BITS+24-1:24];
       end

   assign rd_periph_num   = rd_periph_num_reg;
   assign wr_periph_num   = wr_periph_num_reg;
   assign rd_periph_delay = rd_periph_delay_reg;
   assign wr_periph_delay = wr_periph_delay_reg;
   
   assign rd_periph_block = 1'b0;
   assign wr_periph_block = 1'b0;

   
   
   always @(posedge clk or posedge reset)
     if (reset)
       begin
      ch_enable <= #1 1'b1;
       end
     else if (wr_ch_enable)
       begin
      ch_enable <= #1 pwdata[0];
       end
   
   always @(posedge clk or posedge reset)
     if (reset)
       ch_in_prog <= #1 1'b0;
     else if (ch_update)
       ch_in_prog <= #1 1'b1;
     else if (ch_end & clken)
       ch_in_prog <= #1 1'b0;
   
   always @(posedge clk or posedge reset)
     if (reset)
       rd_ch_in_prog <= #1 1'b0;
     else if (ch_update)
       rd_ch_in_prog <= #1 1'b1;
     else if (fifo_underflow | fifo_overflow)
       rd_ch_in_prog <= #1 1'b0;
     else if (rd_ch_end & clken)
       rd_ch_in_prog <= #1 1'b0;
   
   always @(posedge clk or posedge reset)
     if (reset)
       wr_ch_in_prog <= #1 1'b0;
     else if (ch_update)
       wr_ch_in_prog <= #1 1'b1;
     else if (fifo_underflow | fifo_overflow)
       wr_ch_in_prog <= #1 1'b0;
     else if (wr_ch_end & clken)
       wr_ch_in_prog <= #1 1'b0;

   always @(posedge clk or posedge reset)
     if (reset)
       load_in_prog_reg <= #1 1'b0;
     else if (load_req & clken)
       load_in_prog_reg <= #1 1'b1;
     else if (ch_update & clken)
       load_in_prog_reg <= #1 1'b0;
   
   always @(posedge clk or posedge reset)
     if (reset)
       load_req_in_prog_reg <= #1 1'b0;
     else if (load_req & clken)
       load_req_in_prog_reg <= #1 1'b1;
     else if (load_cmd & clken)
       load_req_in_prog_reg <= #1 1'b0;

   assign load_in_prog     = load_in_prog_reg;
   assign load_req_in_prog = load_req_in_prog_reg;

   assign auto_retry    = 1'b0;
   assign ch_retry_wait = 1'b0;
   assign ch_retry      = 1'b0;
   
   assign ch_update_pre = wr_ch_start | load_wr_last | ch_retry;

   always @(posedge clk or posedge reset)
     if (reset)
       ch_update <= #1 1'b0;
     else if (ch_update_pre)
       ch_update <= #1 1'b1;
     else if (clken)
       ch_update <= #1 1'b0;
   
   prgen_delay #(1) delay_ch_update (.clk(clk), .reset(reset), .din(ch_update), .dout(ch_update_d));

   assign load_req       = (ch_enable & ch_end & (~cmd_last)) | (ch_update & (x_size == 'd0));
   assign load_addr      = {cmd_next_addr[32-1:2], 2'b00};

   assign ch_end         = rd_ch_end & wr_ch_end & wr_clr_last & (~ch_retry_wait);

   assign ch_end_int     = ch_enable & ch_end & cmd_set_int;
   assign ch_rd_active   = ch_enable & (rd_ch_in_prog | load_req_in_prog);
   assign ch_wr_active   = ch_enable & wr_ch_in_prog;
   
   assign ch_end_set     = |int_counter;
   assign ch_end_clear   = wr_int_clear & pwdata[0];

   assign {timeout_aw,
           timeout_w,
           timeout_b,
           timeout_ar,
           timeout_r} = timeout_bus[4:0];
   
   
   assign int_bus        = {INT_NUM{clken}} & {
                           wdt_timeout,
                           timeout_aw,
                           timeout_ar,
                           fifo_underflow,
                           fifo_overflow,
                           wr_slverr,
                           rd_slverr,
                           ch_end_set
                           };

   prgen_rawstat #(INT_NUM) rawstat(
                    .clk(clk),
                    .reset(reset),
                    .clear(wr_int_clear),
                    .write(wr_int_rawstat),
                    .pwdata(pwdata[INT_NUM-1:0]),
                    .int_bus(int_bus),
                    .rawstat(int_rawstat)
                    );
   
   
   always @(posedge clk or posedge reset)
     if (reset)
       int_enable <= #1 {INT_NUM{1'b1}};
     else if (wr_int_enable)
       int_enable <= #1 pwdata[INT_NUM-1:0];

   assign int_status = int_rawstat & int_enable;

   assign ch_int     = |int_status;

   assign int_proc_num = 3'd0;
   assign int_all_proc = ch_int;

   assign end_swap = end_swap_reg;
   
   //---------------------- Read Operations -----------------------------------  
   assign rd_burst_max_size_rd = rd_burst_max_size_reg;
   assign wr_burst_max_size_rd = wr_burst_max_size_reg;

   
   //always @(/*AUTOSENSE*/) - no AUTOSENSE because of include file  
   always @(allow_full_burst or allow_full_fifo
        or allow_joint_burst or allow_line_cmd or auto_retry
        or block or buff_size or ch_enable or ch_rd_active
        or ch_wr_active or cmd_counter or cmd_last
        or cmd_next_addr or cmd_port_num or cmd_set_int
        or end_swap or frame_width or int_counter or int_enable
        or int_proc_num or int_rawstat or int_status or joint_reg
        or rd_allow_full_fifo or rd_burst_max_size_rd or rd_gap
        or rd_incr or rd_outs or rd_outs_max or rd_outstanding
        or rd_outstanding_cfg or rd_periph_block_reg
        or rd_periph_delay or rd_periph_num or rd_port_num_cfg
        or rd_start_addr or rd_tokens or rd_wait_limit
        or rd_x_offset or rd_y_offset or simple_mem
        or wr_allow_full_fifo or wr_burst_max_size_rd
        or wr_fullness or wr_incr or wr_outs or wr_outs_max
        or wr_outstanding or wr_outstanding_cfg
        or wr_periph_block_reg or wr_periph_delay or wr_periph_num
        or wr_port_num or wr_start_addr or wr_tokens
        or wr_wait_limit or wr_x_offset or wr_y_offset)
     begin
    rd_cmd_line0     = {32{1'b0}};
    rd_cmd_line1     = {32{1'b0}};
    rd_cmd_line2     = {32{1'b0}};
    rd_cmd_line3     = {32{1'b0}};
    rd_static_line0  = {32{1'b0}};
    rd_static_line1  = {32{1'b0}};
    rd_static_line2  = {32{1'b0}};
    rd_static_line3  = {32{1'b0}};
    rd_static_line4  = {32{1'b0}};
    rd_restrict      = {32{1'b0}};
     rd_rd_offsets    = {32{1'b0}};
     rd_wr_offsets    = {32{1'b0}};
      rd_fifo_fullness = {32{1'b0}};
      rd_cmd_outs      = {32{1'b0}};
    rd_ch_enable     = {32{1'b0}};
    rd_ch_active     = {32{1'b0}};
    rd_cmd_counter   = {32{1'b0}};
    rd_int_rawstat   = {32{1'b0}};
    rd_int_enable    = {32{1'b0}};
    rd_int_status    = {32{1'b0}};

    
    rd_cmd_line0[32-1:0]           = rd_start_addr;
    
    rd_cmd_line1[32-1:0]           = wr_start_addr;
    
    rd_cmd_line2[10-1:0]           = buff_size;
    
    rd_cmd_line3[0]                       = cmd_set_int;
    rd_cmd_line3[1]                       = cmd_last;
    rd_cmd_line3[32-1:2]           = cmd_next_addr;
    
    rd_static_line0[8-1:0]       = rd_burst_max_size_rd;
    rd_static_line0[`TOKEN_BITS+16-1:16]  = rd_tokens;
    rd_static_line0[`OUT_BITS+24-1:24]    = rd_outs_max;
    rd_static_line0[30]                   = rd_outstanding_cfg;
    rd_static_line0[31]                   = rd_incr;
    
    rd_static_line1[8-1:0]       = wr_burst_max_size_rd;
    rd_static_line1[`TOKEN_BITS+16-1:16]  = wr_tokens;
    rd_static_line1[`OUT_BITS+24-1:24]    = wr_outs_max;
    rd_static_line1[30]                   = wr_outstanding_cfg;
    rd_static_line1[31]                   = wr_incr;
    
    rd_static_line2[`FRAME_BITS-1:0]      = frame_width;
    rd_static_line2[15]                   = block;
    rd_static_line2[16]                   = joint_reg;
    rd_static_line2[17]                   = auto_retry;
    rd_static_line2[20]                   = cmd_port_num;
    rd_static_line2[21]                   = rd_port_num_cfg;
    rd_static_line2[22]                   = wr_port_num;
    rd_static_line2[26:24]                = int_proc_num;
    rd_static_line2[29:28]                = end_swap;
    
    
    rd_static_line4[4:0]                  = rd_periph_num;
    rd_static_line4[`DELAY_BITS+8-1:8]    = rd_periph_delay;
    rd_static_line4[20:16]                = wr_periph_num;
    rd_static_line4[`DELAY_BITS+24-1:24]  = wr_periph_delay;
    
    rd_restrict[0]                        = rd_allow_full_fifo;
    rd_restrict[1]                        = wr_allow_full_fifo;
    rd_restrict[2]                        = allow_full_fifo;
    rd_restrict[3]                        = allow_full_burst;
    rd_restrict[4]                        = allow_joint_burst;
    rd_restrict[5]                        = rd_outstanding;
    rd_restrict[6]                        = wr_outstanding;
    rd_restrict[7]                        = allow_line_cmd;
    rd_restrict[8]                        = simple_mem;
        
    rd_rd_offsets[10-1:0]          = rd_x_offset;
    rd_rd_offsets[10-`X_BITS+16-1:16]     = rd_y_offset;

    rd_wr_offsets[10-1:0]          = wr_x_offset;
    rd_wr_offsets[10-`X_BITS+16-1:16]     = wr_y_offset;

    rd_fifo_fullness[5:0]           = rd_gap;
    rd_fifo_fullness[5+16:16]     = wr_fullness;

    rd_cmd_outs[`OUT_BITS-1:0]            = rd_outs;
    rd_cmd_outs[`OUT_BITS-1+8:8]          = wr_outs;
    
    rd_ch_enable[0]                       = ch_enable;
    
    rd_ch_active[0]                       = ch_rd_active;
    rd_ch_active[1]                       = ch_wr_active;
    
    rd_cmd_counter[`CMD_CNT_BITS-1:0]     = cmd_counter;
    rd_cmd_counter[`INT_CNT_BITS-1+16:16] = int_counter;
        
    rd_int_rawstat[INT_NUM-1:0]           = int_rawstat;
    
    rd_int_enable[INT_NUM-1:0]            = int_enable;
    
    rd_int_status[INT_NUM-1:0]            = int_status;
     end
   
               
   //always @(/*AUTOSENSE*/) - no AUTOSENSE because of include file
   always @(gpaddr or rd_ch_active or rd_ch_enable
        or rd_cmd_counter or rd_cmd_line0 or rd_cmd_line1
        or rd_cmd_line2 or rd_cmd_line3 or rd_cmd_outs
        or rd_fifo_fullness or rd_int_enable or rd_int_rawstat
        or rd_int_status or rd_rd_offsets or rd_restrict
        or rd_static_line0 or rd_static_line1 or rd_static_line2
        or rd_static_line3 or rd_static_line4 or rd_wr_offsets)
     begin
    prdata_pre  = {32{1'b0}};
      
    case (gpaddr)
      CMD_LINE0                 : prdata_pre  = rd_cmd_line0;
      CMD_LINE1                 : prdata_pre  = rd_cmd_line1;
      CMD_LINE2                 : prdata_pre  = rd_cmd_line2;
      CMD_LINE3                 : prdata_pre  = rd_cmd_line3;
      
      STATIC_LINE0              : prdata_pre  = rd_static_line0;
      STATIC_LINE1              : prdata_pre  = rd_static_line1;
      STATIC_LINE2              : prdata_pre  = rd_static_line2;
      STATIC_LINE3              : prdata_pre  = rd_static_line3;
      STATIC_LINE4              : prdata_pre  = rd_static_line4;

      RESTRICT                  : prdata_pre  = rd_restrict;
      RD_OFFSETS                : prdata_pre  = rd_rd_offsets;
      WR_OFFSETS                : prdata_pre  = rd_wr_offsets;
      FIFO_FULLNESS             : prdata_pre  = rd_fifo_fullness;
      CMD_OUTS                  : prdata_pre  = rd_cmd_outs;
      
      CH_ENABLE                 : prdata_pre  = rd_ch_enable;
      CH_START                  : prdata_pre  = {32{1'b0}};
      CH_ACTIVE                 : prdata_pre  = rd_ch_active;
      CH_CMD_COUNTER            : prdata_pre  = rd_cmd_counter;
      
      INT_RAWSTAT               : prdata_pre  = rd_int_rawstat;
      INT_CLEAR                 : prdata_pre  = {32{1'b0}};
      INT_ENABLE                : prdata_pre  = rd_int_enable;
      INT_STATUS                : prdata_pre  = rd_int_status;
      
      default                   : prdata_pre  = {32{1'b0}};
    endcase
     end

               
   //always @(/*AUTOSENSE*/) - no AUTOSENSE because of include file
   always @(gpaddr or gpread or gpwrite or psel)
     begin
    pslverr_pre = 1'b0;
      
    case (gpaddr)
      CMD_LINE0                 : pslverr_pre = 1'b0;    //read and write  
      CMD_LINE1                 : pslverr_pre = 1'b0;    //read and write  
      CMD_LINE2                 : pslverr_pre = 1'b0;    //read and write  
      CMD_LINE3                 : pslverr_pre = 1'b0;    //read and write  
      
      STATIC_LINE0              : pslverr_pre = 1'b0;    //read and write  
      STATIC_LINE1              : pslverr_pre = 1'b0;    //read and write  
      STATIC_LINE2              : pslverr_pre = 1'b0;    //read and write   
      STATIC_LINE3              : pslverr_pre = 1'b0;    //read and write   
      STATIC_LINE4              : pslverr_pre = 1'b0;    //read and write  
      
      RESTRICT                  : pslverr_pre = gpwrite; //read only
      RD_OFFSETS                : pslverr_pre = gpwrite; //read only
      WR_OFFSETS                : pslverr_pre = gpwrite; //read only
      FIFO_FULLNESS             : pslverr_pre = gpwrite; //read only
      CMD_OUTS                  : pslverr_pre = gpwrite; //read only
      
      CH_ENABLE                 : pslverr_pre = 1'b0;    //read and write  
      CH_START                  : pslverr_pre = gpread;  //write only
      CH_ACTIVE                 : pslverr_pre = gpwrite; //read only
      CH_CMD_COUNTER            : pslverr_pre = gpwrite; //read only
      
      INT_RAWSTAT               : pslverr_pre = 1'b0;    //read and write  
      INT_CLEAR                 : pslverr_pre = gpread;  //write only
      INT_ENABLE                : pslverr_pre = 1'b0;    //read and write  
      INT_STATUS                : pslverr_pre = gpwrite; //read only
      
      default                   : pslverr_pre = psel;    //decode error
    endcase
     end

   always @(posedge clk or posedge reset)
     if (reset)
       prdata <= #1 {32{1'b0}};
     else if (gpread & pclken)
       prdata <= #1 prdata_pre;
     else if (pclken)
       prdata <= #1 {32{1'b0}};
   
   always @(posedge clk or posedge reset)
     if (reset)
       pslverr <= #1 1'b0;
     else if ((gpread | gpwrite) & pclken)
       pslverr <= #1 pslverr_pre;
     else if (pclken)
       pslverr <= #1 1'b0;


   
endmodule


