`define ALU_ADD     4'b0000
`define ALU_SUB     4'b0001
`define ALU_OR      4'b0010
`define ALU_SLT     4'b0011
`define ALU_SLTU    4'b0100
`define ALU_SLL     4'b0101
`define ALU_SLLV    4'b0110
`define ALU_SRL     4'b0111
`define ALU_SRLV    4'b1000
`define ALU_SRA     4'b1001
`define ALU_SRAV    4'b1010
`define ALU_AND     4'b1011
`define ALU_XOR     4'b1100
`define ALU_NOR     4'b1101

// define alu module

`define ZERO_EXT     2'b00
`define SIGN_EXT     2'b01
`define LUI_EXT      2'b10
//define ext module 
 
`define PC_J       4'b0001
`define PC_JAL     4'b0010
`define PC_BEQ     4'b0011
`define PC_JR      4'b0100
`define PC_BNE     4'b0101
`define PC_BLEZ    4'b0110
`define PC_BGTZ    4'b0111
`define PC_BGEZ    4'b1000
`define PC_BLTZ    4'b1001
`define PC_JALR    4'b1010
`define PC_BREAK   4'b1011
`define PC_ERET   4'b1100
// define npc module

`define LW         3'b000
`define LB         3'b001
`define LBU        3'b010
`define LH         3'b011
`define LHU        3'b100
//define ext_load module 

`define SW         2'b00
`define SB         2'b01
`define SH         2'b10
//define ext_store module 

`define mult       3'b001
`define div        3'b010
`define mth        3'b011
`define mtl        3'b100
`define multu       3'b101
`define divu        3'b110
 //define mult\div module 
