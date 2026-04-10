 import uvm_pkg::*;
`include "uvm_macros.svh"
// `include"design.sv"
`include "interface_fifo.sv"
`include "seq_item.sv"
`include "sequencer.sv"
`include "sequence.sv"
`include "driver.sv"
`include "monitor.sv"
`include "agent.sv"




module top;
  
  logic clk;
  initial clk=0;
  always #5clk=~clk;//10 unit clk generation
  
  //interface instance
  
  fifo_if#(8,16)vif(clk);
  
  //dut instance 
  
  sync_fifo#(
    .DATA_WIDTH(8),
    .DEPTH(16))
   dut (.clk(clk),
         .rst(vif.rst),
         .wr_en(vif.wr_en),
         .wr_data(vif.wr_data),
         .rd_en(vif.rd_en),
         .rd_data(vif.rd_data),
         .full(vif.full),
        .empty(vif.empty),
         .almost_full(vif.almost_full),
         .almost_empty(vif.almost_empty),
         .overflow(vif.overflow),
         .underflow(vif.underflow),
         .fifo_count(vif.fifo_count));
  
  //Connectiongg virtual interface to uvm
  
  initial begin
    uvm_config_db#(virtual fifo_if)::set(null,"*","vif",vif);
    run_test("fifo_test");
 
  end
   
endmodule