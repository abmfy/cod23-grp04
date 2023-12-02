// Generator : SpinalHDL v1.9.4    git head : 270018552577f3bb8e5339ee2583c9c22d324215
// Component : Top
// Git hash  : cfb5cc6521aa284a896e53ec6e1cf67792347826

`timescale 1ns/1ps

module Top (
  input  wire          clk_11M0592,
  input  wire          push_btn,
  input  wire [3:0]    touch_btn,
  input  wire [31:0]   dip_sw,
  output wire [15:0]   leds,
  output wire [7:0]    dpy0,
  output wire [7:0]    dpy1,
  output wire [19:0]   base_ram_addr,
  output wire [3:0]    base_ram_be_n,
  output wire          base_ram_ce_n,
  output wire          base_ram_oe_n,
  output wire          base_ram_we_n,
  output wire [19:0]   ext_ram_addr,
  output wire [3:0]    ext_ram_be_n,
  output wire          ext_ram_ce_n,
  output wire          ext_ram_oe_n,
  output wire          ext_ram_we_n,
  output wire          txd,
  input  wire          rxd,
  input  wire          clk_50M,
  input  wire          reset_btn,
  inout  wire [31:0]   base_ram_data,
  inout  wire [31:0]   ext_ram_data
);
  localparam AluOp_OP1 = 5'd0;
  localparam AluOp_ADD = 5'd1;
  localparam AluOp_SUB = 5'd2;
  localparam AluOp_AND_1 = 5'd3;
  localparam AluOp_OR_1 = 5'd4;
  localparam AluOp_XOR_1 = 5'd5;
  localparam AluOp_NOT_1 = 5'd6;
  localparam AluOp_SLL_1 = 5'd7;
  localparam AluOp_SRL_1 = 5'd8;
  localparam AluOp_SRA_1 = 5'd9;
  localparam AluOp_ROL_1 = 5'd10;
  localparam AluOp_SLT = 5'd11;
  localparam AluOp_SLTU = 5'd12;
  localparam AluOp_OP2 = 5'd13;
  localparam AluOp_ANDN = 5'd14;
  localparam AluOp_CLZ = 5'd15;
  localparam AluOp_PACK = 5'd16;
  localparam PrivilegeMode_U = 2'd0;
  localparam PrivilegeMode_S = 2'd1;
  localparam PrivilegeMode_M = 2'd3;
  localparam CsrOp_N = 2'd0;
  localparam CsrOp_W = 2'd1;
  localparam CsrOp_S = 2'd2;
  localparam CsrOp_C = 2'd3;
  localparam BrType_F = 3'd0;
  localparam BrType_T = 3'd1;
  localparam BrType_EQ = 3'd2;
  localparam BrType_NE = 3'd3;
  localparam BrType_LT = 3'd4;
  localparam BrType_GE = 3'd5;
  localparam BrType_LTU = 3'd6;
  localparam BrType_GEU = 3'd7;
  localparam RegSel_ALU = 2'd0;
  localparam RegSel_MEM = 2'd1;
  localparam RegSel_PC = 2'd2;

  wire                bufferCC_1_io_dataIn;
  wire       [31:0]   csr_io_mie_w;
  wire                csr_io_mie_we;
  wire       [31:0]   csr_io_mscratch_w;
  wire                csr_io_mscratch_we;
  wire       [31:0]   csr_io_mip_w;
  wire                csr_io_mip_we;
  wire                If_2_io_br_br;
  wire       [31:0]   If_2_io_br_pc;
  wire                If_2_io_stall;
  wire                If_2_io_bubble;
  wire                Id_1_io_stall;
  wire                Id_1_io_bubble;
  wire       [3:0]    seg_l_iDIG;
  wire       [3:0]    seg_h_iDIG;
  wire                clkCtrl_pll_clk_out1;
  wire                clkCtrl_pll_clk_out2;
  wire                clkCtrl_pll_locked;
  wire                bufferCC_1_io_dataOut;
  wire       [31:0]   reg_file_io_r_data_a;
  wire       [31:0]   reg_file_io_r_data_b;
  wire       [31:0]   alu_1_io_y;
  wire       [31:0]   csr_io_csr_r;
  wire       [31:0]   csr_io_mstatus_r;
  wire       [31:0]   csr_io_mie_r;
  wire       [31:0]   csr_io_mtvec_r;
  wire       [31:0]   csr_io_mscratch_r;
  wire       [31:0]   csr_io_mepc_r;
  wire       [31:0]   csr_io_mcause_r;
  wire       [31:0]   csr_io_mip_r;
  wire                trap_1_io_flush_req_0;
  wire                trap_1_io_flush_req_1;
  wire                trap_1_io_flush_req_2;
  wire                trap_1_io_br_br;
  wire       [31:0]   trap_1_io_br_pc;
  wire       [31:0]   trap_1_io_mstatus_w;
  wire                trap_1_io_mstatus_we;
  wire       [31:0]   trap_1_io_mtvec_w;
  wire                trap_1_io_mtvec_we;
  wire       [31:0]   trap_1_io_mepc_w;
  wire                trap_1_io_mepc_we;
  wire       [31:0]   trap_1_io_mcause_w;
  wire                trap_1_io_mcause_we;
  wire       [1:0]    trap_1_io_prv;
  wire                If_2_io_o_real;
  wire       [31:0]   If_2_io_o_pc;
  wire       [31:0]   If_2_io_o_instr;
  wire                If_2_io_o_trap_trap;
  wire       [31:0]   If_2_io_o_trap_epc;
  wire       [31:0]   If_2_io_o_trap_cause;
  wire                If_2_io_trap;
  wire                If_2_io_wb_cyc;
  wire                If_2_io_wb_stb;
  wire                If_2_io_wb_we;
  wire       [31:0]   If_2_io_wb_adr;
  wire       [31:0]   If_2_io_wb_dat_w;
  wire       [3:0]    If_2_io_wb_sel;
  wire                Id_1_io_o_real;
  wire       [31:0]   Id_1_io_o_pc;
  wire       [31:0]   Id_1_io_o_reg_data_a;
  wire       [31:0]   Id_1_io_o_reg_data_b;
  wire       [4:0]    Id_1_io_o_reg_addr_a;
  wire       [4:0]    Id_1_io_o_reg_addr_b;
  wire       [4:0]    Id_1_io_o_reg_addr_d;
  wire       [4:0]    Id_1_io_o_alu_op;
  wire       [1:0]    Id_1_io_o_csr_op;
  wire       [2:0]    Id_1_io_o_br_type;
  wire       [31:0]   Id_1_io_o_imm;
  wire                Id_1_io_o_use_pc;
  wire                Id_1_io_o_use_uimm;
  wire                Id_1_io_o_use_rs2;
  wire                Id_1_io_o_mem_en;
  wire                Id_1_io_o_mem_we;
  wire       [3:0]    Id_1_io_o_mem_sel;
  wire                Id_1_io_o_mem_unsigned;
  wire                Id_1_io_o_reg_we;
  wire       [1:0]    Id_1_io_o_reg_sel;
  wire                Id_1_io_o_trap_trap;
  wire       [31:0]   Id_1_io_o_trap_epc;
  wire       [31:0]   Id_1_io_o_trap_cause;
  wire                Id_1_io_trap;
  wire       [4:0]    Id_1_io_reg_addr_a;
  wire       [4:0]    Id_1_io_reg_addr_b;
  wire                Exe_1_io_o_real;
  wire       [31:0]   Exe_1_io_o_pc;
  wire       [31:0]   Exe_1_io_o_reg_data_b;
  wire       [4:0]    Exe_1_io_o_reg_addr_d;
  wire       [1:0]    Exe_1_io_o_csr_op;
  wire       [31:0]   Exe_1_io_o_imm;
  wire                Exe_1_io_o_mem_en;
  wire                Exe_1_io_o_mem_we;
  wire       [3:0]    Exe_1_io_o_mem_sel;
  wire                Exe_1_io_o_mem_unsigned;
  wire                Exe_1_io_o_reg_we;
  wire       [1:0]    Exe_1_io_o_reg_sel;
  wire       [31:0]   Exe_1_io_o_alu_y;
  wire                Exe_1_io_o_trap_trap;
  wire       [31:0]   Exe_1_io_o_trap_epc;
  wire       [31:0]   Exe_1_io_o_trap_cause;
  wire                Exe_1_io_br_br;
  wire       [31:0]   Exe_1_io_br_pc;
  wire                Exe_1_io_flush_req;
  wire                Exe_1_io_trap;
  wire       [31:0]   Exe_1_io_alu_a;
  wire       [31:0]   Exe_1_io_alu_b;
  wire       [4:0]    Exe_1_io_alu_op;
  wire                Mem_1_io_o_real;
  wire       [31:0]   Mem_1_io_o_pc;
  wire                Mem_1_io_o_reg_we;
  wire       [4:0]    Mem_1_io_o_reg_addr_d;
  wire       [31:0]   Mem_1_io_o_reg_data_d;
  wire                Mem_1_io_o_trap_trap;
  wire       [31:0]   Mem_1_io_o_trap_epc;
  wire       [31:0]   Mem_1_io_o_trap_cause;
  wire                Mem_1_io_forward_we;
  wire       [4:0]    Mem_1_io_forward_addr;
  wire       [31:0]   Mem_1_io_forward_data;
  wire                Mem_1_io_stall_req;
  wire                Mem_1_io_trap;
  wire       [11:0]   Mem_1_io_csr_addr;
  wire       [31:0]   Mem_1_io_csr_w;
  wire                Mem_1_io_csr_we;
  wire                Mem_1_io_wb_cyc;
  wire                Mem_1_io_wb_stb;
  wire                Mem_1_io_wb_we;
  wire       [31:0]   Mem_1_io_wb_adr;
  wire       [31:0]   Mem_1_io_wb_dat_w;
  wire       [3:0]    Mem_1_io_wb_sel;
  wire                Wb_1_io_forward_we;
  wire       [4:0]    Wb_1_io_forward_addr;
  wire       [31:0]   Wb_1_io_forward_data;
  wire                Wb_1_io_trap_commit_trap;
  wire       [31:0]   Wb_1_io_trap_commit_epc;
  wire       [31:0]   Wb_1_io_trap_commit_cause;
  wire       [4:0]    Wb_1_io_reg_addr;
  wire       [31:0]   Wb_1_io_reg_data;
  wire                Wb_1_io_reg_we;
  wire       [7:0]    seg_l_oSEG1;
  wire       [7:0]    seg_h_oSEG1;
  wire                muxes_0_io_wb_ack;
  wire       [31:0]   muxes_0_io_wb_dat_r;
  wire                muxes_0_io_slaves_0_cyc;
  wire                muxes_0_io_slaves_0_stb;
  wire                muxes_0_io_slaves_0_we;
  wire       [31:0]   muxes_0_io_slaves_0_adr;
  wire       [31:0]   muxes_0_io_slaves_0_dat_w;
  wire       [3:0]    muxes_0_io_slaves_0_sel;
  wire                muxes_0_io_slaves_1_cyc;
  wire                muxes_0_io_slaves_1_stb;
  wire                muxes_0_io_slaves_1_we;
  wire       [31:0]   muxes_0_io_slaves_1_adr;
  wire       [31:0]   muxes_0_io_slaves_1_dat_w;
  wire       [3:0]    muxes_0_io_slaves_1_sel;
  wire                muxes_0_io_slaves_2_cyc;
  wire                muxes_0_io_slaves_2_stb;
  wire                muxes_0_io_slaves_2_we;
  wire       [31:0]   muxes_0_io_slaves_2_adr;
  wire       [31:0]   muxes_0_io_slaves_2_dat_w;
  wire       [3:0]    muxes_0_io_slaves_2_sel;
  wire                muxes_1_io_wb_ack;
  wire       [31:0]   muxes_1_io_wb_dat_r;
  wire                muxes_1_io_slaves_0_cyc;
  wire                muxes_1_io_slaves_0_stb;
  wire                muxes_1_io_slaves_0_we;
  wire       [31:0]   muxes_1_io_slaves_0_adr;
  wire       [31:0]   muxes_1_io_slaves_0_dat_w;
  wire       [3:0]    muxes_1_io_slaves_0_sel;
  wire                muxes_1_io_slaves_1_cyc;
  wire                muxes_1_io_slaves_1_stb;
  wire                muxes_1_io_slaves_1_we;
  wire       [31:0]   muxes_1_io_slaves_1_adr;
  wire       [31:0]   muxes_1_io_slaves_1_dat_w;
  wire       [3:0]    muxes_1_io_slaves_1_sel;
  wire                muxes_1_io_slaves_2_cyc;
  wire                muxes_1_io_slaves_2_stb;
  wire                muxes_1_io_slaves_2_we;
  wire       [31:0]   muxes_1_io_slaves_2_adr;
  wire       [31:0]   muxes_1_io_slaves_2_dat_w;
  wire       [3:0]    muxes_1_io_slaves_2_sel;
  wire                arbiters_0_io_masters_0_ack;
  wire       [31:0]   arbiters_0_io_masters_0_dat_r;
  wire                arbiters_0_io_masters_1_ack;
  wire       [31:0]   arbiters_0_io_masters_1_dat_r;
  wire                arbiters_0_io_wb_cyc;
  wire                arbiters_0_io_wb_stb;
  wire                arbiters_0_io_wb_we;
  wire       [31:0]   arbiters_0_io_wb_adr;
  wire       [31:0]   arbiters_0_io_wb_dat_w;
  wire       [3:0]    arbiters_0_io_wb_sel;
  wire                arbiters_1_io_masters_0_ack;
  wire       [31:0]   arbiters_1_io_masters_0_dat_r;
  wire                arbiters_1_io_masters_1_ack;
  wire       [31:0]   arbiters_1_io_masters_1_dat_r;
  wire                arbiters_1_io_wb_cyc;
  wire                arbiters_1_io_wb_stb;
  wire                arbiters_1_io_wb_we;
  wire       [31:0]   arbiters_1_io_wb_adr;
  wire       [31:0]   arbiters_1_io_wb_dat_w;
  wire       [3:0]    arbiters_1_io_wb_sel;
  wire                arbiters_2_io_masters_0_ack;
  wire       [31:0]   arbiters_2_io_masters_0_dat_r;
  wire                arbiters_2_io_masters_1_ack;
  wire       [31:0]   arbiters_2_io_masters_1_dat_r;
  wire                arbiters_2_io_wb_cyc;
  wire                arbiters_2_io_wb_stb;
  wire                arbiters_2_io_wb_we;
  wire       [31:0]   arbiters_2_io_wb_adr;
  wire       [31:0]   arbiters_2_io_wb_dat_w;
  wire       [3:0]    arbiters_2_io_wb_sel;
  wire                base_ram_io_wb_ack;
  wire       [31:0]   base_ram_io_wb_dat_r;
  wire       [19:0]   base_ram_io_sram_addr;
  wire       [3:0]    base_ram_io_sram_be_n;
  wire                base_ram_io_sram_ce_n;
  wire                base_ram_io_sram_oe_n;
  wire                base_ram_io_sram_we_n;
  wire       [31:0]   base_ram_io_sram_data_write;
  wire                base_ram_io_sram_data_writeEnable;
  wire                ext_ram_io_wb_ack;
  wire       [31:0]   ext_ram_io_wb_dat_r;
  wire       [19:0]   ext_ram_io_sram_addr;
  wire       [3:0]    ext_ram_io_sram_be_n;
  wire                ext_ram_io_sram_ce_n;
  wire                ext_ram_io_sram_oe_n;
  wire                ext_ram_io_sram_we_n;
  wire       [31:0]   ext_ram_io_sram_data_write;
  wire                ext_ram_io_sram_data_writeEnable;
  wire                uart_wb_ack_o;
  wire       [31:0]   uart_wb_dat_o;
  wire                uart_uart_txd_o;
  reg                 _zz_ext_ram_data;
  reg                 _zz_ext_ram_data_1;
  reg                 _zz_ext_ram_data_2;
  reg                 _zz_ext_ram_data_3;
  reg                 _zz_ext_ram_data_4;
  reg                 _zz_ext_ram_data_5;
  reg                 _zz_ext_ram_data_6;
  reg                 _zz_ext_ram_data_7;
  reg                 _zz_ext_ram_data_8;
  reg                 _zz_ext_ram_data_9;
  reg                 _zz_ext_ram_data_10;
  reg                 _zz_ext_ram_data_11;
  reg                 _zz_ext_ram_data_12;
  reg                 _zz_ext_ram_data_13;
  reg                 _zz_ext_ram_data_14;
  reg                 _zz_ext_ram_data_15;
  reg                 _zz_ext_ram_data_16;
  reg                 _zz_ext_ram_data_17;
  reg                 _zz_ext_ram_data_18;
  reg                 _zz_ext_ram_data_19;
  reg                 _zz_ext_ram_data_20;
  reg                 _zz_ext_ram_data_21;
  reg                 _zz_ext_ram_data_22;
  reg                 _zz_ext_ram_data_23;
  reg                 _zz_ext_ram_data_24;
  reg                 _zz_ext_ram_data_25;
  reg                 _zz_ext_ram_data_26;
  reg                 _zz_ext_ram_data_27;
  reg                 _zz_ext_ram_data_28;
  reg                 _zz_ext_ram_data_29;
  reg                 _zz_ext_ram_data_30;
  reg                 _zz_ext_ram_data_31;
  reg                 _zz_base_ram_data;
  reg                 _zz_base_ram_data_1;
  reg                 _zz_base_ram_data_2;
  reg                 _zz_base_ram_data_3;
  reg                 _zz_base_ram_data_4;
  reg                 _zz_base_ram_data_5;
  reg                 _zz_base_ram_data_6;
  reg                 _zz_base_ram_data_7;
  reg                 _zz_base_ram_data_8;
  reg                 _zz_base_ram_data_9;
  reg                 _zz_base_ram_data_10;
  reg                 _zz_base_ram_data_11;
  reg                 _zz_base_ram_data_12;
  reg                 _zz_base_ram_data_13;
  reg                 _zz_base_ram_data_14;
  reg                 _zz_base_ram_data_15;
  reg                 _zz_base_ram_data_16;
  reg                 _zz_base_ram_data_17;
  reg                 _zz_base_ram_data_18;
  reg                 _zz_base_ram_data_19;
  reg                 _zz_base_ram_data_20;
  reg                 _zz_base_ram_data_21;
  reg                 _zz_base_ram_data_22;
  reg                 _zz_base_ram_data_23;
  reg                 _zz_base_ram_data_24;
  reg                 _zz_base_ram_data_25;
  reg                 _zz_base_ram_data_26;
  reg                 _zz_base_ram_data_27;
  reg                 _zz_base_ram_data_28;
  reg                 _zz_base_ram_data_29;
  reg                 _zz_base_ram_data_30;
  reg                 _zz_base_ram_data_31;
  wire       [31:0]   _zz_io_sram_data_read;
  wire       [31:0]   _zz_base_ram_data_32;
  wire                _zz_when_InOutWrapper_l13;
  wire       [31:0]   _zz_io_sram_data_read_1;
  wire       [31:0]   _zz_ext_ram_data_32;
  wire                _zz_when_InOutWrapper_l13_1;
  wire                sys_clk;
  wire                sys_reset;
  wire       [31:0]   _zz_when_InOutWrapper_l13_2;
  wire       [31:0]   _zz_base_ram_data_33;
  reg        [31:0]   _zz_io_sram_data_read_2;
  wire                when_InOutWrapper_l13;
  wire                when_InOutWrapper_l13_1;
  wire                when_InOutWrapper_l13_2;
  wire                when_InOutWrapper_l13_3;
  wire                when_InOutWrapper_l13_4;
  wire                when_InOutWrapper_l13_5;
  wire                when_InOutWrapper_l13_6;
  wire                when_InOutWrapper_l13_7;
  wire                when_InOutWrapper_l13_8;
  wire                when_InOutWrapper_l13_9;
  wire                when_InOutWrapper_l13_10;
  wire                when_InOutWrapper_l13_11;
  wire                when_InOutWrapper_l13_12;
  wire                when_InOutWrapper_l13_13;
  wire                when_InOutWrapper_l13_14;
  wire                when_InOutWrapper_l13_15;
  wire                when_InOutWrapper_l13_16;
  wire                when_InOutWrapper_l13_17;
  wire                when_InOutWrapper_l13_18;
  wire                when_InOutWrapper_l13_19;
  wire                when_InOutWrapper_l13_20;
  wire                when_InOutWrapper_l13_21;
  wire                when_InOutWrapper_l13_22;
  wire                when_InOutWrapper_l13_23;
  wire                when_InOutWrapper_l13_24;
  wire                when_InOutWrapper_l13_25;
  wire                when_InOutWrapper_l13_26;
  wire                when_InOutWrapper_l13_27;
  wire                when_InOutWrapper_l13_28;
  wire                when_InOutWrapper_l13_29;
  wire                when_InOutWrapper_l13_30;
  wire                when_InOutWrapper_l13_31;
  wire       [31:0]   _zz_when_InOutWrapper_l13_3;
  wire       [31:0]   _zz_ext_ram_data_33;
  reg        [31:0]   _zz_io_sram_data_read_3;
  wire                when_InOutWrapper_l13_32;
  wire                when_InOutWrapper_l13_33;
  wire                when_InOutWrapper_l13_34;
  wire                when_InOutWrapper_l13_35;
  wire                when_InOutWrapper_l13_36;
  wire                when_InOutWrapper_l13_37;
  wire                when_InOutWrapper_l13_38;
  wire                when_InOutWrapper_l13_39;
  wire                when_InOutWrapper_l13_40;
  wire                when_InOutWrapper_l13_41;
  wire                when_InOutWrapper_l13_42;
  wire                when_InOutWrapper_l13_43;
  wire                when_InOutWrapper_l13_44;
  wire                when_InOutWrapper_l13_45;
  wire                when_InOutWrapper_l13_46;
  wire                when_InOutWrapper_l13_47;
  wire                when_InOutWrapper_l13_48;
  wire                when_InOutWrapper_l13_49;
  wire                when_InOutWrapper_l13_50;
  wire                when_InOutWrapper_l13_51;
  wire                when_InOutWrapper_l13_52;
  wire                when_InOutWrapper_l13_53;
  wire                when_InOutWrapper_l13_54;
  wire                when_InOutWrapper_l13_55;
  wire                when_InOutWrapper_l13_56;
  wire                when_InOutWrapper_l13_57;
  wire                when_InOutWrapper_l13_58;
  wire                when_InOutWrapper_l13_59;
  wire                when_InOutWrapper_l13_60;
  wire                when_InOutWrapper_l13_61;
  wire                when_InOutWrapper_l13_62;
  wire                when_InOutWrapper_l13_63;

  pll_example clkCtrl_pll (
    .clk_in1  (clk_50M             ), //i
    .reset    (reset_btn           ), //i
    .clk_out1 (clkCtrl_pll_clk_out1), //o
    .clk_out2 (clkCtrl_pll_clk_out2), //o
    .locked   (clkCtrl_pll_locked  )  //o
  );
  BufferCC bufferCC_1 (
    .io_dataIn  (bufferCC_1_io_dataIn ), //i
    .io_dataOut (bufferCC_1_io_dataOut), //o
    .sys_clk    (sys_clk              ), //i
    .locked     (clkCtrl_pll_locked   )  //i
  );
  RegFile reg_file (
    .io_r_addr_a (Id_1_io_reg_addr_a[4:0]   ), //i
    .io_r_data_a (reg_file_io_r_data_a[31:0]), //o
    .io_r_addr_b (Id_1_io_reg_addr_b[4:0]   ), //i
    .io_r_data_b (reg_file_io_r_data_b[31:0]), //o
    .io_w_addr   (Wb_1_io_reg_addr[4:0]     ), //i
    .io_w_data   (Wb_1_io_reg_data[31:0]    ), //i
    .io_w_we     (Wb_1_io_reg_we            ), //i
    .sys_clk     (sys_clk                   ), //i
    .sys_reset   (sys_reset                 )  //i
  );
  Alu alu_1 (
    .io_a  (Exe_1_io_alu_a[31:0]), //i
    .io_b  (Exe_1_io_alu_b[31:0]), //i
    .io_op (Exe_1_io_alu_op[4:0]), //i
    .io_y  (alu_1_io_y[31:0]    )  //o
  );
  CsrFile csr (
    .io_csr_addr    (Mem_1_io_csr_addr[11:0]  ), //i
    .io_csr_r       (csr_io_csr_r[31:0]       ), //o
    .io_csr_w       (Mem_1_io_csr_w[31:0]     ), //i
    .io_csr_we      (Mem_1_io_csr_we          ), //i
    .io_mstatus_r   (csr_io_mstatus_r[31:0]   ), //o
    .io_mstatus_w   (trap_1_io_mstatus_w[31:0]), //i
    .io_mstatus_we  (trap_1_io_mstatus_we     ), //i
    .io_mie_r       (csr_io_mie_r[31:0]       ), //o
    .io_mie_w       (csr_io_mie_w[31:0]       ), //i
    .io_mie_we      (csr_io_mie_we            ), //i
    .io_mtvec_r     (csr_io_mtvec_r[31:0]     ), //o
    .io_mtvec_w     (trap_1_io_mtvec_w[31:0]  ), //i
    .io_mtvec_we    (trap_1_io_mtvec_we       ), //i
    .io_mscratch_r  (csr_io_mscratch_r[31:0]  ), //o
    .io_mscratch_w  (csr_io_mscratch_w[31:0]  ), //i
    .io_mscratch_we (csr_io_mscratch_we       ), //i
    .io_mepc_r      (csr_io_mepc_r[31:0]      ), //o
    .io_mepc_w      (trap_1_io_mepc_w[31:0]   ), //i
    .io_mepc_we     (trap_1_io_mepc_we        ), //i
    .io_mcause_r    (csr_io_mcause_r[31:0]    ), //o
    .io_mcause_w    (trap_1_io_mcause_w[31:0] ), //i
    .io_mcause_we   (trap_1_io_mcause_we      ), //i
    .io_mip_r       (csr_io_mip_r[31:0]       ), //o
    .io_mip_w       (csr_io_mip_w[31:0]       ), //i
    .io_mip_we      (csr_io_mip_we            ), //i
    .sys_clk        (sys_clk                  ), //i
    .sys_reset      (sys_reset                )  //i
  );
  Trap trap_1 (
    .io_trap_0       (Id_1_io_trap                   ), //i
    .io_trap_1       (Exe_1_io_trap                  ), //i
    .io_trap_2       (Mem_1_io_trap                  ), //i
    .io_flush_req_0  (trap_1_io_flush_req_0          ), //o
    .io_flush_req_1  (trap_1_io_flush_req_1          ), //o
    .io_flush_req_2  (trap_1_io_flush_req_2          ), //o
    .io_commit_trap  (Wb_1_io_trap_commit_trap       ), //i
    .io_commit_epc   (Wb_1_io_trap_commit_epc[31:0]  ), //i
    .io_commit_cause (Wb_1_io_trap_commit_cause[31:0]), //i
    .io_br_br        (trap_1_io_br_br                ), //o
    .io_br_pc        (trap_1_io_br_pc[31:0]          ), //o
    .io_mstatus_r    (csr_io_mstatus_r[31:0]         ), //i
    .io_mstatus_w    (trap_1_io_mstatus_w[31:0]      ), //o
    .io_mstatus_we   (trap_1_io_mstatus_we           ), //o
    .io_mtvec_r      (csr_io_mtvec_r[31:0]           ), //i
    .io_mtvec_w      (trap_1_io_mtvec_w[31:0]        ), //o
    .io_mtvec_we     (trap_1_io_mtvec_we             ), //o
    .io_mepc_r       (csr_io_mepc_r[31:0]            ), //i
    .io_mepc_w       (trap_1_io_mepc_w[31:0]         ), //o
    .io_mepc_we      (trap_1_io_mepc_we              ), //o
    .io_mcause_r     (csr_io_mcause_r[31:0]          ), //i
    .io_mcause_w     (trap_1_io_mcause_w[31:0]       ), //o
    .io_mcause_we    (trap_1_io_mcause_we            ), //o
    .io_prv          (trap_1_io_prv[1:0]             ), //o
    .sys_clk         (sys_clk                        ), //i
    .sys_reset       (sys_reset                      )  //i
  );
  IF_1 If_2 (
    .io_o_real       (If_2_io_o_real            ), //o
    .io_o_pc         (If_2_io_o_pc[31:0]        ), //o
    .io_o_instr      (If_2_io_o_instr[31:0]     ), //o
    .io_o_trap_trap  (If_2_io_o_trap_trap       ), //o
    .io_o_trap_epc   (If_2_io_o_trap_epc[31:0]  ), //o
    .io_o_trap_cause (If_2_io_o_trap_cause[31:0]), //o
    .io_br_br        (If_2_io_br_br             ), //i
    .io_br_pc        (If_2_io_br_pc[31:0]       ), //i
    .io_stall        (If_2_io_stall             ), //i
    .io_bubble       (If_2_io_bubble            ), //i
    .io_trap         (If_2_io_trap              ), //o
    .io_mie          (csr_io_mie_r[31:0]        ), //i
    .io_mip          (csr_io_mip_r[31:0]        ), //i
    .io_wb_cyc       (If_2_io_wb_cyc            ), //o
    .io_wb_stb       (If_2_io_wb_stb            ), //o
    .io_wb_ack       (muxes_1_io_wb_ack         ), //i
    .io_wb_we        (If_2_io_wb_we             ), //o
    .io_wb_adr       (If_2_io_wb_adr[31:0]      ), //o
    .io_wb_dat_r     (muxes_1_io_wb_dat_r[31:0] ), //i
    .io_wb_dat_w     (If_2_io_wb_dat_w[31:0]    ), //o
    .io_wb_sel       (If_2_io_wb_sel[3:0]       ), //o
    .sys_clk         (sys_clk                   ), //i
    .sys_reset       (sys_reset                 )  //i
  );
  ID Id_1 (
    .io_i_real         (If_2_io_o_real            ), //i
    .io_i_pc           (If_2_io_o_pc[31:0]        ), //i
    .io_i_instr        (If_2_io_o_instr[31:0]     ), //i
    .io_i_trap_trap    (If_2_io_o_trap_trap       ), //i
    .io_i_trap_epc     (If_2_io_o_trap_epc[31:0]  ), //i
    .io_i_trap_cause   (If_2_io_o_trap_cause[31:0]), //i
    .io_o_real         (Id_1_io_o_real            ), //o
    .io_o_pc           (Id_1_io_o_pc[31:0]        ), //o
    .io_o_reg_data_a   (Id_1_io_o_reg_data_a[31:0]), //o
    .io_o_reg_data_b   (Id_1_io_o_reg_data_b[31:0]), //o
    .io_o_reg_addr_a   (Id_1_io_o_reg_addr_a[4:0] ), //o
    .io_o_reg_addr_b   (Id_1_io_o_reg_addr_b[4:0] ), //o
    .io_o_reg_addr_d   (Id_1_io_o_reg_addr_d[4:0] ), //o
    .io_o_alu_op       (Id_1_io_o_alu_op[4:0]     ), //o
    .io_o_csr_op       (Id_1_io_o_csr_op[1:0]     ), //o
    .io_o_br_type      (Id_1_io_o_br_type[2:0]    ), //o
    .io_o_imm          (Id_1_io_o_imm[31:0]       ), //o
    .io_o_use_pc       (Id_1_io_o_use_pc          ), //o
    .io_o_use_uimm     (Id_1_io_o_use_uimm        ), //o
    .io_o_use_rs2      (Id_1_io_o_use_rs2         ), //o
    .io_o_mem_en       (Id_1_io_o_mem_en          ), //o
    .io_o_mem_we       (Id_1_io_o_mem_we          ), //o
    .io_o_mem_sel      (Id_1_io_o_mem_sel[3:0]    ), //o
    .io_o_mem_unsigned (Id_1_io_o_mem_unsigned    ), //o
    .io_o_reg_we       (Id_1_io_o_reg_we          ), //o
    .io_o_reg_sel      (Id_1_io_o_reg_sel[1:0]    ), //o
    .io_o_trap_trap    (Id_1_io_o_trap_trap       ), //o
    .io_o_trap_epc     (Id_1_io_o_trap_epc[31:0]  ), //o
    .io_o_trap_cause   (Id_1_io_o_trap_cause[31:0]), //o
    .io_stall          (Id_1_io_stall             ), //i
    .io_bubble         (Id_1_io_bubble            ), //i
    .io_trap           (Id_1_io_trap              ), //o
    .io_reg_addr_a     (Id_1_io_reg_addr_a[4:0]   ), //o
    .io_reg_data_a     (reg_file_io_r_data_a[31:0]), //i
    .io_reg_addr_b     (Id_1_io_reg_addr_b[4:0]   ), //o
    .io_reg_data_b     (reg_file_io_r_data_b[31:0]), //i
    .sys_clk           (sys_clk                   ), //i
    .sys_reset         (sys_reset                 )  //i
  );
  EXE Exe_1 (
    .io_i_real         (Id_1_io_o_real             ), //i
    .io_i_pc           (Id_1_io_o_pc[31:0]         ), //i
    .io_i_reg_data_a   (Id_1_io_o_reg_data_a[31:0] ), //i
    .io_i_reg_data_b   (Id_1_io_o_reg_data_b[31:0] ), //i
    .io_i_reg_addr_a   (Id_1_io_o_reg_addr_a[4:0]  ), //i
    .io_i_reg_addr_b   (Id_1_io_o_reg_addr_b[4:0]  ), //i
    .io_i_reg_addr_d   (Id_1_io_o_reg_addr_d[4:0]  ), //i
    .io_i_alu_op       (Id_1_io_o_alu_op[4:0]      ), //i
    .io_i_csr_op       (Id_1_io_o_csr_op[1:0]      ), //i
    .io_i_br_type      (Id_1_io_o_br_type[2:0]     ), //i
    .io_i_imm          (Id_1_io_o_imm[31:0]        ), //i
    .io_i_use_pc       (Id_1_io_o_use_pc           ), //i
    .io_i_use_uimm     (Id_1_io_o_use_uimm         ), //i
    .io_i_use_rs2      (Id_1_io_o_use_rs2          ), //i
    .io_i_mem_en       (Id_1_io_o_mem_en           ), //i
    .io_i_mem_we       (Id_1_io_o_mem_we           ), //i
    .io_i_mem_sel      (Id_1_io_o_mem_sel[3:0]     ), //i
    .io_i_mem_unsigned (Id_1_io_o_mem_unsigned     ), //i
    .io_i_reg_we       (Id_1_io_o_reg_we           ), //i
    .io_i_reg_sel      (Id_1_io_o_reg_sel[1:0]     ), //i
    .io_i_trap_trap    (Id_1_io_o_trap_trap        ), //i
    .io_i_trap_epc     (Id_1_io_o_trap_epc[31:0]   ), //i
    .io_i_trap_cause   (Id_1_io_o_trap_cause[31:0] ), //i
    .io_o_real         (Exe_1_io_o_real            ), //o
    .io_o_pc           (Exe_1_io_o_pc[31:0]        ), //o
    .io_o_reg_data_b   (Exe_1_io_o_reg_data_b[31:0]), //o
    .io_o_reg_addr_d   (Exe_1_io_o_reg_addr_d[4:0] ), //o
    .io_o_csr_op       (Exe_1_io_o_csr_op[1:0]     ), //o
    .io_o_imm          (Exe_1_io_o_imm[31:0]       ), //o
    .io_o_mem_en       (Exe_1_io_o_mem_en          ), //o
    .io_o_mem_we       (Exe_1_io_o_mem_we          ), //o
    .io_o_mem_sel      (Exe_1_io_o_mem_sel[3:0]    ), //o
    .io_o_mem_unsigned (Exe_1_io_o_mem_unsigned    ), //o
    .io_o_reg_we       (Exe_1_io_o_reg_we          ), //o
    .io_o_reg_sel      (Exe_1_io_o_reg_sel[1:0]    ), //o
    .io_o_alu_y        (Exe_1_io_o_alu_y[31:0]     ), //o
    .io_o_trap_trap    (Exe_1_io_o_trap_trap       ), //o
    .io_o_trap_epc     (Exe_1_io_o_trap_epc[31:0]  ), //o
    .io_o_trap_cause   (Exe_1_io_o_trap_cause[31:0]), //o
    .io_br_br          (Exe_1_io_br_br             ), //o
    .io_br_pc          (Exe_1_io_br_pc[31:0]       ), //o
    .io_forward_0_we   (Mem_1_io_forward_we        ), //i
    .io_forward_0_addr (Mem_1_io_forward_addr[4:0] ), //i
    .io_forward_0_data (Mem_1_io_forward_data[31:0]), //i
    .io_forward_1_we   (Wb_1_io_forward_we         ), //i
    .io_forward_1_addr (Wb_1_io_forward_addr[4:0]  ), //i
    .io_forward_1_data (Wb_1_io_forward_data[31:0] ), //i
    .io_stall          (Mem_1_io_stall_req         ), //i
    .io_bubble         (trap_1_io_flush_req_2      ), //i
    .io_flush_req      (Exe_1_io_flush_req         ), //o
    .io_trap           (Exe_1_io_trap              ), //o
    .io_alu_a          (Exe_1_io_alu_a[31:0]       ), //o
    .io_alu_b          (Exe_1_io_alu_b[31:0]       ), //o
    .io_alu_op         (Exe_1_io_alu_op[4:0]       ), //o
    .io_alu_y          (alu_1_io_y[31:0]           ), //i
    .sys_clk           (sys_clk                    ), //i
    .sys_reset         (sys_reset                  )  //i
  );
  MEM Mem_1 (
    .io_i_real         (Exe_1_io_o_real            ), //i
    .io_i_pc           (Exe_1_io_o_pc[31:0]        ), //i
    .io_i_reg_data_b   (Exe_1_io_o_reg_data_b[31:0]), //i
    .io_i_reg_addr_d   (Exe_1_io_o_reg_addr_d[4:0] ), //i
    .io_i_csr_op       (Exe_1_io_o_csr_op[1:0]     ), //i
    .io_i_imm          (Exe_1_io_o_imm[31:0]       ), //i
    .io_i_mem_en       (Exe_1_io_o_mem_en          ), //i
    .io_i_mem_we       (Exe_1_io_o_mem_we          ), //i
    .io_i_mem_sel      (Exe_1_io_o_mem_sel[3:0]    ), //i
    .io_i_mem_unsigned (Exe_1_io_o_mem_unsigned    ), //i
    .io_i_reg_we       (Exe_1_io_o_reg_we          ), //i
    .io_i_reg_sel      (Exe_1_io_o_reg_sel[1:0]    ), //i
    .io_i_alu_y        (Exe_1_io_o_alu_y[31:0]     ), //i
    .io_i_trap_trap    (Exe_1_io_o_trap_trap       ), //i
    .io_i_trap_epc     (Exe_1_io_o_trap_epc[31:0]  ), //i
    .io_i_trap_cause   (Exe_1_io_o_trap_cause[31:0]), //i
    .io_o_real         (Mem_1_io_o_real            ), //o
    .io_o_pc           (Mem_1_io_o_pc[31:0]        ), //o
    .io_o_reg_we       (Mem_1_io_o_reg_we          ), //o
    .io_o_reg_addr_d   (Mem_1_io_o_reg_addr_d[4:0] ), //o
    .io_o_reg_data_d   (Mem_1_io_o_reg_data_d[31:0]), //o
    .io_o_trap_trap    (Mem_1_io_o_trap_trap       ), //o
    .io_o_trap_epc     (Mem_1_io_o_trap_epc[31:0]  ), //o
    .io_o_trap_cause   (Mem_1_io_o_trap_cause[31:0]), //o
    .io_forward_we     (Mem_1_io_forward_we        ), //o
    .io_forward_addr   (Mem_1_io_forward_addr[4:0] ), //o
    .io_forward_data   (Mem_1_io_forward_data[31:0]), //o
    .io_stall_req      (Mem_1_io_stall_req         ), //o
    .io_trap           (Mem_1_io_trap              ), //o
    .io_csr_addr       (Mem_1_io_csr_addr[11:0]    ), //o
    .io_csr_r          (csr_io_csr_r[31:0]         ), //i
    .io_csr_w          (Mem_1_io_csr_w[31:0]       ), //o
    .io_csr_we         (Mem_1_io_csr_we            ), //o
    .io_wb_cyc         (Mem_1_io_wb_cyc            ), //o
    .io_wb_stb         (Mem_1_io_wb_stb            ), //o
    .io_wb_ack         (muxes_0_io_wb_ack          ), //i
    .io_wb_we          (Mem_1_io_wb_we             ), //o
    .io_wb_adr         (Mem_1_io_wb_adr[31:0]      ), //o
    .io_wb_dat_r       (muxes_0_io_wb_dat_r[31:0]  ), //i
    .io_wb_dat_w       (Mem_1_io_wb_dat_w[31:0]    ), //o
    .io_wb_sel         (Mem_1_io_wb_sel[3:0]       ), //o
    .sys_clk           (sys_clk                    ), //i
    .sys_reset         (sys_reset                  )  //i
  );
  WB Wb_1 (
    .io_i_real            (Mem_1_io_o_real                ), //i
    .io_i_pc              (Mem_1_io_o_pc[31:0]            ), //i
    .io_i_reg_we          (Mem_1_io_o_reg_we              ), //i
    .io_i_reg_addr_d      (Mem_1_io_o_reg_addr_d[4:0]     ), //i
    .io_i_reg_data_d      (Mem_1_io_o_reg_data_d[31:0]    ), //i
    .io_i_trap_trap       (Mem_1_io_o_trap_trap           ), //i
    .io_i_trap_epc        (Mem_1_io_o_trap_epc[31:0]      ), //i
    .io_i_trap_cause      (Mem_1_io_o_trap_cause[31:0]    ), //i
    .io_forward_we        (Wb_1_io_forward_we             ), //o
    .io_forward_addr      (Wb_1_io_forward_addr[4:0]      ), //o
    .io_forward_data      (Wb_1_io_forward_data[31:0]     ), //o
    .io_trap_commit_trap  (Wb_1_io_trap_commit_trap       ), //o
    .io_trap_commit_epc   (Wb_1_io_trap_commit_epc[31:0]  ), //o
    .io_trap_commit_cause (Wb_1_io_trap_commit_cause[31:0]), //o
    .io_reg_addr          (Wb_1_io_reg_addr[4:0]          ), //o
    .io_reg_data          (Wb_1_io_reg_data[31:0]         ), //o
    .io_reg_we            (Wb_1_io_reg_we                 )  //o
  );
  SEG7_LUT seg_l (
    .iDIG  (seg_l_iDIG[3:0] ), //i
    .oSEG1 (seg_l_oSEG1[7:0])  //o
  );
  SEG7_LUT seg_h (
    .iDIG  (seg_h_iDIG[3:0] ), //i
    .oSEG1 (seg_h_oSEG1[7:0])  //o
  );
  WbMux muxes_0 (
    .io_wb_cyc         (Mem_1_io_wb_cyc                    ), //i
    .io_wb_stb         (Mem_1_io_wb_stb                    ), //i
    .io_wb_ack         (muxes_0_io_wb_ack                  ), //o
    .io_wb_we          (Mem_1_io_wb_we                     ), //i
    .io_wb_adr         (Mem_1_io_wb_adr[31:0]              ), //i
    .io_wb_dat_r       (muxes_0_io_wb_dat_r[31:0]          ), //o
    .io_wb_dat_w       (Mem_1_io_wb_dat_w[31:0]            ), //i
    .io_wb_sel         (Mem_1_io_wb_sel[3:0]               ), //i
    .io_slaves_0_cyc   (muxes_0_io_slaves_0_cyc            ), //o
    .io_slaves_0_stb   (muxes_0_io_slaves_0_stb            ), //o
    .io_slaves_0_ack   (arbiters_0_io_masters_0_ack        ), //i
    .io_slaves_0_we    (muxes_0_io_slaves_0_we             ), //o
    .io_slaves_0_adr   (muxes_0_io_slaves_0_adr[31:0]      ), //o
    .io_slaves_0_dat_r (arbiters_0_io_masters_0_dat_r[31:0]), //i
    .io_slaves_0_dat_w (muxes_0_io_slaves_0_dat_w[31:0]    ), //o
    .io_slaves_0_sel   (muxes_0_io_slaves_0_sel[3:0]       ), //o
    .io_slaves_1_cyc   (muxes_0_io_slaves_1_cyc            ), //o
    .io_slaves_1_stb   (muxes_0_io_slaves_1_stb            ), //o
    .io_slaves_1_ack   (arbiters_1_io_masters_0_ack        ), //i
    .io_slaves_1_we    (muxes_0_io_slaves_1_we             ), //o
    .io_slaves_1_adr   (muxes_0_io_slaves_1_adr[31:0]      ), //o
    .io_slaves_1_dat_r (arbiters_1_io_masters_0_dat_r[31:0]), //i
    .io_slaves_1_dat_w (muxes_0_io_slaves_1_dat_w[31:0]    ), //o
    .io_slaves_1_sel   (muxes_0_io_slaves_1_sel[3:0]       ), //o
    .io_slaves_2_cyc   (muxes_0_io_slaves_2_cyc            ), //o
    .io_slaves_2_stb   (muxes_0_io_slaves_2_stb            ), //o
    .io_slaves_2_ack   (arbiters_2_io_masters_0_ack        ), //i
    .io_slaves_2_we    (muxes_0_io_slaves_2_we             ), //o
    .io_slaves_2_adr   (muxes_0_io_slaves_2_adr[31:0]      ), //o
    .io_slaves_2_dat_r (arbiters_2_io_masters_0_dat_r[31:0]), //i
    .io_slaves_2_dat_w (muxes_0_io_slaves_2_dat_w[31:0]    ), //o
    .io_slaves_2_sel   (muxes_0_io_slaves_2_sel[3:0]       )  //o
  );
  WbMux muxes_1 (
    .io_wb_cyc         (If_2_io_wb_cyc                     ), //i
    .io_wb_stb         (If_2_io_wb_stb                     ), //i
    .io_wb_ack         (muxes_1_io_wb_ack                  ), //o
    .io_wb_we          (If_2_io_wb_we                      ), //i
    .io_wb_adr         (If_2_io_wb_adr[31:0]               ), //i
    .io_wb_dat_r       (muxes_1_io_wb_dat_r[31:0]          ), //o
    .io_wb_dat_w       (If_2_io_wb_dat_w[31:0]             ), //i
    .io_wb_sel         (If_2_io_wb_sel[3:0]                ), //i
    .io_slaves_0_cyc   (muxes_1_io_slaves_0_cyc            ), //o
    .io_slaves_0_stb   (muxes_1_io_slaves_0_stb            ), //o
    .io_slaves_0_ack   (arbiters_0_io_masters_1_ack        ), //i
    .io_slaves_0_we    (muxes_1_io_slaves_0_we             ), //o
    .io_slaves_0_adr   (muxes_1_io_slaves_0_adr[31:0]      ), //o
    .io_slaves_0_dat_r (arbiters_0_io_masters_1_dat_r[31:0]), //i
    .io_slaves_0_dat_w (muxes_1_io_slaves_0_dat_w[31:0]    ), //o
    .io_slaves_0_sel   (muxes_1_io_slaves_0_sel[3:0]       ), //o
    .io_slaves_1_cyc   (muxes_1_io_slaves_1_cyc            ), //o
    .io_slaves_1_stb   (muxes_1_io_slaves_1_stb            ), //o
    .io_slaves_1_ack   (arbiters_1_io_masters_1_ack        ), //i
    .io_slaves_1_we    (muxes_1_io_slaves_1_we             ), //o
    .io_slaves_1_adr   (muxes_1_io_slaves_1_adr[31:0]      ), //o
    .io_slaves_1_dat_r (arbiters_1_io_masters_1_dat_r[31:0]), //i
    .io_slaves_1_dat_w (muxes_1_io_slaves_1_dat_w[31:0]    ), //o
    .io_slaves_1_sel   (muxes_1_io_slaves_1_sel[3:0]       ), //o
    .io_slaves_2_cyc   (muxes_1_io_slaves_2_cyc            ), //o
    .io_slaves_2_stb   (muxes_1_io_slaves_2_stb            ), //o
    .io_slaves_2_ack   (arbiters_2_io_masters_1_ack        ), //i
    .io_slaves_2_we    (muxes_1_io_slaves_2_we             ), //o
    .io_slaves_2_adr   (muxes_1_io_slaves_2_adr[31:0]      ), //o
    .io_slaves_2_dat_r (arbiters_2_io_masters_1_dat_r[31:0]), //i
    .io_slaves_2_dat_w (muxes_1_io_slaves_2_dat_w[31:0]    ), //o
    .io_slaves_2_sel   (muxes_1_io_slaves_2_sel[3:0]       )  //o
  );
  WbArbiter arbiters_0 (
    .io_masters_0_cyc   (muxes_0_io_slaves_0_cyc            ), //i
    .io_masters_0_stb   (muxes_0_io_slaves_0_stb            ), //i
    .io_masters_0_ack   (arbiters_0_io_masters_0_ack        ), //o
    .io_masters_0_we    (muxes_0_io_slaves_0_we             ), //i
    .io_masters_0_adr   (muxes_0_io_slaves_0_adr[31:0]      ), //i
    .io_masters_0_dat_r (arbiters_0_io_masters_0_dat_r[31:0]), //o
    .io_masters_0_dat_w (muxes_0_io_slaves_0_dat_w[31:0]    ), //i
    .io_masters_0_sel   (muxes_0_io_slaves_0_sel[3:0]       ), //i
    .io_masters_1_cyc   (muxes_1_io_slaves_0_cyc            ), //i
    .io_masters_1_stb   (muxes_1_io_slaves_0_stb            ), //i
    .io_masters_1_ack   (arbiters_0_io_masters_1_ack        ), //o
    .io_masters_1_we    (muxes_1_io_slaves_0_we             ), //i
    .io_masters_1_adr   (muxes_1_io_slaves_0_adr[31:0]      ), //i
    .io_masters_1_dat_r (arbiters_0_io_masters_1_dat_r[31:0]), //o
    .io_masters_1_dat_w (muxes_1_io_slaves_0_dat_w[31:0]    ), //i
    .io_masters_1_sel   (muxes_1_io_slaves_0_sel[3:0]       ), //i
    .io_wb_cyc          (arbiters_0_io_wb_cyc               ), //o
    .io_wb_stb          (arbiters_0_io_wb_stb               ), //o
    .io_wb_ack          (base_ram_io_wb_ack                 ), //i
    .io_wb_we           (arbiters_0_io_wb_we                ), //o
    .io_wb_adr          (arbiters_0_io_wb_adr[31:0]         ), //o
    .io_wb_dat_r        (base_ram_io_wb_dat_r[31:0]         ), //i
    .io_wb_dat_w        (arbiters_0_io_wb_dat_w[31:0]       ), //o
    .io_wb_sel          (arbiters_0_io_wb_sel[3:0]          ), //o
    .sys_reset          (sys_reset                          ), //i
    .sys_clk            (sys_clk                            )  //i
  );
  WbArbiter arbiters_1 (
    .io_masters_0_cyc   (muxes_0_io_slaves_1_cyc            ), //i
    .io_masters_0_stb   (muxes_0_io_slaves_1_stb            ), //i
    .io_masters_0_ack   (arbiters_1_io_masters_0_ack        ), //o
    .io_masters_0_we    (muxes_0_io_slaves_1_we             ), //i
    .io_masters_0_adr   (muxes_0_io_slaves_1_adr[31:0]      ), //i
    .io_masters_0_dat_r (arbiters_1_io_masters_0_dat_r[31:0]), //o
    .io_masters_0_dat_w (muxes_0_io_slaves_1_dat_w[31:0]    ), //i
    .io_masters_0_sel   (muxes_0_io_slaves_1_sel[3:0]       ), //i
    .io_masters_1_cyc   (muxes_1_io_slaves_1_cyc            ), //i
    .io_masters_1_stb   (muxes_1_io_slaves_1_stb            ), //i
    .io_masters_1_ack   (arbiters_1_io_masters_1_ack        ), //o
    .io_masters_1_we    (muxes_1_io_slaves_1_we             ), //i
    .io_masters_1_adr   (muxes_1_io_slaves_1_adr[31:0]      ), //i
    .io_masters_1_dat_r (arbiters_1_io_masters_1_dat_r[31:0]), //o
    .io_masters_1_dat_w (muxes_1_io_slaves_1_dat_w[31:0]    ), //i
    .io_masters_1_sel   (muxes_1_io_slaves_1_sel[3:0]       ), //i
    .io_wb_cyc          (arbiters_1_io_wb_cyc               ), //o
    .io_wb_stb          (arbiters_1_io_wb_stb               ), //o
    .io_wb_ack          (ext_ram_io_wb_ack                  ), //i
    .io_wb_we           (arbiters_1_io_wb_we                ), //o
    .io_wb_adr          (arbiters_1_io_wb_adr[31:0]         ), //o
    .io_wb_dat_r        (ext_ram_io_wb_dat_r[31:0]          ), //i
    .io_wb_dat_w        (arbiters_1_io_wb_dat_w[31:0]       ), //o
    .io_wb_sel          (arbiters_1_io_wb_sel[3:0]          ), //o
    .sys_reset          (sys_reset                          ), //i
    .sys_clk            (sys_clk                            )  //i
  );
  WbArbiter arbiters_2 (
    .io_masters_0_cyc   (muxes_0_io_slaves_2_cyc            ), //i
    .io_masters_0_stb   (muxes_0_io_slaves_2_stb            ), //i
    .io_masters_0_ack   (arbiters_2_io_masters_0_ack        ), //o
    .io_masters_0_we    (muxes_0_io_slaves_2_we             ), //i
    .io_masters_0_adr   (muxes_0_io_slaves_2_adr[31:0]      ), //i
    .io_masters_0_dat_r (arbiters_2_io_masters_0_dat_r[31:0]), //o
    .io_masters_0_dat_w (muxes_0_io_slaves_2_dat_w[31:0]    ), //i
    .io_masters_0_sel   (muxes_0_io_slaves_2_sel[3:0]       ), //i
    .io_masters_1_cyc   (muxes_1_io_slaves_2_cyc            ), //i
    .io_masters_1_stb   (muxes_1_io_slaves_2_stb            ), //i
    .io_masters_1_ack   (arbiters_2_io_masters_1_ack        ), //o
    .io_masters_1_we    (muxes_1_io_slaves_2_we             ), //i
    .io_masters_1_adr   (muxes_1_io_slaves_2_adr[31:0]      ), //i
    .io_masters_1_dat_r (arbiters_2_io_masters_1_dat_r[31:0]), //o
    .io_masters_1_dat_w (muxes_1_io_slaves_2_dat_w[31:0]    ), //i
    .io_masters_1_sel   (muxes_1_io_slaves_2_sel[3:0]       ), //i
    .io_wb_cyc          (arbiters_2_io_wb_cyc               ), //o
    .io_wb_stb          (arbiters_2_io_wb_stb               ), //o
    .io_wb_ack          (uart_wb_ack_o                      ), //i
    .io_wb_we           (arbiters_2_io_wb_we                ), //o
    .io_wb_adr          (arbiters_2_io_wb_adr[31:0]         ), //o
    .io_wb_dat_r        (uart_wb_dat_o[31:0]                ), //i
    .io_wb_dat_w        (arbiters_2_io_wb_dat_w[31:0]       ), //o
    .io_wb_sel          (arbiters_2_io_wb_sel[3:0]          ), //o
    .sys_reset          (sys_reset                          ), //i
    .sys_clk            (sys_clk                            )  //i
  );
  SramController base_ram (
    .io_wb_cyc                (arbiters_0_io_wb_cyc             ), //i
    .io_wb_stb                (arbiters_0_io_wb_stb             ), //i
    .io_wb_ack                (base_ram_io_wb_ack               ), //o
    .io_wb_we                 (arbiters_0_io_wb_we              ), //i
    .io_wb_adr                (arbiters_0_io_wb_adr[31:0]       ), //i
    .io_wb_dat_r              (base_ram_io_wb_dat_r[31:0]       ), //o
    .io_wb_dat_w              (arbiters_0_io_wb_dat_w[31:0]     ), //i
    .io_wb_sel                (arbiters_0_io_wb_sel[3:0]        ), //i
    .io_sram_data_read        (_zz_io_sram_data_read[31:0]      ), //i
    .io_sram_data_write       (base_ram_io_sram_data_write[31:0]), //o
    .io_sram_data_writeEnable (base_ram_io_sram_data_writeEnable), //o
    .io_sram_addr             (base_ram_io_sram_addr[19:0]      ), //o
    .io_sram_be_n             (base_ram_io_sram_be_n[3:0]       ), //o
    .io_sram_ce_n             (base_ram_io_sram_ce_n            ), //o
    .io_sram_oe_n             (base_ram_io_sram_oe_n            ), //o
    .io_sram_we_n             (base_ram_io_sram_we_n            ), //o
    .sys_clk                  (sys_clk                          ), //i
    .sys_reset                (sys_reset                        )  //i
  );
  SramController ext_ram (
    .io_wb_cyc                (arbiters_1_io_wb_cyc            ), //i
    .io_wb_stb                (arbiters_1_io_wb_stb            ), //i
    .io_wb_ack                (ext_ram_io_wb_ack               ), //o
    .io_wb_we                 (arbiters_1_io_wb_we             ), //i
    .io_wb_adr                (arbiters_1_io_wb_adr[31:0]      ), //i
    .io_wb_dat_r              (ext_ram_io_wb_dat_r[31:0]       ), //o
    .io_wb_dat_w              (arbiters_1_io_wb_dat_w[31:0]    ), //i
    .io_wb_sel                (arbiters_1_io_wb_sel[3:0]       ), //i
    .io_sram_data_read        (_zz_io_sram_data_read_1[31:0]   ), //i
    .io_sram_data_write       (ext_ram_io_sram_data_write[31:0]), //o
    .io_sram_data_writeEnable (ext_ram_io_sram_data_writeEnable), //o
    .io_sram_addr             (ext_ram_io_sram_addr[19:0]      ), //o
    .io_sram_be_n             (ext_ram_io_sram_be_n[3:0]       ), //o
    .io_sram_ce_n             (ext_ram_io_sram_ce_n            ), //o
    .io_sram_oe_n             (ext_ram_io_sram_oe_n            ), //o
    .io_sram_we_n             (ext_ram_io_sram_we_n            ), //o
    .sys_clk                  (sys_clk                         ), //i
    .sys_reset                (sys_reset                       )  //i
  );
  uart_controller #(
    .ADDR_WIDTH(32),
    .DATA_WIDTH(32),
    .CLK_FREQ(100000000),
    .BAUD(115200)
  ) uart (
    .clk_i      (sys_clk                     ), //i
    .rst_i      (sys_reset                   ), //i
    .wb_cyc_i   (arbiters_2_io_wb_cyc        ), //i
    .wb_stb_i   (arbiters_2_io_wb_stb        ), //i
    .wb_ack_o   (uart_wb_ack_o               ), //o
    .wb_we_i    (arbiters_2_io_wb_we         ), //i
    .wb_adr_i   (arbiters_2_io_wb_adr[31:0]  ), //i
    .wb_dat_o   (uart_wb_dat_o[31:0]         ), //o
    .wb_dat_i   (arbiters_2_io_wb_dat_w[31:0]), //i
    .wb_sel_i   (arbiters_2_io_wb_sel[3:0]   ), //i
    .uart_txd_o (uart_uart_txd_o             ), //o
    .uart_rxd_i (rxd                         )  //i
  );
  assign base_ram_data[0] = _zz_base_ram_data_31 ? _zz_base_ram_data_33[0] : 1'bz;
  assign base_ram_data[1] = _zz_base_ram_data_30 ? _zz_base_ram_data_33[1] : 1'bz;
  assign base_ram_data[2] = _zz_base_ram_data_29 ? _zz_base_ram_data_33[2] : 1'bz;
  assign base_ram_data[3] = _zz_base_ram_data_28 ? _zz_base_ram_data_33[3] : 1'bz;
  assign base_ram_data[4] = _zz_base_ram_data_27 ? _zz_base_ram_data_33[4] : 1'bz;
  assign base_ram_data[5] = _zz_base_ram_data_26 ? _zz_base_ram_data_33[5] : 1'bz;
  assign base_ram_data[6] = _zz_base_ram_data_25 ? _zz_base_ram_data_33[6] : 1'bz;
  assign base_ram_data[7] = _zz_base_ram_data_24 ? _zz_base_ram_data_33[7] : 1'bz;
  assign base_ram_data[8] = _zz_base_ram_data_23 ? _zz_base_ram_data_33[8] : 1'bz;
  assign base_ram_data[9] = _zz_base_ram_data_22 ? _zz_base_ram_data_33[9] : 1'bz;
  assign base_ram_data[10] = _zz_base_ram_data_21 ? _zz_base_ram_data_33[10] : 1'bz;
  assign base_ram_data[11] = _zz_base_ram_data_20 ? _zz_base_ram_data_33[11] : 1'bz;
  assign base_ram_data[12] = _zz_base_ram_data_19 ? _zz_base_ram_data_33[12] : 1'bz;
  assign base_ram_data[13] = _zz_base_ram_data_18 ? _zz_base_ram_data_33[13] : 1'bz;
  assign base_ram_data[14] = _zz_base_ram_data_17 ? _zz_base_ram_data_33[14] : 1'bz;
  assign base_ram_data[15] = _zz_base_ram_data_16 ? _zz_base_ram_data_33[15] : 1'bz;
  assign base_ram_data[16] = _zz_base_ram_data_15 ? _zz_base_ram_data_33[16] : 1'bz;
  assign base_ram_data[17] = _zz_base_ram_data_14 ? _zz_base_ram_data_33[17] : 1'bz;
  assign base_ram_data[18] = _zz_base_ram_data_13 ? _zz_base_ram_data_33[18] : 1'bz;
  assign base_ram_data[19] = _zz_base_ram_data_12 ? _zz_base_ram_data_33[19] : 1'bz;
  assign base_ram_data[20] = _zz_base_ram_data_11 ? _zz_base_ram_data_33[20] : 1'bz;
  assign base_ram_data[21] = _zz_base_ram_data_10 ? _zz_base_ram_data_33[21] : 1'bz;
  assign base_ram_data[22] = _zz_base_ram_data_9 ? _zz_base_ram_data_33[22] : 1'bz;
  assign base_ram_data[23] = _zz_base_ram_data_8 ? _zz_base_ram_data_33[23] : 1'bz;
  assign base_ram_data[24] = _zz_base_ram_data_7 ? _zz_base_ram_data_33[24] : 1'bz;
  assign base_ram_data[25] = _zz_base_ram_data_6 ? _zz_base_ram_data_33[25] : 1'bz;
  assign base_ram_data[26] = _zz_base_ram_data_5 ? _zz_base_ram_data_33[26] : 1'bz;
  assign base_ram_data[27] = _zz_base_ram_data_4 ? _zz_base_ram_data_33[27] : 1'bz;
  assign base_ram_data[28] = _zz_base_ram_data_3 ? _zz_base_ram_data_33[28] : 1'bz;
  assign base_ram_data[29] = _zz_base_ram_data_2 ? _zz_base_ram_data_33[29] : 1'bz;
  assign base_ram_data[30] = _zz_base_ram_data_1 ? _zz_base_ram_data_33[30] : 1'bz;
  assign base_ram_data[31] = _zz_base_ram_data ? _zz_base_ram_data_33[31] : 1'bz;
  assign ext_ram_data[0] = _zz_ext_ram_data_31 ? _zz_ext_ram_data_33[0] : 1'bz;
  assign ext_ram_data[1] = _zz_ext_ram_data_30 ? _zz_ext_ram_data_33[1] : 1'bz;
  assign ext_ram_data[2] = _zz_ext_ram_data_29 ? _zz_ext_ram_data_33[2] : 1'bz;
  assign ext_ram_data[3] = _zz_ext_ram_data_28 ? _zz_ext_ram_data_33[3] : 1'bz;
  assign ext_ram_data[4] = _zz_ext_ram_data_27 ? _zz_ext_ram_data_33[4] : 1'bz;
  assign ext_ram_data[5] = _zz_ext_ram_data_26 ? _zz_ext_ram_data_33[5] : 1'bz;
  assign ext_ram_data[6] = _zz_ext_ram_data_25 ? _zz_ext_ram_data_33[6] : 1'bz;
  assign ext_ram_data[7] = _zz_ext_ram_data_24 ? _zz_ext_ram_data_33[7] : 1'bz;
  assign ext_ram_data[8] = _zz_ext_ram_data_23 ? _zz_ext_ram_data_33[8] : 1'bz;
  assign ext_ram_data[9] = _zz_ext_ram_data_22 ? _zz_ext_ram_data_33[9] : 1'bz;
  assign ext_ram_data[10] = _zz_ext_ram_data_21 ? _zz_ext_ram_data_33[10] : 1'bz;
  assign ext_ram_data[11] = _zz_ext_ram_data_20 ? _zz_ext_ram_data_33[11] : 1'bz;
  assign ext_ram_data[12] = _zz_ext_ram_data_19 ? _zz_ext_ram_data_33[12] : 1'bz;
  assign ext_ram_data[13] = _zz_ext_ram_data_18 ? _zz_ext_ram_data_33[13] : 1'bz;
  assign ext_ram_data[14] = _zz_ext_ram_data_17 ? _zz_ext_ram_data_33[14] : 1'bz;
  assign ext_ram_data[15] = _zz_ext_ram_data_16 ? _zz_ext_ram_data_33[15] : 1'bz;
  assign ext_ram_data[16] = _zz_ext_ram_data_15 ? _zz_ext_ram_data_33[16] : 1'bz;
  assign ext_ram_data[17] = _zz_ext_ram_data_14 ? _zz_ext_ram_data_33[17] : 1'bz;
  assign ext_ram_data[18] = _zz_ext_ram_data_13 ? _zz_ext_ram_data_33[18] : 1'bz;
  assign ext_ram_data[19] = _zz_ext_ram_data_12 ? _zz_ext_ram_data_33[19] : 1'bz;
  assign ext_ram_data[20] = _zz_ext_ram_data_11 ? _zz_ext_ram_data_33[20] : 1'bz;
  assign ext_ram_data[21] = _zz_ext_ram_data_10 ? _zz_ext_ram_data_33[21] : 1'bz;
  assign ext_ram_data[22] = _zz_ext_ram_data_9 ? _zz_ext_ram_data_33[22] : 1'bz;
  assign ext_ram_data[23] = _zz_ext_ram_data_8 ? _zz_ext_ram_data_33[23] : 1'bz;
  assign ext_ram_data[24] = _zz_ext_ram_data_7 ? _zz_ext_ram_data_33[24] : 1'bz;
  assign ext_ram_data[25] = _zz_ext_ram_data_6 ? _zz_ext_ram_data_33[25] : 1'bz;
  assign ext_ram_data[26] = _zz_ext_ram_data_5 ? _zz_ext_ram_data_33[26] : 1'bz;
  assign ext_ram_data[27] = _zz_ext_ram_data_4 ? _zz_ext_ram_data_33[27] : 1'bz;
  assign ext_ram_data[28] = _zz_ext_ram_data_3 ? _zz_ext_ram_data_33[28] : 1'bz;
  assign ext_ram_data[29] = _zz_ext_ram_data_2 ? _zz_ext_ram_data_33[29] : 1'bz;
  assign ext_ram_data[30] = _zz_ext_ram_data_1 ? _zz_ext_ram_data_33[30] : 1'bz;
  assign ext_ram_data[31] = _zz_ext_ram_data ? _zz_ext_ram_data_33[31] : 1'bz;
  always @(*) begin
    _zz_ext_ram_data = 1'b0;
    if(when_InOutWrapper_l13_63) begin
      _zz_ext_ram_data = 1'b1;
    end
  end

  always @(*) begin
    _zz_ext_ram_data_1 = 1'b0;
    if(when_InOutWrapper_l13_62) begin
      _zz_ext_ram_data_1 = 1'b1;
    end
  end

  always @(*) begin
    _zz_ext_ram_data_2 = 1'b0;
    if(when_InOutWrapper_l13_61) begin
      _zz_ext_ram_data_2 = 1'b1;
    end
  end

  always @(*) begin
    _zz_ext_ram_data_3 = 1'b0;
    if(when_InOutWrapper_l13_60) begin
      _zz_ext_ram_data_3 = 1'b1;
    end
  end

  always @(*) begin
    _zz_ext_ram_data_4 = 1'b0;
    if(when_InOutWrapper_l13_59) begin
      _zz_ext_ram_data_4 = 1'b1;
    end
  end

  always @(*) begin
    _zz_ext_ram_data_5 = 1'b0;
    if(when_InOutWrapper_l13_58) begin
      _zz_ext_ram_data_5 = 1'b1;
    end
  end

  always @(*) begin
    _zz_ext_ram_data_6 = 1'b0;
    if(when_InOutWrapper_l13_57) begin
      _zz_ext_ram_data_6 = 1'b1;
    end
  end

  always @(*) begin
    _zz_ext_ram_data_7 = 1'b0;
    if(when_InOutWrapper_l13_56) begin
      _zz_ext_ram_data_7 = 1'b1;
    end
  end

  always @(*) begin
    _zz_ext_ram_data_8 = 1'b0;
    if(when_InOutWrapper_l13_55) begin
      _zz_ext_ram_data_8 = 1'b1;
    end
  end

  always @(*) begin
    _zz_ext_ram_data_9 = 1'b0;
    if(when_InOutWrapper_l13_54) begin
      _zz_ext_ram_data_9 = 1'b1;
    end
  end

  always @(*) begin
    _zz_ext_ram_data_10 = 1'b0;
    if(when_InOutWrapper_l13_53) begin
      _zz_ext_ram_data_10 = 1'b1;
    end
  end

  always @(*) begin
    _zz_ext_ram_data_11 = 1'b0;
    if(when_InOutWrapper_l13_52) begin
      _zz_ext_ram_data_11 = 1'b1;
    end
  end

  always @(*) begin
    _zz_ext_ram_data_12 = 1'b0;
    if(when_InOutWrapper_l13_51) begin
      _zz_ext_ram_data_12 = 1'b1;
    end
  end

  always @(*) begin
    _zz_ext_ram_data_13 = 1'b0;
    if(when_InOutWrapper_l13_50) begin
      _zz_ext_ram_data_13 = 1'b1;
    end
  end

  always @(*) begin
    _zz_ext_ram_data_14 = 1'b0;
    if(when_InOutWrapper_l13_49) begin
      _zz_ext_ram_data_14 = 1'b1;
    end
  end

  always @(*) begin
    _zz_ext_ram_data_15 = 1'b0;
    if(when_InOutWrapper_l13_48) begin
      _zz_ext_ram_data_15 = 1'b1;
    end
  end

  always @(*) begin
    _zz_ext_ram_data_16 = 1'b0;
    if(when_InOutWrapper_l13_47) begin
      _zz_ext_ram_data_16 = 1'b1;
    end
  end

  always @(*) begin
    _zz_ext_ram_data_17 = 1'b0;
    if(when_InOutWrapper_l13_46) begin
      _zz_ext_ram_data_17 = 1'b1;
    end
  end

  always @(*) begin
    _zz_ext_ram_data_18 = 1'b0;
    if(when_InOutWrapper_l13_45) begin
      _zz_ext_ram_data_18 = 1'b1;
    end
  end

  always @(*) begin
    _zz_ext_ram_data_19 = 1'b0;
    if(when_InOutWrapper_l13_44) begin
      _zz_ext_ram_data_19 = 1'b1;
    end
  end

  always @(*) begin
    _zz_ext_ram_data_20 = 1'b0;
    if(when_InOutWrapper_l13_43) begin
      _zz_ext_ram_data_20 = 1'b1;
    end
  end

  always @(*) begin
    _zz_ext_ram_data_21 = 1'b0;
    if(when_InOutWrapper_l13_42) begin
      _zz_ext_ram_data_21 = 1'b1;
    end
  end

  always @(*) begin
    _zz_ext_ram_data_22 = 1'b0;
    if(when_InOutWrapper_l13_41) begin
      _zz_ext_ram_data_22 = 1'b1;
    end
  end

  always @(*) begin
    _zz_ext_ram_data_23 = 1'b0;
    if(when_InOutWrapper_l13_40) begin
      _zz_ext_ram_data_23 = 1'b1;
    end
  end

  always @(*) begin
    _zz_ext_ram_data_24 = 1'b0;
    if(when_InOutWrapper_l13_39) begin
      _zz_ext_ram_data_24 = 1'b1;
    end
  end

  always @(*) begin
    _zz_ext_ram_data_25 = 1'b0;
    if(when_InOutWrapper_l13_38) begin
      _zz_ext_ram_data_25 = 1'b1;
    end
  end

  always @(*) begin
    _zz_ext_ram_data_26 = 1'b0;
    if(when_InOutWrapper_l13_37) begin
      _zz_ext_ram_data_26 = 1'b1;
    end
  end

  always @(*) begin
    _zz_ext_ram_data_27 = 1'b0;
    if(when_InOutWrapper_l13_36) begin
      _zz_ext_ram_data_27 = 1'b1;
    end
  end

  always @(*) begin
    _zz_ext_ram_data_28 = 1'b0;
    if(when_InOutWrapper_l13_35) begin
      _zz_ext_ram_data_28 = 1'b1;
    end
  end

  always @(*) begin
    _zz_ext_ram_data_29 = 1'b0;
    if(when_InOutWrapper_l13_34) begin
      _zz_ext_ram_data_29 = 1'b1;
    end
  end

  always @(*) begin
    _zz_ext_ram_data_30 = 1'b0;
    if(when_InOutWrapper_l13_33) begin
      _zz_ext_ram_data_30 = 1'b1;
    end
  end

  always @(*) begin
    _zz_ext_ram_data_31 = 1'b0;
    if(when_InOutWrapper_l13_32) begin
      _zz_ext_ram_data_31 = 1'b1;
    end
  end

  always @(*) begin
    _zz_base_ram_data = 1'b0;
    if(when_InOutWrapper_l13_31) begin
      _zz_base_ram_data = 1'b1;
    end
  end

  always @(*) begin
    _zz_base_ram_data_1 = 1'b0;
    if(when_InOutWrapper_l13_30) begin
      _zz_base_ram_data_1 = 1'b1;
    end
  end

  always @(*) begin
    _zz_base_ram_data_2 = 1'b0;
    if(when_InOutWrapper_l13_29) begin
      _zz_base_ram_data_2 = 1'b1;
    end
  end

  always @(*) begin
    _zz_base_ram_data_3 = 1'b0;
    if(when_InOutWrapper_l13_28) begin
      _zz_base_ram_data_3 = 1'b1;
    end
  end

  always @(*) begin
    _zz_base_ram_data_4 = 1'b0;
    if(when_InOutWrapper_l13_27) begin
      _zz_base_ram_data_4 = 1'b1;
    end
  end

  always @(*) begin
    _zz_base_ram_data_5 = 1'b0;
    if(when_InOutWrapper_l13_26) begin
      _zz_base_ram_data_5 = 1'b1;
    end
  end

  always @(*) begin
    _zz_base_ram_data_6 = 1'b0;
    if(when_InOutWrapper_l13_25) begin
      _zz_base_ram_data_6 = 1'b1;
    end
  end

  always @(*) begin
    _zz_base_ram_data_7 = 1'b0;
    if(when_InOutWrapper_l13_24) begin
      _zz_base_ram_data_7 = 1'b1;
    end
  end

  always @(*) begin
    _zz_base_ram_data_8 = 1'b0;
    if(when_InOutWrapper_l13_23) begin
      _zz_base_ram_data_8 = 1'b1;
    end
  end

  always @(*) begin
    _zz_base_ram_data_9 = 1'b0;
    if(when_InOutWrapper_l13_22) begin
      _zz_base_ram_data_9 = 1'b1;
    end
  end

  always @(*) begin
    _zz_base_ram_data_10 = 1'b0;
    if(when_InOutWrapper_l13_21) begin
      _zz_base_ram_data_10 = 1'b1;
    end
  end

  always @(*) begin
    _zz_base_ram_data_11 = 1'b0;
    if(when_InOutWrapper_l13_20) begin
      _zz_base_ram_data_11 = 1'b1;
    end
  end

  always @(*) begin
    _zz_base_ram_data_12 = 1'b0;
    if(when_InOutWrapper_l13_19) begin
      _zz_base_ram_data_12 = 1'b1;
    end
  end

  always @(*) begin
    _zz_base_ram_data_13 = 1'b0;
    if(when_InOutWrapper_l13_18) begin
      _zz_base_ram_data_13 = 1'b1;
    end
  end

  always @(*) begin
    _zz_base_ram_data_14 = 1'b0;
    if(when_InOutWrapper_l13_17) begin
      _zz_base_ram_data_14 = 1'b1;
    end
  end

  always @(*) begin
    _zz_base_ram_data_15 = 1'b0;
    if(when_InOutWrapper_l13_16) begin
      _zz_base_ram_data_15 = 1'b1;
    end
  end

  always @(*) begin
    _zz_base_ram_data_16 = 1'b0;
    if(when_InOutWrapper_l13_15) begin
      _zz_base_ram_data_16 = 1'b1;
    end
  end

  always @(*) begin
    _zz_base_ram_data_17 = 1'b0;
    if(when_InOutWrapper_l13_14) begin
      _zz_base_ram_data_17 = 1'b1;
    end
  end

  always @(*) begin
    _zz_base_ram_data_18 = 1'b0;
    if(when_InOutWrapper_l13_13) begin
      _zz_base_ram_data_18 = 1'b1;
    end
  end

  always @(*) begin
    _zz_base_ram_data_19 = 1'b0;
    if(when_InOutWrapper_l13_12) begin
      _zz_base_ram_data_19 = 1'b1;
    end
  end

  always @(*) begin
    _zz_base_ram_data_20 = 1'b0;
    if(when_InOutWrapper_l13_11) begin
      _zz_base_ram_data_20 = 1'b1;
    end
  end

  always @(*) begin
    _zz_base_ram_data_21 = 1'b0;
    if(when_InOutWrapper_l13_10) begin
      _zz_base_ram_data_21 = 1'b1;
    end
  end

  always @(*) begin
    _zz_base_ram_data_22 = 1'b0;
    if(when_InOutWrapper_l13_9) begin
      _zz_base_ram_data_22 = 1'b1;
    end
  end

  always @(*) begin
    _zz_base_ram_data_23 = 1'b0;
    if(when_InOutWrapper_l13_8) begin
      _zz_base_ram_data_23 = 1'b1;
    end
  end

  always @(*) begin
    _zz_base_ram_data_24 = 1'b0;
    if(when_InOutWrapper_l13_7) begin
      _zz_base_ram_data_24 = 1'b1;
    end
  end

  always @(*) begin
    _zz_base_ram_data_25 = 1'b0;
    if(when_InOutWrapper_l13_6) begin
      _zz_base_ram_data_25 = 1'b1;
    end
  end

  always @(*) begin
    _zz_base_ram_data_26 = 1'b0;
    if(when_InOutWrapper_l13_5) begin
      _zz_base_ram_data_26 = 1'b1;
    end
  end

  always @(*) begin
    _zz_base_ram_data_27 = 1'b0;
    if(when_InOutWrapper_l13_4) begin
      _zz_base_ram_data_27 = 1'b1;
    end
  end

  always @(*) begin
    _zz_base_ram_data_28 = 1'b0;
    if(when_InOutWrapper_l13_3) begin
      _zz_base_ram_data_28 = 1'b1;
    end
  end

  always @(*) begin
    _zz_base_ram_data_29 = 1'b0;
    if(when_InOutWrapper_l13_2) begin
      _zz_base_ram_data_29 = 1'b1;
    end
  end

  always @(*) begin
    _zz_base_ram_data_30 = 1'b0;
    if(when_InOutWrapper_l13_1) begin
      _zz_base_ram_data_30 = 1'b1;
    end
  end

  always @(*) begin
    _zz_base_ram_data_31 = 1'b0;
    if(when_InOutWrapper_l13) begin
      _zz_base_ram_data_31 = 1'b1;
    end
  end

  assign sys_clk = clkCtrl_pll_clk_out1;
  assign bufferCC_1_io_dataIn = (1'b0 ^ 1'b0);
  assign sys_reset = bufferCC_1_io_dataOut;
  assign seg_l_iDIG = If_2_io_o_pc[3 : 0];
  assign seg_h_iDIG = If_2_io_o_pc[7 : 4];
  assign dpy0 = seg_l_oSEG1;
  assign dpy1 = seg_h_oSEG1;
  assign leds = If_2_io_o_instr[15:0];
  assign If_2_io_br_br = (trap_1_io_br_br || Exe_1_io_br_br);
  assign If_2_io_br_pc = (trap_1_io_br_br ? trap_1_io_br_pc : Exe_1_io_br_pc);
  assign If_2_io_stall = (((! trap_1_io_flush_req_0) && (! Exe_1_io_flush_req)) && Mem_1_io_stall_req);
  assign If_2_io_bubble = (trap_1_io_flush_req_0 || Exe_1_io_flush_req);
  assign Id_1_io_stall = (((! trap_1_io_flush_req_1) && (! Exe_1_io_flush_req)) && Mem_1_io_stall_req);
  assign Id_1_io_bubble = (trap_1_io_flush_req_1 || Exe_1_io_flush_req);
  assign csr_io_mscratch_we = 1'b0;
  assign csr_io_mscratch_w = 32'h00000000;
  assign csr_io_mip_we = 1'b0;
  assign csr_io_mip_w = 32'h00000000;
  assign csr_io_mie_we = 1'b0;
  assign csr_io_mie_w = 32'h00000000;
  assign _zz_base_ram_data_32 = base_ram_io_sram_data_write;
  assign _zz_when_InOutWrapper_l13 = base_ram_io_sram_data_writeEnable;
  assign base_ram_addr = base_ram_io_sram_addr;
  assign base_ram_be_n = base_ram_io_sram_be_n;
  assign base_ram_ce_n = base_ram_io_sram_ce_n;
  assign base_ram_oe_n = base_ram_io_sram_oe_n;
  assign base_ram_we_n = base_ram_io_sram_we_n;
  assign _zz_ext_ram_data_32 = ext_ram_io_sram_data_write;
  assign _zz_when_InOutWrapper_l13_1 = ext_ram_io_sram_data_writeEnable;
  assign ext_ram_addr = ext_ram_io_sram_addr;
  assign ext_ram_be_n = ext_ram_io_sram_be_n;
  assign ext_ram_ce_n = ext_ram_io_sram_ce_n;
  assign ext_ram_oe_n = ext_ram_io_sram_oe_n;
  assign ext_ram_we_n = ext_ram_io_sram_we_n;
  assign txd = uart_uart_txd_o;
  assign when_InOutWrapper_l13 = _zz_when_InOutWrapper_l13_2[0];
  always @(*) begin
    _zz_io_sram_data_read_2[0] = base_ram_data[0];
    _zz_io_sram_data_read_2[1] = base_ram_data[1];
    _zz_io_sram_data_read_2[2] = base_ram_data[2];
    _zz_io_sram_data_read_2[3] = base_ram_data[3];
    _zz_io_sram_data_read_2[4] = base_ram_data[4];
    _zz_io_sram_data_read_2[5] = base_ram_data[5];
    _zz_io_sram_data_read_2[6] = base_ram_data[6];
    _zz_io_sram_data_read_2[7] = base_ram_data[7];
    _zz_io_sram_data_read_2[8] = base_ram_data[8];
    _zz_io_sram_data_read_2[9] = base_ram_data[9];
    _zz_io_sram_data_read_2[10] = base_ram_data[10];
    _zz_io_sram_data_read_2[11] = base_ram_data[11];
    _zz_io_sram_data_read_2[12] = base_ram_data[12];
    _zz_io_sram_data_read_2[13] = base_ram_data[13];
    _zz_io_sram_data_read_2[14] = base_ram_data[14];
    _zz_io_sram_data_read_2[15] = base_ram_data[15];
    _zz_io_sram_data_read_2[16] = base_ram_data[16];
    _zz_io_sram_data_read_2[17] = base_ram_data[17];
    _zz_io_sram_data_read_2[18] = base_ram_data[18];
    _zz_io_sram_data_read_2[19] = base_ram_data[19];
    _zz_io_sram_data_read_2[20] = base_ram_data[20];
    _zz_io_sram_data_read_2[21] = base_ram_data[21];
    _zz_io_sram_data_read_2[22] = base_ram_data[22];
    _zz_io_sram_data_read_2[23] = base_ram_data[23];
    _zz_io_sram_data_read_2[24] = base_ram_data[24];
    _zz_io_sram_data_read_2[25] = base_ram_data[25];
    _zz_io_sram_data_read_2[26] = base_ram_data[26];
    _zz_io_sram_data_read_2[27] = base_ram_data[27];
    _zz_io_sram_data_read_2[28] = base_ram_data[28];
    _zz_io_sram_data_read_2[29] = base_ram_data[29];
    _zz_io_sram_data_read_2[30] = base_ram_data[30];
    _zz_io_sram_data_read_2[31] = base_ram_data[31];
  end

  assign when_InOutWrapper_l13_1 = _zz_when_InOutWrapper_l13_2[1];
  assign when_InOutWrapper_l13_2 = _zz_when_InOutWrapper_l13_2[2];
  assign when_InOutWrapper_l13_3 = _zz_when_InOutWrapper_l13_2[3];
  assign when_InOutWrapper_l13_4 = _zz_when_InOutWrapper_l13_2[4];
  assign when_InOutWrapper_l13_5 = _zz_when_InOutWrapper_l13_2[5];
  assign when_InOutWrapper_l13_6 = _zz_when_InOutWrapper_l13_2[6];
  assign when_InOutWrapper_l13_7 = _zz_when_InOutWrapper_l13_2[7];
  assign when_InOutWrapper_l13_8 = _zz_when_InOutWrapper_l13_2[8];
  assign when_InOutWrapper_l13_9 = _zz_when_InOutWrapper_l13_2[9];
  assign when_InOutWrapper_l13_10 = _zz_when_InOutWrapper_l13_2[10];
  assign when_InOutWrapper_l13_11 = _zz_when_InOutWrapper_l13_2[11];
  assign when_InOutWrapper_l13_12 = _zz_when_InOutWrapper_l13_2[12];
  assign when_InOutWrapper_l13_13 = _zz_when_InOutWrapper_l13_2[13];
  assign when_InOutWrapper_l13_14 = _zz_when_InOutWrapper_l13_2[14];
  assign when_InOutWrapper_l13_15 = _zz_when_InOutWrapper_l13_2[15];
  assign when_InOutWrapper_l13_16 = _zz_when_InOutWrapper_l13_2[16];
  assign when_InOutWrapper_l13_17 = _zz_when_InOutWrapper_l13_2[17];
  assign when_InOutWrapper_l13_18 = _zz_when_InOutWrapper_l13_2[18];
  assign when_InOutWrapper_l13_19 = _zz_when_InOutWrapper_l13_2[19];
  assign when_InOutWrapper_l13_20 = _zz_when_InOutWrapper_l13_2[20];
  assign when_InOutWrapper_l13_21 = _zz_when_InOutWrapper_l13_2[21];
  assign when_InOutWrapper_l13_22 = _zz_when_InOutWrapper_l13_2[22];
  assign when_InOutWrapper_l13_23 = _zz_when_InOutWrapper_l13_2[23];
  assign when_InOutWrapper_l13_24 = _zz_when_InOutWrapper_l13_2[24];
  assign when_InOutWrapper_l13_25 = _zz_when_InOutWrapper_l13_2[25];
  assign when_InOutWrapper_l13_26 = _zz_when_InOutWrapper_l13_2[26];
  assign when_InOutWrapper_l13_27 = _zz_when_InOutWrapper_l13_2[27];
  assign when_InOutWrapper_l13_28 = _zz_when_InOutWrapper_l13_2[28];
  assign when_InOutWrapper_l13_29 = _zz_when_InOutWrapper_l13_2[29];
  assign when_InOutWrapper_l13_30 = _zz_when_InOutWrapper_l13_2[30];
  assign when_InOutWrapper_l13_31 = _zz_when_InOutWrapper_l13_2[31];
  assign _zz_when_InOutWrapper_l13_2 = (_zz_when_InOutWrapper_l13 ? 32'hffffffff : 32'h00000000);
  assign _zz_base_ram_data_33 = _zz_base_ram_data_32;
  assign _zz_io_sram_data_read = _zz_io_sram_data_read_2;
  assign when_InOutWrapper_l13_32 = _zz_when_InOutWrapper_l13_3[0];
  always @(*) begin
    _zz_io_sram_data_read_3[0] = ext_ram_data[0];
    _zz_io_sram_data_read_3[1] = ext_ram_data[1];
    _zz_io_sram_data_read_3[2] = ext_ram_data[2];
    _zz_io_sram_data_read_3[3] = ext_ram_data[3];
    _zz_io_sram_data_read_3[4] = ext_ram_data[4];
    _zz_io_sram_data_read_3[5] = ext_ram_data[5];
    _zz_io_sram_data_read_3[6] = ext_ram_data[6];
    _zz_io_sram_data_read_3[7] = ext_ram_data[7];
    _zz_io_sram_data_read_3[8] = ext_ram_data[8];
    _zz_io_sram_data_read_3[9] = ext_ram_data[9];
    _zz_io_sram_data_read_3[10] = ext_ram_data[10];
    _zz_io_sram_data_read_3[11] = ext_ram_data[11];
    _zz_io_sram_data_read_3[12] = ext_ram_data[12];
    _zz_io_sram_data_read_3[13] = ext_ram_data[13];
    _zz_io_sram_data_read_3[14] = ext_ram_data[14];
    _zz_io_sram_data_read_3[15] = ext_ram_data[15];
    _zz_io_sram_data_read_3[16] = ext_ram_data[16];
    _zz_io_sram_data_read_3[17] = ext_ram_data[17];
    _zz_io_sram_data_read_3[18] = ext_ram_data[18];
    _zz_io_sram_data_read_3[19] = ext_ram_data[19];
    _zz_io_sram_data_read_3[20] = ext_ram_data[20];
    _zz_io_sram_data_read_3[21] = ext_ram_data[21];
    _zz_io_sram_data_read_3[22] = ext_ram_data[22];
    _zz_io_sram_data_read_3[23] = ext_ram_data[23];
    _zz_io_sram_data_read_3[24] = ext_ram_data[24];
    _zz_io_sram_data_read_3[25] = ext_ram_data[25];
    _zz_io_sram_data_read_3[26] = ext_ram_data[26];
    _zz_io_sram_data_read_3[27] = ext_ram_data[27];
    _zz_io_sram_data_read_3[28] = ext_ram_data[28];
    _zz_io_sram_data_read_3[29] = ext_ram_data[29];
    _zz_io_sram_data_read_3[30] = ext_ram_data[30];
    _zz_io_sram_data_read_3[31] = ext_ram_data[31];
  end

  assign when_InOutWrapper_l13_33 = _zz_when_InOutWrapper_l13_3[1];
  assign when_InOutWrapper_l13_34 = _zz_when_InOutWrapper_l13_3[2];
  assign when_InOutWrapper_l13_35 = _zz_when_InOutWrapper_l13_3[3];
  assign when_InOutWrapper_l13_36 = _zz_when_InOutWrapper_l13_3[4];
  assign when_InOutWrapper_l13_37 = _zz_when_InOutWrapper_l13_3[5];
  assign when_InOutWrapper_l13_38 = _zz_when_InOutWrapper_l13_3[6];
  assign when_InOutWrapper_l13_39 = _zz_when_InOutWrapper_l13_3[7];
  assign when_InOutWrapper_l13_40 = _zz_when_InOutWrapper_l13_3[8];
  assign when_InOutWrapper_l13_41 = _zz_when_InOutWrapper_l13_3[9];
  assign when_InOutWrapper_l13_42 = _zz_when_InOutWrapper_l13_3[10];
  assign when_InOutWrapper_l13_43 = _zz_when_InOutWrapper_l13_3[11];
  assign when_InOutWrapper_l13_44 = _zz_when_InOutWrapper_l13_3[12];
  assign when_InOutWrapper_l13_45 = _zz_when_InOutWrapper_l13_3[13];
  assign when_InOutWrapper_l13_46 = _zz_when_InOutWrapper_l13_3[14];
  assign when_InOutWrapper_l13_47 = _zz_when_InOutWrapper_l13_3[15];
  assign when_InOutWrapper_l13_48 = _zz_when_InOutWrapper_l13_3[16];
  assign when_InOutWrapper_l13_49 = _zz_when_InOutWrapper_l13_3[17];
  assign when_InOutWrapper_l13_50 = _zz_when_InOutWrapper_l13_3[18];
  assign when_InOutWrapper_l13_51 = _zz_when_InOutWrapper_l13_3[19];
  assign when_InOutWrapper_l13_52 = _zz_when_InOutWrapper_l13_3[20];
  assign when_InOutWrapper_l13_53 = _zz_when_InOutWrapper_l13_3[21];
  assign when_InOutWrapper_l13_54 = _zz_when_InOutWrapper_l13_3[22];
  assign when_InOutWrapper_l13_55 = _zz_when_InOutWrapper_l13_3[23];
  assign when_InOutWrapper_l13_56 = _zz_when_InOutWrapper_l13_3[24];
  assign when_InOutWrapper_l13_57 = _zz_when_InOutWrapper_l13_3[25];
  assign when_InOutWrapper_l13_58 = _zz_when_InOutWrapper_l13_3[26];
  assign when_InOutWrapper_l13_59 = _zz_when_InOutWrapper_l13_3[27];
  assign when_InOutWrapper_l13_60 = _zz_when_InOutWrapper_l13_3[28];
  assign when_InOutWrapper_l13_61 = _zz_when_InOutWrapper_l13_3[29];
  assign when_InOutWrapper_l13_62 = _zz_when_InOutWrapper_l13_3[30];
  assign when_InOutWrapper_l13_63 = _zz_when_InOutWrapper_l13_3[31];
  assign _zz_when_InOutWrapper_l13_3 = (_zz_when_InOutWrapper_l13_1 ? 32'hffffffff : 32'h00000000);
  assign _zz_ext_ram_data_33 = _zz_ext_ram_data_32;
  assign _zz_io_sram_data_read_1 = _zz_io_sram_data_read_3;

endmodule

//SramController_1 replaced by SramController

module SramController (
  input  wire          io_wb_cyc,
  input  wire          io_wb_stb,
  output reg           io_wb_ack,
  input  wire          io_wb_we,
  input  wire [31:0]   io_wb_adr,
  output wire [31:0]   io_wb_dat_r,
  input  wire [31:0]   io_wb_dat_w,
  input  wire [3:0]    io_wb_sel,
  input  wire [31:0]   io_sram_data_read,
  output wire [31:0]   io_sram_data_write,
  output reg           io_sram_data_writeEnable,
  output wire [19:0]   io_sram_addr,
  output wire [3:0]    io_sram_be_n,
  output wire          io_sram_ce_n,
  output reg           io_sram_oe_n,
  output reg           io_sram_we_n,
  input  wire          sys_clk,
  input  wire          sys_reset
);
  localparam fsm_enumDef_1_BOOT = 3'd0;
  localparam fsm_enumDef_1_idle = 3'd1;
  localparam fsm_enumDef_1_read = 3'd2;
  localparam fsm_enumDef_1_write = 3'd3;
  localparam fsm_enumDef_1_write_2 = 3'd4;

  reg                 fsm_wantExit;
  reg                 fsm_wantStart;
  wire                fsm_wantKill;
  reg        [2:0]    fsm_stateReg;
  reg        [2:0]    fsm_stateNext;
  wire                when_SramController_l33;
  wire                when_StateMachine_l253;
  wire                when_StateMachine_l253_1;
  `ifndef SYNTHESIS
  reg [55:0] fsm_stateReg_string;
  reg [55:0] fsm_stateNext_string;
  `endif


  `ifndef SYNTHESIS
  always @(*) begin
    case(fsm_stateReg)
      fsm_enumDef_1_BOOT : fsm_stateReg_string = "BOOT   ";
      fsm_enumDef_1_idle : fsm_stateReg_string = "idle   ";
      fsm_enumDef_1_read : fsm_stateReg_string = "read   ";
      fsm_enumDef_1_write : fsm_stateReg_string = "write  ";
      fsm_enumDef_1_write_2 : fsm_stateReg_string = "write_2";
      default : fsm_stateReg_string = "???????";
    endcase
  end
  always @(*) begin
    case(fsm_stateNext)
      fsm_enumDef_1_BOOT : fsm_stateNext_string = "BOOT   ";
      fsm_enumDef_1_idle : fsm_stateNext_string = "idle   ";
      fsm_enumDef_1_read : fsm_stateNext_string = "read   ";
      fsm_enumDef_1_write : fsm_stateNext_string = "write  ";
      fsm_enumDef_1_write_2 : fsm_stateNext_string = "write_2";
      default : fsm_stateNext_string = "???????";
    endcase
  end
  `endif

  assign io_wb_dat_r = io_sram_data_read;
  assign io_sram_data_write = io_wb_dat_w;
  assign io_sram_addr = io_wb_adr[21 : 2];
  assign io_sram_ce_n = (! ((io_wb_cyc && io_wb_stb) && (! io_wb_ack)));
  assign io_sram_be_n = (~ io_wb_sel);
  always @(*) begin
    fsm_wantExit = 1'b0;
    case(fsm_stateReg)
      fsm_enumDef_1_idle : begin
      end
      fsm_enumDef_1_read : begin
        fsm_wantExit = 1'b1;
      end
      fsm_enumDef_1_write : begin
      end
      fsm_enumDef_1_write_2 : begin
        fsm_wantExit = 1'b1;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_wantStart = 1'b0;
    case(fsm_stateReg)
      fsm_enumDef_1_idle : begin
      end
      fsm_enumDef_1_read : begin
      end
      fsm_enumDef_1_write : begin
      end
      fsm_enumDef_1_write_2 : begin
      end
      default : begin
        fsm_wantStart = 1'b1;
      end
    endcase
  end

  assign fsm_wantKill = 1'b0;
  always @(*) begin
    io_wb_ack = 1'b0;
    if(when_StateMachine_l253) begin
      io_wb_ack = 1'b1;
    end
  end

  always @(*) begin
    io_sram_oe_n = 1'b0;
    case(fsm_stateReg)
      fsm_enumDef_1_idle : begin
      end
      fsm_enumDef_1_read : begin
      end
      fsm_enumDef_1_write : begin
        io_sram_oe_n = 1'b1;
      end
      fsm_enumDef_1_write_2 : begin
        io_sram_oe_n = 1'b1;
      end
      default : begin
      end
    endcase
    if(when_StateMachine_l253_1) begin
      io_sram_oe_n = 1'b1;
    end
  end

  always @(*) begin
    io_sram_we_n = 1'b1;
    case(fsm_stateReg)
      fsm_enumDef_1_idle : begin
      end
      fsm_enumDef_1_read : begin
      end
      fsm_enumDef_1_write : begin
        io_sram_we_n = 1'b0;
      end
      fsm_enumDef_1_write_2 : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    io_sram_data_writeEnable = 1'b0;
    case(fsm_stateReg)
      fsm_enumDef_1_idle : begin
      end
      fsm_enumDef_1_read : begin
      end
      fsm_enumDef_1_write : begin
        io_sram_data_writeEnable = 1'b1;
      end
      fsm_enumDef_1_write_2 : begin
        io_sram_data_writeEnable = 1'b1;
      end
      default : begin
      end
    endcase
    if(when_StateMachine_l253_1) begin
      io_sram_data_writeEnable = 1'b1;
    end
  end

  always @(*) begin
    fsm_stateNext = fsm_stateReg;
    case(fsm_stateReg)
      fsm_enumDef_1_idle : begin
        if(when_SramController_l33) begin
          if(io_wb_we) begin
            fsm_stateNext = fsm_enumDef_1_write;
          end else begin
            fsm_stateNext = fsm_enumDef_1_read;
          end
        end
      end
      fsm_enumDef_1_read : begin
        fsm_stateNext = fsm_enumDef_1_BOOT;
      end
      fsm_enumDef_1_write : begin
        fsm_stateNext = fsm_enumDef_1_write_2;
      end
      fsm_enumDef_1_write_2 : begin
        fsm_stateNext = fsm_enumDef_1_BOOT;
      end
      default : begin
      end
    endcase
    if(fsm_wantStart) begin
      fsm_stateNext = fsm_enumDef_1_idle;
    end
    if(fsm_wantKill) begin
      fsm_stateNext = fsm_enumDef_1_BOOT;
    end
  end

  assign when_SramController_l33 = (io_wb_cyc && io_wb_stb);
  assign when_StateMachine_l253 = ((! (fsm_stateReg == fsm_enumDef_1_idle)) && (fsm_stateNext == fsm_enumDef_1_idle));
  assign when_StateMachine_l253_1 = ((! (fsm_stateReg == fsm_enumDef_1_write)) && (fsm_stateNext == fsm_enumDef_1_write));
  always @(posedge sys_clk or posedge sys_reset) begin
    if(sys_reset) begin
      fsm_stateReg <= fsm_enumDef_1_BOOT;
    end else begin
      fsm_stateReg <= fsm_stateNext;
    end
  end


endmodule

//WbArbiter_2 replaced by WbArbiter

//WbArbiter_1 replaced by WbArbiter

module WbArbiter (
  input  wire          io_masters_0_cyc,
  input  wire          io_masters_0_stb,
  output wire          io_masters_0_ack,
  input  wire          io_masters_0_we,
  input  wire [31:0]   io_masters_0_adr,
  output wire [31:0]   io_masters_0_dat_r,
  input  wire [31:0]   io_masters_0_dat_w,
  input  wire [3:0]    io_masters_0_sel,
  input  wire          io_masters_1_cyc,
  input  wire          io_masters_1_stb,
  output wire          io_masters_1_ack,
  input  wire          io_masters_1_we,
  input  wire [31:0]   io_masters_1_adr,
  output wire [31:0]   io_masters_1_dat_r,
  input  wire [31:0]   io_masters_1_dat_w,
  input  wire [3:0]    io_masters_1_sel,
  output wire          io_wb_cyc,
  output wire          io_wb_stb,
  input  wire          io_wb_ack,
  output wire          io_wb_we,
  output wire [31:0]   io_wb_adr,
  input  wire [31:0]   io_wb_dat_r,
  output wire [31:0]   io_wb_dat_w,
  output wire [3:0]    io_wb_sel,
  input  wire          sys_reset,
  input  wire          sys_clk
);

  wire       [1:0]    arbiter_1_request;
  wire       [1:0]    arbiter_1_acknowledge;
  wire       [1:0]    arbiter_1_grant;
  wire                arbiter_1_grant_valid;
  wire       [0:0]    arbiter_1_grant_encoded;
  wire                wbm_sel_0;
  wire                wbm_sel_1;
  wire                _zz_enable;
  wire                enable;

  arbiter #(
    .PORTS(2),
    .ARB_TYPE_ROUND_ROBIN(1'b0),
    .ARB_BLOCK(1'b1),
    .ARB_BLOCK_ACK(1'b0),
    .ARB_LSB_HIGH_PRIORITY(1'b1)
  ) arbiter_1 (
    .clk           (sys_clk                   ), //i
    .rst           (sys_reset                 ), //i
    .request       (arbiter_1_request[1:0]    ), //i
    .acknowledge   (arbiter_1_acknowledge[1:0]), //i
    .grant         (arbiter_1_grant[1:0]      ), //o
    .grant_valid   (arbiter_1_grant_valid     ), //o
    .grant_encoded (arbiter_1_grant_encoded   )  //o
  );
  assign arbiter_1_acknowledge = 2'b00;
  assign arbiter_1_request = {io_masters_1_cyc,io_masters_0_cyc};
  assign wbm_sel_0 = (arbiter_1_grant[0] && arbiter_1_grant_valid);
  assign wbm_sel_1 = (arbiter_1_grant[1] && arbiter_1_grant_valid);
  assign _zz_enable = 1'b1;
  assign enable = ((1'b0 || (wbm_sel_0 == _zz_enable)) || (wbm_sel_1 == _zz_enable));
  assign io_masters_0_dat_r = io_wb_dat_r;
  assign io_masters_0_ack = (io_wb_ack && wbm_sel_0);
  assign io_masters_1_dat_r = io_wb_dat_r;
  assign io_masters_1_ack = (io_wb_ack && wbm_sel_1);
  assign io_wb_adr = (enable ? (wbm_sel_0 ? io_masters_0_adr : io_masters_1_adr) : 32'h00000000);
  assign io_wb_dat_w = (enable ? (wbm_sel_0 ? io_masters_0_dat_w : io_masters_1_dat_w) : 32'h00000000);
  assign io_wb_we = (enable ? (wbm_sel_0 ? io_masters_0_we : io_masters_1_we) : 1'b0);
  assign io_wb_sel = (enable ? (wbm_sel_0 ? io_masters_0_sel : io_masters_1_sel) : 4'b0000);
  assign io_wb_stb = (enable ? (wbm_sel_0 ? io_masters_0_stb : io_masters_1_stb) : 1'b0);
  assign io_wb_cyc = (enable ? (wbm_sel_0 ? 1'b1 : 1'b1) : 1'b0);

endmodule

//WbMux_1 replaced by WbMux

module WbMux (
  input  wire          io_wb_cyc,
  input  wire          io_wb_stb,
  output wire          io_wb_ack,
  input  wire          io_wb_we,
  input  wire [31:0]   io_wb_adr,
  output wire [31:0]   io_wb_dat_r,
  input  wire [31:0]   io_wb_dat_w,
  input  wire [3:0]    io_wb_sel,
  output wire          io_slaves_0_cyc,
  output wire          io_slaves_0_stb,
  input  wire          io_slaves_0_ack,
  output wire          io_slaves_0_we,
  output wire [31:0]   io_slaves_0_adr,
  input  wire [31:0]   io_slaves_0_dat_r,
  output wire [31:0]   io_slaves_0_dat_w,
  output wire [3:0]    io_slaves_0_sel,
  output wire          io_slaves_1_cyc,
  output wire          io_slaves_1_stb,
  input  wire          io_slaves_1_ack,
  output wire          io_slaves_1_we,
  output wire [31:0]   io_slaves_1_adr,
  input  wire [31:0]   io_slaves_1_dat_r,
  output wire [31:0]   io_slaves_1_dat_w,
  output wire [3:0]    io_slaves_1_sel,
  output wire          io_slaves_2_cyc,
  output wire          io_slaves_2_stb,
  input  wire          io_slaves_2_ack,
  output wire          io_slaves_2_we,
  output wire [31:0]   io_slaves_2_adr,
  input  wire [31:0]   io_slaves_2_dat_r,
  output wire [31:0]   io_slaves_2_dat_w,
  output wire [3:0]    io_slaves_2_sel
);

  wire                slave_match_0;
  wire                slave_match_1;
  wire                slave_match_2;
  wire                slave_sel_0;
  wire                slave_sel_1;
  wire                slave_sel_2;

  assign slave_match_0 = (((io_wb_adr ^ 32'h80000000) & 32'hffc00000) == 32'h00000000);
  assign slave_match_1 = (((io_wb_adr ^ 32'h80400000) & 32'hffc00000) == 32'h00000000);
  assign slave_match_2 = (((io_wb_adr ^ 32'h10000000) & 32'hffff0000) == 32'h00000000);
  assign slave_sel_0 = (slave_match_0 && (1'b0 == 1'b0));
  assign slave_sel_1 = (slave_match_1 && ((1'b0 || slave_match_0) == 1'b0));
  assign slave_sel_2 = (slave_match_2 && (((1'b0 || slave_match_0) || slave_match_1) == 1'b0));
  assign io_wb_dat_r = (slave_sel_0 ? io_slaves_0_dat_r : (slave_sel_1 ? io_slaves_1_dat_r : io_slaves_2_dat_r));
  assign io_wb_ack = ((io_slaves_0_ack || io_slaves_1_ack) || io_slaves_2_ack);
  assign io_slaves_0_cyc = (io_wb_cyc && slave_sel_0);
  assign io_slaves_0_stb = (io_wb_stb && slave_sel_0);
  assign io_slaves_0_we = (io_wb_we && slave_sel_0);
  assign io_slaves_0_adr = io_wb_adr;
  assign io_slaves_0_dat_w = io_wb_dat_w;
  assign io_slaves_0_sel = io_wb_sel;
  assign io_slaves_1_cyc = (io_wb_cyc && slave_sel_1);
  assign io_slaves_1_stb = (io_wb_stb && slave_sel_1);
  assign io_slaves_1_we = (io_wb_we && slave_sel_1);
  assign io_slaves_1_adr = io_wb_adr;
  assign io_slaves_1_dat_w = io_wb_dat_w;
  assign io_slaves_1_sel = io_wb_sel;
  assign io_slaves_2_cyc = (io_wb_cyc && slave_sel_2);
  assign io_slaves_2_stb = (io_wb_stb && slave_sel_2);
  assign io_slaves_2_we = (io_wb_we && slave_sel_2);
  assign io_slaves_2_adr = io_wb_adr;
  assign io_slaves_2_dat_w = io_wb_dat_w;
  assign io_slaves_2_sel = io_wb_sel;

endmodule

module WB (
  input  wire          io_i_real,
  input  wire [31:0]   io_i_pc,
  input  wire          io_i_reg_we,
  input  wire [4:0]    io_i_reg_addr_d,
  input  wire [31:0]   io_i_reg_data_d,
  input  wire          io_i_trap_trap,
  input  wire [31:0]   io_i_trap_epc,
  input  wire [31:0]   io_i_trap_cause,
  output wire          io_forward_we,
  output wire [4:0]    io_forward_addr,
  output wire [31:0]   io_forward_data,
  output reg           io_trap_commit_trap,
  output reg  [31:0]   io_trap_commit_epc,
  output reg  [31:0]   io_trap_commit_cause,
  output wire [4:0]    io_reg_addr,
  output wire [31:0]   io_reg_data,
  output reg           io_reg_we
);


  assign io_forward_we = io_i_reg_we;
  assign io_forward_addr = io_i_reg_addr_d;
  assign io_forward_data = io_i_reg_data_d;
  always @(*) begin
    io_reg_we = io_i_reg_we;
    if(io_i_trap_trap) begin
      io_reg_we = 1'b0;
    end
  end

  assign io_reg_addr = io_i_reg_addr_d;
  assign io_reg_data = io_i_reg_data_d;
  always @(*) begin
    if(io_i_trap_trap) begin
      io_trap_commit_trap = 1'b1;
    end else begin
      io_trap_commit_trap = 1'b0;
    end
  end

  always @(*) begin
    if(io_i_trap_trap) begin
      io_trap_commit_epc = io_i_trap_epc;
    end else begin
      io_trap_commit_epc = 32'h00000000;
    end
  end

  always @(*) begin
    if(io_i_trap_trap) begin
      io_trap_commit_cause = io_i_trap_cause;
    end else begin
      io_trap_commit_cause = 32'h00000000;
    end
  end


endmodule

module MEM (
  input  wire          io_i_real,
  input  wire [31:0]   io_i_pc,
  input  wire [31:0]   io_i_reg_data_b,
  input  wire [4:0]    io_i_reg_addr_d,
  input  wire [1:0]    io_i_csr_op,
  input  wire [31:0]   io_i_imm,
  input  wire          io_i_mem_en,
  input  wire          io_i_mem_we,
  input  wire [3:0]    io_i_mem_sel,
  input  wire          io_i_mem_unsigned,
  input  wire          io_i_reg_we,
  input  wire [1:0]    io_i_reg_sel,
  input  wire [31:0]   io_i_alu_y,
  input  wire          io_i_trap_trap,
  input  wire [31:0]   io_i_trap_epc,
  input  wire [31:0]   io_i_trap_cause,
  output reg           io_o_real,
  output reg  [31:0]   io_o_pc,
  output reg           io_o_reg_we,
  output reg  [4:0]    io_o_reg_addr_d,
  output reg  [31:0]   io_o_reg_data_d,
  output reg           io_o_trap_trap,
  output reg  [31:0]   io_o_trap_epc,
  output reg  [31:0]   io_o_trap_cause,
  output wire          io_forward_we,
  output wire [4:0]    io_forward_addr,
  output wire [31:0]   io_forward_data,
  output wire          io_stall_req,
  output reg           io_trap,
  output reg  [11:0]   io_csr_addr,
  input  wire [31:0]   io_csr_r,
  output reg  [31:0]   io_csr_w,
  output reg           io_csr_we,
  output wire          io_wb_cyc,
  output reg           io_wb_stb,
  input  wire          io_wb_ack,
  output reg           io_wb_we,
  output reg  [31:0]   io_wb_adr,
  input  wire [31:0]   io_wb_dat_r,
  output reg  [31:0]   io_wb_dat_w,
  output reg  [3:0]    io_wb_sel,
  input  wire          sys_clk,
  input  wire          sys_reset
);
  localparam CsrOp_N = 2'd0;
  localparam CsrOp_W = 2'd1;
  localparam CsrOp_S = 2'd2;
  localparam CsrOp_C = 2'd3;
  localparam RegSel_ALU = 2'd0;
  localparam RegSel_MEM = 2'd1;
  localparam RegSel_PC = 2'd2;
  localparam fsm_enumDef_BOOT = 2'd0;
  localparam fsm_enumDef_start = 2'd1;
  localparam fsm_enumDef_fetch = 2'd2;

  wire       [5:0]    _zz_mem_data_read;
  wire       [5:0]    _zz_mem_data_write;
  wire       [7:0]    _zz__zz_reg_data;
  wire       [15:0]   _zz__zz_reg_data_1;
  wire       [31:0]   _zz__zz_reg_data_1_1;
  wire       [7:0]    _zz__zz_reg_data_1_2;
  wire       [31:0]   _zz__zz_reg_data_1_3;
  wire       [15:0]   _zz__zz_reg_data_1_4;
  wire       [31:0]   _zz__zz_reg_data_1_5;
  wire       [31:0]   _zz__zz_reg_data_1_6;
  wire       [31:0]   _zz_reg_data_2;
  wire       [31:0]   mem_adr;
  wire       [1:0]    offset;
  wire       [3:0]    mem_sel;
  wire       [31:0]   mem_data_read;
  wire       [31:0]   mem_data_write;
  reg        [31:0]   reg_data;
  reg        [31:0]   _zz_reg_data;
  reg        [31:0]   _zz_reg_data_1;
  wire                when_MEM_l52;
  wire                when_MEM_l114;
  wire                fsm_wantExit;
  reg                 fsm_wantStart;
  wire                fsm_wantKill;
  reg        [1:0]    fsm_stateReg;
  reg        [1:0]    fsm_stateNext;
  `ifndef SYNTHESIS
  reg [7:0] io_i_csr_op_string;
  reg [23:0] io_i_reg_sel_string;
  reg [39:0] fsm_stateReg_string;
  reg [39:0] fsm_stateNext_string;
  `endif


  assign _zz_mem_data_read = (offset * 4'b1000);
  assign _zz_mem_data_write = (offset * 4'b1000);
  assign _zz__zz_reg_data = mem_data_read[7 : 0];
  assign _zz__zz_reg_data_1 = mem_data_read[15 : 0];
  assign _zz__zz_reg_data_1_2 = mem_data_read[7 : 0];
  assign _zz__zz_reg_data_1_1 = {{24{_zz__zz_reg_data_1_2[7]}}, _zz__zz_reg_data_1_2};
  assign _zz__zz_reg_data_1_4 = mem_data_read[15 : 0];
  assign _zz__zz_reg_data_1_3 = {{16{_zz__zz_reg_data_1_4[15]}}, _zz__zz_reg_data_1_4};
  assign _zz__zz_reg_data_1_6 = mem_data_read[31 : 0];
  assign _zz__zz_reg_data_1_5 = _zz__zz_reg_data_1_6;
  assign _zz_reg_data_2 = (io_i_pc + 32'h00000004);
  `ifndef SYNTHESIS
  always @(*) begin
    case(io_i_csr_op)
      CsrOp_N : io_i_csr_op_string = "N";
      CsrOp_W : io_i_csr_op_string = "W";
      CsrOp_S : io_i_csr_op_string = "S";
      CsrOp_C : io_i_csr_op_string = "C";
      default : io_i_csr_op_string = "?";
    endcase
  end
  always @(*) begin
    case(io_i_reg_sel)
      RegSel_ALU : io_i_reg_sel_string = "ALU";
      RegSel_MEM : io_i_reg_sel_string = "MEM";
      RegSel_PC : io_i_reg_sel_string = "PC ";
      default : io_i_reg_sel_string = "???";
    endcase
  end
  always @(*) begin
    case(fsm_stateReg)
      fsm_enumDef_BOOT : fsm_stateReg_string = "BOOT ";
      fsm_enumDef_start : fsm_stateReg_string = "start";
      fsm_enumDef_fetch : fsm_stateReg_string = "fetch";
      default : fsm_stateReg_string = "?????";
    endcase
  end
  always @(*) begin
    case(fsm_stateNext)
      fsm_enumDef_BOOT : fsm_stateNext_string = "BOOT ";
      fsm_enumDef_start : fsm_stateNext_string = "start";
      fsm_enumDef_fetch : fsm_stateNext_string = "fetch";
      default : fsm_stateNext_string = "?????";
    endcase
  end
  `endif

  assign mem_adr = io_i_alu_y;
  assign offset = mem_adr[1 : 0];
  assign mem_sel = (io_i_mem_sel <<< offset);
  assign mem_data_read = (io_wb_dat_r >>> _zz_mem_data_read);
  assign mem_data_write = (io_i_reg_data_b <<< _zz_mem_data_write);
  always @(*) begin
    case(io_i_reg_sel)
      RegSel_ALU : begin
        reg_data = io_i_alu_y;
      end
      RegSel_MEM : begin
        if(io_i_mem_unsigned) begin
          reg_data = _zz_reg_data;
        end else begin
          reg_data = _zz_reg_data_1;
        end
      end
      default : begin
        reg_data = _zz_reg_data_2;
      end
    endcase
    if(when_MEM_l52) begin
      reg_data = io_csr_r;
    end
  end

  always @(*) begin
    _zz_reg_data = 32'h00000000;
    case(io_i_mem_sel)
      4'b0001 : begin
        _zz_reg_data = {24'd0, _zz__zz_reg_data};
      end
      4'b0011 : begin
        _zz_reg_data = {16'd0, _zz__zz_reg_data_1};
      end
      4'b1111 : begin
        _zz_reg_data = mem_data_read[31 : 0];
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    _zz_reg_data_1 = 32'h00000000;
    case(io_i_mem_sel)
      4'b0001 : begin
        _zz_reg_data_1 = _zz__zz_reg_data_1_1;
      end
      4'b0011 : begin
        _zz_reg_data_1 = _zz__zz_reg_data_1_3;
      end
      4'b1111 : begin
        _zz_reg_data_1 = _zz__zz_reg_data_1_5;
      end
      default : begin
      end
    endcase
  end

  assign when_MEM_l52 = (io_i_csr_op != CsrOp_N);
  always @(*) begin
    io_trap = io_o_trap_trap;
    case(fsm_stateReg)
      fsm_enumDef_start : begin
        if(io_i_trap_trap) begin
          io_trap = 1'b1;
        end else begin
          if(io_i_mem_en) begin
            io_trap = 1'b0;
          end else begin
            io_trap = 1'b0;
          end
        end
      end
      fsm_enumDef_fetch : begin
        io_trap = 1'b0;
        if(io_wb_ack) begin
          io_trap = 1'b0;
        end
      end
      default : begin
      end
    endcase
  end

  assign io_forward_we = io_i_reg_we;
  assign io_forward_addr = io_i_reg_addr_d;
  assign io_forward_data = reg_data;
  always @(*) begin
    io_csr_addr = 12'h000;
    if(when_MEM_l114) begin
      io_csr_addr = io_i_imm[11 : 0];
    end
  end

  always @(*) begin
    io_csr_w = 32'h00000000;
    case(io_i_csr_op)
      CsrOp_W : begin
        io_csr_w = io_i_alu_y;
      end
      CsrOp_S : begin
        io_csr_w = (io_csr_r | io_i_alu_y);
      end
      CsrOp_C : begin
        io_csr_w = (io_csr_r & (~ io_i_alu_y));
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    io_csr_we = 1'b0;
    if(when_MEM_l114) begin
      io_csr_we = 1'b1;
    end
  end

  assign when_MEM_l114 = (io_i_csr_op != CsrOp_N);
  assign io_stall_req = (io_i_mem_en && (! io_wb_ack));
  assign io_wb_cyc = io_wb_stb;
  assign fsm_wantExit = 1'b0;
  always @(*) begin
    fsm_wantStart = 1'b0;
    case(fsm_stateReg)
      fsm_enumDef_start : begin
      end
      fsm_enumDef_fetch : begin
      end
      default : begin
        fsm_wantStart = 1'b1;
      end
    endcase
  end

  assign fsm_wantKill = 1'b0;
  always @(*) begin
    io_wb_stb = 1'b0;
    case(fsm_stateReg)
      fsm_enumDef_start : begin
        if(!io_i_trap_trap) begin
          if(io_i_mem_en) begin
            io_wb_stb = 1'b1;
          end
        end
      end
      fsm_enumDef_fetch : begin
        io_wb_stb = 1'b1;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    io_wb_we = 1'b0;
    case(fsm_stateReg)
      fsm_enumDef_start : begin
        if(!io_i_trap_trap) begin
          if(io_i_mem_en) begin
            io_wb_we = io_i_mem_we;
          end
        end
      end
      fsm_enumDef_fetch : begin
        io_wb_we = io_i_mem_we;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    io_wb_adr = 32'h00000000;
    case(fsm_stateReg)
      fsm_enumDef_start : begin
        if(!io_i_trap_trap) begin
          if(io_i_mem_en) begin
            io_wb_adr = mem_adr;
          end
        end
      end
      fsm_enumDef_fetch : begin
        io_wb_adr = mem_adr;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    io_wb_dat_w = 32'h00000000;
    case(fsm_stateReg)
      fsm_enumDef_start : begin
        if(!io_i_trap_trap) begin
          if(io_i_mem_en) begin
            io_wb_dat_w = mem_data_write;
          end
        end
      end
      fsm_enumDef_fetch : begin
        io_wb_dat_w = mem_data_write;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    io_wb_sel = 4'b0000;
    case(fsm_stateReg)
      fsm_enumDef_start : begin
        if(!io_i_trap_trap) begin
          if(io_i_mem_en) begin
            io_wb_sel = mem_sel;
          end
        end
      end
      fsm_enumDef_fetch : begin
        io_wb_sel = mem_sel;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_stateNext = fsm_stateReg;
    case(fsm_stateReg)
      fsm_enumDef_start : begin
        if(!io_i_trap_trap) begin
          if(io_i_mem_en) begin
            fsm_stateNext = fsm_enumDef_fetch;
          end
        end
      end
      fsm_enumDef_fetch : begin
        if(io_wb_ack) begin
          fsm_stateNext = fsm_enumDef_start;
        end
      end
      default : begin
      end
    endcase
    if(fsm_wantStart) begin
      fsm_stateNext = fsm_enumDef_start;
    end
    if(fsm_wantKill) begin
      fsm_stateNext = fsm_enumDef_BOOT;
    end
  end

  always @(posedge sys_clk or posedge sys_reset) begin
    if(sys_reset) begin
      io_o_real <= 1'b0;
      io_o_pc <= 32'h00000000;
      io_o_reg_we <= 1'b0;
      io_o_reg_addr_d <= 5'h00;
      io_o_reg_data_d <= 32'h00000000;
      io_o_trap_trap <= 1'b0;
      io_o_trap_epc <= 32'h00000000;
      io_o_trap_cause <= 32'h00000000;
      fsm_stateReg <= fsm_enumDef_BOOT;
    end else begin
      io_o_trap_trap <= io_trap;
      fsm_stateReg <= fsm_stateNext;
      case(fsm_stateReg)
        fsm_enumDef_start : begin
          if(io_i_trap_trap) begin
            io_o_trap_epc <= io_i_trap_epc;
            io_o_trap_cause <= io_i_trap_cause;
          end else begin
            if(io_i_mem_en) begin
              io_o_real <= 1'b0;
              io_o_pc <= 32'h00000000;
              io_o_reg_we <= 1'b0;
              io_o_trap_epc <= 32'h00000000;
              io_o_trap_cause <= 32'h00000000;
            end else begin
              io_o_real <= io_i_real;
              io_o_pc <= io_i_pc;
              io_o_reg_we <= io_i_reg_we;
              io_o_reg_addr_d <= io_i_reg_addr_d;
              io_o_reg_data_d <= reg_data;
              io_o_trap_epc <= 32'h00000000;
              io_o_trap_cause <= 32'h00000000;
            end
          end
        end
        fsm_enumDef_fetch : begin
          io_o_real <= 1'b0;
          io_o_pc <= 32'h00000000;
          io_o_reg_we <= 1'b0;
          io_o_trap_epc <= 32'h00000000;
          io_o_trap_cause <= 32'h00000000;
          if(io_wb_ack) begin
            io_o_real <= io_i_real;
            io_o_pc <= io_i_pc;
            io_o_reg_we <= io_i_reg_we;
            io_o_reg_addr_d <= io_i_reg_addr_d;
            io_o_reg_data_d <= reg_data;
            io_o_trap_epc <= 32'h00000000;
            io_o_trap_cause <= 32'h00000000;
          end
        end
        default : begin
        end
      endcase
    end
  end


endmodule

module EXE (
  input  wire          io_i_real,
  input  wire [31:0]   io_i_pc,
  input  wire [31:0]   io_i_reg_data_a,
  input  wire [31:0]   io_i_reg_data_b,
  input  wire [4:0]    io_i_reg_addr_a,
  input  wire [4:0]    io_i_reg_addr_b,
  input  wire [4:0]    io_i_reg_addr_d,
  input  wire [4:0]    io_i_alu_op,
  input  wire [1:0]    io_i_csr_op,
  input  wire [2:0]    io_i_br_type,
  input  wire [31:0]   io_i_imm,
  input  wire          io_i_use_pc,
  input  wire          io_i_use_uimm,
  input  wire          io_i_use_rs2,
  input  wire          io_i_mem_en,
  input  wire          io_i_mem_we,
  input  wire [3:0]    io_i_mem_sel,
  input  wire          io_i_mem_unsigned,
  input  wire          io_i_reg_we,
  input  wire [1:0]    io_i_reg_sel,
  input  wire          io_i_trap_trap,
  input  wire [31:0]   io_i_trap_epc,
  input  wire [31:0]   io_i_trap_cause,
  output reg           io_o_real,
  output reg  [31:0]   io_o_pc,
  output reg  [31:0]   io_o_reg_data_b,
  output reg  [4:0]    io_o_reg_addr_d,
  output reg  [1:0]    io_o_csr_op,
  output reg  [31:0]   io_o_imm,
  output reg           io_o_mem_en,
  output reg           io_o_mem_we,
  output reg  [3:0]    io_o_mem_sel,
  output reg           io_o_mem_unsigned,
  output reg           io_o_reg_we,
  output reg  [1:0]    io_o_reg_sel,
  output reg  [31:0]   io_o_alu_y,
  output reg           io_o_trap_trap,
  output reg  [31:0]   io_o_trap_epc,
  output reg  [31:0]   io_o_trap_cause,
  output reg           io_br_br,
  output wire [31:0]   io_br_pc,
  input  wire          io_forward_0_we,
  input  wire [4:0]    io_forward_0_addr,
  input  wire [31:0]   io_forward_0_data,
  input  wire          io_forward_1_we,
  input  wire [4:0]    io_forward_1_addr,
  input  wire [31:0]   io_forward_1_data,
  input  wire          io_stall,
  input  wire          io_bubble,
  output wire          io_flush_req,
  output reg           io_trap,
  output wire [31:0]   io_alu_a,
  output wire [31:0]   io_alu_b,
  output wire [4:0]    io_alu_op,
  input  wire [31:0]   io_alu_y,
  input  wire          sys_clk,
  input  wire          sys_reset
);
  localparam AluOp_OP1 = 5'd0;
  localparam AluOp_ADD = 5'd1;
  localparam AluOp_SUB = 5'd2;
  localparam AluOp_AND_1 = 5'd3;
  localparam AluOp_OR_1 = 5'd4;
  localparam AluOp_XOR_1 = 5'd5;
  localparam AluOp_NOT_1 = 5'd6;
  localparam AluOp_SLL_1 = 5'd7;
  localparam AluOp_SRL_1 = 5'd8;
  localparam AluOp_SRA_1 = 5'd9;
  localparam AluOp_ROL_1 = 5'd10;
  localparam AluOp_SLT = 5'd11;
  localparam AluOp_SLTU = 5'd12;
  localparam AluOp_OP2 = 5'd13;
  localparam AluOp_ANDN = 5'd14;
  localparam AluOp_CLZ = 5'd15;
  localparam AluOp_PACK = 5'd16;
  localparam CsrOp_N = 2'd0;
  localparam CsrOp_W = 2'd1;
  localparam CsrOp_S = 2'd2;
  localparam CsrOp_C = 2'd3;
  localparam BrType_F = 3'd0;
  localparam BrType_T = 3'd1;
  localparam BrType_EQ = 3'd2;
  localparam BrType_NE = 3'd3;
  localparam BrType_LT = 3'd4;
  localparam BrType_GE = 3'd5;
  localparam BrType_LTU = 3'd6;
  localparam BrType_GEU = 3'd7;
  localparam RegSel_ALU = 2'd0;
  localparam RegSel_MEM = 2'd1;
  localparam RegSel_PC = 2'd2;

  wire       [31:0]   _zz_io_alu_a;
  wire       [4:0]    _zz_io_alu_a_1;
  wire       [31:0]   _zz_io_br_pc;
  wire       [0:0]    _zz_io_br_pc_1;
  wire       [31:0]   _zz_io_br_br;
  wire       [31:0]   _zz_io_br_br_1;
  wire       [31:0]   _zz_io_br_br_2;
  wire       [31:0]   _zz_io_br_br_3;
  reg        [31:0]   reg_a;
  reg        [31:0]   reg_b;
  wire                when_EXE_l66;
  wire                when_EXE_l67;
  wire                when_EXE_l70;
  wire                when_EXE_l66_1;
  wire                when_EXE_l67_1;
  wire                when_EXE_l70_1;
  `ifndef SYNTHESIS
  reg [39:0] io_i_alu_op_string;
  reg [7:0] io_i_csr_op_string;
  reg [23:0] io_i_br_type_string;
  reg [23:0] io_i_reg_sel_string;
  reg [7:0] io_o_csr_op_string;
  reg [23:0] io_o_reg_sel_string;
  reg [39:0] io_alu_op_string;
  `endif


  assign _zz_io_alu_a_1 = io_i_reg_addr_a;
  assign _zz_io_alu_a = {27'd0, _zz_io_alu_a_1};
  assign _zz_io_br_pc_1 = io_alu_y[0];
  assign _zz_io_br_pc = {31'd0, _zz_io_br_pc_1};
  assign _zz_io_br_br = reg_a;
  assign _zz_io_br_br_1 = reg_b;
  assign _zz_io_br_br_2 = reg_b;
  assign _zz_io_br_br_3 = reg_a;
  `ifndef SYNTHESIS
  always @(*) begin
    case(io_i_alu_op)
      AluOp_OP1 : io_i_alu_op_string = "OP1  ";
      AluOp_ADD : io_i_alu_op_string = "ADD  ";
      AluOp_SUB : io_i_alu_op_string = "SUB  ";
      AluOp_AND_1 : io_i_alu_op_string = "AND_1";
      AluOp_OR_1 : io_i_alu_op_string = "OR_1 ";
      AluOp_XOR_1 : io_i_alu_op_string = "XOR_1";
      AluOp_NOT_1 : io_i_alu_op_string = "NOT_1";
      AluOp_SLL_1 : io_i_alu_op_string = "SLL_1";
      AluOp_SRL_1 : io_i_alu_op_string = "SRL_1";
      AluOp_SRA_1 : io_i_alu_op_string = "SRA_1";
      AluOp_ROL_1 : io_i_alu_op_string = "ROL_1";
      AluOp_SLT : io_i_alu_op_string = "SLT  ";
      AluOp_SLTU : io_i_alu_op_string = "SLTU ";
      AluOp_OP2 : io_i_alu_op_string = "OP2  ";
      AluOp_ANDN : io_i_alu_op_string = "ANDN ";
      AluOp_CLZ : io_i_alu_op_string = "CLZ  ";
      AluOp_PACK : io_i_alu_op_string = "PACK ";
      default : io_i_alu_op_string = "?????";
    endcase
  end
  always @(*) begin
    case(io_i_csr_op)
      CsrOp_N : io_i_csr_op_string = "N";
      CsrOp_W : io_i_csr_op_string = "W";
      CsrOp_S : io_i_csr_op_string = "S";
      CsrOp_C : io_i_csr_op_string = "C";
      default : io_i_csr_op_string = "?";
    endcase
  end
  always @(*) begin
    case(io_i_br_type)
      BrType_F : io_i_br_type_string = "F  ";
      BrType_T : io_i_br_type_string = "T  ";
      BrType_EQ : io_i_br_type_string = "EQ ";
      BrType_NE : io_i_br_type_string = "NE ";
      BrType_LT : io_i_br_type_string = "LT ";
      BrType_GE : io_i_br_type_string = "GE ";
      BrType_LTU : io_i_br_type_string = "LTU";
      BrType_GEU : io_i_br_type_string = "GEU";
      default : io_i_br_type_string = "???";
    endcase
  end
  always @(*) begin
    case(io_i_reg_sel)
      RegSel_ALU : io_i_reg_sel_string = "ALU";
      RegSel_MEM : io_i_reg_sel_string = "MEM";
      RegSel_PC : io_i_reg_sel_string = "PC ";
      default : io_i_reg_sel_string = "???";
    endcase
  end
  always @(*) begin
    case(io_o_csr_op)
      CsrOp_N : io_o_csr_op_string = "N";
      CsrOp_W : io_o_csr_op_string = "W";
      CsrOp_S : io_o_csr_op_string = "S";
      CsrOp_C : io_o_csr_op_string = "C";
      default : io_o_csr_op_string = "?";
    endcase
  end
  always @(*) begin
    case(io_o_reg_sel)
      RegSel_ALU : io_o_reg_sel_string = "ALU";
      RegSel_MEM : io_o_reg_sel_string = "MEM";
      RegSel_PC : io_o_reg_sel_string = "PC ";
      default : io_o_reg_sel_string = "???";
    endcase
  end
  always @(*) begin
    case(io_alu_op)
      AluOp_OP1 : io_alu_op_string = "OP1  ";
      AluOp_ADD : io_alu_op_string = "ADD  ";
      AluOp_SUB : io_alu_op_string = "SUB  ";
      AluOp_AND_1 : io_alu_op_string = "AND_1";
      AluOp_OR_1 : io_alu_op_string = "OR_1 ";
      AluOp_XOR_1 : io_alu_op_string = "XOR_1";
      AluOp_NOT_1 : io_alu_op_string = "NOT_1";
      AluOp_SLL_1 : io_alu_op_string = "SLL_1";
      AluOp_SRL_1 : io_alu_op_string = "SRL_1";
      AluOp_SRA_1 : io_alu_op_string = "SRA_1";
      AluOp_ROL_1 : io_alu_op_string = "ROL_1";
      AluOp_SLT : io_alu_op_string = "SLT  ";
      AluOp_SLTU : io_alu_op_string = "SLTU ";
      AluOp_OP2 : io_alu_op_string = "OP2  ";
      AluOp_ANDN : io_alu_op_string = "ANDN ";
      AluOp_CLZ : io_alu_op_string = "CLZ  ";
      AluOp_PACK : io_alu_op_string = "PACK ";
      default : io_alu_op_string = "?????";
    endcase
  end
  `endif

  always @(*) begin
    io_trap = io_o_trap_trap;
    if(!io_stall) begin
      if(io_bubble) begin
        io_trap = 1'b0;
      end else begin
        if(io_i_trap_trap) begin
          io_trap = 1'b1;
        end
      end
    end
  end

  always @(*) begin
    reg_a = io_i_reg_data_a;
    if(when_EXE_l66) begin
      if(when_EXE_l67) begin
        reg_a = io_forward_1_data;
      end
    end
    if(when_EXE_l66_1) begin
      if(when_EXE_l67_1) begin
        reg_a = io_forward_0_data;
      end
    end
  end

  always @(*) begin
    reg_b = io_i_reg_data_b;
    if(when_EXE_l66) begin
      if(when_EXE_l70) begin
        reg_b = io_forward_1_data;
      end
    end
    if(when_EXE_l66_1) begin
      if(when_EXE_l70_1) begin
        reg_b = io_forward_0_data;
      end
    end
  end

  assign when_EXE_l66 = (io_forward_1_we && (io_forward_1_addr != 5'h00));
  assign when_EXE_l67 = (io_forward_1_addr == io_i_reg_addr_a);
  assign when_EXE_l70 = (io_forward_1_addr == io_i_reg_addr_b);
  assign when_EXE_l66_1 = (io_forward_0_we && (io_forward_0_addr != 5'h00));
  assign when_EXE_l67_1 = (io_forward_0_addr == io_i_reg_addr_a);
  assign when_EXE_l70_1 = (io_forward_0_addr == io_i_reg_addr_b);
  assign io_alu_a = (io_i_use_pc ? io_i_pc : (io_i_use_uimm ? _zz_io_alu_a : reg_a));
  assign io_alu_b = (io_i_use_rs2 ? reg_b : io_i_imm);
  assign io_alu_op = io_i_alu_op;
  assign io_br_pc = (io_alu_y ^ _zz_io_br_pc);
  always @(*) begin
    case(io_i_br_type)
      BrType_F : begin
        io_br_br = 1'b0;
      end
      BrType_T : begin
        io_br_br = 1'b1;
      end
      BrType_EQ : begin
        io_br_br = (reg_a == reg_b);
      end
      BrType_NE : begin
        io_br_br = (reg_a != reg_b);
      end
      BrType_LT : begin
        io_br_br = ($signed(_zz_io_br_br) < $signed(_zz_io_br_br_1));
      end
      BrType_GE : begin
        io_br_br = ($signed(_zz_io_br_br_2) <= $signed(_zz_io_br_br_3));
      end
      BrType_LTU : begin
        io_br_br = (reg_a < reg_b);
      end
      default : begin
        io_br_br = (reg_b <= reg_a);
      end
    endcase
    if(io_i_trap_trap) begin
      io_br_br = 1'b0;
    end
  end

  assign io_flush_req = io_br_br;
  always @(posedge sys_clk or posedge sys_reset) begin
    if(sys_reset) begin
      io_o_real <= 1'b0;
      io_o_pc <= 32'h00000000;
      io_o_reg_data_b <= 32'h00000000;
      io_o_reg_addr_d <= 5'h00;
      io_o_csr_op <= CsrOp_N;
      io_o_imm <= 32'h00000000;
      io_o_mem_en <= 1'b0;
      io_o_mem_we <= 1'b0;
      io_o_mem_sel <= 4'b0000;
      io_o_mem_unsigned <= 1'b0;
      io_o_reg_we <= 1'b0;
      io_o_reg_sel <= RegSel_ALU;
      io_o_alu_y <= 32'h00000000;
      io_o_trap_trap <= 1'b0;
      io_o_trap_epc <= 32'h00000000;
      io_o_trap_cause <= 32'h00000000;
    end else begin
      io_o_trap_trap <= io_trap;
      if(!io_stall) begin
        if(io_bubble) begin
          io_o_real <= 1'b0;
          io_o_pc <= 32'h00000000;
          io_o_csr_op <= CsrOp_N;
          io_o_mem_en <= 1'b0;
          io_o_reg_we <= 1'b0;
          io_o_trap_epc <= 32'h00000000;
          io_o_trap_cause <= 32'h00000000;
        end else begin
          if(io_i_trap_trap) begin
            io_o_trap_epc <= io_i_trap_epc;
            io_o_trap_cause <= io_i_trap_cause;
          end else begin
            io_o_alu_y <= io_alu_y;
            io_o_real <= io_i_real;
            io_o_pc <= io_i_pc;
            io_o_reg_data_b <= reg_b;
            io_o_reg_addr_d <= io_i_reg_addr_d;
            io_o_csr_op <= io_i_csr_op;
            io_o_imm <= io_i_imm;
            io_o_mem_en <= io_i_mem_en;
            io_o_mem_we <= io_i_mem_we;
            io_o_mem_sel <= io_i_mem_sel;
            io_o_mem_unsigned <= io_i_mem_unsigned;
            io_o_reg_we <= io_i_reg_we;
            io_o_reg_sel <= io_i_reg_sel;
          end
        end
      end
    end
  end


endmodule

module ID (
  input  wire          io_i_real,
  input  wire [31:0]   io_i_pc,
  input  wire [31:0]   io_i_instr,
  input  wire          io_i_trap_trap,
  input  wire [31:0]   io_i_trap_epc,
  input  wire [31:0]   io_i_trap_cause,
  output reg           io_o_real,
  output reg  [31:0]   io_o_pc,
  output reg  [31:0]   io_o_reg_data_a,
  output reg  [31:0]   io_o_reg_data_b,
  output reg  [4:0]    io_o_reg_addr_a,
  output reg  [4:0]    io_o_reg_addr_b,
  output reg  [4:0]    io_o_reg_addr_d,
  output reg  [4:0]    io_o_alu_op,
  output reg  [1:0]    io_o_csr_op,
  output reg  [2:0]    io_o_br_type,
  output reg  [31:0]   io_o_imm,
  output reg           io_o_use_pc,
  output reg           io_o_use_uimm,
  output reg           io_o_use_rs2,
  output reg           io_o_mem_en,
  output reg           io_o_mem_we,
  output reg  [3:0]    io_o_mem_sel,
  output reg           io_o_mem_unsigned,
  output reg           io_o_reg_we,
  output reg  [1:0]    io_o_reg_sel,
  output reg           io_o_trap_trap,
  output reg  [31:0]   io_o_trap_epc,
  output reg  [31:0]   io_o_trap_cause,
  input  wire          io_stall,
  input  wire          io_bubble,
  output reg           io_trap,
  output wire [4:0]    io_reg_addr_a,
  input  wire [31:0]   io_reg_data_a,
  output wire [4:0]    io_reg_addr_b,
  input  wire [31:0]   io_reg_data_b,
  input  wire          sys_clk,
  input  wire          sys_reset
);
  localparam AluOp_OP1 = 5'd0;
  localparam AluOp_ADD = 5'd1;
  localparam AluOp_SUB = 5'd2;
  localparam AluOp_AND_1 = 5'd3;
  localparam AluOp_OR_1 = 5'd4;
  localparam AluOp_XOR_1 = 5'd5;
  localparam AluOp_NOT_1 = 5'd6;
  localparam AluOp_SLL_1 = 5'd7;
  localparam AluOp_SRL_1 = 5'd8;
  localparam AluOp_SRA_1 = 5'd9;
  localparam AluOp_ROL_1 = 5'd10;
  localparam AluOp_SLT = 5'd11;
  localparam AluOp_SLTU = 5'd12;
  localparam AluOp_OP2 = 5'd13;
  localparam AluOp_ANDN = 5'd14;
  localparam AluOp_CLZ = 5'd15;
  localparam AluOp_PACK = 5'd16;
  localparam CsrOp_N = 2'd0;
  localparam CsrOp_W = 2'd1;
  localparam CsrOp_S = 2'd2;
  localparam CsrOp_C = 2'd3;
  localparam BrType_F = 3'd0;
  localparam BrType_T = 3'd1;
  localparam BrType_EQ = 3'd2;
  localparam BrType_NE = 3'd3;
  localparam BrType_LT = 3'd4;
  localparam BrType_GE = 3'd5;
  localparam BrType_LTU = 3'd6;
  localparam BrType_GEU = 3'd7;
  localparam RegSel_ALU = 2'd0;
  localparam RegSel_MEM = 2'd1;
  localparam RegSel_PC = 2'd2;
  localparam Instr_UNK = 6'd0;
  localparam Instr_LUI = 6'd1;
  localparam Instr_AUIPC = 6'd2;
  localparam Instr_JAL = 6'd3;
  localparam Instr_JALR = 6'd4;
  localparam Instr_BEQ = 6'd5;
  localparam Instr_BNE = 6'd6;
  localparam Instr_BLT = 6'd7;
  localparam Instr_BGE = 6'd8;
  localparam Instr_BLTU = 6'd9;
  localparam Instr_BGEU = 6'd10;
  localparam Instr_LB = 6'd11;
  localparam Instr_LH = 6'd12;
  localparam Instr_LW = 6'd13;
  localparam Instr_LBU = 6'd14;
  localparam Instr_LHU = 6'd15;
  localparam Instr_SB = 6'd16;
  localparam Instr_SH = 6'd17;
  localparam Instr_SW = 6'd18;
  localparam Instr_ADDI = 6'd19;
  localparam Instr_SLTI = 6'd20;
  localparam Instr_SLTIU = 6'd21;
  localparam Instr_XORI = 6'd22;
  localparam Instr_ORI = 6'd23;
  localparam Instr_ANDI = 6'd24;
  localparam Instr_SLLI = 6'd25;
  localparam Instr_SRLI = 6'd26;
  localparam Instr_SRAI = 6'd27;
  localparam Instr_ADD = 6'd28;
  localparam Instr_SUB = 6'd29;
  localparam Instr_SLL_1 = 6'd30;
  localparam Instr_SLT = 6'd31;
  localparam Instr_SLTU = 6'd32;
  localparam Instr_XOR_1 = 6'd33;
  localparam Instr_SRL_1 = 6'd34;
  localparam Instr_SRA_1 = 6'd35;
  localparam Instr_OR_1 = 6'd36;
  localparam Instr_AND_1 = 6'd37;
  localparam Instr_ECALL = 6'd38;
  localparam Instr_EBREAK = 6'd39;
  localparam Instr_FENCE_I = 6'd40;
  localparam Instr_CSRRW = 6'd41;
  localparam Instr_CSRRS = 6'd42;
  localparam Instr_CSRRC = 6'd43;
  localparam Instr_CSRRWI = 6'd44;
  localparam Instr_CSRRSI = 6'd45;
  localparam Instr_CSRRCI = 6'd46;
  localparam Instr_MRET = 6'd47;
  localparam Instr_ANDN = 6'd48;
  localparam Instr_CLZ = 6'd49;
  localparam Instr_PACK = 6'd50;
  localparam InstrType_R = 3'd0;
  localparam InstrType_I = 3'd1;
  localparam InstrType_S = 3'd2;
  localparam InstrType_B = 3'd3;
  localparam InstrType_U = 3'd4;
  localparam InstrType_J = 3'd5;

  wire       [31:0]   _zz_imm;
  wire       [11:0]   _zz_imm_1;
  wire       [31:0]   _zz_imm_2;
  wire       [11:0]   _zz_imm_3;
  wire       [31:0]   _zz_imm_4;
  wire       [12:0]   _zz_imm_5;
  wire       [31:0]   _zz_imm_6;
  wire       [31:0]   _zz_imm_7;
  wire       [31:0]   _zz_imm_8;
  wire       [20:0]   _zz_imm_9;
  wire       [6:0]    opcode;
  wire       [2:0]    funct3;
  wire       [6:0]    funct7;
  wire       [4:0]    rs1;
  wire       [4:0]    rs2;
  wire       [4:0]    rd;
  reg        [5:0]    instr_kind;
  reg        [2:0]    instr_type;
  reg        [31:0]   imm;
  reg        [4:0]    alu_op;
  reg        [1:0]    csr_op;
  reg        [2:0]    br_type;
  reg                 use_pc;
  reg                 use_uimm;
  reg                 use_rs2;
  reg                 mem_en;
  reg                 mem_we;
  reg        [3:0]    mem_sel;
  reg                 mem_unsigned;
  reg                 reg_we;
  reg        [1:0]    reg_sel;
  wire                when_ID_l792;
  wire                when_ID_l796;
  wire                when_ID_l800;
  `ifndef SYNTHESIS
  reg [39:0] io_o_alu_op_string;
  reg [7:0] io_o_csr_op_string;
  reg [23:0] io_o_br_type_string;
  reg [23:0] io_o_reg_sel_string;
  reg [55:0] instr_kind_string;
  reg [7:0] instr_type_string;
  reg [39:0] alu_op_string;
  reg [7:0] csr_op_string;
  reg [23:0] br_type_string;
  reg [23:0] reg_sel_string;
  `endif


  assign _zz_imm_1 = io_i_instr[31 : 20];
  assign _zz_imm = {{20{_zz_imm_1[11]}}, _zz_imm_1};
  assign _zz_imm_3 = {io_i_instr[31 : 25],io_i_instr[11 : 7]};
  assign _zz_imm_2 = {{20{_zz_imm_3[11]}}, _zz_imm_3};
  assign _zz_imm_5 = {{{{io_i_instr[31],io_i_instr[7]},io_i_instr[30 : 25]},io_i_instr[11 : 8]},1'b0};
  assign _zz_imm_4 = {{19{_zz_imm_5[12]}}, _zz_imm_5};
  assign _zz_imm_7 = {io_i_instr[31 : 12],12'h000};
  assign _zz_imm_6 = _zz_imm_7;
  assign _zz_imm_9 = {{{{io_i_instr[31],io_i_instr[19 : 12]},io_i_instr[20]},io_i_instr[30 : 21]},1'b0};
  assign _zz_imm_8 = {{11{_zz_imm_9[20]}}, _zz_imm_9};
  `ifndef SYNTHESIS
  always @(*) begin
    case(io_o_alu_op)
      AluOp_OP1 : io_o_alu_op_string = "OP1  ";
      AluOp_ADD : io_o_alu_op_string = "ADD  ";
      AluOp_SUB : io_o_alu_op_string = "SUB  ";
      AluOp_AND_1 : io_o_alu_op_string = "AND_1";
      AluOp_OR_1 : io_o_alu_op_string = "OR_1 ";
      AluOp_XOR_1 : io_o_alu_op_string = "XOR_1";
      AluOp_NOT_1 : io_o_alu_op_string = "NOT_1";
      AluOp_SLL_1 : io_o_alu_op_string = "SLL_1";
      AluOp_SRL_1 : io_o_alu_op_string = "SRL_1";
      AluOp_SRA_1 : io_o_alu_op_string = "SRA_1";
      AluOp_ROL_1 : io_o_alu_op_string = "ROL_1";
      AluOp_SLT : io_o_alu_op_string = "SLT  ";
      AluOp_SLTU : io_o_alu_op_string = "SLTU ";
      AluOp_OP2 : io_o_alu_op_string = "OP2  ";
      AluOp_ANDN : io_o_alu_op_string = "ANDN ";
      AluOp_CLZ : io_o_alu_op_string = "CLZ  ";
      AluOp_PACK : io_o_alu_op_string = "PACK ";
      default : io_o_alu_op_string = "?????";
    endcase
  end
  always @(*) begin
    case(io_o_csr_op)
      CsrOp_N : io_o_csr_op_string = "N";
      CsrOp_W : io_o_csr_op_string = "W";
      CsrOp_S : io_o_csr_op_string = "S";
      CsrOp_C : io_o_csr_op_string = "C";
      default : io_o_csr_op_string = "?";
    endcase
  end
  always @(*) begin
    case(io_o_br_type)
      BrType_F : io_o_br_type_string = "F  ";
      BrType_T : io_o_br_type_string = "T  ";
      BrType_EQ : io_o_br_type_string = "EQ ";
      BrType_NE : io_o_br_type_string = "NE ";
      BrType_LT : io_o_br_type_string = "LT ";
      BrType_GE : io_o_br_type_string = "GE ";
      BrType_LTU : io_o_br_type_string = "LTU";
      BrType_GEU : io_o_br_type_string = "GEU";
      default : io_o_br_type_string = "???";
    endcase
  end
  always @(*) begin
    case(io_o_reg_sel)
      RegSel_ALU : io_o_reg_sel_string = "ALU";
      RegSel_MEM : io_o_reg_sel_string = "MEM";
      RegSel_PC : io_o_reg_sel_string = "PC ";
      default : io_o_reg_sel_string = "???";
    endcase
  end
  always @(*) begin
    case(instr_kind)
      Instr_UNK : instr_kind_string = "UNK    ";
      Instr_LUI : instr_kind_string = "LUI    ";
      Instr_AUIPC : instr_kind_string = "AUIPC  ";
      Instr_JAL : instr_kind_string = "JAL    ";
      Instr_JALR : instr_kind_string = "JALR   ";
      Instr_BEQ : instr_kind_string = "BEQ    ";
      Instr_BNE : instr_kind_string = "BNE    ";
      Instr_BLT : instr_kind_string = "BLT    ";
      Instr_BGE : instr_kind_string = "BGE    ";
      Instr_BLTU : instr_kind_string = "BLTU   ";
      Instr_BGEU : instr_kind_string = "BGEU   ";
      Instr_LB : instr_kind_string = "LB     ";
      Instr_LH : instr_kind_string = "LH     ";
      Instr_LW : instr_kind_string = "LW     ";
      Instr_LBU : instr_kind_string = "LBU    ";
      Instr_LHU : instr_kind_string = "LHU    ";
      Instr_SB : instr_kind_string = "SB     ";
      Instr_SH : instr_kind_string = "SH     ";
      Instr_SW : instr_kind_string = "SW     ";
      Instr_ADDI : instr_kind_string = "ADDI   ";
      Instr_SLTI : instr_kind_string = "SLTI   ";
      Instr_SLTIU : instr_kind_string = "SLTIU  ";
      Instr_XORI : instr_kind_string = "XORI   ";
      Instr_ORI : instr_kind_string = "ORI    ";
      Instr_ANDI : instr_kind_string = "ANDI   ";
      Instr_SLLI : instr_kind_string = "SLLI   ";
      Instr_SRLI : instr_kind_string = "SRLI   ";
      Instr_SRAI : instr_kind_string = "SRAI   ";
      Instr_ADD : instr_kind_string = "ADD    ";
      Instr_SUB : instr_kind_string = "SUB    ";
      Instr_SLL_1 : instr_kind_string = "SLL_1  ";
      Instr_SLT : instr_kind_string = "SLT    ";
      Instr_SLTU : instr_kind_string = "SLTU   ";
      Instr_XOR_1 : instr_kind_string = "XOR_1  ";
      Instr_SRL_1 : instr_kind_string = "SRL_1  ";
      Instr_SRA_1 : instr_kind_string = "SRA_1  ";
      Instr_OR_1 : instr_kind_string = "OR_1   ";
      Instr_AND_1 : instr_kind_string = "AND_1  ";
      Instr_ECALL : instr_kind_string = "ECALL  ";
      Instr_EBREAK : instr_kind_string = "EBREAK ";
      Instr_FENCE_I : instr_kind_string = "FENCE_I";
      Instr_CSRRW : instr_kind_string = "CSRRW  ";
      Instr_CSRRS : instr_kind_string = "CSRRS  ";
      Instr_CSRRC : instr_kind_string = "CSRRC  ";
      Instr_CSRRWI : instr_kind_string = "CSRRWI ";
      Instr_CSRRSI : instr_kind_string = "CSRRSI ";
      Instr_CSRRCI : instr_kind_string = "CSRRCI ";
      Instr_MRET : instr_kind_string = "MRET   ";
      Instr_ANDN : instr_kind_string = "ANDN   ";
      Instr_CLZ : instr_kind_string = "CLZ    ";
      Instr_PACK : instr_kind_string = "PACK   ";
      default : instr_kind_string = "???????";
    endcase
  end
  always @(*) begin
    case(instr_type)
      InstrType_R : instr_type_string = "R";
      InstrType_I : instr_type_string = "I";
      InstrType_S : instr_type_string = "S";
      InstrType_B : instr_type_string = "B";
      InstrType_U : instr_type_string = "U";
      InstrType_J : instr_type_string = "J";
      default : instr_type_string = "?";
    endcase
  end
  always @(*) begin
    case(alu_op)
      AluOp_OP1 : alu_op_string = "OP1  ";
      AluOp_ADD : alu_op_string = "ADD  ";
      AluOp_SUB : alu_op_string = "SUB  ";
      AluOp_AND_1 : alu_op_string = "AND_1";
      AluOp_OR_1 : alu_op_string = "OR_1 ";
      AluOp_XOR_1 : alu_op_string = "XOR_1";
      AluOp_NOT_1 : alu_op_string = "NOT_1";
      AluOp_SLL_1 : alu_op_string = "SLL_1";
      AluOp_SRL_1 : alu_op_string = "SRL_1";
      AluOp_SRA_1 : alu_op_string = "SRA_1";
      AluOp_ROL_1 : alu_op_string = "ROL_1";
      AluOp_SLT : alu_op_string = "SLT  ";
      AluOp_SLTU : alu_op_string = "SLTU ";
      AluOp_OP2 : alu_op_string = "OP2  ";
      AluOp_ANDN : alu_op_string = "ANDN ";
      AluOp_CLZ : alu_op_string = "CLZ  ";
      AluOp_PACK : alu_op_string = "PACK ";
      default : alu_op_string = "?????";
    endcase
  end
  always @(*) begin
    case(csr_op)
      CsrOp_N : csr_op_string = "N";
      CsrOp_W : csr_op_string = "W";
      CsrOp_S : csr_op_string = "S";
      CsrOp_C : csr_op_string = "C";
      default : csr_op_string = "?";
    endcase
  end
  always @(*) begin
    case(br_type)
      BrType_F : br_type_string = "F  ";
      BrType_T : br_type_string = "T  ";
      BrType_EQ : br_type_string = "EQ ";
      BrType_NE : br_type_string = "NE ";
      BrType_LT : br_type_string = "LT ";
      BrType_GE : br_type_string = "GE ";
      BrType_LTU : br_type_string = "LTU";
      BrType_GEU : br_type_string = "GEU";
      default : br_type_string = "???";
    endcase
  end
  always @(*) begin
    case(reg_sel)
      RegSel_ALU : reg_sel_string = "ALU";
      RegSel_MEM : reg_sel_string = "MEM";
      RegSel_PC : reg_sel_string = "PC ";
      default : reg_sel_string = "???";
    endcase
  end
  `endif

  assign opcode = io_i_instr[6 : 0];
  assign funct3 = io_i_instr[14 : 12];
  assign funct7 = io_i_instr[31 : 25];
  assign rs1 = io_i_instr[19 : 15];
  assign rs2 = io_i_instr[24 : 20];
  assign rd = io_i_instr[11 : 7];
  always @(*) begin
    instr_kind = Instr_UNK;
    case(opcode)
      7'h37 : begin
        instr_kind = Instr_LUI;
      end
      7'h17 : begin
        instr_kind = Instr_AUIPC;
      end
      7'h6f : begin
        instr_kind = Instr_JAL;
      end
      7'h67 : begin
        instr_kind = Instr_JALR;
      end
      7'h63 : begin
        case(funct3)
          3'b000 : begin
            instr_kind = Instr_BEQ;
          end
          3'b001 : begin
            instr_kind = Instr_BNE;
          end
          3'b100 : begin
            instr_kind = Instr_BLT;
          end
          3'b101 : begin
            instr_kind = Instr_BGE;
          end
          3'b110 : begin
            instr_kind = Instr_BLTU;
          end
          3'b111 : begin
            instr_kind = Instr_BGEU;
          end
          default : begin
          end
        endcase
      end
      7'h03 : begin
        case(funct3)
          3'b000 : begin
            instr_kind = Instr_LB;
          end
          3'b001 : begin
            instr_kind = Instr_LH;
          end
          3'b010 : begin
            instr_kind = Instr_LW;
          end
          3'b100 : begin
            instr_kind = Instr_LBU;
          end
          3'b101 : begin
            instr_kind = Instr_LHU;
          end
          default : begin
          end
        endcase
      end
      7'h23 : begin
        case(funct3)
          3'b000 : begin
            instr_kind = Instr_SB;
          end
          3'b001 : begin
            instr_kind = Instr_SH;
          end
          3'b010 : begin
            instr_kind = Instr_SW;
          end
          default : begin
          end
        endcase
      end
      7'h13 : begin
        case(funct3)
          3'b000 : begin
            instr_kind = Instr_ADDI;
          end
          3'b010 : begin
            instr_kind = Instr_SLTI;
          end
          3'b011 : begin
            instr_kind = Instr_SLTIU;
          end
          3'b100 : begin
            instr_kind = Instr_XORI;
          end
          3'b110 : begin
            instr_kind = Instr_ORI;
          end
          3'b111 : begin
            instr_kind = Instr_ANDI;
          end
          3'b001 : begin
            casez(funct7)
              7'b00000?? : begin
                instr_kind = Instr_SLLI;
              end
              7'h30 : begin
                instr_kind = Instr_CLZ;
              end
              default : begin
              end
            endcase
          end
          default : begin
            case(funct7)
              7'h00 : begin
                instr_kind = Instr_SRLI;
              end
              7'h20 : begin
                instr_kind = Instr_SRAI;
              end
              default : begin
              end
            endcase
          end
        endcase
      end
      7'h33 : begin
        case(funct3)
          3'b000 : begin
            case(funct7)
              7'h00 : begin
                instr_kind = Instr_ADD;
              end
              7'h20 : begin
                instr_kind = Instr_SUB;
              end
              default : begin
              end
            endcase
          end
          3'b001 : begin
            instr_kind = Instr_SLL_1;
          end
          3'b010 : begin
            instr_kind = Instr_SLT;
          end
          3'b011 : begin
            instr_kind = Instr_SLTU;
          end
          3'b100 : begin
            case(funct7)
              7'h00 : begin
                instr_kind = Instr_XOR_1;
              end
              7'h04 : begin
                instr_kind = Instr_PACK;
              end
              default : begin
              end
            endcase
          end
          3'b101 : begin
            case(funct7)
              7'h00 : begin
                instr_kind = Instr_SRL_1;
              end
              7'h20 : begin
                instr_kind = Instr_SRA_1;
              end
              default : begin
              end
            endcase
          end
          3'b110 : begin
            instr_kind = Instr_OR_1;
          end
          default : begin
            case(funct7)
              7'h00 : begin
                instr_kind = Instr_AND_1;
              end
              7'h20 : begin
                instr_kind = Instr_ANDN;
              end
              default : begin
              end
            endcase
          end
        endcase
      end
      7'h73 : begin
        case(funct3)
          3'b000 : begin
            case(rs2)
              5'h00 : begin
                instr_kind = Instr_ECALL;
              end
              5'h01 : begin
                instr_kind = Instr_EBREAK;
              end
              5'h02 : begin
                instr_kind = Instr_MRET;
              end
              default : begin
              end
            endcase
          end
          3'b001 : begin
            instr_kind = Instr_CSRRW;
          end
          3'b010 : begin
            instr_kind = Instr_CSRRS;
          end
          3'b011 : begin
            instr_kind = Instr_CSRRC;
          end
          3'b101 : begin
            instr_kind = Instr_CSRRWI;
          end
          3'b110 : begin
            instr_kind = Instr_CSRRSI;
          end
          3'b111 : begin
            instr_kind = Instr_CSRRCI;
          end
          default : begin
          end
        endcase
      end
      7'h0f : begin
        instr_kind = Instr_FENCE_I;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    instr_type = InstrType_I;
    case(instr_kind)
      Instr_ADD, Instr_SUB, Instr_SLL_1, Instr_SLT, Instr_SLTU, Instr_XOR_1, Instr_SRL_1, Instr_SRA_1, Instr_OR_1, Instr_AND_1, Instr_ANDN, Instr_CLZ, Instr_PACK : begin
        instr_type = InstrType_R;
      end
      Instr_JALR, Instr_ADDI, Instr_SLTI, Instr_SLTIU, Instr_XORI, Instr_ORI, Instr_ANDI, Instr_SLLI, Instr_SRLI, Instr_SRAI, Instr_LB, Instr_LH, Instr_LW, Instr_LBU, Instr_LHU, Instr_ECALL, Instr_EBREAK, Instr_CSRRW, Instr_CSRRS, Instr_CSRRC, Instr_CSRRWI, Instr_CSRRSI, Instr_CSRRCI, Instr_MRET : begin
        instr_type = InstrType_I;
      end
      Instr_SB, Instr_SH, Instr_SW : begin
        instr_type = InstrType_S;
      end
      Instr_BEQ, Instr_BNE, Instr_BLT, Instr_BGE, Instr_BLTU, Instr_BGEU : begin
        instr_type = InstrType_B;
      end
      Instr_LUI, Instr_AUIPC : begin
        instr_type = InstrType_U;
      end
      Instr_JAL : begin
        instr_type = InstrType_J;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    case(instr_type)
      InstrType_R : begin
        imm = 32'h00000000;
      end
      InstrType_I : begin
        imm = _zz_imm;
      end
      InstrType_S : begin
        imm = _zz_imm_2;
      end
      InstrType_B : begin
        imm = _zz_imm_4;
      end
      InstrType_U : begin
        imm = _zz_imm_6;
      end
      default : begin
        imm = _zz_imm_8;
      end
    endcase
  end

  always @(*) begin
    alu_op = AluOp_ADD;
    case(instr_kind)
      Instr_CSRRW, Instr_CSRRS, Instr_CSRRC, Instr_CSRRWI, Instr_CSRRSI, Instr_CSRRCI : begin
        alu_op = AluOp_OP1;
      end
      Instr_AUIPC, Instr_JAL, Instr_JALR, Instr_BEQ, Instr_BNE, Instr_LB, Instr_LH, Instr_LW, Instr_LBU, Instr_LHU, Instr_SB, Instr_SH, Instr_SW, Instr_ADDI, Instr_ADD : begin
        alu_op = AluOp_ADD;
      end
      Instr_SUB : begin
        alu_op = AluOp_SUB;
      end
      Instr_ANDI, Instr_AND_1 : begin
        alu_op = AluOp_AND_1;
      end
      Instr_ORI, Instr_OR_1 : begin
        alu_op = AluOp_OR_1;
      end
      Instr_XORI, Instr_XOR_1 : begin
        alu_op = AluOp_XOR_1;
      end
      Instr_SLLI, Instr_SLL_1 : begin
        alu_op = AluOp_SLL_1;
      end
      Instr_SRLI, Instr_SRL_1 : begin
        alu_op = AluOp_SRL_1;
      end
      Instr_SRAI, Instr_SRA_1 : begin
        alu_op = AluOp_SRA_1;
      end
      Instr_SLTI, Instr_SLT : begin
        alu_op = AluOp_SLT;
      end
      Instr_SLTIU, Instr_SLTU : begin
        alu_op = AluOp_SLTU;
      end
      Instr_LUI : begin
        alu_op = AluOp_OP2;
      end
      Instr_ANDN : begin
        alu_op = AluOp_ANDN;
      end
      Instr_CLZ : begin
        alu_op = AluOp_CLZ;
      end
      Instr_PACK : begin
        alu_op = AluOp_PACK;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    csr_op = CsrOp_N;
    case(instr_kind)
      Instr_CSRRW, Instr_CSRRWI : begin
        csr_op = CsrOp_W;
      end
      Instr_CSRRS, Instr_CSRRSI : begin
        csr_op = CsrOp_S;
      end
      Instr_CSRRC, Instr_CSRRCI : begin
        csr_op = CsrOp_C;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    br_type = BrType_F;
    case(instr_kind)
      Instr_JAL, Instr_JALR : begin
        br_type = BrType_T;
      end
      Instr_BEQ : begin
        br_type = BrType_EQ;
      end
      Instr_BNE : begin
        br_type = BrType_NE;
      end
      Instr_BLT : begin
        br_type = BrType_LT;
      end
      Instr_BGE : begin
        br_type = BrType_GE;
      end
      Instr_BLTU : begin
        br_type = BrType_LTU;
      end
      Instr_BGEU : begin
        br_type = BrType_GEU;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    use_pc = 1'b0;
    case(instr_kind)
      Instr_AUIPC, Instr_JAL, Instr_BEQ, Instr_BNE, Instr_BLT, Instr_BGE, Instr_BLTU, Instr_BGEU : begin
        use_pc = 1'b1;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    use_uimm = 1'b0;
    case(instr_kind)
      Instr_CSRRSI, Instr_CSRRWI, Instr_CSRRCI : begin
        use_uimm = 1'b1;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    use_rs2 = 1'b0;
    case(instr_kind)
      Instr_ADD, Instr_SUB, Instr_SLL_1, Instr_SLT, Instr_SLTU, Instr_XOR_1, Instr_SRL_1, Instr_SRA_1, Instr_OR_1, Instr_AND_1, Instr_ANDN, Instr_PACK : begin
        use_rs2 = 1'b1;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    mem_en = 1'b0;
    case(instr_kind)
      Instr_LB, Instr_LH, Instr_LW, Instr_LBU, Instr_LHU, Instr_SB, Instr_SH, Instr_SW : begin
        mem_en = 1'b1;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    mem_we = 1'b0;
    case(instr_kind)
      Instr_SB, Instr_SH, Instr_SW : begin
        mem_we = 1'b1;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    mem_sel = 4'b0000;
    case(instr_kind)
      Instr_LB, Instr_LBU, Instr_SB : begin
        mem_sel = 4'b0001;
      end
      Instr_LH, Instr_LHU, Instr_SH : begin
        mem_sel = 4'b0011;
      end
      Instr_LW, Instr_SW : begin
        mem_sel = 4'b1111;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    mem_unsigned = 1'b0;
    case(instr_kind)
      Instr_LBU, Instr_LHU : begin
        mem_unsigned = 1'b1;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    reg_we = 1'b0;
    case(instr_kind)
      Instr_LUI, Instr_AUIPC, Instr_JAL, Instr_JALR, Instr_LB, Instr_LH, Instr_LW, Instr_LBU, Instr_LHU, Instr_ADDI, Instr_SLTI, Instr_SLTIU, Instr_XORI, Instr_ORI, Instr_ANDI, Instr_SLLI, Instr_SRLI, Instr_SRAI, Instr_ADD, Instr_SUB, Instr_SLL_1, Instr_SLT, Instr_SLTU, Instr_XOR_1, Instr_SRL_1, Instr_SRA_1, Instr_OR_1, Instr_AND_1, Instr_CSRRW, Instr_CSRRS, Instr_CSRRC, Instr_CSRRWI, Instr_CSRRSI, Instr_CSRRCI, Instr_ANDN, Instr_CLZ, Instr_PACK : begin
        reg_we = 1'b1;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    reg_sel = RegSel_ALU;
    case(instr_kind)
      Instr_LB, Instr_LH, Instr_LW, Instr_LBU, Instr_LHU : begin
        reg_sel = RegSel_MEM;
      end
      Instr_JAL, Instr_JALR : begin
        reg_sel = RegSel_PC;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    io_trap = io_o_trap_trap;
    if(!io_stall) begin
      if(io_bubble) begin
        io_trap = 1'b0;
      end else begin
        if(io_i_trap_trap) begin
          io_trap = 1'b1;
        end else begin
          if(when_ID_l792) begin
            io_trap = 1'b1;
          end else begin
            if(when_ID_l796) begin
              io_trap = 1'b1;
            end else begin
              if(when_ID_l800) begin
                io_trap = 1'b1;
              end
            end
          end
        end
      end
    end
  end

  assign io_reg_addr_a = rs1;
  assign io_reg_addr_b = rs2;
  assign when_ID_l792 = (instr_kind == Instr_EBREAK);
  assign when_ID_l796 = (instr_kind == Instr_ECALL);
  assign when_ID_l800 = (instr_kind == Instr_MRET);
  always @(posedge sys_clk or posedge sys_reset) begin
    if(sys_reset) begin
      io_o_real <= 1'b0;
      io_o_pc <= 32'h00000000;
      io_o_reg_data_a <= 32'h00000000;
      io_o_reg_data_b <= 32'h00000000;
      io_o_reg_addr_a <= 5'h00;
      io_o_reg_addr_b <= 5'h00;
      io_o_reg_addr_d <= 5'h00;
      io_o_alu_op <= AluOp_ADD;
      io_o_csr_op <= CsrOp_N;
      io_o_br_type <= BrType_F;
      io_o_imm <= 32'h00000000;
      io_o_use_pc <= 1'b0;
      io_o_use_uimm <= 1'b0;
      io_o_use_rs2 <= 1'b0;
      io_o_mem_en <= 1'b0;
      io_o_mem_we <= 1'b0;
      io_o_mem_sel <= 4'b0000;
      io_o_mem_unsigned <= 1'b0;
      io_o_reg_we <= 1'b0;
      io_o_reg_sel <= RegSel_ALU;
      io_o_trap_trap <= 1'b0;
      io_o_trap_epc <= 32'h00000000;
      io_o_trap_cause <= 32'h00000000;
    end else begin
      io_o_trap_trap <= io_trap;
      if(!io_stall) begin
        if(io_bubble) begin
          io_o_real <= 1'b0;
          io_o_pc <= 32'h00000000;
          io_o_csr_op <= CsrOp_N;
          io_o_br_type <= BrType_F;
          io_o_mem_en <= 1'b0;
          io_o_reg_we <= 1'b0;
          io_o_trap_epc <= 32'h00000000;
          io_o_trap_cause <= 32'h00000000;
        end else begin
          if(io_i_trap_trap) begin
            io_o_trap_epc <= io_i_trap_epc;
            io_o_trap_cause <= io_i_trap_cause;
          end else begin
            if(when_ID_l792) begin
              io_o_trap_epc <= io_i_pc;
              io_o_trap_cause <= 32'h00000003;
            end else begin
              if(when_ID_l796) begin
                io_o_trap_epc <= io_i_pc;
                io_o_trap_cause <= 32'h00000008;
              end else begin
                if(when_ID_l800) begin
                  io_o_trap_epc <= io_i_pc;
                  io_o_trap_cause <= 32'h00000018;
                end else begin
                  io_o_real <= io_i_real;
                  io_o_pc <= io_i_pc;
                  io_o_reg_data_a <= io_reg_data_a;
                  io_o_reg_data_b <= io_reg_data_b;
                  io_o_reg_addr_a <= rs1;
                  io_o_reg_addr_b <= rs2;
                  io_o_reg_addr_d <= rd;
                  io_o_alu_op <= alu_op;
                  io_o_csr_op <= csr_op;
                  io_o_br_type <= br_type;
                  io_o_imm <= imm;
                  io_o_use_pc <= use_pc;
                  io_o_use_uimm <= use_uimm;
                  io_o_use_rs2 <= use_rs2;
                  io_o_mem_en <= mem_en;
                  io_o_mem_we <= mem_we;
                  io_o_mem_sel <= mem_sel;
                  io_o_mem_unsigned <= mem_unsigned;
                  io_o_reg_we <= reg_we;
                  io_o_reg_sel <= reg_sel;
                end
              end
            end
          end
        end
      end
    end
  end


endmodule

module IF_1 (
  output reg           io_o_real,
  output reg  [31:0]   io_o_pc,
  output reg  [31:0]   io_o_instr,
  output reg           io_o_trap_trap,
  output reg  [31:0]   io_o_trap_epc,
  output reg  [31:0]   io_o_trap_cause,
  input  wire          io_br_br,
  input  wire [31:0]   io_br_pc,
  input  wire          io_stall,
  input  wire          io_bubble,
  output reg           io_trap,
  input  wire [31:0]   io_mie,
  input  wire [31:0]   io_mip,
  output wire          io_wb_cyc,
  output reg           io_wb_stb,
  input  wire          io_wb_ack,
  output reg           io_wb_we,
  output reg  [31:0]   io_wb_adr,
  input  wire [31:0]   io_wb_dat_r,
  output wire [31:0]   io_wb_dat_w,
  output reg  [3:0]    io_wb_sel,
  input  wire          sys_clk,
  input  wire          sys_reset
);
  localparam fsm_enumDef_BOOT = 2'd0;
  localparam fsm_enumDef_start = 2'd1;
  localparam fsm_enumDef_fetch = 2'd2;

  reg        [31:0]   pc;
  reg                 delay_br;
  reg                 delay_ack;
  reg        [31:0]   delay_instr;
  wire       [31:0]   interrupt;
  wire                fsm_wantExit;
  reg                 fsm_wantStart;
  wire                fsm_wantKill;
  reg        [1:0]    fsm_stateReg;
  reg        [1:0]    fsm_stateNext;
  wire                _zz_when_StateMachine_l237;
  wire                _zz_when_StateMachine_l237_1;
  wire                when_IF_l108;
  wire                when_IF_l126;
  wire                when_IF_l69;
  wire                when_IF_l73;
  wire                when_IF_l137;
  wire                when_StateMachine_l237;
  wire                when_StateMachine_l253;
  `ifndef SYNTHESIS
  reg [39:0] fsm_stateReg_string;
  reg [39:0] fsm_stateNext_string;
  `endif


  `ifndef SYNTHESIS
  always @(*) begin
    case(fsm_stateReg)
      fsm_enumDef_BOOT : fsm_stateReg_string = "BOOT ";
      fsm_enumDef_start : fsm_stateReg_string = "start";
      fsm_enumDef_fetch : fsm_stateReg_string = "fetch";
      default : fsm_stateReg_string = "?????";
    endcase
  end
  always @(*) begin
    case(fsm_stateNext)
      fsm_enumDef_BOOT : fsm_stateNext_string = "BOOT ";
      fsm_enumDef_start : fsm_stateNext_string = "start";
      fsm_enumDef_fetch : fsm_stateNext_string = "fetch";
      default : fsm_stateNext_string = "?????";
    endcase
  end
  `endif

  assign interrupt = (io_mie & io_mip);
  always @(*) begin
    io_trap = io_o_trap_trap;
    case(fsm_stateReg)
      fsm_enumDef_start : begin
        if(!io_stall) begin
          if(io_bubble) begin
            io_trap = 1'b0;
          end else begin
            io_trap = 1'b0;
          end
        end
      end
      fsm_enumDef_fetch : begin
        io_trap = 1'b0;
        if(when_IF_l126) begin
          if(!io_stall) begin
            if(!when_IF_l137) begin
              if(when_IF_l69) begin
                io_trap = 1'b1;
              end else begin
                io_trap = 1'b0;
              end
            end
          end
        end
      end
      default : begin
      end
    endcase
  end

  assign io_wb_cyc = io_wb_stb;
  assign fsm_wantExit = 1'b0;
  always @(*) begin
    fsm_wantStart = 1'b0;
    case(fsm_stateReg)
      fsm_enumDef_start : begin
      end
      fsm_enumDef_fetch : begin
      end
      default : begin
        fsm_wantStart = 1'b1;
      end
    endcase
  end

  assign fsm_wantKill = 1'b0;
  always @(*) begin
    io_wb_we = 1'b0;
    case(fsm_stateReg)
      fsm_enumDef_start : begin
      end
      fsm_enumDef_fetch : begin
        io_wb_we = 1'b0;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    io_wb_adr = 32'h00000000;
    case(fsm_stateReg)
      fsm_enumDef_start : begin
      end
      fsm_enumDef_fetch : begin
        io_wb_adr = pc;
      end
      default : begin
      end
    endcase
  end

  assign io_wb_dat_w = 32'h00000000;
  always @(*) begin
    io_wb_sel = 4'b0000;
    case(fsm_stateReg)
      fsm_enumDef_start : begin
      end
      fsm_enumDef_fetch : begin
        io_wb_sel = 4'b1111;
      end
      default : begin
      end
    endcase
  end

  assign _zz_when_StateMachine_l237 = (fsm_stateReg == fsm_enumDef_fetch);
  assign _zz_when_StateMachine_l237_1 = (fsm_stateNext == fsm_enumDef_fetch);
  always @(*) begin
    fsm_stateNext = fsm_stateReg;
    case(fsm_stateReg)
      fsm_enumDef_start : begin
        if(!io_stall) begin
          if(!io_bubble) begin
            fsm_stateNext = fsm_enumDef_fetch;
          end
        end
      end
      fsm_enumDef_fetch : begin
        if(when_IF_l126) begin
          if(!io_stall) begin
            if(when_IF_l137) begin
              fsm_stateNext = fsm_enumDef_start;
            end else begin
              fsm_stateNext = fsm_enumDef_start;
            end
          end
        end
      end
      default : begin
      end
    endcase
    if(fsm_wantStart) begin
      fsm_stateNext = fsm_enumDef_start;
    end
    if(fsm_wantKill) begin
      fsm_stateNext = fsm_enumDef_BOOT;
    end
  end

  assign when_IF_l108 = (io_br_br || delay_br);
  assign when_IF_l126 = (io_wb_ack || delay_ack);
  assign when_IF_l69 = (interrupt != 32'h00000000);
  assign when_IF_l73 = interrupt[7];
  assign when_IF_l137 = (io_br_br || delay_br);
  assign when_StateMachine_l237 = (_zz_when_StateMachine_l237 && (! _zz_when_StateMachine_l237_1));
  assign when_StateMachine_l253 = ((! _zz_when_StateMachine_l237) && _zz_when_StateMachine_l237_1);
  always @(posedge sys_clk or posedge sys_reset) begin
    if(sys_reset) begin
      pc <= 32'h80000000;
      delay_br <= 1'b0;
      delay_ack <= 1'b0;
      delay_instr <= 32'h00000013;
      io_o_real <= 1'b0;
      io_o_pc <= 32'h80000000;
      io_o_instr <= 32'h00000013;
      io_o_trap_trap <= 1'b0;
      io_o_trap_epc <= 32'h00000000;
      io_o_trap_cause <= 32'h00000000;
      io_wb_stb <= 1'b0;
      fsm_stateReg <= fsm_enumDef_BOOT;
    end else begin
      io_o_trap_trap <= io_trap;
      if(io_br_br) begin
        delay_br <= 1'b1;
        pc <= io_br_pc;
      end
      fsm_stateReg <= fsm_stateNext;
      case(fsm_stateReg)
        fsm_enumDef_start : begin
          if(!io_stall) begin
            if(io_bubble) begin
              io_o_real <= 1'b0;
              io_o_pc <= 32'h00000000;
              io_o_instr <= 32'h00000013;
              io_o_trap_epc <= 32'h00000000;
              io_o_trap_cause <= 32'h00000000;
            end else begin
              io_o_real <= 1'b0;
              io_o_pc <= 32'h00000000;
              io_o_instr <= 32'h00000013;
              io_o_trap_epc <= 32'h00000000;
              io_o_trap_cause <= 32'h00000000;
              if(when_IF_l108) begin
                delay_br <= 1'b0;
              end
            end
          end
        end
        fsm_enumDef_fetch : begin
          io_o_real <= 1'b0;
          io_o_pc <= 32'h00000000;
          io_o_instr <= 32'h00000013;
          io_o_trap_epc <= 32'h00000000;
          io_o_trap_cause <= 32'h00000000;
          if(when_IF_l126) begin
            delay_ack <= 1'b0;
            if(io_stall) begin
              delay_ack <= 1'b1;
              if(io_wb_ack) begin
                io_wb_stb <= 1'b0;
                delay_instr <= io_wb_dat_r;
              end
            end else begin
              if(when_IF_l137) begin
                delay_br <= 1'b0;
              end else begin
                if(when_IF_l69) begin
                  io_o_trap_epc <= pc;
                  if(when_IF_l73) begin
                    io_o_trap_cause <= 32'h80000007;
                  end else begin
                    io_o_trap_cause <= 32'h80000010;
                  end
                end else begin
                  io_o_real <= 1'b1;
                  io_o_pc <= pc;
                  io_o_instr <= (delay_ack ? delay_instr : io_wb_dat_r);
                  pc <= (pc + 32'h00000004);
                end
              end
            end
          end
        end
        default : begin
        end
      endcase
      if(when_StateMachine_l237) begin
        io_wb_stb <= 1'b0;
      end
      if(when_StateMachine_l253) begin
        io_wb_stb <= 1'b1;
      end
    end
  end


endmodule

module Trap (
  input  wire          io_trap_0,
  input  wire          io_trap_1,
  input  wire          io_trap_2,
  output reg           io_flush_req_0,
  output reg           io_flush_req_1,
  output reg           io_flush_req_2,
  input  wire          io_commit_trap,
  input  wire [31:0]   io_commit_epc,
  input  wire [31:0]   io_commit_cause,
  output reg           io_br_br,
  output reg  [31:0]   io_br_pc,
  input  wire [31:0]   io_mstatus_r,
  output reg  [31:0]   io_mstatus_w,
  output reg           io_mstatus_we,
  input  wire [31:0]   io_mtvec_r,
  output wire [31:0]   io_mtvec_w,
  output wire          io_mtvec_we,
  input  wire [31:0]   io_mepc_r,
  output reg  [31:0]   io_mepc_w,
  output reg           io_mepc_we,
  input  wire [31:0]   io_mcause_r,
  output reg  [31:0]   io_mcause_w,
  output reg           io_mcause_we,
  output reg  [1:0]    io_prv,
  input  wire          sys_clk,
  input  wire          sys_reset
);
  localparam PrivilegeMode_U = 2'd0;
  localparam PrivilegeMode_S = 2'd1;
  localparam PrivilegeMode_M = 2'd3;

  wire       [31:0]   _zz_io_br_pc;
  wire       [33:0]   _zz_io_br_pc_1;
  wire                cause_interrupt;
  wire       [30:0]   cause_exception_code;
  wire       [1:0]    mstatus_mpp;
  wire       [1:0]    _zz_mstatus_mpp;
  wire       [1:0]    mtvec_mode;
  wire       [31:0]   mtvec_base;
  wire       [31:0]   mepc_mepc;
  wire                when_Trap_l110;
  `ifndef SYNTHESIS
  reg [7:0] io_prv_string;
  reg [7:0] mstatus_mpp_string;
  reg [7:0] _zz_mstatus_mpp_string;
  `endif


  assign _zz_io_br_pc_1 = (cause_exception_code * 3'b100);
  assign _zz_io_br_pc = _zz_io_br_pc_1[31:0];
  `ifndef SYNTHESIS
  always @(*) begin
    case(io_prv)
      PrivilegeMode_U : io_prv_string = "U";
      PrivilegeMode_S : io_prv_string = "S";
      PrivilegeMode_M : io_prv_string = "M";
      default : io_prv_string = "?";
    endcase
  end
  always @(*) begin
    case(mstatus_mpp)
      PrivilegeMode_U : mstatus_mpp_string = "U";
      PrivilegeMode_S : mstatus_mpp_string = "S";
      PrivilegeMode_M : mstatus_mpp_string = "M";
      default : mstatus_mpp_string = "?";
    endcase
  end
  always @(*) begin
    case(_zz_mstatus_mpp)
      PrivilegeMode_U : _zz_mstatus_mpp_string = "U";
      PrivilegeMode_S : _zz_mstatus_mpp_string = "S";
      PrivilegeMode_M : _zz_mstatus_mpp_string = "M";
      default : _zz_mstatus_mpp_string = "?";
    endcase
  end
  `endif

  assign cause_interrupt = io_commit_cause[31];
  assign cause_exception_code = io_commit_cause[30 : 0];
  always @(*) begin
    io_mstatus_we = 1'b0;
    if(io_commit_trap) begin
      if(when_Trap_l110) begin
        io_mstatus_we = 1'b1;
      end else begin
        io_mstatus_we = 1'b1;
      end
    end
  end

  always @(*) begin
    io_mstatus_w = 32'h00000000;
    if(io_commit_trap) begin
      if(when_Trap_l110) begin
        io_mstatus_w[12 : 11] = PrivilegeMode_U;
      end else begin
        io_mstatus_w[12 : 11] = io_prv;
      end
    end
  end

  assign _zz_mstatus_mpp = io_mstatus_r[12 : 11];
  assign mstatus_mpp = _zz_mstatus_mpp;
  assign io_mtvec_we = 1'b0;
  assign io_mtvec_w = 32'h00000000;
  assign mtvec_mode = io_mtvec_r[1 : 0];
  assign mtvec_base = {io_mtvec_r[31 : 2],2'b00};
  always @(*) begin
    io_mepc_we = 1'b0;
    if(io_commit_trap) begin
      if(!when_Trap_l110) begin
        io_mepc_we = 1'b1;
      end
    end
  end

  always @(*) begin
    io_mepc_w = 32'h00000000;
    if(io_commit_trap) begin
      if(!when_Trap_l110) begin
        io_mepc_w = io_commit_epc;
      end
    end
  end

  assign mepc_mepc = io_mepc_r;
  always @(*) begin
    io_mcause_we = 1'b0;
    if(io_commit_trap) begin
      if(!when_Trap_l110) begin
        io_mcause_we = 1'b1;
      end
    end
  end

  always @(*) begin
    io_mcause_w = 32'h00000000;
    if(io_commit_trap) begin
      if(!when_Trap_l110) begin
        io_mcause_w = io_commit_cause;
      end
    end
  end

  always @(*) begin
    io_br_br = 1'b0;
    if(io_commit_trap) begin
      io_br_br = 1'b1;
    end
  end

  always @(*) begin
    io_br_pc = 32'h00000000;
    if(io_commit_trap) begin
      if(when_Trap_l110) begin
        io_br_pc = mepc_mepc;
      end else begin
        case(mtvec_mode)
          2'b00 : begin
            io_br_pc = mtvec_base;
          end
          2'b01 : begin
            if(cause_interrupt) begin
              io_br_pc = (mtvec_base + _zz_io_br_pc);
            end else begin
              io_br_pc = mtvec_base;
            end
          end
          default : begin
          end
        endcase
      end
    end
  end

  always @(*) begin
    io_flush_req_0 = 1'b0;
    if(io_trap_0) begin
      io_flush_req_0 = 1'b1;
    end
    if(io_trap_1) begin
      io_flush_req_0 = 1'b1;
    end
    if(io_trap_2) begin
      io_flush_req_0 = 1'b1;
    end
    if(io_commit_trap) begin
      io_flush_req_0 = 1'b1;
    end
  end

  always @(*) begin
    io_flush_req_1 = 1'b0;
    if(io_trap_1) begin
      io_flush_req_1 = 1'b1;
    end
    if(io_trap_2) begin
      io_flush_req_1 = 1'b1;
    end
    if(io_commit_trap) begin
      io_flush_req_1 = 1'b1;
    end
  end

  always @(*) begin
    io_flush_req_2 = 1'b0;
    if(io_trap_2) begin
      io_flush_req_2 = 1'b1;
    end
    if(io_commit_trap) begin
      io_flush_req_2 = 1'b1;
    end
  end

  assign when_Trap_l110 = (io_commit_cause == 32'h00000018);
  always @(posedge sys_clk or posedge sys_reset) begin
    if(sys_reset) begin
      io_prv <= PrivilegeMode_M;
    end else begin
      if(io_commit_trap) begin
        if(when_Trap_l110) begin
          io_prv <= mstatus_mpp;
        end else begin
          io_prv <= PrivilegeMode_M;
        end
      end
    end
  end


endmodule

module CsrFile (
  input  wire [11:0]   io_csr_addr,
  output reg  [31:0]   io_csr_r,
  input  wire [31:0]   io_csr_w,
  input  wire          io_csr_we,
  output wire [31:0]   io_mstatus_r,
  input  wire [31:0]   io_mstatus_w,
  input  wire          io_mstatus_we,
  output wire [31:0]   io_mie_r,
  input  wire [31:0]   io_mie_w,
  input  wire          io_mie_we,
  output wire [31:0]   io_mtvec_r,
  input  wire [31:0]   io_mtvec_w,
  input  wire          io_mtvec_we,
  output wire [31:0]   io_mscratch_r,
  input  wire [31:0]   io_mscratch_w,
  input  wire          io_mscratch_we,
  output wire [31:0]   io_mepc_r,
  input  wire [31:0]   io_mepc_w,
  input  wire          io_mepc_we,
  output wire [31:0]   io_mcause_r,
  input  wire [31:0]   io_mcause_w,
  input  wire          io_mcause_we,
  output wire [31:0]   io_mip_r,
  input  wire [31:0]   io_mip_w,
  input  wire          io_mip_we,
  input  wire          sys_clk,
  input  wire          sys_reset
);

  reg        [31:0]   mstatus_1_io_w;
  reg                 mstatus_1_io_we;
  reg        [31:0]   mie_1_io_w;
  reg                 mie_1_io_we;
  reg        [31:0]   mtvec_1_io_w;
  reg                 mtvec_1_io_we;
  reg        [31:0]   mscratch_1_io_w;
  reg                 mscratch_1_io_we;
  reg        [31:0]   mepc_1_io_w;
  reg                 mepc_1_io_we;
  reg        [31:0]   mcause_1_io_w;
  reg                 mcause_1_io_we;
  reg        [31:0]   mip_1_io_w;
  reg                 mip_1_io_we;
  wire       [31:0]   mstatus_1_io_r;
  wire       [31:0]   mie_1_io_r;
  wire       [31:0]   mtvec_1_io_r;
  wire       [31:0]   mscratch_1_io_r;
  wire       [31:0]   mepc_1_io_r;
  wire       [31:0]   mcause_1_io_r;
  wire       [31:0]   mip_1_io_r;
  wire                when_Csr_l68;
  wire                when_Csr_l68_1;
  wire                when_Csr_l68_2;
  wire                when_Csr_l68_3;
  wire                when_Csr_l68_4;
  wire                when_Csr_l68_5;
  wire                when_Csr_l68_6;

  Mstatus mstatus_1 (
    .io_r      (mstatus_1_io_r[31:0]), //o
    .io_w      (mstatus_1_io_w[31:0]), //i
    .io_we     (mstatus_1_io_we     ), //i
    .sys_clk   (sys_clk             ), //i
    .sys_reset (sys_reset           )  //i
  );
  Mie mie_1 (
    .io_r      (mie_1_io_r[31:0]), //o
    .io_w      (mie_1_io_w[31:0]), //i
    .io_we     (mie_1_io_we     ), //i
    .sys_clk   (sys_clk         ), //i
    .sys_reset (sys_reset       )  //i
  );
  Mtvec mtvec_1 (
    .io_r      (mtvec_1_io_r[31:0]), //o
    .io_w      (mtvec_1_io_w[31:0]), //i
    .io_we     (mtvec_1_io_we     ), //i
    .sys_clk   (sys_clk           ), //i
    .sys_reset (sys_reset         )  //i
  );
  Mscratch mscratch_1 (
    .io_r      (mscratch_1_io_r[31:0]), //o
    .io_w      (mscratch_1_io_w[31:0]), //i
    .io_we     (mscratch_1_io_we     ), //i
    .sys_clk   (sys_clk              ), //i
    .sys_reset (sys_reset            )  //i
  );
  Mepc mepc_1 (
    .io_r      (mepc_1_io_r[31:0]), //o
    .io_w      (mepc_1_io_w[31:0]), //i
    .io_we     (mepc_1_io_we     ), //i
    .sys_clk   (sys_clk          ), //i
    .sys_reset (sys_reset        )  //i
  );
  Mcause mcause_1 (
    .io_r      (mcause_1_io_r[31:0]), //o
    .io_w      (mcause_1_io_w[31:0]), //i
    .io_we     (mcause_1_io_we     ), //i
    .sys_clk   (sys_clk            ), //i
    .sys_reset (sys_reset          )  //i
  );
  Mip mip_1 (
    .io_r      (mip_1_io_r[31:0]), //o
    .io_w      (mip_1_io_w[31:0]), //i
    .io_we     (mip_1_io_we     ), //i
    .sys_clk   (sys_clk         ), //i
    .sys_reset (sys_reset       )  //i
  );
  always @(*) begin
    io_csr_r = 32'h00000000;
    if(!io_mstatus_we) begin
      if(when_Csr_l68) begin
        io_csr_r = mstatus_1_io_r;
      end
    end
    if(!io_mie_we) begin
      if(when_Csr_l68_1) begin
        io_csr_r = mie_1_io_r;
      end
    end
    if(!io_mtvec_we) begin
      if(when_Csr_l68_2) begin
        io_csr_r = mtvec_1_io_r;
      end
    end
    if(!io_mscratch_we) begin
      if(when_Csr_l68_3) begin
        io_csr_r = mscratch_1_io_r;
      end
    end
    if(!io_mepc_we) begin
      if(when_Csr_l68_4) begin
        io_csr_r = mepc_1_io_r;
      end
    end
    if(!io_mcause_we) begin
      if(when_Csr_l68_5) begin
        io_csr_r = mcause_1_io_r;
      end
    end
    if(!io_mip_we) begin
      if(when_Csr_l68_6) begin
        io_csr_r = mip_1_io_r;
      end
    end
  end

  assign io_mstatus_r = mstatus_1_io_r;
  always @(*) begin
    if(io_mstatus_we) begin
      mstatus_1_io_we = 1'b1;
    end else begin
      if(when_Csr_l68) begin
        mstatus_1_io_we = io_csr_we;
      end else begin
        mstatus_1_io_we = 1'b0;
      end
    end
  end

  always @(*) begin
    if(io_mstatus_we) begin
      mstatus_1_io_w = io_mstatus_w;
    end else begin
      if(when_Csr_l68) begin
        mstatus_1_io_w = io_csr_w;
      end else begin
        mstatus_1_io_w = 32'h00000000;
      end
    end
  end

  assign when_Csr_l68 = (io_csr_addr == 12'h300);
  assign io_mie_r = mie_1_io_r;
  always @(*) begin
    if(io_mie_we) begin
      mie_1_io_we = 1'b1;
    end else begin
      if(when_Csr_l68_1) begin
        mie_1_io_we = io_csr_we;
      end else begin
        mie_1_io_we = 1'b0;
      end
    end
  end

  always @(*) begin
    if(io_mie_we) begin
      mie_1_io_w = io_mie_w;
    end else begin
      if(when_Csr_l68_1) begin
        mie_1_io_w = io_csr_w;
      end else begin
        mie_1_io_w = 32'h00000000;
      end
    end
  end

  assign when_Csr_l68_1 = (io_csr_addr == 12'h304);
  assign io_mtvec_r = mtvec_1_io_r;
  always @(*) begin
    if(io_mtvec_we) begin
      mtvec_1_io_we = 1'b1;
    end else begin
      if(when_Csr_l68_2) begin
        mtvec_1_io_we = io_csr_we;
      end else begin
        mtvec_1_io_we = 1'b0;
      end
    end
  end

  always @(*) begin
    if(io_mtvec_we) begin
      mtvec_1_io_w = io_mtvec_w;
    end else begin
      if(when_Csr_l68_2) begin
        mtvec_1_io_w = io_csr_w;
      end else begin
        mtvec_1_io_w = 32'h00000000;
      end
    end
  end

  assign when_Csr_l68_2 = (io_csr_addr == 12'h305);
  assign io_mscratch_r = mscratch_1_io_r;
  always @(*) begin
    if(io_mscratch_we) begin
      mscratch_1_io_we = 1'b1;
    end else begin
      if(when_Csr_l68_3) begin
        mscratch_1_io_we = io_csr_we;
      end else begin
        mscratch_1_io_we = 1'b0;
      end
    end
  end

  always @(*) begin
    if(io_mscratch_we) begin
      mscratch_1_io_w = io_mscratch_w;
    end else begin
      if(when_Csr_l68_3) begin
        mscratch_1_io_w = io_csr_w;
      end else begin
        mscratch_1_io_w = 32'h00000000;
      end
    end
  end

  assign when_Csr_l68_3 = (io_csr_addr == 12'h340);
  assign io_mepc_r = mepc_1_io_r;
  always @(*) begin
    if(io_mepc_we) begin
      mepc_1_io_we = 1'b1;
    end else begin
      if(when_Csr_l68_4) begin
        mepc_1_io_we = io_csr_we;
      end else begin
        mepc_1_io_we = 1'b0;
      end
    end
  end

  always @(*) begin
    if(io_mepc_we) begin
      mepc_1_io_w = io_mepc_w;
    end else begin
      if(when_Csr_l68_4) begin
        mepc_1_io_w = io_csr_w;
      end else begin
        mepc_1_io_w = 32'h00000000;
      end
    end
  end

  assign when_Csr_l68_4 = (io_csr_addr == 12'h341);
  assign io_mcause_r = mcause_1_io_r;
  always @(*) begin
    if(io_mcause_we) begin
      mcause_1_io_we = 1'b1;
    end else begin
      if(when_Csr_l68_5) begin
        mcause_1_io_we = io_csr_we;
      end else begin
        mcause_1_io_we = 1'b0;
      end
    end
  end

  always @(*) begin
    if(io_mcause_we) begin
      mcause_1_io_w = io_mcause_w;
    end else begin
      if(when_Csr_l68_5) begin
        mcause_1_io_w = io_csr_w;
      end else begin
        mcause_1_io_w = 32'h00000000;
      end
    end
  end

  assign when_Csr_l68_5 = (io_csr_addr == 12'h342);
  assign io_mip_r = mip_1_io_r;
  always @(*) begin
    if(io_mip_we) begin
      mip_1_io_we = 1'b1;
    end else begin
      if(when_Csr_l68_6) begin
        mip_1_io_we = io_csr_we;
      end else begin
        mip_1_io_we = 1'b0;
      end
    end
  end

  always @(*) begin
    if(io_mip_we) begin
      mip_1_io_w = io_mip_w;
    end else begin
      if(when_Csr_l68_6) begin
        mip_1_io_w = io_csr_w;
      end else begin
        mip_1_io_w = 32'h00000000;
      end
    end
  end

  assign when_Csr_l68_6 = (io_csr_addr == 12'h344);

endmodule

module Alu (
  input  wire [31:0]   io_a,
  input  wire [31:0]   io_b,
  input  wire [4:0]    io_op,
  output reg  [31:0]   io_y
);
  localparam AluOp_OP1 = 5'd0;
  localparam AluOp_ADD = 5'd1;
  localparam AluOp_SUB = 5'd2;
  localparam AluOp_AND_1 = 5'd3;
  localparam AluOp_OR_1 = 5'd4;
  localparam AluOp_XOR_1 = 5'd5;
  localparam AluOp_NOT_1 = 5'd6;
  localparam AluOp_SLL_1 = 5'd7;
  localparam AluOp_SRL_1 = 5'd8;
  localparam AluOp_SRA_1 = 5'd9;
  localparam AluOp_ROL_1 = 5'd10;
  localparam AluOp_SLT = 5'd11;
  localparam AluOp_SLTU = 5'd12;
  localparam AluOp_OP2 = 5'd13;
  localparam AluOp_ANDN = 5'd14;
  localparam AluOp_CLZ = 5'd15;
  localparam AluOp_PACK = 5'd16;

  wire       [31:0]   _zz_io_y_7;
  wire       [31:0]   _zz_io_y_8;
  wire       [31:0]   _zz_io_y_9;
  wire       [0:0]    _zz_io_y_10;
  wire       [0:0]    _zz_io_y_11;
  wire                _zz__zz_io_y_6;
  wire       [0:0]    _zz__zz_io_y_6_1;
  wire       [20:0]   _zz__zz_io_y_6_2;
  wire                _zz__zz_io_y_6_3;
  wire       [0:0]    _zz__zz_io_y_6_4;
  wire       [9:0]    _zz__zz_io_y_6_5;
  wire                _zz_io_y_12;
  wire       [31:0]   _zz_io_y_13;
  wire       [31:0]   _zz_io_y_14;
  wire                _zz_io_y_15;
  wire       [31:0]   _zz_io_y_16;
  wire       [31:0]   _zz_io_y_17;
  wire                _zz_io_y_18;
  wire       [31:0]   _zz_io_y_19;
  wire       [31:0]   _zz_io_y_20;
  wire       [31:0]   s_a;
  wire       [31:0]   s_b;
  wire       [31:0]   u_a;
  wire       [31:0]   u_b;
  wire       [4:0]    shamt;
  reg        [31:0]   _zz_io_y;
  reg        [31:0]   _zz_io_y_1;
  reg        [31:0]   _zz_io_y_2;
  reg        [31:0]   _zz_io_y_3;
  reg        [31:0]   _zz_io_y_4;
  wire       [31:0]   _zz_io_y_5;
  wire       [31:0]   _zz_io_y_6;
  `ifndef SYNTHESIS
  reg [39:0] io_op_string;
  `endif


  assign _zz_io_y_7 = ($signed(s_a) + $signed(s_b));
  assign _zz_io_y_8 = ($signed(s_a) - $signed(s_b));
  assign _zz_io_y_9 = ($signed(s_a) >>> shamt);
  assign _zz_io_y_10 = ($signed(s_a) < $signed(s_b));
  assign _zz_io_y_11 = (u_a < u_b);
  assign _zz__zz_io_y_6 = io_a[9];
  assign _zz__zz_io_y_6_1 = io_a[10];
  assign _zz__zz_io_y_6_2 = {io_a[11],{io_a[12],{io_a[13],{io_a[14],{io_a[15],{io_a[16],{io_a[17],{io_a[18],{io_a[19],{_zz__zz_io_y_6_3,{_zz__zz_io_y_6_4,_zz__zz_io_y_6_5}}}}}}}}}}};
  assign _zz__zz_io_y_6_3 = io_a[20];
  assign _zz__zz_io_y_6_4 = io_a[21];
  assign _zz__zz_io_y_6_5 = {io_a[22],{io_a[23],{io_a[24],{io_a[25],{io_a[26],{io_a[27],{io_a[28],{io_a[29],{io_a[30],io_a[31]}}}}}}}}};
  assign _zz_io_y_12 = _zz_io_y_6[8];
  assign _zz_io_y_13 = 32'h00000008;
  assign _zz_io_y_14 = (_zz_io_y_6[9] ? 32'h00000009 : (_zz_io_y_6[10] ? 32'h0000000a : (_zz_io_y_6[11] ? 32'h0000000b : (_zz_io_y_6[12] ? 32'h0000000c : (_zz_io_y_6[13] ? 32'h0000000d : (_zz_io_y_6[14] ? 32'h0000000e : (_zz_io_y_6[15] ? 32'h0000000f : (_zz_io_y_6[16] ? 32'h00000010 : (_zz_io_y_6[17] ? 32'h00000011 : (_zz_io_y_6[18] ? 32'h00000012 : (_zz_io_y_15 ? _zz_io_y_16 : _zz_io_y_17)))))))))));
  assign _zz_io_y_15 = _zz_io_y_6[19];
  assign _zz_io_y_16 = 32'h00000013;
  assign _zz_io_y_17 = (_zz_io_y_6[20] ? 32'h00000014 : (_zz_io_y_6[21] ? 32'h00000015 : (_zz_io_y_6[22] ? 32'h00000016 : (_zz_io_y_6[23] ? 32'h00000017 : (_zz_io_y_6[24] ? 32'h00000018 : (_zz_io_y_6[25] ? 32'h00000019 : (_zz_io_y_6[26] ? 32'h0000001a : (_zz_io_y_6[27] ? 32'h0000001b : (_zz_io_y_6[28] ? 32'h0000001c : (_zz_io_y_6[29] ? 32'h0000001d : (_zz_io_y_18 ? _zz_io_y_19 : _zz_io_y_20)))))))))));
  assign _zz_io_y_18 = _zz_io_y_6[30];
  assign _zz_io_y_19 = 32'h0000001e;
  assign _zz_io_y_20 = 32'h0000001f;
  `ifndef SYNTHESIS
  always @(*) begin
    case(io_op)
      AluOp_OP1 : io_op_string = "OP1  ";
      AluOp_ADD : io_op_string = "ADD  ";
      AluOp_SUB : io_op_string = "SUB  ";
      AluOp_AND_1 : io_op_string = "AND_1";
      AluOp_OR_1 : io_op_string = "OR_1 ";
      AluOp_XOR_1 : io_op_string = "XOR_1";
      AluOp_NOT_1 : io_op_string = "NOT_1";
      AluOp_SLL_1 : io_op_string = "SLL_1";
      AluOp_SRL_1 : io_op_string = "SRL_1";
      AluOp_SRA_1 : io_op_string = "SRA_1";
      AluOp_ROL_1 : io_op_string = "ROL_1";
      AluOp_SLT : io_op_string = "SLT  ";
      AluOp_SLTU : io_op_string = "SLTU ";
      AluOp_OP2 : io_op_string = "OP2  ";
      AluOp_ANDN : io_op_string = "ANDN ";
      AluOp_CLZ : io_op_string = "CLZ  ";
      AluOp_PACK : io_op_string = "PACK ";
      default : io_op_string = "?????";
    endcase
  end
  `endif

  assign s_a = io_a;
  assign s_b = io_b;
  assign u_a = io_a;
  assign u_b = io_b;
  assign shamt = io_b[4 : 0];
  always @(*) begin
    case(io_op)
      AluOp_OP1 : begin
        io_y = io_a;
      end
      AluOp_ADD : begin
        io_y = _zz_io_y_7;
      end
      AluOp_SUB : begin
        io_y = _zz_io_y_8;
      end
      AluOp_AND_1 : begin
        io_y = (io_a & io_b);
      end
      AluOp_OR_1 : begin
        io_y = (io_a | io_b);
      end
      AluOp_XOR_1 : begin
        io_y = (io_a ^ io_b);
      end
      AluOp_NOT_1 : begin
        io_y = (~ io_a);
      end
      AluOp_SLL_1 : begin
        io_y = (io_a <<< shamt);
      end
      AluOp_SRL_1 : begin
        io_y = (io_a >>> shamt);
      end
      AluOp_SRA_1 : begin
        io_y = _zz_io_y_9;
      end
      AluOp_ROL_1 : begin
        io_y = _zz_io_y;
      end
      AluOp_SLT : begin
        io_y = {31'd0, _zz_io_y_10};
      end
      AluOp_SLTU : begin
        io_y = {31'd0, _zz_io_y_11};
      end
      AluOp_OP2 : begin
        io_y = io_b;
      end
      AluOp_ANDN : begin
        io_y = (io_a & (~ io_b));
      end
      AluOp_CLZ : begin
        io_y = ((io_a != 32'h00000000) ? (_zz_io_y_6[0] ? 32'h00000000 : (_zz_io_y_6[1] ? 32'h00000001 : (_zz_io_y_6[2] ? 32'h00000002 : (_zz_io_y_6[3] ? 32'h00000003 : (_zz_io_y_6[4] ? 32'h00000004 : (_zz_io_y_6[5] ? 32'h00000005 : (_zz_io_y_6[6] ? 32'h00000006 : (_zz_io_y_6[7] ? 32'h00000007 : (_zz_io_y_12 ? _zz_io_y_13 : _zz_io_y_14))))))))) : 32'h00000020);
      end
      default : begin
        io_y = {io_b[15 : 0],io_a[15 : 0]};
      end
    endcase
  end

  always @(*) begin
    _zz_io_y = _zz_io_y_1;
    _zz_io_y = (shamt[4] ? {_zz_io_y_1[15 : 0],_zz_io_y_1[31 : 16]} : _zz_io_y_1);
  end

  always @(*) begin
    _zz_io_y_1 = _zz_io_y_2;
    _zz_io_y_1 = (shamt[3] ? {_zz_io_y_2[23 : 0],_zz_io_y_2[31 : 24]} : _zz_io_y_2);
  end

  always @(*) begin
    _zz_io_y_2 = _zz_io_y_3;
    _zz_io_y_2 = (shamt[2] ? {_zz_io_y_3[27 : 0],_zz_io_y_3[31 : 28]} : _zz_io_y_3);
  end

  always @(*) begin
    _zz_io_y_3 = _zz_io_y_4;
    _zz_io_y_3 = (shamt[1] ? {_zz_io_y_4[29 : 0],_zz_io_y_4[31 : 30]} : _zz_io_y_4);
  end

  always @(*) begin
    _zz_io_y_4 = _zz_io_y_5;
    _zz_io_y_4 = (shamt[0] ? {_zz_io_y_5[30 : 0],_zz_io_y_5[31 : 31]} : _zz_io_y_5);
  end

  assign _zz_io_y_5 = io_a;
  assign _zz_io_y_6 = {io_a[0],{io_a[1],{io_a[2],{io_a[3],{io_a[4],{io_a[5],{io_a[6],{io_a[7],{io_a[8],{_zz__zz_io_y_6,{_zz__zz_io_y_6_1,_zz__zz_io_y_6_2}}}}}}}}}}};

endmodule

module RegFile (
  input  wire [4:0]    io_r_addr_a,
  output reg  [31:0]   io_r_data_a,
  input  wire [4:0]    io_r_addr_b,
  output reg  [31:0]   io_r_data_b,
  input  wire [4:0]    io_w_addr,
  input  wire [31:0]   io_w_data,
  input  wire          io_w_we,
  input  wire          sys_clk,
  input  wire          sys_reset
);

  reg        [31:0]   _zz_io_r_data_a;
  reg        [31:0]   _zz_io_r_data_b;
  reg        [31:0]   mem_0;
  reg        [31:0]   mem_1;
  reg        [31:0]   mem_2;
  reg        [31:0]   mem_3;
  reg        [31:0]   mem_4;
  reg        [31:0]   mem_5;
  reg        [31:0]   mem_6;
  reg        [31:0]   mem_7;
  reg        [31:0]   mem_8;
  reg        [31:0]   mem_9;
  reg        [31:0]   mem_10;
  reg        [31:0]   mem_11;
  reg        [31:0]   mem_12;
  reg        [31:0]   mem_13;
  reg        [31:0]   mem_14;
  reg        [31:0]   mem_15;
  reg        [31:0]   mem_16;
  reg        [31:0]   mem_17;
  reg        [31:0]   mem_18;
  reg        [31:0]   mem_19;
  reg        [31:0]   mem_20;
  reg        [31:0]   mem_21;
  reg        [31:0]   mem_22;
  reg        [31:0]   mem_23;
  reg        [31:0]   mem_24;
  reg        [31:0]   mem_25;
  reg        [31:0]   mem_26;
  reg        [31:0]   mem_27;
  reg        [31:0]   mem_28;
  reg        [31:0]   mem_29;
  reg        [31:0]   mem_30;
  reg        [31:0]   mem_31;
  wire                when_RegFile_l48;
  wire       [31:0]   _zz_1;
  wire                when_RegFile_l52;
  wire                when_RegFile_l55;

  always @(*) begin
    case(io_r_addr_a)
      5'b00000 : _zz_io_r_data_a = mem_0;
      5'b00001 : _zz_io_r_data_a = mem_1;
      5'b00010 : _zz_io_r_data_a = mem_2;
      5'b00011 : _zz_io_r_data_a = mem_3;
      5'b00100 : _zz_io_r_data_a = mem_4;
      5'b00101 : _zz_io_r_data_a = mem_5;
      5'b00110 : _zz_io_r_data_a = mem_6;
      5'b00111 : _zz_io_r_data_a = mem_7;
      5'b01000 : _zz_io_r_data_a = mem_8;
      5'b01001 : _zz_io_r_data_a = mem_9;
      5'b01010 : _zz_io_r_data_a = mem_10;
      5'b01011 : _zz_io_r_data_a = mem_11;
      5'b01100 : _zz_io_r_data_a = mem_12;
      5'b01101 : _zz_io_r_data_a = mem_13;
      5'b01110 : _zz_io_r_data_a = mem_14;
      5'b01111 : _zz_io_r_data_a = mem_15;
      5'b10000 : _zz_io_r_data_a = mem_16;
      5'b10001 : _zz_io_r_data_a = mem_17;
      5'b10010 : _zz_io_r_data_a = mem_18;
      5'b10011 : _zz_io_r_data_a = mem_19;
      5'b10100 : _zz_io_r_data_a = mem_20;
      5'b10101 : _zz_io_r_data_a = mem_21;
      5'b10110 : _zz_io_r_data_a = mem_22;
      5'b10111 : _zz_io_r_data_a = mem_23;
      5'b11000 : _zz_io_r_data_a = mem_24;
      5'b11001 : _zz_io_r_data_a = mem_25;
      5'b11010 : _zz_io_r_data_a = mem_26;
      5'b11011 : _zz_io_r_data_a = mem_27;
      5'b11100 : _zz_io_r_data_a = mem_28;
      5'b11101 : _zz_io_r_data_a = mem_29;
      5'b11110 : _zz_io_r_data_a = mem_30;
      default : _zz_io_r_data_a = mem_31;
    endcase
  end

  always @(*) begin
    case(io_r_addr_b)
      5'b00000 : _zz_io_r_data_b = mem_0;
      5'b00001 : _zz_io_r_data_b = mem_1;
      5'b00010 : _zz_io_r_data_b = mem_2;
      5'b00011 : _zz_io_r_data_b = mem_3;
      5'b00100 : _zz_io_r_data_b = mem_4;
      5'b00101 : _zz_io_r_data_b = mem_5;
      5'b00110 : _zz_io_r_data_b = mem_6;
      5'b00111 : _zz_io_r_data_b = mem_7;
      5'b01000 : _zz_io_r_data_b = mem_8;
      5'b01001 : _zz_io_r_data_b = mem_9;
      5'b01010 : _zz_io_r_data_b = mem_10;
      5'b01011 : _zz_io_r_data_b = mem_11;
      5'b01100 : _zz_io_r_data_b = mem_12;
      5'b01101 : _zz_io_r_data_b = mem_13;
      5'b01110 : _zz_io_r_data_b = mem_14;
      5'b01111 : _zz_io_r_data_b = mem_15;
      5'b10000 : _zz_io_r_data_b = mem_16;
      5'b10001 : _zz_io_r_data_b = mem_17;
      5'b10010 : _zz_io_r_data_b = mem_18;
      5'b10011 : _zz_io_r_data_b = mem_19;
      5'b10100 : _zz_io_r_data_b = mem_20;
      5'b10101 : _zz_io_r_data_b = mem_21;
      5'b10110 : _zz_io_r_data_b = mem_22;
      5'b10111 : _zz_io_r_data_b = mem_23;
      5'b11000 : _zz_io_r_data_b = mem_24;
      5'b11001 : _zz_io_r_data_b = mem_25;
      5'b11010 : _zz_io_r_data_b = mem_26;
      5'b11011 : _zz_io_r_data_b = mem_27;
      5'b11100 : _zz_io_r_data_b = mem_28;
      5'b11101 : _zz_io_r_data_b = mem_29;
      5'b11110 : _zz_io_r_data_b = mem_30;
      default : _zz_io_r_data_b = mem_31;
    endcase
  end

  always @(*) begin
    io_r_data_a = _zz_io_r_data_a;
    if(when_RegFile_l48) begin
      if(when_RegFile_l52) begin
        io_r_data_a = io_w_data;
      end
    end
  end

  always @(*) begin
    io_r_data_b = _zz_io_r_data_b;
    if(when_RegFile_l48) begin
      if(when_RegFile_l55) begin
        io_r_data_b = io_w_data;
      end
    end
  end

  assign when_RegFile_l48 = (io_w_we && (io_w_addr != 5'h00));
  assign _zz_1 = ({31'd0,1'b1} <<< io_w_addr);
  assign when_RegFile_l52 = (io_w_addr == io_r_addr_a);
  assign when_RegFile_l55 = (io_w_addr == io_r_addr_b);
  always @(posedge sys_clk or posedge sys_reset) begin
    if(sys_reset) begin
      mem_0 <= 32'h00000000;
      mem_1 <= 32'h00000000;
      mem_2 <= 32'h00000000;
      mem_3 <= 32'h00000000;
      mem_4 <= 32'h00000000;
      mem_5 <= 32'h00000000;
      mem_6 <= 32'h00000000;
      mem_7 <= 32'h00000000;
      mem_8 <= 32'h00000000;
      mem_9 <= 32'h00000000;
      mem_10 <= 32'h00000000;
      mem_11 <= 32'h00000000;
      mem_12 <= 32'h00000000;
      mem_13 <= 32'h00000000;
      mem_14 <= 32'h00000000;
      mem_15 <= 32'h00000000;
      mem_16 <= 32'h00000000;
      mem_17 <= 32'h00000000;
      mem_18 <= 32'h00000000;
      mem_19 <= 32'h00000000;
      mem_20 <= 32'h00000000;
      mem_21 <= 32'h00000000;
      mem_22 <= 32'h00000000;
      mem_23 <= 32'h00000000;
      mem_24 <= 32'h00000000;
      mem_25 <= 32'h00000000;
      mem_26 <= 32'h00000000;
      mem_27 <= 32'h00000000;
      mem_28 <= 32'h00000000;
      mem_29 <= 32'h00000000;
      mem_30 <= 32'h00000000;
      mem_31 <= 32'h00000000;
    end else begin
      if(when_RegFile_l48) begin
        if(_zz_1[0]) begin
          mem_0 <= io_w_data;
        end
        if(_zz_1[1]) begin
          mem_1 <= io_w_data;
        end
        if(_zz_1[2]) begin
          mem_2 <= io_w_data;
        end
        if(_zz_1[3]) begin
          mem_3 <= io_w_data;
        end
        if(_zz_1[4]) begin
          mem_4 <= io_w_data;
        end
        if(_zz_1[5]) begin
          mem_5 <= io_w_data;
        end
        if(_zz_1[6]) begin
          mem_6 <= io_w_data;
        end
        if(_zz_1[7]) begin
          mem_7 <= io_w_data;
        end
        if(_zz_1[8]) begin
          mem_8 <= io_w_data;
        end
        if(_zz_1[9]) begin
          mem_9 <= io_w_data;
        end
        if(_zz_1[10]) begin
          mem_10 <= io_w_data;
        end
        if(_zz_1[11]) begin
          mem_11 <= io_w_data;
        end
        if(_zz_1[12]) begin
          mem_12 <= io_w_data;
        end
        if(_zz_1[13]) begin
          mem_13 <= io_w_data;
        end
        if(_zz_1[14]) begin
          mem_14 <= io_w_data;
        end
        if(_zz_1[15]) begin
          mem_15 <= io_w_data;
        end
        if(_zz_1[16]) begin
          mem_16 <= io_w_data;
        end
        if(_zz_1[17]) begin
          mem_17 <= io_w_data;
        end
        if(_zz_1[18]) begin
          mem_18 <= io_w_data;
        end
        if(_zz_1[19]) begin
          mem_19 <= io_w_data;
        end
        if(_zz_1[20]) begin
          mem_20 <= io_w_data;
        end
        if(_zz_1[21]) begin
          mem_21 <= io_w_data;
        end
        if(_zz_1[22]) begin
          mem_22 <= io_w_data;
        end
        if(_zz_1[23]) begin
          mem_23 <= io_w_data;
        end
        if(_zz_1[24]) begin
          mem_24 <= io_w_data;
        end
        if(_zz_1[25]) begin
          mem_25 <= io_w_data;
        end
        if(_zz_1[26]) begin
          mem_26 <= io_w_data;
        end
        if(_zz_1[27]) begin
          mem_27 <= io_w_data;
        end
        if(_zz_1[28]) begin
          mem_28 <= io_w_data;
        end
        if(_zz_1[29]) begin
          mem_29 <= io_w_data;
        end
        if(_zz_1[30]) begin
          mem_30 <= io_w_data;
        end
        if(_zz_1[31]) begin
          mem_31 <= io_w_data;
        end
      end
    end
  end


endmodule

module BufferCC (
  input  wire          io_dataIn,
  output wire          io_dataOut,
  input  wire          sys_clk,
  input  wire          locked
);

  (* async_reg = "true" *) reg                 buffers_0;
  (* async_reg = "true" *) reg                 buffers_1;

  assign io_dataOut = buffers_1;
  always @(posedge sys_clk or negedge locked) begin
    if(!locked) begin
      buffers_0 <= 1'b1;
      buffers_1 <= 1'b1;
    end else begin
      buffers_0 <= io_dataIn;
      buffers_1 <= buffers_0;
    end
  end


endmodule

module Mip (
  output wire [31:0]   io_r,
  input  wire [31:0]   io_w,
  input  wire          io_we,
  input  wire          sys_clk,
  input  wire          sys_reset
);

  reg        [31:0]   reg_1;
  wire                mtip;
  wire                mtip_w;

  assign io_r = reg_1;
  assign mtip = reg_1[7];
  assign mtip_w = io_w[7];
  always @(posedge sys_clk or posedge sys_reset) begin
    if(sys_reset) begin
      reg_1 <= 32'h00000000;
    end else begin
      if(io_we) begin
        reg_1[7] <= mtip_w;
      end
    end
  end


endmodule

module Mcause (
  output wire [31:0]   io_r,
  input  wire [31:0]   io_w,
  input  wire          io_we,
  input  wire          sys_clk,
  input  wire          sys_reset
);

  reg        [31:0]   reg_1;
  wire                interrupt;
  wire                interrupt_w;
  wire       [30:0]   exception_code;
  wire       [30:0]   exception_code_w;

  assign io_r = reg_1;
  assign interrupt = reg_1[31];
  assign interrupt_w = io_w[31];
  assign exception_code = reg_1[30 : 0];
  assign exception_code_w = io_w[30 : 0];
  always @(posedge sys_clk or posedge sys_reset) begin
    if(sys_reset) begin
      reg_1 <= 32'h00000000;
    end else begin
      if(io_we) begin
        reg_1[31] <= interrupt_w;
        reg_1[30 : 0] <= exception_code_w;
      end
    end
  end


endmodule

module Mepc (
  output wire [31:0]   io_r,
  input  wire [31:0]   io_w,
  input  wire          io_we,
  input  wire          sys_clk,
  input  wire          sys_reset
);

  reg        [31:0]   reg_1;
  wire       [31:0]   mepc_1;
  wire       [31:0]   mepc_w;

  assign io_r = reg_1;
  assign mepc_1 = reg_1[31 : 0];
  assign mepc_w = io_w[31 : 0];
  always @(posedge sys_clk or posedge sys_reset) begin
    if(sys_reset) begin
      reg_1 <= 32'h00000000;
    end else begin
      if(io_we) begin
        reg_1[31 : 0] <= mepc_w;
      end
    end
  end


endmodule

module Mscratch (
  output wire [31:0]   io_r,
  input  wire [31:0]   io_w,
  input  wire          io_we,
  input  wire          sys_clk,
  input  wire          sys_reset
);

  reg        [31:0]   reg_1;
  wire       [31:0]   mscratch_1;
  wire       [31:0]   mscratch_w;

  assign io_r = reg_1;
  assign mscratch_1 = reg_1[31 : 0];
  assign mscratch_w = io_w[31 : 0];
  always @(posedge sys_clk or posedge sys_reset) begin
    if(sys_reset) begin
      reg_1 <= 32'h00000000;
    end else begin
      if(io_we) begin
        reg_1[31 : 0] <= mscratch_w;
      end
    end
  end


endmodule

module Mtvec (
  output wire [31:0]   io_r,
  input  wire [31:0]   io_w,
  input  wire          io_we,
  input  wire          sys_clk,
  input  wire          sys_reset
);

  reg        [31:0]   reg_1;
  wire       [1:0]    mode;
  wire       [1:0]    mode_w;
  wire       [29:0]   base;
  wire       [29:0]   base_w;

  assign io_r = reg_1;
  assign mode = reg_1[1 : 0];
  assign mode_w = io_w[1 : 0];
  assign base = reg_1[31 : 2];
  assign base_w = io_w[31 : 2];
  always @(posedge sys_clk or posedge sys_reset) begin
    if(sys_reset) begin
      reg_1 <= 32'h00000000;
    end else begin
      if(io_we) begin
        reg_1[1 : 0] <= mode_w;
        reg_1[31 : 2] <= base_w;
      end
    end
  end


endmodule

module Mie (
  output wire [31:0]   io_r,
  input  wire [31:0]   io_w,
  input  wire          io_we,
  input  wire          sys_clk,
  input  wire          sys_reset
);

  reg        [31:0]   reg_1;
  wire                mtie;
  wire                mtie_w;

  assign io_r = reg_1;
  assign mtie = reg_1[7];
  assign mtie_w = io_w[7];
  always @(posedge sys_clk or posedge sys_reset) begin
    if(sys_reset) begin
      reg_1 <= 32'h00000000;
    end else begin
      if(io_we) begin
        reg_1[7] <= mtie_w;
      end
    end
  end


endmodule

module Mstatus (
  output wire [31:0]   io_r,
  input  wire [31:0]   io_w,
  input  wire          io_we,
  input  wire          sys_clk,
  input  wire          sys_reset
);
  localparam PrivilegeMode_U = 2'd0;
  localparam PrivilegeMode_S = 2'd1;
  localparam PrivilegeMode_M = 2'd3;

  reg        [31:0]   reg_1;
  wire       [1:0]    mpp;
  wire       [1:0]    mpp_w;

  assign io_r = reg_1;
  assign mpp = reg_1[12 : 11];
  assign mpp_w = io_w[12 : 11];
  always @(posedge sys_clk or posedge sys_reset) begin
    if(sys_reset) begin
      reg_1 <= 32'h00000000;
    end else begin
      if(io_we) begin
        if((mpp_w == PrivilegeMode_U) || (mpp_w == PrivilegeMode_S) || (mpp_w == PrivilegeMode_M)) begin
            reg_1[12 : 11] <= mpp_w;
        end
      end
    end
  end


endmodule
