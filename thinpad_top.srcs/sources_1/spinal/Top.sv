// Generator : SpinalHDL v1.9.4    git head : 270018552577f3bb8e5339ee2583c9c22d324215
// Component : Top
// Git hash  : 7052a75b4aa654b8401979b4de7e15ff5d3cfc0e

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
  localparam AluOp_OP1 = 4'd0;
  localparam AluOp_ADD = 4'd1;
  localparam AluOp_SUB = 4'd2;
  localparam AluOp_AND_1 = 4'd3;
  localparam AluOp_OR_1 = 4'd4;
  localparam AluOp_XOR_1 = 4'd5;
  localparam AluOp_NOT_1 = 4'd6;
  localparam AluOp_SLL_1 = 4'd7;
  localparam AluOp_SRL_1 = 4'd8;
  localparam AluOp_SRA_1 = 4'd9;
  localparam AluOp_ROL_1 = 4'd10;
  localparam AluOp_OP2 = 4'd11;
  localparam BrType_F = 2'd0;
  localparam BrType_T = 2'd1;
  localparam BrType_EQ = 2'd2;
  localparam BrType_NE = 2'd3;
  localparam RegSel_ALU = 2'd0;
  localparam RegSel_MEM = 2'd1;
  localparam RegSel_PC = 2'd2;

  wire                bufferCC_1_io_dataIn;
  wire                If_2_io_stall;
  wire                Id_1_io_stall;
  wire       [3:0]    seg_l_iDIG;
  wire       [3:0]    seg_h_iDIG;
  wire                clkCtrl_pll_clk_out1;
  wire                clkCtrl_pll_clk_out2;
  wire                clkCtrl_pll_locked;
  wire                bufferCC_1_io_dataOut;
  wire       [31:0]   reg_file_io_r_data_a;
  wire       [31:0]   reg_file_io_r_data_b;
  wire       [31:0]   alu_1_io_y;
  wire       [31:0]   If_2_io_o_pc;
  wire       [31:0]   If_2_io_o_instr;
  wire                If_2_io_wb_cyc;
  wire                If_2_io_wb_stb;
  wire                If_2_io_wb_we;
  wire       [31:0]   If_2_io_wb_adr;
  wire       [31:0]   If_2_io_wb_dat_w;
  wire       [3:0]    If_2_io_wb_sel;
  wire       [31:0]   Id_1_io_o_pc;
  wire       [31:0]   Id_1_io_o_reg_data_a;
  wire       [31:0]   Id_1_io_o_reg_data_b;
  wire       [4:0]    Id_1_io_o_reg_addr_a;
  wire       [4:0]    Id_1_io_o_reg_addr_b;
  wire       [4:0]    Id_1_io_o_reg_addr_d;
  wire       [3:0]    Id_1_io_o_alu_op;
  wire       [1:0]    Id_1_io_o_br_type;
  wire       [31:0]   Id_1_io_o_imm;
  wire                Id_1_io_o_use_pc;
  wire                Id_1_io_o_use_rs2;
  wire                Id_1_io_o_mem_en;
  wire                Id_1_io_o_mem_we;
  wire       [3:0]    Id_1_io_o_mem_sel;
  wire                Id_1_io_o_reg_we;
  wire       [1:0]    Id_1_io_o_reg_sel;
  wire       [4:0]    Id_1_io_reg_addr_a;
  wire       [4:0]    Id_1_io_reg_addr_b;
  wire       [31:0]   Exe_1_io_o_pc;
  wire       [31:0]   Exe_1_io_o_reg_data_b;
  wire       [4:0]    Exe_1_io_o_reg_addr_d;
  wire                Exe_1_io_o_mem_en;
  wire                Exe_1_io_o_mem_we;
  wire       [3:0]    Exe_1_io_o_mem_sel;
  wire                Exe_1_io_o_reg_we;
  wire       [1:0]    Exe_1_io_o_reg_sel;
  wire       [31:0]   Exe_1_io_o_alu_y;
  wire                Exe_1_io_br_br;
  wire       [31:0]   Exe_1_io_br_pc;
  wire                Exe_1_io_flush_req;
  wire       [31:0]   Exe_1_io_alu_a;
  wire       [31:0]   Exe_1_io_alu_b;
  wire       [3:0]    Exe_1_io_alu_op;
  wire                Mem_1_io_o_reg_we;
  wire       [4:0]    Mem_1_io_o_reg_addr_d;
  wire       [31:0]   Mem_1_io_o_reg_data_d;
  wire                Mem_1_io_forward_we;
  wire       [4:0]    Mem_1_io_forward_addr;
  wire       [31:0]   Mem_1_io_forward_data;
  wire                Mem_1_io_stall_req;
  wire                Mem_1_io_wb_cyc;
  wire                Mem_1_io_wb_stb;
  wire                Mem_1_io_wb_we;
  wire       [31:0]   Mem_1_io_wb_adr;
  wire       [31:0]   Mem_1_io_wb_dat_w;
  wire       [3:0]    Mem_1_io_wb_sel;
  wire       [4:0]    Wb_1_io_reg_addr;
  wire       [31:0]   Wb_1_io_reg_data;
  wire                Wb_1_io_reg_we;
  wire       [7:0]    seg_l_oSEG1;
  wire       [7:0]    seg_h_oSEG1;
  wire                arbiter_1_io_masters_0_ack;
  wire       [31:0]   arbiter_1_io_masters_0_dat_r;
  wire                arbiter_1_io_masters_1_ack;
  wire       [31:0]   arbiter_1_io_masters_1_dat_r;
  wire                arbiter_1_io_wb_cyc;
  wire                arbiter_1_io_wb_stb;
  wire                arbiter_1_io_wb_we;
  wire       [31:0]   arbiter_1_io_wb_adr;
  wire       [31:0]   arbiter_1_io_wb_dat_w;
  wire       [3:0]    arbiter_1_io_wb_sel;
  wire                mux_io_wb_ack;
  wire       [31:0]   mux_io_wb_dat_r;
  wire                mux_io_slaves_0_cyc;
  wire                mux_io_slaves_0_stb;
  wire                mux_io_slaves_0_we;
  wire       [31:0]   mux_io_slaves_0_adr;
  wire       [31:0]   mux_io_slaves_0_dat_w;
  wire       [3:0]    mux_io_slaves_0_sel;
  wire                mux_io_slaves_1_cyc;
  wire                mux_io_slaves_1_stb;
  wire                mux_io_slaves_1_we;
  wire       [31:0]   mux_io_slaves_1_adr;
  wire       [31:0]   mux_io_slaves_1_dat_w;
  wire       [3:0]    mux_io_slaves_1_sel;
  wire                mux_io_slaves_2_cyc;
  wire                mux_io_slaves_2_stb;
  wire                mux_io_slaves_2_we;
  wire       [31:0]   mux_io_slaves_2_adr;
  wire       [31:0]   mux_io_slaves_2_dat_w;
  wire       [3:0]    mux_io_slaves_2_sel;
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
    .io_op (Exe_1_io_alu_op[3:0]), //i
    .io_y  (alu_1_io_y[31:0]    )  //o
  );
  IF_1 If_2 (
    .io_o_pc     (If_2_io_o_pc[31:0]                ), //o
    .io_o_instr  (If_2_io_o_instr[31:0]             ), //o
    .io_br_br    (Exe_1_io_br_br                    ), //i
    .io_br_pc    (Exe_1_io_br_pc[31:0]              ), //i
    .io_stall    (If_2_io_stall                     ), //i
    .io_bubble   (Exe_1_io_flush_req                ), //i
    .io_wb_cyc   (If_2_io_wb_cyc                    ), //o
    .io_wb_stb   (If_2_io_wb_stb                    ), //o
    .io_wb_ack   (arbiter_1_io_masters_1_ack        ), //i
    .io_wb_we    (If_2_io_wb_we                     ), //o
    .io_wb_adr   (If_2_io_wb_adr[31:0]              ), //o
    .io_wb_dat_r (arbiter_1_io_masters_1_dat_r[31:0]), //i
    .io_wb_dat_w (If_2_io_wb_dat_w[31:0]            ), //o
    .io_wb_sel   (If_2_io_wb_sel[3:0]               ), //o
    .sys_clk     (sys_clk                           ), //i
    .sys_reset   (sys_reset                         )  //i
  );
  ID Id_1 (
    .io_i_pc         (If_2_io_o_pc[31:0]        ), //i
    .io_i_instr      (If_2_io_o_instr[31:0]     ), //i
    .io_o_pc         (Id_1_io_o_pc[31:0]        ), //o
    .io_o_reg_data_a (Id_1_io_o_reg_data_a[31:0]), //o
    .io_o_reg_data_b (Id_1_io_o_reg_data_b[31:0]), //o
    .io_o_reg_addr_a (Id_1_io_o_reg_addr_a[4:0] ), //o
    .io_o_reg_addr_b (Id_1_io_o_reg_addr_b[4:0] ), //o
    .io_o_reg_addr_d (Id_1_io_o_reg_addr_d[4:0] ), //o
    .io_o_alu_op     (Id_1_io_o_alu_op[3:0]     ), //o
    .io_o_br_type    (Id_1_io_o_br_type[1:0]    ), //o
    .io_o_imm        (Id_1_io_o_imm[31:0]       ), //o
    .io_o_use_pc     (Id_1_io_o_use_pc          ), //o
    .io_o_use_rs2    (Id_1_io_o_use_rs2         ), //o
    .io_o_mem_en     (Id_1_io_o_mem_en          ), //o
    .io_o_mem_we     (Id_1_io_o_mem_we          ), //o
    .io_o_mem_sel    (Id_1_io_o_mem_sel[3:0]    ), //o
    .io_o_reg_we     (Id_1_io_o_reg_we          ), //o
    .io_o_reg_sel    (Id_1_io_o_reg_sel[1:0]    ), //o
    .io_stall        (Id_1_io_stall             ), //i
    .io_bubble       (Exe_1_io_flush_req        ), //i
    .io_reg_addr_a   (Id_1_io_reg_addr_a[4:0]   ), //o
    .io_reg_data_a   (reg_file_io_r_data_a[31:0]), //i
    .io_reg_addr_b   (Id_1_io_reg_addr_b[4:0]   ), //o
    .io_reg_data_b   (reg_file_io_r_data_b[31:0]), //i
    .sys_clk         (sys_clk                   ), //i
    .sys_reset       (sys_reset                 )  //i
  );
  EXE Exe_1 (
    .io_i_pc         (Id_1_io_o_pc[31:0]         ), //i
    .io_i_reg_data_a (Id_1_io_o_reg_data_a[31:0] ), //i
    .io_i_reg_data_b (Id_1_io_o_reg_data_b[31:0] ), //i
    .io_i_reg_addr_a (Id_1_io_o_reg_addr_a[4:0]  ), //i
    .io_i_reg_addr_b (Id_1_io_o_reg_addr_b[4:0]  ), //i
    .io_i_reg_addr_d (Id_1_io_o_reg_addr_d[4:0]  ), //i
    .io_i_alu_op     (Id_1_io_o_alu_op[3:0]      ), //i
    .io_i_br_type    (Id_1_io_o_br_type[1:0]     ), //i
    .io_i_imm        (Id_1_io_o_imm[31:0]        ), //i
    .io_i_use_pc     (Id_1_io_o_use_pc           ), //i
    .io_i_use_rs2    (Id_1_io_o_use_rs2          ), //i
    .io_i_mem_en     (Id_1_io_o_mem_en           ), //i
    .io_i_mem_we     (Id_1_io_o_mem_we           ), //i
    .io_i_mem_sel    (Id_1_io_o_mem_sel[3:0]     ), //i
    .io_i_reg_we     (Id_1_io_o_reg_we           ), //i
    .io_i_reg_sel    (Id_1_io_o_reg_sel[1:0]     ), //i
    .io_o_pc         (Exe_1_io_o_pc[31:0]        ), //o
    .io_o_reg_data_b (Exe_1_io_o_reg_data_b[31:0]), //o
    .io_o_reg_addr_d (Exe_1_io_o_reg_addr_d[4:0] ), //o
    .io_o_mem_en     (Exe_1_io_o_mem_en          ), //o
    .io_o_mem_we     (Exe_1_io_o_mem_we          ), //o
    .io_o_mem_sel    (Exe_1_io_o_mem_sel[3:0]    ), //o
    .io_o_reg_we     (Exe_1_io_o_reg_we          ), //o
    .io_o_reg_sel    (Exe_1_io_o_reg_sel[1:0]    ), //o
    .io_o_alu_y      (Exe_1_io_o_alu_y[31:0]     ), //o
    .io_br_br        (Exe_1_io_br_br             ), //o
    .io_br_pc        (Exe_1_io_br_pc[31:0]       ), //o
    .io_forward_we   (Mem_1_io_forward_we        ), //i
    .io_forward_addr (Mem_1_io_forward_addr[4:0] ), //i
    .io_forward_data (Mem_1_io_forward_data[31:0]), //i
    .io_stall        (Mem_1_io_stall_req         ), //i
    .io_flush_req    (Exe_1_io_flush_req         ), //o
    .io_alu_a        (Exe_1_io_alu_a[31:0]       ), //o
    .io_alu_b        (Exe_1_io_alu_b[31:0]       ), //o
    .io_alu_op       (Exe_1_io_alu_op[3:0]       ), //o
    .io_alu_y        (alu_1_io_y[31:0]           ), //i
    .sys_clk         (sys_clk                    ), //i
    .sys_reset       (sys_reset                  )  //i
  );
  MEM Mem_1 (
    .io_i_pc         (Exe_1_io_o_pc[31:0]               ), //i
    .io_i_reg_data_b (Exe_1_io_o_reg_data_b[31:0]       ), //i
    .io_i_reg_addr_d (Exe_1_io_o_reg_addr_d[4:0]        ), //i
    .io_i_mem_en     (Exe_1_io_o_mem_en                 ), //i
    .io_i_mem_we     (Exe_1_io_o_mem_we                 ), //i
    .io_i_mem_sel    (Exe_1_io_o_mem_sel[3:0]           ), //i
    .io_i_reg_we     (Exe_1_io_o_reg_we                 ), //i
    .io_i_reg_sel    (Exe_1_io_o_reg_sel[1:0]           ), //i
    .io_i_alu_y      (Exe_1_io_o_alu_y[31:0]            ), //i
    .io_o_reg_we     (Mem_1_io_o_reg_we                 ), //o
    .io_o_reg_addr_d (Mem_1_io_o_reg_addr_d[4:0]        ), //o
    .io_o_reg_data_d (Mem_1_io_o_reg_data_d[31:0]       ), //o
    .io_forward_we   (Mem_1_io_forward_we               ), //o
    .io_forward_addr (Mem_1_io_forward_addr[4:0]        ), //o
    .io_forward_data (Mem_1_io_forward_data[31:0]       ), //o
    .io_stall_req    (Mem_1_io_stall_req                ), //o
    .io_wb_cyc       (Mem_1_io_wb_cyc                   ), //o
    .io_wb_stb       (Mem_1_io_wb_stb                   ), //o
    .io_wb_ack       (arbiter_1_io_masters_0_ack        ), //i
    .io_wb_we        (Mem_1_io_wb_we                    ), //o
    .io_wb_adr       (Mem_1_io_wb_adr[31:0]             ), //o
    .io_wb_dat_r     (arbiter_1_io_masters_0_dat_r[31:0]), //i
    .io_wb_dat_w     (Mem_1_io_wb_dat_w[31:0]           ), //o
    .io_wb_sel       (Mem_1_io_wb_sel[3:0]              ), //o
    .sys_clk         (sys_clk                           ), //i
    .sys_reset       (sys_reset                         )  //i
  );
  WB Wb_1 (
    .io_i_reg_we     (Mem_1_io_o_reg_we          ), //i
    .io_i_reg_addr_d (Mem_1_io_o_reg_addr_d[4:0] ), //i
    .io_i_reg_data_d (Mem_1_io_o_reg_data_d[31:0]), //i
    .io_reg_addr     (Wb_1_io_reg_addr[4:0]      ), //o
    .io_reg_data     (Wb_1_io_reg_data[31:0]     ), //o
    .io_reg_we       (Wb_1_io_reg_we             )  //o
  );
  SEG7_LUT seg_l (
    .iDIG  (seg_l_iDIG[3:0] ), //i
    .oSEG1 (seg_l_oSEG1[7:0])  //o
  );
  SEG7_LUT seg_h (
    .iDIG  (seg_h_iDIG[3:0] ), //i
    .oSEG1 (seg_h_oSEG1[7:0])  //o
  );
  WbArbiter arbiter_1 (
    .io_masters_0_cyc   (Mem_1_io_wb_cyc                   ), //i
    .io_masters_0_stb   (Mem_1_io_wb_stb                   ), //i
    .io_masters_0_ack   (arbiter_1_io_masters_0_ack        ), //o
    .io_masters_0_we    (Mem_1_io_wb_we                    ), //i
    .io_masters_0_adr   (Mem_1_io_wb_adr[31:0]             ), //i
    .io_masters_0_dat_r (arbiter_1_io_masters_0_dat_r[31:0]), //o
    .io_masters_0_dat_w (Mem_1_io_wb_dat_w[31:0]           ), //i
    .io_masters_0_sel   (Mem_1_io_wb_sel[3:0]              ), //i
    .io_masters_1_cyc   (If_2_io_wb_cyc                    ), //i
    .io_masters_1_stb   (If_2_io_wb_stb                    ), //i
    .io_masters_1_ack   (arbiter_1_io_masters_1_ack        ), //o
    .io_masters_1_we    (If_2_io_wb_we                     ), //i
    .io_masters_1_adr   (If_2_io_wb_adr[31:0]              ), //i
    .io_masters_1_dat_r (arbiter_1_io_masters_1_dat_r[31:0]), //o
    .io_masters_1_dat_w (If_2_io_wb_dat_w[31:0]            ), //i
    .io_masters_1_sel   (If_2_io_wb_sel[3:0]               ), //i
    .io_wb_cyc          (arbiter_1_io_wb_cyc               ), //o
    .io_wb_stb          (arbiter_1_io_wb_stb               ), //o
    .io_wb_ack          (mux_io_wb_ack                     ), //i
    .io_wb_we           (arbiter_1_io_wb_we                ), //o
    .io_wb_adr          (arbiter_1_io_wb_adr[31:0]         ), //o
    .io_wb_dat_r        (mux_io_wb_dat_r[31:0]             ), //i
    .io_wb_dat_w        (arbiter_1_io_wb_dat_w[31:0]       ), //o
    .io_wb_sel          (arbiter_1_io_wb_sel[3:0]          ), //o
    .sys_reset          (sys_reset                         ), //i
    .sys_clk            (sys_clk                           )  //i
  );
  WbMux mux (
    .io_wb_cyc         (arbiter_1_io_wb_cyc        ), //i
    .io_wb_stb         (arbiter_1_io_wb_stb        ), //i
    .io_wb_ack         (mux_io_wb_ack              ), //o
    .io_wb_we          (arbiter_1_io_wb_we         ), //i
    .io_wb_adr         (arbiter_1_io_wb_adr[31:0]  ), //i
    .io_wb_dat_r       (mux_io_wb_dat_r[31:0]      ), //o
    .io_wb_dat_w       (arbiter_1_io_wb_dat_w[31:0]), //i
    .io_wb_sel         (arbiter_1_io_wb_sel[3:0]   ), //i
    .io_slaves_0_cyc   (mux_io_slaves_0_cyc        ), //o
    .io_slaves_0_stb   (mux_io_slaves_0_stb        ), //o
    .io_slaves_0_ack   (base_ram_io_wb_ack         ), //i
    .io_slaves_0_we    (mux_io_slaves_0_we         ), //o
    .io_slaves_0_adr   (mux_io_slaves_0_adr[31:0]  ), //o
    .io_slaves_0_dat_r (base_ram_io_wb_dat_r[31:0] ), //i
    .io_slaves_0_dat_w (mux_io_slaves_0_dat_w[31:0]), //o
    .io_slaves_0_sel   (mux_io_slaves_0_sel[3:0]   ), //o
    .io_slaves_1_cyc   (mux_io_slaves_1_cyc        ), //o
    .io_slaves_1_stb   (mux_io_slaves_1_stb        ), //o
    .io_slaves_1_ack   (ext_ram_io_wb_ack          ), //i
    .io_slaves_1_we    (mux_io_slaves_1_we         ), //o
    .io_slaves_1_adr   (mux_io_slaves_1_adr[31:0]  ), //o
    .io_slaves_1_dat_r (ext_ram_io_wb_dat_r[31:0]  ), //i
    .io_slaves_1_dat_w (mux_io_slaves_1_dat_w[31:0]), //o
    .io_slaves_1_sel   (mux_io_slaves_1_sel[3:0]   ), //o
    .io_slaves_2_cyc   (mux_io_slaves_2_cyc        ), //o
    .io_slaves_2_stb   (mux_io_slaves_2_stb        ), //o
    .io_slaves_2_ack   (uart_wb_ack_o              ), //i
    .io_slaves_2_we    (mux_io_slaves_2_we         ), //o
    .io_slaves_2_adr   (mux_io_slaves_2_adr[31:0]  ), //o
    .io_slaves_2_dat_r (uart_wb_dat_o[31:0]        ), //i
    .io_slaves_2_dat_w (mux_io_slaves_2_dat_w[31:0]), //o
    .io_slaves_2_sel   (mux_io_slaves_2_sel[3:0]   )  //o
  );
  SramController base_ram (
    .io_wb_cyc                (mux_io_slaves_0_cyc              ), //i
    .io_wb_stb                (mux_io_slaves_0_stb              ), //i
    .io_wb_ack                (base_ram_io_wb_ack               ), //o
    .io_wb_we                 (mux_io_slaves_0_we               ), //i
    .io_wb_adr                (mux_io_slaves_0_adr[31:0]        ), //i
    .io_wb_dat_r              (base_ram_io_wb_dat_r[31:0]       ), //o
    .io_wb_dat_w              (mux_io_slaves_0_dat_w[31:0]      ), //i
    .io_wb_sel                (mux_io_slaves_0_sel[3:0]         ), //i
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
    .io_wb_cyc                (mux_io_slaves_1_cyc             ), //i
    .io_wb_stb                (mux_io_slaves_1_stb             ), //i
    .io_wb_ack                (ext_ram_io_wb_ack               ), //o
    .io_wb_we                 (mux_io_slaves_1_we              ), //i
    .io_wb_adr                (mux_io_slaves_1_adr[31:0]       ), //i
    .io_wb_dat_r              (ext_ram_io_wb_dat_r[31:0]       ), //o
    .io_wb_dat_w              (mux_io_slaves_1_dat_w[31:0]     ), //i
    .io_wb_sel                (mux_io_slaves_1_sel[3:0]        ), //i
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
    .CLK_FREQ(10000000),
    .BAUD(115200)
  ) uart (
    .clk_i      (sys_clk                    ), //i
    .rst_i      (sys_reset                  ), //i
    .wb_cyc_i   (mux_io_slaves_2_cyc        ), //i
    .wb_stb_i   (mux_io_slaves_2_stb        ), //i
    .wb_ack_o   (uart_wb_ack_o              ), //o
    .wb_we_i    (mux_io_slaves_2_we         ), //i
    .wb_adr_i   (mux_io_slaves_2_adr[31:0]  ), //i
    .wb_dat_o   (uart_wb_dat_o[31:0]        ), //o
    .wb_dat_i   (mux_io_slaves_2_dat_w[31:0]), //i
    .wb_sel_i   (mux_io_slaves_2_sel[3:0]   ), //i
    .uart_txd_o (uart_uart_txd_o            ), //o
    .uart_rxd_i (rxd                        )  //i
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
  assign If_2_io_stall = ((! Exe_1_io_flush_req) && Mem_1_io_stall_req);
  assign Id_1_io_stall = (Exe_1_io_flush_req && Mem_1_io_stall_req);
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

module WB (
  input  wire          io_i_reg_we,
  input  wire [4:0]    io_i_reg_addr_d,
  input  wire [31:0]   io_i_reg_data_d,
  output wire [4:0]    io_reg_addr,
  output wire [31:0]   io_reg_data,
  output wire          io_reg_we
);


  assign io_reg_we = io_i_reg_we;
  assign io_reg_addr = io_i_reg_addr_d;
  assign io_reg_data = io_i_reg_data_d;

endmodule

module MEM (
  input  wire [31:0]   io_i_pc,
  input  wire [31:0]   io_i_reg_data_b,
  input  wire [4:0]    io_i_reg_addr_d,
  input  wire          io_i_mem_en,
  input  wire          io_i_mem_we,
  input  wire [3:0]    io_i_mem_sel,
  input  wire          io_i_reg_we,
  input  wire [1:0]    io_i_reg_sel,
  input  wire [31:0]   io_i_alu_y,
  output reg           io_o_reg_we,
  output reg  [4:0]    io_o_reg_addr_d,
  output reg  [31:0]   io_o_reg_data_d,
  output wire          io_forward_we,
  output wire [4:0]    io_forward_addr,
  output wire [31:0]   io_forward_data,
  output wire          io_stall_req,
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
  localparam RegSel_ALU = 2'd0;
  localparam RegSel_MEM = 2'd1;
  localparam RegSel_PC = 2'd2;
  localparam fsm_enumDef_BOOT = 2'd0;
  localparam fsm_enumDef_start = 2'd1;
  localparam fsm_enumDef_fetch = 2'd2;

  wire       [5:0]    _zz__zz_io_forward_data_1;
  wire       [31:0]   _zz__zz_io_forward_data_2;
  wire       [7:0]    _zz__zz_io_forward_data_2_1;
  wire       [31:0]   _zz__zz_io_forward_data_2_2;
  wire       [15:0]   _zz__zz_io_forward_data_2_3;
  wire       [31:0]   _zz__zz_io_forward_data_2_4;
  wire       [31:0]   _zz__zz_io_forward_data_2_5;
  wire       [31:0]   _zz__zz_io_forward_data;
  wire       [5:0]    _zz_io_wb_dat_w;
  wire       [5:0]    _zz__zz_io_o_reg_data_d_1;
  wire       [31:0]   _zz__zz_io_o_reg_data_d_2;
  wire       [7:0]    _zz__zz_io_o_reg_data_d_2_1;
  wire       [31:0]   _zz__zz_io_o_reg_data_d_2_2;
  wire       [15:0]   _zz__zz_io_o_reg_data_d_2_3;
  wire       [31:0]   _zz__zz_io_o_reg_data_d_2_4;
  wire       [31:0]   _zz__zz_io_o_reg_data_d_2_5;
  wire       [31:0]   _zz__zz_io_o_reg_data_d;
  wire       [5:0]    _zz_io_wb_dat_w_1;
  wire       [5:0]    _zz__zz_io_o_reg_data_d_4;
  wire       [31:0]   _zz__zz_io_o_reg_data_d_5;
  wire       [7:0]    _zz__zz_io_o_reg_data_d_5_1;
  wire       [31:0]   _zz__zz_io_o_reg_data_d_5_2;
  wire       [15:0]   _zz__zz_io_o_reg_data_d_5_3;
  wire       [31:0]   _zz__zz_io_o_reg_data_d_5_4;
  wire       [31:0]   _zz__zz_io_o_reg_data_d_5_5;
  wire       [31:0]   _zz__zz_io_o_reg_data_d_3;
  wire       [31:0]   mem_adr;
  wire       [1:0]    offset;
  reg        [31:0]   _zz_io_forward_data;
  wire       [31:0]   _zz_io_forward_data_1;
  reg        [31:0]   _zz_io_forward_data_2;
  wire                fsm_wantExit;
  reg                 fsm_wantStart;
  wire                fsm_wantKill;
  reg        [1:0]    fsm_stateReg;
  reg        [1:0]    fsm_stateNext;
  reg        [31:0]   _zz_io_o_reg_data_d;
  wire       [31:0]   _zz_io_o_reg_data_d_1;
  reg        [31:0]   _zz_io_o_reg_data_d_2;
  reg        [31:0]   _zz_io_o_reg_data_d_3;
  wire       [31:0]   _zz_io_o_reg_data_d_4;
  reg        [31:0]   _zz_io_o_reg_data_d_5;
  `ifndef SYNTHESIS
  reg [23:0] io_i_reg_sel_string;
  reg [39:0] fsm_stateReg_string;
  reg [39:0] fsm_stateNext_string;
  `endif


  assign _zz__zz_io_forward_data_1 = (offset * 4'b1000);
  assign _zz__zz_io_forward_data_2_1 = _zz_io_forward_data_1[7 : 0];
  assign _zz__zz_io_forward_data_2 = {{24{_zz__zz_io_forward_data_2_1[7]}}, _zz__zz_io_forward_data_2_1};
  assign _zz__zz_io_forward_data_2_3 = _zz_io_forward_data_1[15 : 0];
  assign _zz__zz_io_forward_data_2_2 = {{16{_zz__zz_io_forward_data_2_3[15]}}, _zz__zz_io_forward_data_2_3};
  assign _zz__zz_io_forward_data_2_5 = _zz_io_forward_data_1[31 : 0];
  assign _zz__zz_io_forward_data_2_4 = _zz__zz_io_forward_data_2_5;
  assign _zz__zz_io_forward_data = (io_i_pc + 32'h00000004);
  assign _zz_io_wb_dat_w = (offset * 4'b1000);
  assign _zz__zz_io_o_reg_data_d_1 = (offset * 4'b1000);
  assign _zz__zz_io_o_reg_data_d_2_1 = _zz_io_o_reg_data_d_1[7 : 0];
  assign _zz__zz_io_o_reg_data_d_2 = {{24{_zz__zz_io_o_reg_data_d_2_1[7]}}, _zz__zz_io_o_reg_data_d_2_1};
  assign _zz__zz_io_o_reg_data_d_2_3 = _zz_io_o_reg_data_d_1[15 : 0];
  assign _zz__zz_io_o_reg_data_d_2_2 = {{16{_zz__zz_io_o_reg_data_d_2_3[15]}}, _zz__zz_io_o_reg_data_d_2_3};
  assign _zz__zz_io_o_reg_data_d_2_5 = _zz_io_o_reg_data_d_1[31 : 0];
  assign _zz__zz_io_o_reg_data_d_2_4 = _zz__zz_io_o_reg_data_d_2_5;
  assign _zz__zz_io_o_reg_data_d = (io_i_pc + 32'h00000004);
  assign _zz_io_wb_dat_w_1 = (offset * 4'b1000);
  assign _zz__zz_io_o_reg_data_d_4 = (offset * 4'b1000);
  assign _zz__zz_io_o_reg_data_d_5_1 = _zz_io_o_reg_data_d_4[7 : 0];
  assign _zz__zz_io_o_reg_data_d_5 = {{24{_zz__zz_io_o_reg_data_d_5_1[7]}}, _zz__zz_io_o_reg_data_d_5_1};
  assign _zz__zz_io_o_reg_data_d_5_3 = _zz_io_o_reg_data_d_4[15 : 0];
  assign _zz__zz_io_o_reg_data_d_5_2 = {{16{_zz__zz_io_o_reg_data_d_5_3[15]}}, _zz__zz_io_o_reg_data_d_5_3};
  assign _zz__zz_io_o_reg_data_d_5_5 = _zz_io_o_reg_data_d_4[31 : 0];
  assign _zz__zz_io_o_reg_data_d_5_4 = _zz__zz_io_o_reg_data_d_5_5;
  assign _zz__zz_io_o_reg_data_d_3 = (io_i_pc + 32'h00000004);
  `ifndef SYNTHESIS
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
  assign io_forward_we = io_i_mem_en;
  assign io_forward_addr = io_i_reg_addr_d;
  always @(*) begin
    case(io_i_reg_sel)
      RegSel_ALU : begin
        _zz_io_forward_data = io_i_alu_y;
      end
      RegSel_MEM : begin
        _zz_io_forward_data = _zz_io_forward_data_2;
      end
      default : begin
        _zz_io_forward_data = _zz__zz_io_forward_data;
      end
    endcase
  end

  assign _zz_io_forward_data_1 = (io_wb_dat_r >>> _zz__zz_io_forward_data_1);
  always @(*) begin
    _zz_io_forward_data_2 = 32'h00000000;
    case(io_i_mem_sel)
      4'b0001 : begin
        _zz_io_forward_data_2 = _zz__zz_io_forward_data_2;
      end
      4'b0011 : begin
        _zz_io_forward_data_2 = _zz__zz_io_forward_data_2_2;
      end
      4'b1111 : begin
        _zz_io_forward_data_2 = _zz__zz_io_forward_data_2_4;
      end
      default : begin
      end
    endcase
  end

  assign io_forward_data = _zz_io_forward_data;
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
        if(io_i_mem_en) begin
          io_wb_stb = 1'b1;
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
        if(io_i_mem_en) begin
          io_wb_we = io_i_mem_we;
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
        if(io_i_mem_en) begin
          io_wb_adr = mem_adr;
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
        if(io_i_mem_en) begin
          io_wb_dat_w = (io_i_reg_data_b <<< _zz_io_wb_dat_w);
        end
      end
      fsm_enumDef_fetch : begin
        io_wb_dat_w = (io_i_reg_data_b <<< _zz_io_wb_dat_w_1);
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    io_wb_sel = 4'b0000;
    case(fsm_stateReg)
      fsm_enumDef_start : begin
        if(io_i_mem_en) begin
          io_wb_sel = (io_i_mem_sel <<< offset);
        end
      end
      fsm_enumDef_fetch : begin
        io_wb_sel = (io_i_mem_sel <<< offset);
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_stateNext = fsm_stateReg;
    case(fsm_stateReg)
      fsm_enumDef_start : begin
        if(io_i_mem_en) begin
          fsm_stateNext = fsm_enumDef_fetch;
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

  always @(*) begin
    case(io_i_reg_sel)
      RegSel_ALU : begin
        _zz_io_o_reg_data_d = io_i_alu_y;
      end
      RegSel_MEM : begin
        _zz_io_o_reg_data_d = _zz_io_o_reg_data_d_2;
      end
      default : begin
        _zz_io_o_reg_data_d = _zz__zz_io_o_reg_data_d;
      end
    endcase
  end

  assign _zz_io_o_reg_data_d_1 = (io_wb_dat_r >>> _zz__zz_io_o_reg_data_d_1);
  always @(*) begin
    _zz_io_o_reg_data_d_2 = 32'h00000000;
    case(io_i_mem_sel)
      4'b0001 : begin
        _zz_io_o_reg_data_d_2 = _zz__zz_io_o_reg_data_d_2;
      end
      4'b0011 : begin
        _zz_io_o_reg_data_d_2 = _zz__zz_io_o_reg_data_d_2_2;
      end
      4'b1111 : begin
        _zz_io_o_reg_data_d_2 = _zz__zz_io_o_reg_data_d_2_4;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    case(io_i_reg_sel)
      RegSel_ALU : begin
        _zz_io_o_reg_data_d_3 = io_i_alu_y;
      end
      RegSel_MEM : begin
        _zz_io_o_reg_data_d_3 = _zz_io_o_reg_data_d_5;
      end
      default : begin
        _zz_io_o_reg_data_d_3 = _zz__zz_io_o_reg_data_d_3;
      end
    endcase
  end

  assign _zz_io_o_reg_data_d_4 = (io_wb_dat_r >>> _zz__zz_io_o_reg_data_d_4);
  always @(*) begin
    _zz_io_o_reg_data_d_5 = 32'h00000000;
    case(io_i_mem_sel)
      4'b0001 : begin
        _zz_io_o_reg_data_d_5 = _zz__zz_io_o_reg_data_d_5;
      end
      4'b0011 : begin
        _zz_io_o_reg_data_d_5 = _zz__zz_io_o_reg_data_d_5_2;
      end
      4'b1111 : begin
        _zz_io_o_reg_data_d_5 = _zz__zz_io_o_reg_data_d_5_4;
      end
      default : begin
      end
    endcase
  end

  always @(posedge sys_clk or posedge sys_reset) begin
    if(sys_reset) begin
      io_o_reg_we <= 1'b0;
      io_o_reg_addr_d <= 5'h00;
      io_o_reg_data_d <= 32'h00000000;
      fsm_stateReg <= fsm_enumDef_BOOT;
    end else begin
      fsm_stateReg <= fsm_stateNext;
      case(fsm_stateReg)
        fsm_enumDef_start : begin
          if(io_i_mem_en) begin
            io_o_reg_we <= 1'b0;
          end else begin
            io_o_reg_we <= io_i_reg_we;
            io_o_reg_addr_d <= io_i_reg_addr_d;
            io_o_reg_data_d <= _zz_io_o_reg_data_d;
          end
        end
        fsm_enumDef_fetch : begin
          io_o_reg_we <= 1'b0;
          if(io_wb_ack) begin
            io_o_reg_we <= io_i_reg_we;
            io_o_reg_addr_d <= io_i_reg_addr_d;
            io_o_reg_data_d <= _zz_io_o_reg_data_d_3;
          end
        end
        default : begin
        end
      endcase
    end
  end


endmodule

module EXE (
  input  wire [31:0]   io_i_pc,
  input  wire [31:0]   io_i_reg_data_a,
  input  wire [31:0]   io_i_reg_data_b,
  input  wire [4:0]    io_i_reg_addr_a,
  input  wire [4:0]    io_i_reg_addr_b,
  input  wire [4:0]    io_i_reg_addr_d,
  input  wire [3:0]    io_i_alu_op,
  input  wire [1:0]    io_i_br_type,
  input  wire [31:0]   io_i_imm,
  input  wire          io_i_use_pc,
  input  wire          io_i_use_rs2,
  input  wire          io_i_mem_en,
  input  wire          io_i_mem_we,
  input  wire [3:0]    io_i_mem_sel,
  input  wire          io_i_reg_we,
  input  wire [1:0]    io_i_reg_sel,
  output reg  [31:0]   io_o_pc,
  output reg  [31:0]   io_o_reg_data_b,
  output reg  [4:0]    io_o_reg_addr_d,
  output reg           io_o_mem_en,
  output reg           io_o_mem_we,
  output reg  [3:0]    io_o_mem_sel,
  output reg           io_o_reg_we,
  output reg  [1:0]    io_o_reg_sel,
  output reg  [31:0]   io_o_alu_y,
  output reg           io_br_br,
  output wire [31:0]   io_br_pc,
  input  wire          io_forward_we,
  input  wire [4:0]    io_forward_addr,
  input  wire [31:0]   io_forward_data,
  input  wire          io_stall,
  output wire          io_flush_req,
  output wire [31:0]   io_alu_a,
  output wire [31:0]   io_alu_b,
  output wire [3:0]    io_alu_op,
  input  wire [31:0]   io_alu_y,
  input  wire          sys_clk,
  input  wire          sys_reset
);
  localparam AluOp_OP1 = 4'd0;
  localparam AluOp_ADD = 4'd1;
  localparam AluOp_SUB = 4'd2;
  localparam AluOp_AND_1 = 4'd3;
  localparam AluOp_OR_1 = 4'd4;
  localparam AluOp_XOR_1 = 4'd5;
  localparam AluOp_NOT_1 = 4'd6;
  localparam AluOp_SLL_1 = 4'd7;
  localparam AluOp_SRL_1 = 4'd8;
  localparam AluOp_SRA_1 = 4'd9;
  localparam AluOp_ROL_1 = 4'd10;
  localparam AluOp_OP2 = 4'd11;
  localparam BrType_F = 2'd0;
  localparam BrType_T = 2'd1;
  localparam BrType_EQ = 2'd2;
  localparam BrType_NE = 2'd3;
  localparam RegSel_ALU = 2'd0;
  localparam RegSel_MEM = 2'd1;
  localparam RegSel_PC = 2'd2;

  wire       [31:0]   _zz_io_br_pc;
  wire       [0:0]    _zz_io_br_pc_1;
  reg        [31:0]   reg_a;
  reg        [31:0]   reg_b;
  wire                when_EXE_l38;
  wire                when_EXE_l39;
  wire                when_EXE_l42;
  `ifndef SYNTHESIS
  reg [39:0] io_i_alu_op_string;
  reg [15:0] io_i_br_type_string;
  reg [23:0] io_i_reg_sel_string;
  reg [23:0] io_o_reg_sel_string;
  reg [39:0] io_alu_op_string;
  `endif


  assign _zz_io_br_pc_1 = io_alu_y[0];
  assign _zz_io_br_pc = {31'd0, _zz_io_br_pc_1};
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
      AluOp_OP2 : io_i_alu_op_string = "OP2  ";
      default : io_i_alu_op_string = "?????";
    endcase
  end
  always @(*) begin
    case(io_i_br_type)
      BrType_F : io_i_br_type_string = "F ";
      BrType_T : io_i_br_type_string = "T ";
      BrType_EQ : io_i_br_type_string = "EQ";
      BrType_NE : io_i_br_type_string = "NE";
      default : io_i_br_type_string = "??";
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
      AluOp_OP2 : io_alu_op_string = "OP2  ";
      default : io_alu_op_string = "?????";
    endcase
  end
  `endif

  always @(*) begin
    reg_a = io_i_reg_data_a;
    if(when_EXE_l38) begin
      if(when_EXE_l39) begin
        reg_a = io_forward_data;
      end
    end
  end

  always @(*) begin
    reg_b = io_i_reg_data_b;
    if(when_EXE_l38) begin
      if(when_EXE_l42) begin
        reg_b = io_forward_data;
      end
    end
  end

  assign when_EXE_l38 = (io_forward_we && (io_forward_addr != 5'h00));
  assign when_EXE_l39 = (io_forward_addr == io_i_reg_addr_a);
  assign when_EXE_l42 = (io_forward_addr == io_i_reg_addr_b);
  assign io_alu_a = (io_i_use_pc ? io_i_pc : reg_a);
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
      default : begin
        io_br_br = (reg_a != reg_b);
      end
    endcase
  end

  assign io_flush_req = io_br_br;
  always @(posedge sys_clk or posedge sys_reset) begin
    if(sys_reset) begin
      io_o_pc <= 32'h00000000;
      io_o_reg_data_b <= 32'h00000000;
      io_o_reg_addr_d <= 5'h00;
      io_o_mem_en <= 1'b0;
      io_o_mem_we <= 1'b0;
      io_o_mem_sel <= 4'b0000;
      io_o_reg_we <= 1'b0;
      io_o_reg_sel <= RegSel_ALU;
      io_o_alu_y <= 32'h00000000;
    end else begin
      if(!io_stall) begin
        io_o_alu_y <= io_alu_y;
        io_o_pc <= io_i_pc;
        io_o_reg_data_b <= reg_b;
        io_o_reg_addr_d <= io_i_reg_addr_d;
        io_o_mem_en <= io_i_mem_en;
        io_o_mem_we <= io_i_mem_we;
        io_o_mem_sel <= io_i_mem_sel;
        io_o_reg_we <= io_i_reg_we;
        io_o_reg_sel <= io_i_reg_sel;
      end
    end
  end


endmodule

module ID (
  input  wire [31:0]   io_i_pc,
  input  wire [31:0]   io_i_instr,
  output reg  [31:0]   io_o_pc,
  output reg  [31:0]   io_o_reg_data_a,
  output reg  [31:0]   io_o_reg_data_b,
  output reg  [4:0]    io_o_reg_addr_a,
  output reg  [4:0]    io_o_reg_addr_b,
  output reg  [4:0]    io_o_reg_addr_d,
  output reg  [3:0]    io_o_alu_op,
  output reg  [1:0]    io_o_br_type,
  output reg  [31:0]   io_o_imm,
  output reg           io_o_use_pc,
  output reg           io_o_use_rs2,
  output reg           io_o_mem_en,
  output reg           io_o_mem_we,
  output reg  [3:0]    io_o_mem_sel,
  output reg           io_o_reg_we,
  output reg  [1:0]    io_o_reg_sel,
  input  wire          io_stall,
  input  wire          io_bubble,
  output wire [4:0]    io_reg_addr_a,
  input  wire [31:0]   io_reg_data_a,
  output wire [4:0]    io_reg_addr_b,
  input  wire [31:0]   io_reg_data_b,
  input  wire          sys_clk,
  input  wire          sys_reset
);
  localparam AluOp_OP1 = 4'd0;
  localparam AluOp_ADD = 4'd1;
  localparam AluOp_SUB = 4'd2;
  localparam AluOp_AND_1 = 4'd3;
  localparam AluOp_OR_1 = 4'd4;
  localparam AluOp_XOR_1 = 4'd5;
  localparam AluOp_NOT_1 = 4'd6;
  localparam AluOp_SLL_1 = 4'd7;
  localparam AluOp_SRL_1 = 4'd8;
  localparam AluOp_SRA_1 = 4'd9;
  localparam AluOp_ROL_1 = 4'd10;
  localparam AluOp_OP2 = 4'd11;
  localparam BrType_F = 2'd0;
  localparam BrType_T = 2'd1;
  localparam BrType_EQ = 2'd2;
  localparam BrType_NE = 2'd3;
  localparam RegSel_ALU = 2'd0;
  localparam RegSel_MEM = 2'd1;
  localparam RegSel_PC = 2'd2;
  localparam Instr_UNK = 5'd0;
  localparam Instr_LUI = 5'd1;
  localparam Instr_AUIPC = 5'd2;
  localparam Instr_JAL = 5'd3;
  localparam Instr_JALR = 5'd4;
  localparam Instr_BEQ = 5'd5;
  localparam Instr_BNE = 5'd6;
  localparam Instr_LB = 5'd7;
  localparam Instr_LW = 5'd8;
  localparam Instr_SB = 5'd9;
  localparam Instr_SW = 5'd10;
  localparam Instr_ADDI = 5'd11;
  localparam Instr_ORI = 5'd12;
  localparam Instr_ANDI = 5'd13;
  localparam Instr_SLLI = 5'd14;
  localparam Instr_SRLI = 5'd15;
  localparam Instr_ADD = 5'd16;
  localparam Instr_XOR_1 = 5'd17;
  localparam Instr_OR_1 = 5'd18;
  localparam Instr_AND_1 = 5'd19;
  localparam InstrType_R = 3'd0;
  localparam InstrType_I = 3'd1;
  localparam InstrType_S = 3'd2;
  localparam InstrType_B = 3'd3;
  localparam InstrType_U = 3'd4;
  localparam InstrType_J = 3'd5;

  wire       [31:0]   _zz__zz_io_o_imm;
  wire       [11:0]   _zz__zz_io_o_imm_1;
  wire       [31:0]   _zz__zz_io_o_imm_2;
  wire       [11:0]   _zz__zz_io_o_imm_3;
  wire       [31:0]   _zz__zz_io_o_imm_4;
  wire       [12:0]   _zz__zz_io_o_imm_5;
  wire       [31:0]   _zz__zz_io_o_imm_6;
  wire       [31:0]   _zz__zz_io_o_imm_7;
  wire       [31:0]   _zz__zz_io_o_imm_8;
  wire       [20:0]   _zz__zz_io_o_imm_9;
  reg        [3:0]    _zz_io_o_alu_op;
  reg        [4:0]    switch_ID_l209;
  wire       [6:0]    switch_ID_l33;
  wire       [2:0]    switch_ID_l47;
  wire       [2:0]    switch_ID_l57;
  wire       [2:0]    switch_ID_l67;
  wire       [2:0]    switch_ID_l80;
  wire       [2:0]    switch_ID_l99;
  reg        [1:0]    _zz_io_o_br_type;
  reg        [4:0]    switch_ID_l263;
  wire       [6:0]    switch_ID_l33_1;
  wire       [2:0]    switch_ID_l47_1;
  wire       [2:0]    switch_ID_l57_1;
  wire       [2:0]    switch_ID_l67_1;
  wire       [2:0]    switch_ID_l80_1;
  wire       [2:0]    switch_ID_l99_1;
  reg        [31:0]   _zz_io_o_imm;
  reg        [2:0]    switch_ID_l172;
  reg        [4:0]    switch_ID_l121;
  wire       [6:0]    switch_ID_l33_2;
  wire       [2:0]    switch_ID_l47_2;
  wire       [2:0]    switch_ID_l57_2;
  wire       [2:0]    switch_ID_l67_2;
  wire       [2:0]    switch_ID_l80_2;
  wire       [2:0]    switch_ID_l99_2;
  reg                 _zz_io_o_use_pc;
  reg        [4:0]    switch_ID_l286;
  wire       [6:0]    switch_ID_l33_3;
  wire       [2:0]    switch_ID_l47_3;
  wire       [2:0]    switch_ID_l57_3;
  wire       [2:0]    switch_ID_l67_3;
  wire       [2:0]    switch_ID_l80_3;
  wire       [2:0]    switch_ID_l99_3;
  reg                 _zz_io_o_use_rs2;
  reg        [4:0]    switch_ID_l301;
  wire       [6:0]    switch_ID_l33_4;
  wire       [2:0]    switch_ID_l47_4;
  wire       [2:0]    switch_ID_l57_4;
  wire       [2:0]    switch_ID_l67_4;
  wire       [2:0]    switch_ID_l80_4;
  wire       [2:0]    switch_ID_l99_4;
  reg                 _zz_io_o_mem_en;
  reg        [4:0]    switch_ID_l316;
  wire       [6:0]    switch_ID_l33_5;
  wire       [2:0]    switch_ID_l47_5;
  wire       [2:0]    switch_ID_l57_5;
  wire       [2:0]    switch_ID_l67_5;
  wire       [2:0]    switch_ID_l80_5;
  wire       [2:0]    switch_ID_l99_5;
  reg                 _zz_io_o_mem_we;
  reg        [4:0]    switch_ID_l331;
  wire       [6:0]    switch_ID_l33_6;
  wire       [2:0]    switch_ID_l47_6;
  wire       [2:0]    switch_ID_l57_6;
  wire       [2:0]    switch_ID_l67_6;
  wire       [2:0]    switch_ID_l80_6;
  wire       [2:0]    switch_ID_l99_6;
  reg        [3:0]    _zz_io_o_mem_sel;
  reg        [4:0]    switch_ID_l344;
  wire       [6:0]    switch_ID_l33_7;
  wire       [2:0]    switch_ID_l47_7;
  wire       [2:0]    switch_ID_l57_7;
  wire       [2:0]    switch_ID_l67_7;
  wire       [2:0]    switch_ID_l80_7;
  wire       [2:0]    switch_ID_l99_7;
  reg                 _zz_io_o_reg_we;
  reg        [4:0]    switch_ID_l363;
  wire       [6:0]    switch_ID_l33_8;
  wire       [2:0]    switch_ID_l47_8;
  wire       [2:0]    switch_ID_l57_8;
  wire       [2:0]    switch_ID_l67_8;
  wire       [2:0]    switch_ID_l80_8;
  wire       [2:0]    switch_ID_l99_8;
  reg        [1:0]    _zz_io_o_reg_sel;
  reg        [4:0]    switch_ID_l389;
  wire       [6:0]    switch_ID_l33_9;
  wire       [2:0]    switch_ID_l47_9;
  wire       [2:0]    switch_ID_l57_9;
  wire       [2:0]    switch_ID_l67_9;
  wire       [2:0]    switch_ID_l80_9;
  wire       [2:0]    switch_ID_l99_9;
  `ifndef SYNTHESIS
  reg [39:0] io_o_alu_op_string;
  reg [15:0] io_o_br_type_string;
  reg [23:0] io_o_reg_sel_string;
  reg [39:0] _zz_io_o_alu_op_string;
  reg [39:0] switch_ID_l209_string;
  reg [15:0] _zz_io_o_br_type_string;
  reg [39:0] switch_ID_l263_string;
  reg [7:0] switch_ID_l172_string;
  reg [39:0] switch_ID_l121_string;
  reg [39:0] switch_ID_l286_string;
  reg [39:0] switch_ID_l301_string;
  reg [39:0] switch_ID_l316_string;
  reg [39:0] switch_ID_l331_string;
  reg [39:0] switch_ID_l344_string;
  reg [39:0] switch_ID_l363_string;
  reg [23:0] _zz_io_o_reg_sel_string;
  reg [39:0] switch_ID_l389_string;
  `endif


  assign _zz__zz_io_o_imm_1 = io_i_instr[31 : 20];
  assign _zz__zz_io_o_imm = {{20{_zz__zz_io_o_imm_1[11]}}, _zz__zz_io_o_imm_1};
  assign _zz__zz_io_o_imm_3 = {io_i_instr[31 : 25],io_i_instr[11 : 7]};
  assign _zz__zz_io_o_imm_2 = {{20{_zz__zz_io_o_imm_3[11]}}, _zz__zz_io_o_imm_3};
  assign _zz__zz_io_o_imm_5 = {{{{io_i_instr[31],io_i_instr[7]},io_i_instr[30 : 25]},io_i_instr[11 : 8]},1'b0};
  assign _zz__zz_io_o_imm_4 = {{19{_zz__zz_io_o_imm_5[12]}}, _zz__zz_io_o_imm_5};
  assign _zz__zz_io_o_imm_7 = {io_i_instr[31 : 12],12'h000};
  assign _zz__zz_io_o_imm_6 = _zz__zz_io_o_imm_7;
  assign _zz__zz_io_o_imm_9 = {{{{io_i_instr[31],io_i_instr[19 : 12]},io_i_instr[20]},io_i_instr[30 : 21]},1'b0};
  assign _zz__zz_io_o_imm_8 = {{11{_zz__zz_io_o_imm_9[20]}}, _zz__zz_io_o_imm_9};
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
      AluOp_OP2 : io_o_alu_op_string = "OP2  ";
      default : io_o_alu_op_string = "?????";
    endcase
  end
  always @(*) begin
    case(io_o_br_type)
      BrType_F : io_o_br_type_string = "F ";
      BrType_T : io_o_br_type_string = "T ";
      BrType_EQ : io_o_br_type_string = "EQ";
      BrType_NE : io_o_br_type_string = "NE";
      default : io_o_br_type_string = "??";
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
    case(_zz_io_o_alu_op)
      AluOp_OP1 : _zz_io_o_alu_op_string = "OP1  ";
      AluOp_ADD : _zz_io_o_alu_op_string = "ADD  ";
      AluOp_SUB : _zz_io_o_alu_op_string = "SUB  ";
      AluOp_AND_1 : _zz_io_o_alu_op_string = "AND_1";
      AluOp_OR_1 : _zz_io_o_alu_op_string = "OR_1 ";
      AluOp_XOR_1 : _zz_io_o_alu_op_string = "XOR_1";
      AluOp_NOT_1 : _zz_io_o_alu_op_string = "NOT_1";
      AluOp_SLL_1 : _zz_io_o_alu_op_string = "SLL_1";
      AluOp_SRL_1 : _zz_io_o_alu_op_string = "SRL_1";
      AluOp_SRA_1 : _zz_io_o_alu_op_string = "SRA_1";
      AluOp_ROL_1 : _zz_io_o_alu_op_string = "ROL_1";
      AluOp_OP2 : _zz_io_o_alu_op_string = "OP2  ";
      default : _zz_io_o_alu_op_string = "?????";
    endcase
  end
  always @(*) begin
    case(switch_ID_l209)
      Instr_UNK : switch_ID_l209_string = "UNK  ";
      Instr_LUI : switch_ID_l209_string = "LUI  ";
      Instr_AUIPC : switch_ID_l209_string = "AUIPC";
      Instr_JAL : switch_ID_l209_string = "JAL  ";
      Instr_JALR : switch_ID_l209_string = "JALR ";
      Instr_BEQ : switch_ID_l209_string = "BEQ  ";
      Instr_BNE : switch_ID_l209_string = "BNE  ";
      Instr_LB : switch_ID_l209_string = "LB   ";
      Instr_LW : switch_ID_l209_string = "LW   ";
      Instr_SB : switch_ID_l209_string = "SB   ";
      Instr_SW : switch_ID_l209_string = "SW   ";
      Instr_ADDI : switch_ID_l209_string = "ADDI ";
      Instr_ORI : switch_ID_l209_string = "ORI  ";
      Instr_ANDI : switch_ID_l209_string = "ANDI ";
      Instr_SLLI : switch_ID_l209_string = "SLLI ";
      Instr_SRLI : switch_ID_l209_string = "SRLI ";
      Instr_ADD : switch_ID_l209_string = "ADD  ";
      Instr_XOR_1 : switch_ID_l209_string = "XOR_1";
      Instr_OR_1 : switch_ID_l209_string = "OR_1 ";
      Instr_AND_1 : switch_ID_l209_string = "AND_1";
      default : switch_ID_l209_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_io_o_br_type)
      BrType_F : _zz_io_o_br_type_string = "F ";
      BrType_T : _zz_io_o_br_type_string = "T ";
      BrType_EQ : _zz_io_o_br_type_string = "EQ";
      BrType_NE : _zz_io_o_br_type_string = "NE";
      default : _zz_io_o_br_type_string = "??";
    endcase
  end
  always @(*) begin
    case(switch_ID_l263)
      Instr_UNK : switch_ID_l263_string = "UNK  ";
      Instr_LUI : switch_ID_l263_string = "LUI  ";
      Instr_AUIPC : switch_ID_l263_string = "AUIPC";
      Instr_JAL : switch_ID_l263_string = "JAL  ";
      Instr_JALR : switch_ID_l263_string = "JALR ";
      Instr_BEQ : switch_ID_l263_string = "BEQ  ";
      Instr_BNE : switch_ID_l263_string = "BNE  ";
      Instr_LB : switch_ID_l263_string = "LB   ";
      Instr_LW : switch_ID_l263_string = "LW   ";
      Instr_SB : switch_ID_l263_string = "SB   ";
      Instr_SW : switch_ID_l263_string = "SW   ";
      Instr_ADDI : switch_ID_l263_string = "ADDI ";
      Instr_ORI : switch_ID_l263_string = "ORI  ";
      Instr_ANDI : switch_ID_l263_string = "ANDI ";
      Instr_SLLI : switch_ID_l263_string = "SLLI ";
      Instr_SRLI : switch_ID_l263_string = "SRLI ";
      Instr_ADD : switch_ID_l263_string = "ADD  ";
      Instr_XOR_1 : switch_ID_l263_string = "XOR_1";
      Instr_OR_1 : switch_ID_l263_string = "OR_1 ";
      Instr_AND_1 : switch_ID_l263_string = "AND_1";
      default : switch_ID_l263_string = "?????";
    endcase
  end
  always @(*) begin
    case(switch_ID_l172)
      InstrType_R : switch_ID_l172_string = "R";
      InstrType_I : switch_ID_l172_string = "I";
      InstrType_S : switch_ID_l172_string = "S";
      InstrType_B : switch_ID_l172_string = "B";
      InstrType_U : switch_ID_l172_string = "U";
      InstrType_J : switch_ID_l172_string = "J";
      default : switch_ID_l172_string = "?";
    endcase
  end
  always @(*) begin
    case(switch_ID_l121)
      Instr_UNK : switch_ID_l121_string = "UNK  ";
      Instr_LUI : switch_ID_l121_string = "LUI  ";
      Instr_AUIPC : switch_ID_l121_string = "AUIPC";
      Instr_JAL : switch_ID_l121_string = "JAL  ";
      Instr_JALR : switch_ID_l121_string = "JALR ";
      Instr_BEQ : switch_ID_l121_string = "BEQ  ";
      Instr_BNE : switch_ID_l121_string = "BNE  ";
      Instr_LB : switch_ID_l121_string = "LB   ";
      Instr_LW : switch_ID_l121_string = "LW   ";
      Instr_SB : switch_ID_l121_string = "SB   ";
      Instr_SW : switch_ID_l121_string = "SW   ";
      Instr_ADDI : switch_ID_l121_string = "ADDI ";
      Instr_ORI : switch_ID_l121_string = "ORI  ";
      Instr_ANDI : switch_ID_l121_string = "ANDI ";
      Instr_SLLI : switch_ID_l121_string = "SLLI ";
      Instr_SRLI : switch_ID_l121_string = "SRLI ";
      Instr_ADD : switch_ID_l121_string = "ADD  ";
      Instr_XOR_1 : switch_ID_l121_string = "XOR_1";
      Instr_OR_1 : switch_ID_l121_string = "OR_1 ";
      Instr_AND_1 : switch_ID_l121_string = "AND_1";
      default : switch_ID_l121_string = "?????";
    endcase
  end
  always @(*) begin
    case(switch_ID_l286)
      Instr_UNK : switch_ID_l286_string = "UNK  ";
      Instr_LUI : switch_ID_l286_string = "LUI  ";
      Instr_AUIPC : switch_ID_l286_string = "AUIPC";
      Instr_JAL : switch_ID_l286_string = "JAL  ";
      Instr_JALR : switch_ID_l286_string = "JALR ";
      Instr_BEQ : switch_ID_l286_string = "BEQ  ";
      Instr_BNE : switch_ID_l286_string = "BNE  ";
      Instr_LB : switch_ID_l286_string = "LB   ";
      Instr_LW : switch_ID_l286_string = "LW   ";
      Instr_SB : switch_ID_l286_string = "SB   ";
      Instr_SW : switch_ID_l286_string = "SW   ";
      Instr_ADDI : switch_ID_l286_string = "ADDI ";
      Instr_ORI : switch_ID_l286_string = "ORI  ";
      Instr_ANDI : switch_ID_l286_string = "ANDI ";
      Instr_SLLI : switch_ID_l286_string = "SLLI ";
      Instr_SRLI : switch_ID_l286_string = "SRLI ";
      Instr_ADD : switch_ID_l286_string = "ADD  ";
      Instr_XOR_1 : switch_ID_l286_string = "XOR_1";
      Instr_OR_1 : switch_ID_l286_string = "OR_1 ";
      Instr_AND_1 : switch_ID_l286_string = "AND_1";
      default : switch_ID_l286_string = "?????";
    endcase
  end
  always @(*) begin
    case(switch_ID_l301)
      Instr_UNK : switch_ID_l301_string = "UNK  ";
      Instr_LUI : switch_ID_l301_string = "LUI  ";
      Instr_AUIPC : switch_ID_l301_string = "AUIPC";
      Instr_JAL : switch_ID_l301_string = "JAL  ";
      Instr_JALR : switch_ID_l301_string = "JALR ";
      Instr_BEQ : switch_ID_l301_string = "BEQ  ";
      Instr_BNE : switch_ID_l301_string = "BNE  ";
      Instr_LB : switch_ID_l301_string = "LB   ";
      Instr_LW : switch_ID_l301_string = "LW   ";
      Instr_SB : switch_ID_l301_string = "SB   ";
      Instr_SW : switch_ID_l301_string = "SW   ";
      Instr_ADDI : switch_ID_l301_string = "ADDI ";
      Instr_ORI : switch_ID_l301_string = "ORI  ";
      Instr_ANDI : switch_ID_l301_string = "ANDI ";
      Instr_SLLI : switch_ID_l301_string = "SLLI ";
      Instr_SRLI : switch_ID_l301_string = "SRLI ";
      Instr_ADD : switch_ID_l301_string = "ADD  ";
      Instr_XOR_1 : switch_ID_l301_string = "XOR_1";
      Instr_OR_1 : switch_ID_l301_string = "OR_1 ";
      Instr_AND_1 : switch_ID_l301_string = "AND_1";
      default : switch_ID_l301_string = "?????";
    endcase
  end
  always @(*) begin
    case(switch_ID_l316)
      Instr_UNK : switch_ID_l316_string = "UNK  ";
      Instr_LUI : switch_ID_l316_string = "LUI  ";
      Instr_AUIPC : switch_ID_l316_string = "AUIPC";
      Instr_JAL : switch_ID_l316_string = "JAL  ";
      Instr_JALR : switch_ID_l316_string = "JALR ";
      Instr_BEQ : switch_ID_l316_string = "BEQ  ";
      Instr_BNE : switch_ID_l316_string = "BNE  ";
      Instr_LB : switch_ID_l316_string = "LB   ";
      Instr_LW : switch_ID_l316_string = "LW   ";
      Instr_SB : switch_ID_l316_string = "SB   ";
      Instr_SW : switch_ID_l316_string = "SW   ";
      Instr_ADDI : switch_ID_l316_string = "ADDI ";
      Instr_ORI : switch_ID_l316_string = "ORI  ";
      Instr_ANDI : switch_ID_l316_string = "ANDI ";
      Instr_SLLI : switch_ID_l316_string = "SLLI ";
      Instr_SRLI : switch_ID_l316_string = "SRLI ";
      Instr_ADD : switch_ID_l316_string = "ADD  ";
      Instr_XOR_1 : switch_ID_l316_string = "XOR_1";
      Instr_OR_1 : switch_ID_l316_string = "OR_1 ";
      Instr_AND_1 : switch_ID_l316_string = "AND_1";
      default : switch_ID_l316_string = "?????";
    endcase
  end
  always @(*) begin
    case(switch_ID_l331)
      Instr_UNK : switch_ID_l331_string = "UNK  ";
      Instr_LUI : switch_ID_l331_string = "LUI  ";
      Instr_AUIPC : switch_ID_l331_string = "AUIPC";
      Instr_JAL : switch_ID_l331_string = "JAL  ";
      Instr_JALR : switch_ID_l331_string = "JALR ";
      Instr_BEQ : switch_ID_l331_string = "BEQ  ";
      Instr_BNE : switch_ID_l331_string = "BNE  ";
      Instr_LB : switch_ID_l331_string = "LB   ";
      Instr_LW : switch_ID_l331_string = "LW   ";
      Instr_SB : switch_ID_l331_string = "SB   ";
      Instr_SW : switch_ID_l331_string = "SW   ";
      Instr_ADDI : switch_ID_l331_string = "ADDI ";
      Instr_ORI : switch_ID_l331_string = "ORI  ";
      Instr_ANDI : switch_ID_l331_string = "ANDI ";
      Instr_SLLI : switch_ID_l331_string = "SLLI ";
      Instr_SRLI : switch_ID_l331_string = "SRLI ";
      Instr_ADD : switch_ID_l331_string = "ADD  ";
      Instr_XOR_1 : switch_ID_l331_string = "XOR_1";
      Instr_OR_1 : switch_ID_l331_string = "OR_1 ";
      Instr_AND_1 : switch_ID_l331_string = "AND_1";
      default : switch_ID_l331_string = "?????";
    endcase
  end
  always @(*) begin
    case(switch_ID_l344)
      Instr_UNK : switch_ID_l344_string = "UNK  ";
      Instr_LUI : switch_ID_l344_string = "LUI  ";
      Instr_AUIPC : switch_ID_l344_string = "AUIPC";
      Instr_JAL : switch_ID_l344_string = "JAL  ";
      Instr_JALR : switch_ID_l344_string = "JALR ";
      Instr_BEQ : switch_ID_l344_string = "BEQ  ";
      Instr_BNE : switch_ID_l344_string = "BNE  ";
      Instr_LB : switch_ID_l344_string = "LB   ";
      Instr_LW : switch_ID_l344_string = "LW   ";
      Instr_SB : switch_ID_l344_string = "SB   ";
      Instr_SW : switch_ID_l344_string = "SW   ";
      Instr_ADDI : switch_ID_l344_string = "ADDI ";
      Instr_ORI : switch_ID_l344_string = "ORI  ";
      Instr_ANDI : switch_ID_l344_string = "ANDI ";
      Instr_SLLI : switch_ID_l344_string = "SLLI ";
      Instr_SRLI : switch_ID_l344_string = "SRLI ";
      Instr_ADD : switch_ID_l344_string = "ADD  ";
      Instr_XOR_1 : switch_ID_l344_string = "XOR_1";
      Instr_OR_1 : switch_ID_l344_string = "OR_1 ";
      Instr_AND_1 : switch_ID_l344_string = "AND_1";
      default : switch_ID_l344_string = "?????";
    endcase
  end
  always @(*) begin
    case(switch_ID_l363)
      Instr_UNK : switch_ID_l363_string = "UNK  ";
      Instr_LUI : switch_ID_l363_string = "LUI  ";
      Instr_AUIPC : switch_ID_l363_string = "AUIPC";
      Instr_JAL : switch_ID_l363_string = "JAL  ";
      Instr_JALR : switch_ID_l363_string = "JALR ";
      Instr_BEQ : switch_ID_l363_string = "BEQ  ";
      Instr_BNE : switch_ID_l363_string = "BNE  ";
      Instr_LB : switch_ID_l363_string = "LB   ";
      Instr_LW : switch_ID_l363_string = "LW   ";
      Instr_SB : switch_ID_l363_string = "SB   ";
      Instr_SW : switch_ID_l363_string = "SW   ";
      Instr_ADDI : switch_ID_l363_string = "ADDI ";
      Instr_ORI : switch_ID_l363_string = "ORI  ";
      Instr_ANDI : switch_ID_l363_string = "ANDI ";
      Instr_SLLI : switch_ID_l363_string = "SLLI ";
      Instr_SRLI : switch_ID_l363_string = "SRLI ";
      Instr_ADD : switch_ID_l363_string = "ADD  ";
      Instr_XOR_1 : switch_ID_l363_string = "XOR_1";
      Instr_OR_1 : switch_ID_l363_string = "OR_1 ";
      Instr_AND_1 : switch_ID_l363_string = "AND_1";
      default : switch_ID_l363_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_io_o_reg_sel)
      RegSel_ALU : _zz_io_o_reg_sel_string = "ALU";
      RegSel_MEM : _zz_io_o_reg_sel_string = "MEM";
      RegSel_PC : _zz_io_o_reg_sel_string = "PC ";
      default : _zz_io_o_reg_sel_string = "???";
    endcase
  end
  always @(*) begin
    case(switch_ID_l389)
      Instr_UNK : switch_ID_l389_string = "UNK  ";
      Instr_LUI : switch_ID_l389_string = "LUI  ";
      Instr_AUIPC : switch_ID_l389_string = "AUIPC";
      Instr_JAL : switch_ID_l389_string = "JAL  ";
      Instr_JALR : switch_ID_l389_string = "JALR ";
      Instr_BEQ : switch_ID_l389_string = "BEQ  ";
      Instr_BNE : switch_ID_l389_string = "BNE  ";
      Instr_LB : switch_ID_l389_string = "LB   ";
      Instr_LW : switch_ID_l389_string = "LW   ";
      Instr_SB : switch_ID_l389_string = "SB   ";
      Instr_SW : switch_ID_l389_string = "SW   ";
      Instr_ADDI : switch_ID_l389_string = "ADDI ";
      Instr_ORI : switch_ID_l389_string = "ORI  ";
      Instr_ANDI : switch_ID_l389_string = "ANDI ";
      Instr_SLLI : switch_ID_l389_string = "SLLI ";
      Instr_SRLI : switch_ID_l389_string = "SRLI ";
      Instr_ADD : switch_ID_l389_string = "ADD  ";
      Instr_XOR_1 : switch_ID_l389_string = "XOR_1";
      Instr_OR_1 : switch_ID_l389_string = "OR_1 ";
      Instr_AND_1 : switch_ID_l389_string = "AND_1";
      default : switch_ID_l389_string = "?????";
    endcase
  end
  `endif

  assign io_reg_addr_a = io_i_instr[19 : 15];
  assign io_reg_addr_b = io_i_instr[24 : 20];
  always @(*) begin
    _zz_io_o_alu_op = AluOp_ADD;
    case(switch_ID_l209)
      Instr_AUIPC, Instr_JAL, Instr_JALR, Instr_BEQ, Instr_BNE, Instr_LB, Instr_LW, Instr_SB, Instr_SW, Instr_ADDI, Instr_ADD : begin
        _zz_io_o_alu_op = AluOp_ADD;
      end
      Instr_ANDI, Instr_AND_1 : begin
        _zz_io_o_alu_op = AluOp_AND_1;
      end
      Instr_ORI, Instr_OR_1 : begin
        _zz_io_o_alu_op = AluOp_OR_1;
      end
      Instr_XOR_1 : begin
        _zz_io_o_alu_op = AluOp_XOR_1;
      end
      Instr_SLLI : begin
        _zz_io_o_alu_op = AluOp_SLL_1;
      end
      Instr_SRLI : begin
        _zz_io_o_alu_op = AluOp_SRL_1;
      end
      Instr_LUI : begin
        _zz_io_o_alu_op = AluOp_OP2;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    switch_ID_l209 = Instr_UNK;
    case(switch_ID_l33)
      7'h37 : begin
        switch_ID_l209 = Instr_LUI;
      end
      7'h17 : begin
        switch_ID_l209 = Instr_AUIPC;
      end
      7'h6f : begin
        switch_ID_l209 = Instr_JAL;
      end
      7'h67 : begin
        switch_ID_l209 = Instr_JALR;
      end
      7'h63 : begin
        case(switch_ID_l47)
          3'b000 : begin
            switch_ID_l209 = Instr_BEQ;
          end
          3'b001 : begin
            switch_ID_l209 = Instr_BNE;
          end
          default : begin
          end
        endcase
      end
      7'h03 : begin
        case(switch_ID_l57)
          3'b000 : begin
            switch_ID_l209 = Instr_LB;
          end
          3'b010 : begin
            switch_ID_l209 = Instr_LW;
          end
          default : begin
          end
        endcase
      end
      7'h23 : begin
        case(switch_ID_l67)
          3'b000 : begin
            switch_ID_l209 = Instr_SB;
          end
          3'b010 : begin
            switch_ID_l209 = Instr_SW;
          end
          default : begin
            switch_ID_l209 = Instr_UNK;
          end
        endcase
      end
      7'h13 : begin
        case(switch_ID_l80)
          3'b000 : begin
            switch_ID_l209 = Instr_ADDI;
          end
          3'b110 : begin
            switch_ID_l209 = Instr_ORI;
          end
          3'b111 : begin
            switch_ID_l209 = Instr_ANDI;
          end
          3'b001 : begin
            switch_ID_l209 = Instr_SLLI;
          end
          3'b101 : begin
            switch_ID_l209 = Instr_SRLI;
          end
          default : begin
          end
        endcase
      end
      7'h33 : begin
        case(switch_ID_l99)
          3'b000 : begin
            switch_ID_l209 = Instr_ADD;
          end
          3'b100 : begin
            switch_ID_l209 = Instr_XOR_1;
          end
          3'b110 : begin
            switch_ID_l209 = Instr_OR_1;
          end
          3'b111 : begin
            switch_ID_l209 = Instr_AND_1;
          end
          default : begin
          end
        endcase
      end
      default : begin
      end
    endcase
  end

  assign switch_ID_l33 = io_i_instr[6 : 0];
  assign switch_ID_l47 = io_i_instr[14 : 12];
  assign switch_ID_l57 = io_i_instr[14 : 12];
  assign switch_ID_l67 = io_i_instr[14 : 12];
  assign switch_ID_l80 = io_i_instr[14 : 12];
  assign switch_ID_l99 = io_i_instr[14 : 12];
  always @(*) begin
    _zz_io_o_br_type = BrType_F;
    case(switch_ID_l263)
      Instr_JAL, Instr_JALR : begin
        _zz_io_o_br_type = BrType_T;
      end
      Instr_BEQ : begin
        _zz_io_o_br_type = BrType_EQ;
      end
      Instr_BNE : begin
        _zz_io_o_br_type = BrType_NE;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    switch_ID_l263 = Instr_UNK;
    case(switch_ID_l33_1)
      7'h37 : begin
        switch_ID_l263 = Instr_LUI;
      end
      7'h17 : begin
        switch_ID_l263 = Instr_AUIPC;
      end
      7'h6f : begin
        switch_ID_l263 = Instr_JAL;
      end
      7'h67 : begin
        switch_ID_l263 = Instr_JALR;
      end
      7'h63 : begin
        case(switch_ID_l47_1)
          3'b000 : begin
            switch_ID_l263 = Instr_BEQ;
          end
          3'b001 : begin
            switch_ID_l263 = Instr_BNE;
          end
          default : begin
          end
        endcase
      end
      7'h03 : begin
        case(switch_ID_l57_1)
          3'b000 : begin
            switch_ID_l263 = Instr_LB;
          end
          3'b010 : begin
            switch_ID_l263 = Instr_LW;
          end
          default : begin
          end
        endcase
      end
      7'h23 : begin
        case(switch_ID_l67_1)
          3'b000 : begin
            switch_ID_l263 = Instr_SB;
          end
          3'b010 : begin
            switch_ID_l263 = Instr_SW;
          end
          default : begin
            switch_ID_l263 = Instr_UNK;
          end
        endcase
      end
      7'h13 : begin
        case(switch_ID_l80_1)
          3'b000 : begin
            switch_ID_l263 = Instr_ADDI;
          end
          3'b110 : begin
            switch_ID_l263 = Instr_ORI;
          end
          3'b111 : begin
            switch_ID_l263 = Instr_ANDI;
          end
          3'b001 : begin
            switch_ID_l263 = Instr_SLLI;
          end
          3'b101 : begin
            switch_ID_l263 = Instr_SRLI;
          end
          default : begin
          end
        endcase
      end
      7'h33 : begin
        case(switch_ID_l99_1)
          3'b000 : begin
            switch_ID_l263 = Instr_ADD;
          end
          3'b100 : begin
            switch_ID_l263 = Instr_XOR_1;
          end
          3'b110 : begin
            switch_ID_l263 = Instr_OR_1;
          end
          3'b111 : begin
            switch_ID_l263 = Instr_AND_1;
          end
          default : begin
          end
        endcase
      end
      default : begin
      end
    endcase
  end

  assign switch_ID_l33_1 = io_i_instr[6 : 0];
  assign switch_ID_l47_1 = io_i_instr[14 : 12];
  assign switch_ID_l57_1 = io_i_instr[14 : 12];
  assign switch_ID_l67_1 = io_i_instr[14 : 12];
  assign switch_ID_l80_1 = io_i_instr[14 : 12];
  assign switch_ID_l99_1 = io_i_instr[14 : 12];
  always @(*) begin
    switch_ID_l172 = InstrType_I;
    case(switch_ID_l121)
      Instr_ADD, Instr_XOR_1, Instr_OR_1, Instr_AND_1 : begin
        switch_ID_l172 = InstrType_R;
      end
      Instr_JALR, Instr_ADDI, Instr_ORI, Instr_ANDI, Instr_SLLI, Instr_SRLI, Instr_LB, Instr_LW : begin
        switch_ID_l172 = InstrType_I;
      end
      Instr_SB, Instr_SW : begin
        switch_ID_l172 = InstrType_S;
      end
      Instr_BEQ, Instr_BNE : begin
        switch_ID_l172 = InstrType_B;
      end
      Instr_LUI, Instr_AUIPC : begin
        switch_ID_l172 = InstrType_U;
      end
      Instr_JAL : begin
        switch_ID_l172 = InstrType_J;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    switch_ID_l121 = Instr_UNK;
    case(switch_ID_l33_2)
      7'h37 : begin
        switch_ID_l121 = Instr_LUI;
      end
      7'h17 : begin
        switch_ID_l121 = Instr_AUIPC;
      end
      7'h6f : begin
        switch_ID_l121 = Instr_JAL;
      end
      7'h67 : begin
        switch_ID_l121 = Instr_JALR;
      end
      7'h63 : begin
        case(switch_ID_l47_2)
          3'b000 : begin
            switch_ID_l121 = Instr_BEQ;
          end
          3'b001 : begin
            switch_ID_l121 = Instr_BNE;
          end
          default : begin
          end
        endcase
      end
      7'h03 : begin
        case(switch_ID_l57_2)
          3'b000 : begin
            switch_ID_l121 = Instr_LB;
          end
          3'b010 : begin
            switch_ID_l121 = Instr_LW;
          end
          default : begin
          end
        endcase
      end
      7'h23 : begin
        case(switch_ID_l67_2)
          3'b000 : begin
            switch_ID_l121 = Instr_SB;
          end
          3'b010 : begin
            switch_ID_l121 = Instr_SW;
          end
          default : begin
            switch_ID_l121 = Instr_UNK;
          end
        endcase
      end
      7'h13 : begin
        case(switch_ID_l80_2)
          3'b000 : begin
            switch_ID_l121 = Instr_ADDI;
          end
          3'b110 : begin
            switch_ID_l121 = Instr_ORI;
          end
          3'b111 : begin
            switch_ID_l121 = Instr_ANDI;
          end
          3'b001 : begin
            switch_ID_l121 = Instr_SLLI;
          end
          3'b101 : begin
            switch_ID_l121 = Instr_SRLI;
          end
          default : begin
          end
        endcase
      end
      7'h33 : begin
        case(switch_ID_l99_2)
          3'b000 : begin
            switch_ID_l121 = Instr_ADD;
          end
          3'b100 : begin
            switch_ID_l121 = Instr_XOR_1;
          end
          3'b110 : begin
            switch_ID_l121 = Instr_OR_1;
          end
          3'b111 : begin
            switch_ID_l121 = Instr_AND_1;
          end
          default : begin
          end
        endcase
      end
      default : begin
      end
    endcase
  end

  assign switch_ID_l33_2 = io_i_instr[6 : 0];
  assign switch_ID_l47_2 = io_i_instr[14 : 12];
  assign switch_ID_l57_2 = io_i_instr[14 : 12];
  assign switch_ID_l67_2 = io_i_instr[14 : 12];
  assign switch_ID_l80_2 = io_i_instr[14 : 12];
  assign switch_ID_l99_2 = io_i_instr[14 : 12];
  always @(*) begin
    case(switch_ID_l172)
      InstrType_R : begin
        _zz_io_o_imm = 32'h00000000;
      end
      InstrType_I : begin
        _zz_io_o_imm = _zz__zz_io_o_imm;
      end
      InstrType_S : begin
        _zz_io_o_imm = _zz__zz_io_o_imm_2;
      end
      InstrType_B : begin
        _zz_io_o_imm = _zz__zz_io_o_imm_4;
      end
      InstrType_U : begin
        _zz_io_o_imm = _zz__zz_io_o_imm_6;
      end
      default : begin
        _zz_io_o_imm = _zz__zz_io_o_imm_8;
      end
    endcase
  end

  always @(*) begin
    _zz_io_o_use_pc = 1'b0;
    case(switch_ID_l286)
      Instr_AUIPC, Instr_JAL, Instr_BEQ, Instr_BNE : begin
        _zz_io_o_use_pc = 1'b1;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    switch_ID_l286 = Instr_UNK;
    case(switch_ID_l33_3)
      7'h37 : begin
        switch_ID_l286 = Instr_LUI;
      end
      7'h17 : begin
        switch_ID_l286 = Instr_AUIPC;
      end
      7'h6f : begin
        switch_ID_l286 = Instr_JAL;
      end
      7'h67 : begin
        switch_ID_l286 = Instr_JALR;
      end
      7'h63 : begin
        case(switch_ID_l47_3)
          3'b000 : begin
            switch_ID_l286 = Instr_BEQ;
          end
          3'b001 : begin
            switch_ID_l286 = Instr_BNE;
          end
          default : begin
          end
        endcase
      end
      7'h03 : begin
        case(switch_ID_l57_3)
          3'b000 : begin
            switch_ID_l286 = Instr_LB;
          end
          3'b010 : begin
            switch_ID_l286 = Instr_LW;
          end
          default : begin
          end
        endcase
      end
      7'h23 : begin
        case(switch_ID_l67_3)
          3'b000 : begin
            switch_ID_l286 = Instr_SB;
          end
          3'b010 : begin
            switch_ID_l286 = Instr_SW;
          end
          default : begin
            switch_ID_l286 = Instr_UNK;
          end
        endcase
      end
      7'h13 : begin
        case(switch_ID_l80_3)
          3'b000 : begin
            switch_ID_l286 = Instr_ADDI;
          end
          3'b110 : begin
            switch_ID_l286 = Instr_ORI;
          end
          3'b111 : begin
            switch_ID_l286 = Instr_ANDI;
          end
          3'b001 : begin
            switch_ID_l286 = Instr_SLLI;
          end
          3'b101 : begin
            switch_ID_l286 = Instr_SRLI;
          end
          default : begin
          end
        endcase
      end
      7'h33 : begin
        case(switch_ID_l99_3)
          3'b000 : begin
            switch_ID_l286 = Instr_ADD;
          end
          3'b100 : begin
            switch_ID_l286 = Instr_XOR_1;
          end
          3'b110 : begin
            switch_ID_l286 = Instr_OR_1;
          end
          3'b111 : begin
            switch_ID_l286 = Instr_AND_1;
          end
          default : begin
          end
        endcase
      end
      default : begin
      end
    endcase
  end

  assign switch_ID_l33_3 = io_i_instr[6 : 0];
  assign switch_ID_l47_3 = io_i_instr[14 : 12];
  assign switch_ID_l57_3 = io_i_instr[14 : 12];
  assign switch_ID_l67_3 = io_i_instr[14 : 12];
  assign switch_ID_l80_3 = io_i_instr[14 : 12];
  assign switch_ID_l99_3 = io_i_instr[14 : 12];
  always @(*) begin
    _zz_io_o_use_rs2 = 1'b0;
    case(switch_ID_l301)
      Instr_ADD, Instr_XOR_1, Instr_OR_1, Instr_AND_1 : begin
        _zz_io_o_use_rs2 = 1'b1;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    switch_ID_l301 = Instr_UNK;
    case(switch_ID_l33_4)
      7'h37 : begin
        switch_ID_l301 = Instr_LUI;
      end
      7'h17 : begin
        switch_ID_l301 = Instr_AUIPC;
      end
      7'h6f : begin
        switch_ID_l301 = Instr_JAL;
      end
      7'h67 : begin
        switch_ID_l301 = Instr_JALR;
      end
      7'h63 : begin
        case(switch_ID_l47_4)
          3'b000 : begin
            switch_ID_l301 = Instr_BEQ;
          end
          3'b001 : begin
            switch_ID_l301 = Instr_BNE;
          end
          default : begin
          end
        endcase
      end
      7'h03 : begin
        case(switch_ID_l57_4)
          3'b000 : begin
            switch_ID_l301 = Instr_LB;
          end
          3'b010 : begin
            switch_ID_l301 = Instr_LW;
          end
          default : begin
          end
        endcase
      end
      7'h23 : begin
        case(switch_ID_l67_4)
          3'b000 : begin
            switch_ID_l301 = Instr_SB;
          end
          3'b010 : begin
            switch_ID_l301 = Instr_SW;
          end
          default : begin
            switch_ID_l301 = Instr_UNK;
          end
        endcase
      end
      7'h13 : begin
        case(switch_ID_l80_4)
          3'b000 : begin
            switch_ID_l301 = Instr_ADDI;
          end
          3'b110 : begin
            switch_ID_l301 = Instr_ORI;
          end
          3'b111 : begin
            switch_ID_l301 = Instr_ANDI;
          end
          3'b001 : begin
            switch_ID_l301 = Instr_SLLI;
          end
          3'b101 : begin
            switch_ID_l301 = Instr_SRLI;
          end
          default : begin
          end
        endcase
      end
      7'h33 : begin
        case(switch_ID_l99_4)
          3'b000 : begin
            switch_ID_l301 = Instr_ADD;
          end
          3'b100 : begin
            switch_ID_l301 = Instr_XOR_1;
          end
          3'b110 : begin
            switch_ID_l301 = Instr_OR_1;
          end
          3'b111 : begin
            switch_ID_l301 = Instr_AND_1;
          end
          default : begin
          end
        endcase
      end
      default : begin
      end
    endcase
  end

  assign switch_ID_l33_4 = io_i_instr[6 : 0];
  assign switch_ID_l47_4 = io_i_instr[14 : 12];
  assign switch_ID_l57_4 = io_i_instr[14 : 12];
  assign switch_ID_l67_4 = io_i_instr[14 : 12];
  assign switch_ID_l80_4 = io_i_instr[14 : 12];
  assign switch_ID_l99_4 = io_i_instr[14 : 12];
  always @(*) begin
    _zz_io_o_mem_en = 1'b0;
    case(switch_ID_l316)
      Instr_LB, Instr_LW, Instr_SB, Instr_SW : begin
        _zz_io_o_mem_en = 1'b1;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    switch_ID_l316 = Instr_UNK;
    case(switch_ID_l33_5)
      7'h37 : begin
        switch_ID_l316 = Instr_LUI;
      end
      7'h17 : begin
        switch_ID_l316 = Instr_AUIPC;
      end
      7'h6f : begin
        switch_ID_l316 = Instr_JAL;
      end
      7'h67 : begin
        switch_ID_l316 = Instr_JALR;
      end
      7'h63 : begin
        case(switch_ID_l47_5)
          3'b000 : begin
            switch_ID_l316 = Instr_BEQ;
          end
          3'b001 : begin
            switch_ID_l316 = Instr_BNE;
          end
          default : begin
          end
        endcase
      end
      7'h03 : begin
        case(switch_ID_l57_5)
          3'b000 : begin
            switch_ID_l316 = Instr_LB;
          end
          3'b010 : begin
            switch_ID_l316 = Instr_LW;
          end
          default : begin
          end
        endcase
      end
      7'h23 : begin
        case(switch_ID_l67_5)
          3'b000 : begin
            switch_ID_l316 = Instr_SB;
          end
          3'b010 : begin
            switch_ID_l316 = Instr_SW;
          end
          default : begin
            switch_ID_l316 = Instr_UNK;
          end
        endcase
      end
      7'h13 : begin
        case(switch_ID_l80_5)
          3'b000 : begin
            switch_ID_l316 = Instr_ADDI;
          end
          3'b110 : begin
            switch_ID_l316 = Instr_ORI;
          end
          3'b111 : begin
            switch_ID_l316 = Instr_ANDI;
          end
          3'b001 : begin
            switch_ID_l316 = Instr_SLLI;
          end
          3'b101 : begin
            switch_ID_l316 = Instr_SRLI;
          end
          default : begin
          end
        endcase
      end
      7'h33 : begin
        case(switch_ID_l99_5)
          3'b000 : begin
            switch_ID_l316 = Instr_ADD;
          end
          3'b100 : begin
            switch_ID_l316 = Instr_XOR_1;
          end
          3'b110 : begin
            switch_ID_l316 = Instr_OR_1;
          end
          3'b111 : begin
            switch_ID_l316 = Instr_AND_1;
          end
          default : begin
          end
        endcase
      end
      default : begin
      end
    endcase
  end

  assign switch_ID_l33_5 = io_i_instr[6 : 0];
  assign switch_ID_l47_5 = io_i_instr[14 : 12];
  assign switch_ID_l57_5 = io_i_instr[14 : 12];
  assign switch_ID_l67_5 = io_i_instr[14 : 12];
  assign switch_ID_l80_5 = io_i_instr[14 : 12];
  assign switch_ID_l99_5 = io_i_instr[14 : 12];
  always @(*) begin
    _zz_io_o_mem_we = 1'b0;
    case(switch_ID_l331)
      Instr_SB, Instr_SW : begin
        _zz_io_o_mem_we = 1'b1;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    switch_ID_l331 = Instr_UNK;
    case(switch_ID_l33_6)
      7'h37 : begin
        switch_ID_l331 = Instr_LUI;
      end
      7'h17 : begin
        switch_ID_l331 = Instr_AUIPC;
      end
      7'h6f : begin
        switch_ID_l331 = Instr_JAL;
      end
      7'h67 : begin
        switch_ID_l331 = Instr_JALR;
      end
      7'h63 : begin
        case(switch_ID_l47_6)
          3'b000 : begin
            switch_ID_l331 = Instr_BEQ;
          end
          3'b001 : begin
            switch_ID_l331 = Instr_BNE;
          end
          default : begin
          end
        endcase
      end
      7'h03 : begin
        case(switch_ID_l57_6)
          3'b000 : begin
            switch_ID_l331 = Instr_LB;
          end
          3'b010 : begin
            switch_ID_l331 = Instr_LW;
          end
          default : begin
          end
        endcase
      end
      7'h23 : begin
        case(switch_ID_l67_6)
          3'b000 : begin
            switch_ID_l331 = Instr_SB;
          end
          3'b010 : begin
            switch_ID_l331 = Instr_SW;
          end
          default : begin
            switch_ID_l331 = Instr_UNK;
          end
        endcase
      end
      7'h13 : begin
        case(switch_ID_l80_6)
          3'b000 : begin
            switch_ID_l331 = Instr_ADDI;
          end
          3'b110 : begin
            switch_ID_l331 = Instr_ORI;
          end
          3'b111 : begin
            switch_ID_l331 = Instr_ANDI;
          end
          3'b001 : begin
            switch_ID_l331 = Instr_SLLI;
          end
          3'b101 : begin
            switch_ID_l331 = Instr_SRLI;
          end
          default : begin
          end
        endcase
      end
      7'h33 : begin
        case(switch_ID_l99_6)
          3'b000 : begin
            switch_ID_l331 = Instr_ADD;
          end
          3'b100 : begin
            switch_ID_l331 = Instr_XOR_1;
          end
          3'b110 : begin
            switch_ID_l331 = Instr_OR_1;
          end
          3'b111 : begin
            switch_ID_l331 = Instr_AND_1;
          end
          default : begin
          end
        endcase
      end
      default : begin
      end
    endcase
  end

  assign switch_ID_l33_6 = io_i_instr[6 : 0];
  assign switch_ID_l47_6 = io_i_instr[14 : 12];
  assign switch_ID_l57_6 = io_i_instr[14 : 12];
  assign switch_ID_l67_6 = io_i_instr[14 : 12];
  assign switch_ID_l80_6 = io_i_instr[14 : 12];
  assign switch_ID_l99_6 = io_i_instr[14 : 12];
  always @(*) begin
    _zz_io_o_mem_sel = 4'b0000;
    case(switch_ID_l344)
      Instr_LB, Instr_SB : begin
        _zz_io_o_mem_sel = 4'b0001;
      end
      Instr_LW, Instr_SW : begin
        _zz_io_o_mem_sel = 4'b1111;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    switch_ID_l344 = Instr_UNK;
    case(switch_ID_l33_7)
      7'h37 : begin
        switch_ID_l344 = Instr_LUI;
      end
      7'h17 : begin
        switch_ID_l344 = Instr_AUIPC;
      end
      7'h6f : begin
        switch_ID_l344 = Instr_JAL;
      end
      7'h67 : begin
        switch_ID_l344 = Instr_JALR;
      end
      7'h63 : begin
        case(switch_ID_l47_7)
          3'b000 : begin
            switch_ID_l344 = Instr_BEQ;
          end
          3'b001 : begin
            switch_ID_l344 = Instr_BNE;
          end
          default : begin
          end
        endcase
      end
      7'h03 : begin
        case(switch_ID_l57_7)
          3'b000 : begin
            switch_ID_l344 = Instr_LB;
          end
          3'b010 : begin
            switch_ID_l344 = Instr_LW;
          end
          default : begin
          end
        endcase
      end
      7'h23 : begin
        case(switch_ID_l67_7)
          3'b000 : begin
            switch_ID_l344 = Instr_SB;
          end
          3'b010 : begin
            switch_ID_l344 = Instr_SW;
          end
          default : begin
            switch_ID_l344 = Instr_UNK;
          end
        endcase
      end
      7'h13 : begin
        case(switch_ID_l80_7)
          3'b000 : begin
            switch_ID_l344 = Instr_ADDI;
          end
          3'b110 : begin
            switch_ID_l344 = Instr_ORI;
          end
          3'b111 : begin
            switch_ID_l344 = Instr_ANDI;
          end
          3'b001 : begin
            switch_ID_l344 = Instr_SLLI;
          end
          3'b101 : begin
            switch_ID_l344 = Instr_SRLI;
          end
          default : begin
          end
        endcase
      end
      7'h33 : begin
        case(switch_ID_l99_7)
          3'b000 : begin
            switch_ID_l344 = Instr_ADD;
          end
          3'b100 : begin
            switch_ID_l344 = Instr_XOR_1;
          end
          3'b110 : begin
            switch_ID_l344 = Instr_OR_1;
          end
          3'b111 : begin
            switch_ID_l344 = Instr_AND_1;
          end
          default : begin
          end
        endcase
      end
      default : begin
      end
    endcase
  end

  assign switch_ID_l33_7 = io_i_instr[6 : 0];
  assign switch_ID_l47_7 = io_i_instr[14 : 12];
  assign switch_ID_l57_7 = io_i_instr[14 : 12];
  assign switch_ID_l67_7 = io_i_instr[14 : 12];
  assign switch_ID_l80_7 = io_i_instr[14 : 12];
  assign switch_ID_l99_7 = io_i_instr[14 : 12];
  always @(*) begin
    _zz_io_o_reg_we = 1'b0;
    case(switch_ID_l363)
      Instr_LUI, Instr_AUIPC, Instr_JAL, Instr_JALR, Instr_LB, Instr_LW, Instr_ADDI, Instr_ORI, Instr_ANDI, Instr_SLLI, Instr_SRLI, Instr_ADD, Instr_XOR_1, Instr_OR_1, Instr_AND_1 : begin
        _zz_io_o_reg_we = 1'b1;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    switch_ID_l363 = Instr_UNK;
    case(switch_ID_l33_8)
      7'h37 : begin
        switch_ID_l363 = Instr_LUI;
      end
      7'h17 : begin
        switch_ID_l363 = Instr_AUIPC;
      end
      7'h6f : begin
        switch_ID_l363 = Instr_JAL;
      end
      7'h67 : begin
        switch_ID_l363 = Instr_JALR;
      end
      7'h63 : begin
        case(switch_ID_l47_8)
          3'b000 : begin
            switch_ID_l363 = Instr_BEQ;
          end
          3'b001 : begin
            switch_ID_l363 = Instr_BNE;
          end
          default : begin
          end
        endcase
      end
      7'h03 : begin
        case(switch_ID_l57_8)
          3'b000 : begin
            switch_ID_l363 = Instr_LB;
          end
          3'b010 : begin
            switch_ID_l363 = Instr_LW;
          end
          default : begin
          end
        endcase
      end
      7'h23 : begin
        case(switch_ID_l67_8)
          3'b000 : begin
            switch_ID_l363 = Instr_SB;
          end
          3'b010 : begin
            switch_ID_l363 = Instr_SW;
          end
          default : begin
            switch_ID_l363 = Instr_UNK;
          end
        endcase
      end
      7'h13 : begin
        case(switch_ID_l80_8)
          3'b000 : begin
            switch_ID_l363 = Instr_ADDI;
          end
          3'b110 : begin
            switch_ID_l363 = Instr_ORI;
          end
          3'b111 : begin
            switch_ID_l363 = Instr_ANDI;
          end
          3'b001 : begin
            switch_ID_l363 = Instr_SLLI;
          end
          3'b101 : begin
            switch_ID_l363 = Instr_SRLI;
          end
          default : begin
          end
        endcase
      end
      7'h33 : begin
        case(switch_ID_l99_8)
          3'b000 : begin
            switch_ID_l363 = Instr_ADD;
          end
          3'b100 : begin
            switch_ID_l363 = Instr_XOR_1;
          end
          3'b110 : begin
            switch_ID_l363 = Instr_OR_1;
          end
          3'b111 : begin
            switch_ID_l363 = Instr_AND_1;
          end
          default : begin
          end
        endcase
      end
      default : begin
      end
    endcase
  end

  assign switch_ID_l33_8 = io_i_instr[6 : 0];
  assign switch_ID_l47_8 = io_i_instr[14 : 12];
  assign switch_ID_l57_8 = io_i_instr[14 : 12];
  assign switch_ID_l67_8 = io_i_instr[14 : 12];
  assign switch_ID_l80_8 = io_i_instr[14 : 12];
  assign switch_ID_l99_8 = io_i_instr[14 : 12];
  always @(*) begin
    _zz_io_o_reg_sel = RegSel_ALU;
    case(switch_ID_l389)
      Instr_LB, Instr_LW : begin
        _zz_io_o_reg_sel = RegSel_MEM;
      end
      Instr_JAL, Instr_JALR : begin
        _zz_io_o_reg_sel = RegSel_PC;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    switch_ID_l389 = Instr_UNK;
    case(switch_ID_l33_9)
      7'h37 : begin
        switch_ID_l389 = Instr_LUI;
      end
      7'h17 : begin
        switch_ID_l389 = Instr_AUIPC;
      end
      7'h6f : begin
        switch_ID_l389 = Instr_JAL;
      end
      7'h67 : begin
        switch_ID_l389 = Instr_JALR;
      end
      7'h63 : begin
        case(switch_ID_l47_9)
          3'b000 : begin
            switch_ID_l389 = Instr_BEQ;
          end
          3'b001 : begin
            switch_ID_l389 = Instr_BNE;
          end
          default : begin
          end
        endcase
      end
      7'h03 : begin
        case(switch_ID_l57_9)
          3'b000 : begin
            switch_ID_l389 = Instr_LB;
          end
          3'b010 : begin
            switch_ID_l389 = Instr_LW;
          end
          default : begin
          end
        endcase
      end
      7'h23 : begin
        case(switch_ID_l67_9)
          3'b000 : begin
            switch_ID_l389 = Instr_SB;
          end
          3'b010 : begin
            switch_ID_l389 = Instr_SW;
          end
          default : begin
            switch_ID_l389 = Instr_UNK;
          end
        endcase
      end
      7'h13 : begin
        case(switch_ID_l80_9)
          3'b000 : begin
            switch_ID_l389 = Instr_ADDI;
          end
          3'b110 : begin
            switch_ID_l389 = Instr_ORI;
          end
          3'b111 : begin
            switch_ID_l389 = Instr_ANDI;
          end
          3'b001 : begin
            switch_ID_l389 = Instr_SLLI;
          end
          3'b101 : begin
            switch_ID_l389 = Instr_SRLI;
          end
          default : begin
          end
        endcase
      end
      7'h33 : begin
        case(switch_ID_l99_9)
          3'b000 : begin
            switch_ID_l389 = Instr_ADD;
          end
          3'b100 : begin
            switch_ID_l389 = Instr_XOR_1;
          end
          3'b110 : begin
            switch_ID_l389 = Instr_OR_1;
          end
          3'b111 : begin
            switch_ID_l389 = Instr_AND_1;
          end
          default : begin
          end
        endcase
      end
      default : begin
      end
    endcase
  end

  assign switch_ID_l33_9 = io_i_instr[6 : 0];
  assign switch_ID_l47_9 = io_i_instr[14 : 12];
  assign switch_ID_l57_9 = io_i_instr[14 : 12];
  assign switch_ID_l67_9 = io_i_instr[14 : 12];
  assign switch_ID_l80_9 = io_i_instr[14 : 12];
  assign switch_ID_l99_9 = io_i_instr[14 : 12];
  always @(posedge sys_clk or posedge sys_reset) begin
    if(sys_reset) begin
      io_o_pc <= 32'h00000000;
      io_o_reg_data_a <= 32'h00000000;
      io_o_reg_data_b <= 32'h00000000;
      io_o_reg_addr_a <= 5'h00;
      io_o_reg_addr_b <= 5'h00;
      io_o_reg_addr_d <= 5'h00;
      io_o_alu_op <= AluOp_ADD;
      io_o_br_type <= BrType_F;
      io_o_imm <= 32'h00000000;
      io_o_use_pc <= 1'b0;
      io_o_use_rs2 <= 1'b0;
      io_o_mem_en <= 1'b0;
      io_o_mem_we <= 1'b0;
      io_o_mem_sel <= 4'b0000;
      io_o_reg_we <= 1'b0;
      io_o_reg_sel <= RegSel_ALU;
    end else begin
      if(!io_stall) begin
        if(io_bubble) begin
          io_o_br_type <= BrType_F;
          io_o_mem_en <= 1'b0;
          io_o_reg_we <= 1'b0;
        end else begin
          io_o_pc <= io_i_pc;
          io_o_reg_data_a <= io_reg_data_a;
          io_o_reg_data_b <= io_reg_data_b;
          io_o_reg_addr_a <= io_i_instr[19 : 15];
          io_o_reg_addr_b <= io_i_instr[24 : 20];
          io_o_reg_addr_d <= io_i_instr[11 : 7];
          io_o_alu_op <= _zz_io_o_alu_op;
          io_o_br_type <= _zz_io_o_br_type;
          io_o_imm <= _zz_io_o_imm;
          io_o_use_pc <= _zz_io_o_use_pc;
          io_o_use_rs2 <= _zz_io_o_use_rs2;
          io_o_mem_en <= _zz_io_o_mem_en;
          io_o_mem_we <= _zz_io_o_mem_we;
          io_o_mem_sel <= _zz_io_o_mem_sel;
          io_o_reg_we <= _zz_io_o_reg_we;
          io_o_reg_sel <= _zz_io_o_reg_sel;
        end
      end
    end
  end


endmodule

module IF_1 (
  output reg  [31:0]   io_o_pc,
  output reg  [31:0]   io_o_instr,
  input  wire          io_br_br,
  input  wire [31:0]   io_br_pc,
  input  wire          io_stall,
  input  wire          io_bubble,
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
  wire                fsm_wantExit;
  reg                 fsm_wantStart;
  wire                fsm_wantKill;
  reg        [1:0]    fsm_stateReg;
  reg        [1:0]    fsm_stateNext;
  wire                _zz_when_StateMachine_l237;
  wire                _zz_when_StateMachine_l237_1;
  wire                when_IF_l91;
  wire                when_IF_l102;
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
        if(when_IF_l91) begin
          if(!io_stall) begin
            if(when_IF_l102) begin
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

  assign when_IF_l91 = (io_wb_ack || delay_ack);
  assign when_IF_l102 = (io_br_br || delay_br);
  assign when_StateMachine_l237 = (_zz_when_StateMachine_l237 && (! _zz_when_StateMachine_l237_1));
  assign when_StateMachine_l253 = ((! _zz_when_StateMachine_l237) && _zz_when_StateMachine_l237_1);
  always @(posedge sys_clk or posedge sys_reset) begin
    if(sys_reset) begin
      pc <= 32'h80000000;
      delay_br <= 1'b0;
      delay_ack <= 1'b0;
      delay_instr <= 32'h00000013;
      io_o_pc <= 32'h80000000;
      io_o_instr <= 32'h00000013;
      io_wb_stb <= 1'b0;
      fsm_stateReg <= fsm_enumDef_BOOT;
    end else begin
      if(io_br_br) begin
        delay_br <= 1'b1;
        pc <= io_br_pc;
      end
      fsm_stateReg <= fsm_stateNext;
      case(fsm_stateReg)
        fsm_enumDef_start : begin
          if(!io_stall) begin
            if(io_bubble) begin
              io_o_instr <= 32'h00000013;
            end else begin
              io_o_instr <= 32'h00000013;
              if(io_br_br) begin
                delay_br <= 1'b0;
              end
            end
          end
        end
        fsm_enumDef_fetch : begin
          io_o_instr <= 32'h00000013;
          if(when_IF_l91) begin
            delay_ack <= 1'b0;
            if(io_stall) begin
              delay_ack <= 1'b1;
              if(io_wb_ack) begin
                io_wb_stb <= 1'b0;
                delay_instr <= io_wb_dat_r;
              end
            end else begin
              if(when_IF_l102) begin
                delay_br <= 1'b0;
              end else begin
                io_o_pc <= pc;
                io_o_instr <= (delay_ack ? delay_instr : io_wb_dat_r);
                pc <= (pc + 32'h00000004);
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

module Alu (
  input  wire [31:0]   io_a,
  input  wire [31:0]   io_b,
  input  wire [3:0]    io_op,
  output reg  [31:0]   io_y
);
  localparam AluOp_OP1 = 4'd0;
  localparam AluOp_ADD = 4'd1;
  localparam AluOp_SUB = 4'd2;
  localparam AluOp_AND_1 = 4'd3;
  localparam AluOp_OR_1 = 4'd4;
  localparam AluOp_XOR_1 = 4'd5;
  localparam AluOp_NOT_1 = 4'd6;
  localparam AluOp_SLL_1 = 4'd7;
  localparam AluOp_SRL_1 = 4'd8;
  localparam AluOp_SRA_1 = 4'd9;
  localparam AluOp_ROL_1 = 4'd10;
  localparam AluOp_OP2 = 4'd11;

  wire       [31:0]   _zz_io_y_6;
  wire       [31:0]   _zz_io_y_7;
  wire       [31:0]   _zz_io_y_8;
  wire       [31:0]   s_a;
  wire       [31:0]   s_b;
  wire       [4:0]    shamt;
  reg        [31:0]   _zz_io_y;
  reg        [31:0]   _zz_io_y_1;
  reg        [31:0]   _zz_io_y_2;
  reg        [31:0]   _zz_io_y_3;
  reg        [31:0]   _zz_io_y_4;
  wire       [31:0]   _zz_io_y_5;
  `ifndef SYNTHESIS
  reg [39:0] io_op_string;
  `endif


  assign _zz_io_y_6 = ($signed(s_a) + $signed(s_b));
  assign _zz_io_y_7 = ($signed(s_a) - $signed(s_b));
  assign _zz_io_y_8 = ($signed(s_a) >>> shamt);
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
      AluOp_OP2 : io_op_string = "OP2  ";
      default : io_op_string = "?????";
    endcase
  end
  `endif

  assign s_a = io_a;
  assign s_b = io_b;
  assign shamt = io_b[4 : 0];
  always @(*) begin
    case(io_op)
      AluOp_OP1 : begin
        io_y = io_a;
      end
      AluOp_ADD : begin
        io_y = _zz_io_y_6;
      end
      AluOp_SUB : begin
        io_y = _zz_io_y_7;
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
        io_y = _zz_io_y_8;
      end
      AluOp_ROL_1 : begin
        io_y = _zz_io_y;
      end
      default : begin
        io_y = io_b;
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
