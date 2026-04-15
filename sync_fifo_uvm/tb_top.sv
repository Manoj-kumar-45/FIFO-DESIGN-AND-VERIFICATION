 import uvm_pkg::*;
`include "uvm_macros.svh"
// `include"design.sv"
`include "interface.sv"
`include "seq_item.sv"
`include "sequencer.sv"
`include "sequence.sv"
`include "driver.sv"
`include "monitor.sv"
`include "agent.sv"
`include "scoreboard.sv"
`include "env.sv"
`include "test.sv"
`include "write_test.sv"
`include "read_test.sv"
`include "wr_then_rd_test.sv"




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
    $display("uvm test is starting");
      run_test("write_test");
    //run_test("fifo_underflow_test");
    //run_test("fifo_overflow_test ");
    //run_test("fifo_empty_test");
    //run_test("fifo_full_test");
    //run_test("wr_then_rd");
    //run_test("read_test");
 
  end
  initial begin
     $dumpfile("dump.vcd"); 
    $dumpvars;
  end
  
endmodule
  
