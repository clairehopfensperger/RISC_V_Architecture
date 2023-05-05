<h1 align = "center">Architecture Hardware Implementation</h1>

## Objective
The goal of this project is to explore a non-traditional computer architecture and implement a program or benchmark on an FPGA.
<br><br>

## Project Deliverables
- A processor on an FPGA that executes a simple instruction set that, in theory, can execute each of the C benchmarks
- A benchmark that executes on the architecture
- A series of micro-benchmarks that executes on the architecture to show that the processor works for all instructions and all paths are exercised on the processor
<br>

## Approach to Creating My Computer Architecture

### My plan:
- Read through and understand Tiny RISC-V ISA
- Practice creating programs with RISC-V on RARS
- Make RISC-V benchmark(s) that cover all of the Tiny RISC-V ISA
- (Very very simply put) Create processor on an FPGA using Quartus and Verilog that will execute the Tiny RISC-V ISA and C benchmarks

#### Regarding last step:
- Decide on encoding rules to use (I decided on using the Tiny RISC-V ISA encoding)
- Create ALU that executes different instructions
- Create register file that covers all registers
- Create control that connects everything
<br>

### Steps I took to develop my architecture:
1. Read through the [Tiny RISC-V ISA](https://www.csl.cornell.edu/courses/ece5745/handouts/ece5745-tinyrv-isa.txt) and worked to understand it
2. Created assembly [benchmarks](https://github.com/clairehopfensperger/Hardware_Implementation/tree/main/Benchmarks) to test all the Tiny RISC-V instructions
3. Created [spreadsheet](https://docs.google.com/spreadsheets/d/1bzJ4BtNq0zZRE7lfEwL_Z8MmB-xBc6bV8E7DlgN-na4/edit#gid=0) to keep track of instructions I need to implement
4. Created [ALU module](https://github.com/clairehopfensperger/Hardware_Implementation/tree/main/Verilog/ALU) in verilog
5. Created [Register module](https://github.com/clairehopfensperger/Hardware_Implementation/tree/main/Verilog/Register) in verilog
6. Created [Control module](https://github.com/clairehopfensperger/Hardware_Implementation/tree/main/Verilog/Control) in verilog
7. Edited Control and ALU modules as I debugged
8. Updated my [master project spreadsheet](https://docs.google.com/spreadsheets/d/1bzJ4BtNq0zZRE7lfEwL_Z8MmB-xBc6bV8E7DlgN-na4/edit#gid=0) as I implement more instructions
9. Made test cases (documented on this [google spreadsheet](https://docs.google.com/spreadsheets/d/1_VlJCmFiX_xoZ7EFGFTkr8dYosKgxOKVg-J6vm1NmeM/edit#gid=0)) and fixed verilog program as needed
10. Demoed my architecture to my professor
<br>

## How I Tested My Architecture

### Process:
1. Created RISC-V assembly benchmark on RARS
2. Put the instructions in a [google spreadsheet](https://docs.google.com/spreadsheets/d/1_VlJCmFiX_xoZ7EFGFTkr8dYosKgxOKVg-J6vm1NmeM/edit#gid=0) and coverted the encoding hex numbers to decimal
3. Put the decimal instructions into a .mif file
4. Ran ModelSim using the testbench [tb_control.v](https://github.com/clairehopfensperger/Hardware_Implementation/blob/main/Verilog/Control/tb_control.v)
5. Verified the ModelSim results match the RARS results
<br>

### Test 1: Pop Count
- Assembly program: [pop_count.asm](https://github.com/clairehopfensperger/Hardware_Implementation/blob/main/Benchmarks/pop_count.asm)
- Spreadsheet: 
  <p align="center">
    <img src="https://github.com/clairehopfensperger/Hardware_Implementation/blob/main/Images/popcountsheet.png" width=750>
  </p>
- Mif file: [pop_count.mif](https://github.com/clairehopfensperger/Hardware_Implementation/blob/main/Verilog/Control/pop_count.mif)
  <p align="center">
    <img src="https://github.com/clairehopfensperger/Hardware_Implementation/blob/main/Images/popcountmif.png" width=500>
  </p>
- ModelSim:
  <p align="center">
    <img src="https://github.com/clairehopfensperger/Hardware_Implementation/blob/main/Images/popcountmodelsim.png" width=1250>
  </p>
  - result_t0: holds the number being "pop counted" and the shifted values from each iteration <br>
  - result_t1: holds the count of 1s after each iteration <br>
  - result_t2: holds the iterating value for the for loop <br>
  - result_t3: holds the total value to iterate to in the for loop <br>
  - result_t4: holds the current least significant bit value from each iteration <br>
  - result_t5: holds the total count of 1s at the end of the program <br>
<br>

## Resources:
- [RARS](https://github.com/TheThirdOne/rars)
- [Tiny RISC-V ISA](https://www.csl.cornell.edu/courses/ece5745/handouts/ece5745-tinyrv-isa.txt)
<br>

