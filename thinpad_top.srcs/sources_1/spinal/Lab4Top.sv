// Generator : SpinalHDL v1.9.4    git head : 270018552577f3bb8e5339ee2583c9c22d324215
// Component : Lab4Top
// Git hash  : ebf9b7119b7ff737909982298b14eee2824dabdf

`timescale 1ns/1ps

module Lab4Top (
  input  wire          clk_11M0592,
  input  wire          push_btn,
  input  wire [3:0]    touch_btn,
  input  wire [31:0]   dip_sw,
  output reg  [15:0]   leds,
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
  input  wire          clk_50M,
  input  wire          reset_btn,
  inout  wire [31:0]   base_ram_data,
  inout  wire [31:0]   ext_ram_data
);

  wire                bufferCC_1_io_dataIn;
  wire                clkCtrl_pll_clk_out1;
  wire                clkCtrl_pll_clk_out2;
  wire                clkCtrl_pll_locked;
  wire                bufferCC_1_io_dataOut;
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
  wire                tester_wb_cyc_o;
  wire                tester_wb_stb_o;
  wire                tester_wb_we_o;
  wire       [31:0]   tester_wb_adr_o;
  wire       [31:0]   tester_wb_dat_o;
  wire       [3:0]    tester_wb_sel_o;
  wire                tester_done;
  wire                tester_error;
  wire       [31:0]   tester_error_round;
  wire       [31:0]   tester_error_addr;
  wire       [31:0]   tester_error_read_data;
  wire       [31:0]   tester_error_expected_data;
  wire                base_io_wb_ack;
  wire       [31:0]   base_io_wb_dat_r;
  wire       [19:0]   base_io_sram_addr;
  wire       [3:0]    base_io_sram_be_n;
  wire                base_io_sram_ce_n;
  wire                base_io_sram_oe_n;
  wire                base_io_sram_we_n;
  wire       [31:0]   base_io_sram_data_write;
  wire                base_io_sram_data_writeEnable;
  wire                ext_io_wb_ack;
  wire       [31:0]   ext_io_wb_dat_r;
  wire       [19:0]   ext_io_sram_addr;
  wire       [3:0]    ext_io_sram_be_n;
  wire                ext_io_sram_ce_n;
  wire                ext_io_sram_oe_n;
  wire                ext_io_sram_we_n;
  wire       [31:0]   ext_io_sram_data_write;
  wire                ext_io_sram_data_writeEnable;
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
  wire       [31:0]   random_seed;
  wire                test_done;
  wire                test_error;
  wire       [31:0]   test_error_round;
  wire       [31:0]   test_error_addr;
  wire       [31:0]   test_error_read_data;
  wire       [31:0]   test_error_expected_data;
  wire       [31:0]   ADDR_BASE;
  wire       [31:0]   ADDR_MASK;
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
  WbMux mux (
    .io_wb_cyc         (tester_wb_cyc_o            ), //i
    .io_wb_stb         (tester_wb_stb_o            ), //i
    .io_wb_ack         (mux_io_wb_ack              ), //o
    .io_wb_we          (tester_wb_we_o             ), //i
    .io_wb_adr         (tester_wb_adr_o[31:0]      ), //i
    .io_wb_dat_r       (mux_io_wb_dat_r[31:0]      ), //o
    .io_wb_dat_w       (tester_wb_dat_o[31:0]      ), //i
    .io_wb_sel         (tester_wb_sel_o[3:0]       ), //i
    .io_slaves_0_cyc   (mux_io_slaves_0_cyc        ), //o
    .io_slaves_0_stb   (mux_io_slaves_0_stb        ), //o
    .io_slaves_0_ack   (base_io_wb_ack             ), //i
    .io_slaves_0_we    (mux_io_slaves_0_we         ), //o
    .io_slaves_0_adr   (mux_io_slaves_0_adr[31:0]  ), //o
    .io_slaves_0_dat_r (base_io_wb_dat_r[31:0]     ), //i
    .io_slaves_0_dat_w (mux_io_slaves_0_dat_w[31:0]), //o
    .io_slaves_0_sel   (mux_io_slaves_0_sel[3:0]   ), //o
    .io_slaves_1_cyc   (mux_io_slaves_1_cyc        ), //o
    .io_slaves_1_stb   (mux_io_slaves_1_stb        ), //o
    .io_slaves_1_ack   (ext_io_wb_ack              ), //i
    .io_slaves_1_we    (mux_io_slaves_1_we         ), //o
    .io_slaves_1_adr   (mux_io_slaves_1_adr[31:0]  ), //o
    .io_slaves_1_dat_r (ext_io_wb_dat_r[31:0]      ), //i
    .io_slaves_1_dat_w (mux_io_slaves_1_dat_w[31:0]), //o
    .io_slaves_1_sel   (mux_io_slaves_1_sel[3:0]   )  //o
  );
  sram_tester #(
    .ADDR_WIDTH(32),
    .DATA_WIDTH(32),
    .ADDR_BASE(32'h80000000),
    .ADDR_MASK(32'h007fffff),
    .TEST_ROUNDS(1000)
  ) tester (
    .clk_i               (sys_clk                         ), //i
    .rst_i               (sys_reset                       ), //i
    .start               (push_btn                        ), //i
    .random_seed         (random_seed[31:0]               ), //i
    .wb_cyc_o            (tester_wb_cyc_o                 ), //o
    .wb_stb_o            (tester_wb_stb_o                 ), //o
    .wb_ack_i            (mux_io_wb_ack                   ), //i
    .wb_we_o             (tester_wb_we_o                  ), //o
    .wb_adr_o            (tester_wb_adr_o[31:0]           ), //o
    .wb_dat_i            (mux_io_wb_dat_r[31:0]           ), //i
    .wb_dat_o            (tester_wb_dat_o[31:0]           ), //o
    .wb_sel_o            (tester_wb_sel_o[3:0]            ), //o
    .done                (tester_done                     ), //o
    .error               (tester_error                    ), //o
    .error_round         (tester_error_round[31:0]        ), //o
    .error_addr          (tester_error_addr[31:0]         ), //o
    .error_read_data     (tester_error_read_data[31:0]    ), //o
    .error_expected_data (tester_error_expected_data[31:0])  //o
  );
  SramController base (
    .io_wb_cyc                (mux_io_slaves_0_cyc          ), //i
    .io_wb_stb                (mux_io_slaves_0_stb          ), //i
    .io_wb_ack                (base_io_wb_ack               ), //o
    .io_wb_we                 (mux_io_slaves_0_we           ), //i
    .io_wb_adr                (mux_io_slaves_0_adr[31:0]    ), //i
    .io_wb_dat_r              (base_io_wb_dat_r[31:0]       ), //o
    .io_wb_dat_w              (mux_io_slaves_0_dat_w[31:0]  ), //i
    .io_wb_sel                (mux_io_slaves_0_sel[3:0]     ), //i
    .io_sram_data_read        (_zz_io_sram_data_read[31:0]  ), //i
    .io_sram_data_write       (base_io_sram_data_write[31:0]), //o
    .io_sram_data_writeEnable (base_io_sram_data_writeEnable), //o
    .io_sram_addr             (base_io_sram_addr[19:0]      ), //o
    .io_sram_be_n             (base_io_sram_be_n[3:0]       ), //o
    .io_sram_ce_n             (base_io_sram_ce_n            ), //o
    .io_sram_oe_n             (base_io_sram_oe_n            ), //o
    .io_sram_we_n             (base_io_sram_we_n            ), //o
    .sys_clk                  (sys_clk                      ), //i
    .sys_reset                (sys_reset                    )  //i
  );
  SramController ext (
    .io_wb_cyc                (mux_io_slaves_1_cyc          ), //i
    .io_wb_stb                (mux_io_slaves_1_stb          ), //i
    .io_wb_ack                (ext_io_wb_ack                ), //o
    .io_wb_we                 (mux_io_slaves_1_we           ), //i
    .io_wb_adr                (mux_io_slaves_1_adr[31:0]    ), //i
    .io_wb_dat_r              (ext_io_wb_dat_r[31:0]        ), //o
    .io_wb_dat_w              (mux_io_slaves_1_dat_w[31:0]  ), //i
    .io_wb_sel                (mux_io_slaves_1_sel[3:0]     ), //i
    .io_sram_data_read        (_zz_io_sram_data_read_1[31:0]), //i
    .io_sram_data_write       (ext_io_sram_data_write[31:0] ), //o
    .io_sram_data_writeEnable (ext_io_sram_data_writeEnable ), //o
    .io_sram_addr             (ext_io_sram_addr[19:0]       ), //o
    .io_sram_be_n             (ext_io_sram_be_n[3:0]        ), //o
    .io_sram_ce_n             (ext_io_sram_ce_n             ), //o
    .io_sram_oe_n             (ext_io_sram_oe_n             ), //o
    .io_sram_we_n             (ext_io_sram_we_n             ), //o
    .sys_clk                  (sys_clk                      ), //i
    .sys_reset                (sys_reset                    )  //i
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
  assign dpy0 = 8'h00;
  assign dpy1 = 8'h00;
  assign random_seed = dip_sw;
  always @(*) begin
    leds = 16'h0000;
    leds[0] = test_done;
    leds[1] = test_error;
  end

  assign ADDR_BASE = 32'h80000000;
  assign ADDR_MASK = 32'h007fffff;
  assign test_done = tester_done;
  assign test_error = tester_error;
  assign test_error_round = tester_error_round;
  assign test_error_addr = tester_error_addr;
  assign test_error_read_data = tester_error_read_data;
  assign test_error_expected_data = tester_error_expected_data;
  assign _zz_base_ram_data_32 = base_io_sram_data_write;
  assign _zz_when_InOutWrapper_l13 = base_io_sram_data_writeEnable;
  assign base_ram_addr = base_io_sram_addr;
  assign base_ram_be_n = base_io_sram_be_n;
  assign base_ram_ce_n = base_io_sram_ce_n;
  assign base_ram_oe_n = base_io_sram_oe_n;
  assign base_ram_we_n = base_io_sram_we_n;
  assign _zz_ext_ram_data_32 = ext_io_sram_data_write;
  assign _zz_when_InOutWrapper_l13_1 = ext_io_sram_data_writeEnable;
  assign ext_ram_addr = ext_io_sram_addr;
  assign ext_ram_be_n = ext_io_sram_be_n;
  assign ext_ram_ce_n = ext_io_sram_ce_n;
  assign ext_ram_oe_n = ext_io_sram_oe_n;
  assign ext_ram_we_n = ext_io_sram_we_n;
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
  localparam fsm_enumDef_BOOT = 3'd0;
  localparam fsm_enumDef_idle = 3'd1;
  localparam fsm_enumDef_read = 3'd2;
  localparam fsm_enumDef_write = 3'd3;
  localparam fsm_enumDef_write_2 = 3'd4;

  wire       [1:0]    offset;
  reg                 fsm_wantExit;
  reg                 fsm_wantStart;
  wire                fsm_wantKill;
  reg        [2:0]    fsm_stateReg;
  reg        [2:0]    fsm_stateNext;
  wire                when_SramController_l48;
  wire                when_StateMachine_l253;
  wire                when_StateMachine_l253_1;
  `ifndef SYNTHESIS
  reg [55:0] fsm_stateReg_string;
  reg [55:0] fsm_stateNext_string;
  `endif


  `ifndef SYNTHESIS
  always @(*) begin
    case(fsm_stateReg)
      fsm_enumDef_BOOT : fsm_stateReg_string = "BOOT   ";
      fsm_enumDef_idle : fsm_stateReg_string = "idle   ";
      fsm_enumDef_read : fsm_stateReg_string = "read   ";
      fsm_enumDef_write : fsm_stateReg_string = "write  ";
      fsm_enumDef_write_2 : fsm_stateReg_string = "write_2";
      default : fsm_stateReg_string = "???????";
    endcase
  end
  always @(*) begin
    case(fsm_stateNext)
      fsm_enumDef_BOOT : fsm_stateNext_string = "BOOT   ";
      fsm_enumDef_idle : fsm_stateNext_string = "idle   ";
      fsm_enumDef_read : fsm_stateNext_string = "read   ";
      fsm_enumDef_write : fsm_stateNext_string = "write  ";
      fsm_enumDef_write_2 : fsm_stateNext_string = "write_2";
      default : fsm_stateNext_string = "???????";
    endcase
  end
  `endif

  assign offset = io_wb_adr[1 : 0];
  assign io_wb_dat_r = io_sram_data_read;
  assign io_sram_data_write = io_wb_dat_w;
  assign io_sram_addr = io_wb_adr[21 : 2];
  assign io_sram_ce_n = (! ((io_wb_cyc && io_wb_stb) && (! io_wb_ack)));
  assign io_sram_be_n = (~ io_wb_sel);
  always @(*) begin
    fsm_wantExit = 1'b0;
    case(fsm_stateReg)
      fsm_enumDef_idle : begin
      end
      fsm_enumDef_read : begin
        fsm_wantExit = 1'b1;
      end
      fsm_enumDef_write : begin
      end
      fsm_enumDef_write_2 : begin
        fsm_wantExit = 1'b1;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_wantStart = 1'b0;
    case(fsm_stateReg)
      fsm_enumDef_idle : begin
      end
      fsm_enumDef_read : begin
      end
      fsm_enumDef_write : begin
      end
      fsm_enumDef_write_2 : begin
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
      fsm_enumDef_idle : begin
      end
      fsm_enumDef_read : begin
      end
      fsm_enumDef_write : begin
        io_sram_oe_n = 1'b1;
      end
      fsm_enumDef_write_2 : begin
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
      fsm_enumDef_idle : begin
      end
      fsm_enumDef_read : begin
      end
      fsm_enumDef_write : begin
        io_sram_we_n = 1'b0;
      end
      fsm_enumDef_write_2 : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    io_sram_data_writeEnable = 1'b0;
    case(fsm_stateReg)
      fsm_enumDef_idle : begin
      end
      fsm_enumDef_read : begin
      end
      fsm_enumDef_write : begin
        io_sram_data_writeEnable = 1'b1;
      end
      fsm_enumDef_write_2 : begin
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
      fsm_enumDef_idle : begin
        if(when_SramController_l48) begin
          if(io_wb_we) begin
            fsm_stateNext = fsm_enumDef_write;
          end else begin
            fsm_stateNext = fsm_enumDef_read;
          end
        end
      end
      fsm_enumDef_read : begin
        fsm_stateNext = fsm_enumDef_BOOT;
      end
      fsm_enumDef_write : begin
        fsm_stateNext = fsm_enumDef_write_2;
      end
      fsm_enumDef_write_2 : begin
        fsm_stateNext = fsm_enumDef_BOOT;
      end
      default : begin
      end
    endcase
    if(fsm_wantStart) begin
      fsm_stateNext = fsm_enumDef_idle;
    end
    if(fsm_wantKill) begin
      fsm_stateNext = fsm_enumDef_BOOT;
    end
  end

  assign when_SramController_l48 = (io_wb_cyc && io_wb_stb);
  assign when_StateMachine_l253 = ((! (fsm_stateReg == fsm_enumDef_idle)) && (fsm_stateNext == fsm_enumDef_idle));
  assign when_StateMachine_l253_1 = ((! (fsm_stateReg == fsm_enumDef_write)) && (fsm_stateNext == fsm_enumDef_write));
  always @(posedge sys_clk or posedge sys_reset) begin
    if(sys_reset) begin
      fsm_stateReg <= fsm_enumDef_BOOT;
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
  output wire [3:0]    io_slaves_1_sel
);

  wire                slave_match_0;
  wire                slave_match_1;
  wire                slave_sel_0;
  wire                slave_sel_1;

  assign slave_match_0 = (((io_wb_adr ^ 32'h80000000) & 32'hffc00000) == 32'h00000000);
  assign slave_match_1 = (((io_wb_adr ^ 32'h80400000) & 32'hffc00000) == 32'h00000000);
  assign slave_sel_0 = (slave_match_0 && (1'b0 == 1'b0));
  assign slave_sel_1 = (slave_match_1 && ((1'b0 || slave_match_0) == 1'b0));
  assign io_wb_dat_r = (slave_sel_0 ? io_slaves_0_dat_r : io_slaves_1_dat_r);
  assign io_wb_ack = (io_slaves_0_ack || io_slaves_1_ack);
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
