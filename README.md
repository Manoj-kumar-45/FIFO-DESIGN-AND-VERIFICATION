FIFO RTL Design and UVM Verification
Description

This project demonstrates the design and verification of a synchronous FIFO using SystemVerilog. The RTL implements standard FIFO functionality, while the verification environment is developed using UVM to validate correctness under different operating conditions.

RTL Design

The FIFO design supports:

Parameterized data width and depth
Write and read operations
Status signals such as full and empty
Proper handling of boundary conditions
Verification Approach

A UVM-based testbench is used to verify the FIFO functionality. The environment includes standard UVM components such as driver, monitor, sequences, and scoreboard.

The testbench performs:

Directed write and read operations
Write followed by read sequences
Validation of data integrity
Checking of full and empty conditions
Test

The implemented test controls the execution of sequences and ensures that:

Data written into the FIFO is correctly read out
No data loss or corruption occurs
FIFO behaves correctly under normal and boundary conditions