//sequence item 
`include "uvm_macros.svh"
import uvm_pkg::*;

class fifo_seq_item extends uvm_sequence_item;
  `uvm_object_utils(fifo_seq_item)
  
  rand logic wr_en;
  rand logic [7:0]wr_data;
  rand logic rd_en;
  
  logic [7:0]rd_data;
  logic empty;
  logic full;
  logic almost_full;
  logic almost_empty;
  logic overflow;
  logic underflow;
  logic [4:0] fifo_count;
  
  constraint c_active{wr_en || rd_en;}
  
  constraint c_wr_bias{wr_en dist {1:=60,0:=40};}
  
  function new(string name = "fifo_seq_item");
    super.new(name);
  endfunction
  
  
  function string convert2string();
    return $sformatf("wr_en=%0b wr_data=%0h rd_en=%0b rd_data=%0h full=%0b empty=%0b count=%0d ov=%0b uv=%0b",
                     wr_en,wr_data,rd_en,rd_data,full,empty,fifo_count,overflow,underflow);
  endfunction
endclass   