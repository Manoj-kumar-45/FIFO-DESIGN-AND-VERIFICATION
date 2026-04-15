class fifo_monitor extends uvm_monitor;

  `uvm_component_utils(fifo_monitor)

  virtual fifo_if vif;
  uvm_analysis_port #(fifo_seq_item) ap;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    ap = new("ap", this);

    if (!uvm_config_db#(virtual fifo_if)::get(this, "", "vif", vif))
      `uvm_fatal("NO_VIF", "Monitor: virtual interface not found");
  endfunction

  task run_phase(uvm_phase phase);

    fifo_seq_item item;

    forever begin
      @(vif.monitor_cb);

      item = fifo_seq_item::type_id::create("item", this);

      // INPUTS
      item.wr_en   = vif.monitor_cb.wr_en;
      item.wr_data = vif.monitor_cb.wr_data;
      item.rd_en   = vif.monitor_cb.rd_en;

      // OUTPUTS
      item.rd_data    = vif.monitor_cb.rd_data;
      item.full       = vif.monitor_cb.full;
      item.empty      = vif.monitor_cb.empty;
      item.overflow   = vif.monitor_cb.overflow;
      item.underflow  = vif.monitor_cb.underflow;
      item.fifo_count = vif.monitor_cb.fifo_count;

      ap.write(item);

    end

  endtask

endclass
