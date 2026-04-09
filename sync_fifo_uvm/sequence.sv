//FIFO base sequence COMMON for ALL the seq 

class base_seq extends uvm_sequence #(fifo_seq_item);
  `uvm_object_utils(base_seq)
  
  function new(string name="fifo_base_seq");
    super.new(name)
  endfunction
endclass


// FIFO write sequence 

class fifo_write_seq extends base_seq;
  
  `uvm_object_utils(fifo_write_seq)
  function new(string name="fifo_write_seq");
    super.new(name)
  endfunction
  
  task body();
    fifo_write_seq req;
    repeat(16)begin
      req=fifo_write_seq::type_id::create("req");
      start_item(req);
      
      assert(req.randomize() with {
        wr_en==1;
        rd_en==0;
      
      });
      finish_item(req);
    end
  endtask
endclass