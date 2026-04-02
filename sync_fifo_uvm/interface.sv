interface fifo_if #(parameter int DATA_WIDTH =8,
                    parameter int DEPTH=16)(input logic clk);
  logic wr_en,rd_en;
  logic [DATA_WIDTH-1:0]wr_data;
  logic [DATA_WIDTH-1:0]rd_data;
  logic full,empty;
  logic almost_full;
  logic almost_empty;
  logic overflow;
  logic underflow;
  logic [$clog2(DEPTH)-1:0]fifo_count;
  
  
  clocking driver_cb @(posedge clk);
    default input #1 output #1;
    output rst,wr_en,wr_data,rd_en,rd_data;
    input full,empty,almost_full,almost_empty,overflow,underflow,fifo_count;
  endclocking
  
  clocking monitor_cb @(posedge clk);
    default input #1;
    input rst,wr_enwr_data,rd_en,rd_data;
    input full,empty,almost_full,almost_empty,overflow,underflow,fifo_count; 
  endclocking 
  
  modport driver_mp (clocking driver_cb,input clk);
  modport monitor_mp (clocking monitor_cb,input clk);
endinterface 
      
    
  