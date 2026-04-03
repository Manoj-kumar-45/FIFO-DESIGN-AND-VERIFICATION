class fifo_monitor extends uvm_monitor;
  `uvm_component_utils(fifo_monitor)
  virtual fifo_if-monitor_mp vif;
  uvm_anaylis_port#(fifo_seq_item)ap;
  
  function new(string new"fifo_monitor",uvm_component parent);
    super.new(name,parent);
    ap=new("ap" this);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    if(!uvm_config_db#(virtual fifo-if.monitor_mp)::get(this,"","vif",vif))
      `uvm_fatal("MON","VIRTUAL INTERFACE IS NOT SET ")
      endfunction
      
      task run_phase(uvm_phase phase);
                       fifo_seq_item tx;
                       forever begin
                         @(vif.monitor_cb);
                         tx=fifo_seq_item::type_id::create("ta",this);
                         //i/p from dut
                         tx.wr_en=vif.monitor_cb.wr_en;
                         tx.rd_en=vif.monitor_cb.rd_en;
                         tx.wr_data=vif.monittor_cb.wr_data;
                         //o?p from dut
                         tx.full=vif.monitor_cb.full;
                         tx.empty=vif.monitor_cb.empty;
                         tx.overflow=vif.monitor_cb.overflow;
                         tx.underflow=vif.monitor_cb.underflow;
                         tx.fifo_count=vif.monitor_cb.fifo_count;
                         
                         ap.write(tx);//it sends trx to scoreboard
                         
                         `uvm_info("MON",tx.convert2string(),UVM_LOW)
                       end
          endtask
endclass
                       