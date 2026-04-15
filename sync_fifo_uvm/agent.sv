import uvm_pkg::*;
`include "uvm_macros.svh"

class fifo_agent extends uvm_agent;
  `uvm_component_utils(fifo_agent)

  fifo_sequencer seqr;
  fifo_driver drv;
  fifo_monitor mon;
  virtual fifo_if vif;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if (!uvm_config_db#(virtual fifo_if)::get(this, "", "vif", vif))
      `uvm_fatal("NO_VIF", "fifo_agent: virtual interface not found");

    seqr = fifo_sequencer::type_id::create("seqr", this);
    drv  = fifo_driver::type_id::create("drv", this);
    mon  = fifo_monitor::type_id::create("mon", this);

    uvm_config_db#(virtual fifo_if)::set(this, "drv", "vif", vif);
    uvm_config_db#(virtual fifo_if)::set(this, "mon", "vif", vif);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    drv.seq_item_port.connect(seqr.seq_item_export);
  endfunction

endclass