// Generator : SpinalHDL v1.9.4    git head : 270018552577f3bb8e5339ee2583c9c22d324215
// Component : Lab2Top
// Git hash  : b0ae1e4d36febd5b7784834dbb13fe18e9dbe54c

`timescale 1ns/1ps

module Lab2Top (
  input  wire          clk_11M0592,
  input  wire          push_btn,
  input  wire [3:0]    touch_btn,
  input  wire [31:0]   dip_sw,
  output wire [15:0]   leds,
  output wire [7:0]    dpy0,
  output wire [7:0]    dpy1,
  input  wire          clk_50M,
  input  wire          reset_btn
);

  wire                bufferCC_1_io_dataIn;
  wire                clkCtrl_pll_clk_out1;
  wire                clkCtrl_pll_clk_out2;
  wire                clkCtrl_pll_locked;
  wire                bufferCC_1_io_dataOut;
  wire       [3:0]    counter_1_io_count;
  wire                trigger_1_io_trigger;
  wire       [7:0]    seg_7_oSEG1;
  wire                sys_clk;
  wire                sys_reset;

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
  Counter counter_1 (
    .io_trigger (trigger_1_io_trigger   ), //i
    .io_count   (counter_1_io_count[3:0]), //o
    .sys_clk    (sys_clk                ), //i
    .sys_reset  (sys_reset              )  //i
  );
  Trigger trigger_1 (
    .io_push_btn (push_btn            ), //i
    .io_trigger  (trigger_1_io_trigger), //o
    .sys_clk     (sys_clk             ), //i
    .sys_reset   (sys_reset           )  //i
  );
  SEG7_LUT seg_7 (
    .iDIG  (counter_1_io_count[3:0]), //i
    .oSEG1 (seg_7_oSEG1[7:0]       )  //o
  );
  assign sys_clk = clkCtrl_pll_clk_out1;
  assign bufferCC_1_io_dataIn = (1'b0 ^ 1'b0);
  assign sys_reset = bufferCC_1_io_dataOut;
  assign dpy0 = seg_7_oSEG1;
  assign dpy1 = 8'h00;
  assign leds = 16'h0000;

endmodule

module Trigger (
  input  wire          io_push_btn,
  output wire          io_trigger,
  input  wire          sys_clk,
  input  wire          sys_reset
);

  reg                 io_push_btn_regNext;
  reg                 _zz_io_trigger;

  assign io_trigger = _zz_io_trigger;
  always @(posedge sys_clk or posedge sys_reset) begin
    if(sys_reset) begin
      io_push_btn_regNext <= 1'b0;
      _zz_io_trigger <= 1'b0;
    end else begin
      io_push_btn_regNext <= io_push_btn;
      _zz_io_trigger <= (io_push_btn && (! io_push_btn_regNext));
    end
  end


endmodule

module Counter (
  input  wire          io_trigger,
  output wire [3:0]    io_count,
  input  wire          sys_clk,
  input  wire          sys_reset
);

  wire       [4:0]    _zz__zz_when_UInt_l120;
  wire       [1:0]    _zz__zz_when_UInt_l120_1;
  reg        [3:0]    counter_1;
  wire       [4:0]    _zz_when_UInt_l120;
  reg        [3:0]    _zz_counter;
  wire                when_UInt_l120;

  assign _zz__zz_when_UInt_l120_1 = {1'b0,1'b1};
  assign _zz__zz_when_UInt_l120 = {3'd0, _zz__zz_when_UInt_l120_1};
  assign _zz_when_UInt_l120 = ({1'b0,counter_1} + _zz__zz_when_UInt_l120);
  assign when_UInt_l120 = (|_zz_when_UInt_l120[4 : 4]);
  always @(*) begin
    if(when_UInt_l120) begin
      _zz_counter = 4'b1111;
    end else begin
      _zz_counter = _zz_when_UInt_l120[3 : 0];
    end
  end

  assign io_count = counter_1;
  always @(posedge sys_clk or posedge sys_reset) begin
    if(sys_reset) begin
      counter_1 <= 4'b0000;
    end else begin
      if(io_trigger) begin
        counter_1 <= _zz_counter;
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
