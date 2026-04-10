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
    fifo_seq_item req;
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

//FIFO read sequence 

class fifo_read_seq extends base_seq;
  `uvm_object_utils(fifo-read_seq)
  function new(string name=fifo_read_seq);
    super.new(name);
  endfunction
  
  task body();
    fifo_seq_item req;
    repeat(16)begin
      req=fifo_read_seq::type_id::create("req");
      start_item(req)
      assert (req.randomize() with {
        wr_en==0;
        rd_en==1;});
      finish_item(req);
    end
  endtask
endclass

//fifo WRITE THEN READ SEQ 

class fifo_wr_then_rd_seq extends base_seq;
  `uvm_object_utils(fifo_wr_then_seq)
  fifo_write_seq wr_seq;
  fifo_read_seq rd_seq;
  
  
  function new(string name="fifo_wr_then_rd_seq");
    super.new(name);
  endfunction
  
  task body();
    wr_seq=fifo_wr_then_rd::type_id::create("wr_seq");
    wr_seq.start(m_sequencer);
    
    rd_seq=fifo_wr_then_rd::type_id::create("rd_seq");
    rd_seq.start(m_sequencer);
  endtaskgit
    
endclass
    
    
    
         //_________FLAGS TEST________________//
//full test 
    
    class fifo_full_seq extends base_seq;
      `uvm_object_utils(fifo_full_test)
      
      function new(string="fifo_full_seq");
        super.new(name);
      endfunction
      
      task body();
        fifo_seq_item req;
        repeat(20) begin
          req=fifo_seq_item::type_id::create("req");
          start_item(req);
          assert(req.randomize()  with {
          wr_en==1;
            rd_en==0;
          
          });
          finish_item(req);
        end
      endtask
    endclass
    
    
    //fifo empty test ::
    
    class fifo_empty_seq extends base_seq;
      `uvm_object_utils(fifo_empty_seq)
      function new(string name="fifo_empty_seq");
        super.new(name);
      endfunction
      
      task body();
        fifo_seq_item req;
        repeat(20)begin
          req=fifo_seq_item::type_id::create("req");
          start_item(req);
          assert(req.randomize() with {
          wr_en==0;
            rd_en==1;
          });
          
          finish_item(req);
        end
      endtask
    endclass
    
    //FIFO OVERFLOW srq
    
    class fifo_overflow_seq extends base_seq;
      `uvm_object_utils(fifo_overflow_seq)
      
      
      function new(string name ="fifo_overflow_seq");
        super.new(name);
      endfunction
      
      task body();
        fifo_seq_item req;
        repeat(16)begin
          req=fifo_seq_item::type_id::create("req");
          start_item(req);
          assert (req.randomize() with {wr_en==1;rd_en==0;});
          finish_item(req);
        end
       //now applay overflow
        repeat(5)begin
          req=fifo_seq_item::type_id::create("req");
          start_item(req);
          assert(req.randomize() with {wr_en==1;rd_en==0;});
          finish_item(req);
        end
      endtask
    endclass
          
          
//FIFO UNDERFLOW SEQ
    
    class fifo_underflow_seq extendss base_seq;
      `uvm_object_utils(fifo_underflow_seq)
      function new (string name="fifo_under_flow");
        super.new(name);
      endfunction
      
      task body();
        fifo_seq_item req;
        repeat(16)begin
          req=fifo_seq_item::type_id::create("req");
          start_item(req);
          assert(req.randomize() with {wr_en==1; rd_en==0;});
        end
        
        repeat(16)begin
          req=fifo_seq_item::type_id::create("req");
          start_item(req);
          assert(req.randomize() wirh {wr_en==0;rd_en==1;});
          finish_item(req);
        end
        
        repeat(5)begin
          req=fifo_seq_item::type_id::create("req");
          start_item(req);
          assert(req.randomize() with {wr_en==0; rd_en==1;});
          finish_item(req);
        end
      endtask
    endclass
      
  
  
