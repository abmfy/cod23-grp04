// Generator : SpinalHDL v1.9.4    git head : 270018552577f3bb8e5339ee2583c9c22d324215
// Component : Lab3Top
// Git hash  : 7b801fbcdc7bf020a087b1f37b565b56780df063

`timescale 1ns/1ps

module Lab3Top (
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

  wire                bufferCC_1_io_dataIn;
  wire                clkCtrl_pll_clk_out1;
  wire                clkCtrl_pll_clk_out2;
  wire                clkCtrl_pll_locked;
  wire                bufferCC_1_io_dataOut;
  wire                trigger_1_io_trigger;
  wire       [15:0]   reg_file_io_rdata_a;
  wire       [15:0]   reg_file_io_rdata_b;
  wire       [15:0]   alu_1_io_y;
  wire       [4:0]    controller_1_io_reg_file_raddr_a;
  wire       [4:0]    controller_1_io_reg_file_raddr_b;
  wire       [4:0]    controller_1_io_reg_file_waddr;
  wire       [15:0]   controller_1_io_reg_file_wdata;
  wire                controller_1_io_reg_file_we;
  wire       [15:0]   controller_1_io_alu_a;
  wire       [15:0]   controller_1_io_alu_b;
  wire       [3:0]    controller_1_io_alu_op;
  wire       [15:0]   controller_1_io_leds;
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
  Trigger trigger_1 (
    .io_push_btn (push_btn            ), //i
    .io_trigger  (trigger_1_io_trigger), //o
    .sys_clk     (sys_clk             ), //i
    .sys_reset   (sys_reset           )  //i
  );
  RegFile reg_file (
    .io_raddr_a (controller_1_io_reg_file_raddr_a[4:0]), //i
    .io_rdata_a (reg_file_io_rdata_a[15:0]            ), //o
    .io_raddr_b (controller_1_io_reg_file_raddr_b[4:0]), //i
    .io_rdata_b (reg_file_io_rdata_b[15:0]            ), //o
    .io_waddr   (controller_1_io_reg_file_waddr[4:0]  ), //i
    .io_wdata   (controller_1_io_reg_file_wdata[15:0] ), //i
    .io_we      (controller_1_io_reg_file_we          ), //i
    .sys_clk    (sys_clk                              ), //i
    .sys_reset  (sys_reset                            )  //i
  );
  Alu alu_1 (
    .io_a  (controller_1_io_alu_a[15:0]), //i
    .io_b  (controller_1_io_alu_b[15:0]), //i
    .io_op (controller_1_io_alu_op[3:0]), //i
    .io_y  (alu_1_io_y[15:0]           )  //o
  );
  Controller controller_1 (
    .io_reg_file_raddr_a (controller_1_io_reg_file_raddr_a[4:0]), //o
    .io_reg_file_rdata_a (reg_file_io_rdata_a[15:0]            ), //i
    .io_reg_file_raddr_b (controller_1_io_reg_file_raddr_b[4:0]), //o
    .io_reg_file_rdata_b (reg_file_io_rdata_b[15:0]            ), //i
    .io_reg_file_waddr   (controller_1_io_reg_file_waddr[4:0]  ), //o
    .io_reg_file_wdata   (controller_1_io_reg_file_wdata[15:0] ), //o
    .io_reg_file_we      (controller_1_io_reg_file_we          ), //o
    .io_alu_a            (controller_1_io_alu_a[15:0]          ), //o
    .io_alu_b            (controller_1_io_alu_b[15:0]          ), //o
    .io_alu_op           (controller_1_io_alu_op[3:0]          ), //o
    .io_alu_y            (alu_1_io_y[15:0]                     ), //i
    .io_step             (trigger_1_io_trigger                 ), //i
    .io_dip_sw           (dip_sw[31:0]                         ), //i
    .io_leds             (controller_1_io_leds[15:0]           ), //o
    .sys_clk             (sys_clk                              ), //i
    .sys_reset           (sys_reset                            )  //i
  );
  assign sys_clk = clkCtrl_pll_clk_out1;
  assign bufferCC_1_io_dataIn = (1'b0 ^ 1'b0);
  assign sys_reset = bufferCC_1_io_dataOut;
  assign leds = controller_1_io_leds;
  assign dpy0 = 8'h00;
  assign dpy1 = 8'h00;

endmodule

module Controller (
  output reg  [4:0]    io_reg_file_raddr_a,
  input  wire [15:0]   io_reg_file_rdata_a,
  output reg  [4:0]    io_reg_file_raddr_b,
  input  wire [15:0]   io_reg_file_rdata_b,
  output reg  [4:0]    io_reg_file_waddr,
  output reg  [15:0]   io_reg_file_wdata,
  output reg           io_reg_file_we,
  output reg  [15:0]   io_alu_a,
  output reg  [15:0]   io_alu_b,
  output reg  [3:0]    io_alu_op,
  input  wire [15:0]   io_alu_y,
  input  wire          io_step,
  input  wire [31:0]   io_dip_sw,
  output reg  [15:0]   io_leds,
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
  localparam fsm_enumDef_BOOT = 3'd0;
  localparam fsm_enumDef_init = 3'd1;
  localparam fsm_enumDef_decode = 3'd2;
  localparam fsm_enumDef_calc = 3'd3;
  localparam fsm_enumDef_read_reg = 3'd4;
  localparam fsm_enumDef_write_reg = 3'd5;

  reg        [31:0]   inst_reg;
  wire                instr_is_rtype;
  wire                instr_is_itype;
  wire                instr_is_peek;
  wire                instr_is_poke;
  wire       [15:0]   instr_imm;
  wire       [4:0]    instr_rd;
  wire       [4:0]    instr_rs1;
  wire       [4:0]    instr_rs2;
  wire       [3:0]    instr_opcode;
  wire       [3:0]    _zz_instr_opcode;
  reg                 fsm_wantExit;
  reg                 fsm_wantStart;
  wire                fsm_wantKill;
  reg        [2:0]    fsm_stateReg;
  reg        [2:0]    fsm_stateNext;
  `ifndef SYNTHESIS
  reg [39:0] io_alu_op_string;
  reg [39:0] instr_opcode_string;
  reg [39:0] _zz_instr_opcode_string;
  reg [71:0] fsm_stateReg_string;
  reg [71:0] fsm_stateNext_string;
  `endif


  `ifndef SYNTHESIS
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
  always @(*) begin
    case(instr_opcode)
      AluOp_OP1 : instr_opcode_string = "OP1  ";
      AluOp_ADD : instr_opcode_string = "ADD  ";
      AluOp_SUB : instr_opcode_string = "SUB  ";
      AluOp_AND_1 : instr_opcode_string = "AND_1";
      AluOp_OR_1 : instr_opcode_string = "OR_1 ";
      AluOp_XOR_1 : instr_opcode_string = "XOR_1";
      AluOp_NOT_1 : instr_opcode_string = "NOT_1";
      AluOp_SLL_1 : instr_opcode_string = "SLL_1";
      AluOp_SRL_1 : instr_opcode_string = "SRL_1";
      AluOp_SRA_1 : instr_opcode_string = "SRA_1";
      AluOp_ROL_1 : instr_opcode_string = "ROL_1";
      AluOp_OP2 : instr_opcode_string = "OP2  ";
      default : instr_opcode_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_instr_opcode)
      AluOp_OP1 : _zz_instr_opcode_string = "OP1  ";
      AluOp_ADD : _zz_instr_opcode_string = "ADD  ";
      AluOp_SUB : _zz_instr_opcode_string = "SUB  ";
      AluOp_AND_1 : _zz_instr_opcode_string = "AND_1";
      AluOp_OR_1 : _zz_instr_opcode_string = "OR_1 ";
      AluOp_XOR_1 : _zz_instr_opcode_string = "XOR_1";
      AluOp_NOT_1 : _zz_instr_opcode_string = "NOT_1";
      AluOp_SLL_1 : _zz_instr_opcode_string = "SLL_1";
      AluOp_SRL_1 : _zz_instr_opcode_string = "SRL_1";
      AluOp_SRA_1 : _zz_instr_opcode_string = "SRA_1";
      AluOp_ROL_1 : _zz_instr_opcode_string = "ROL_1";
      AluOp_OP2 : _zz_instr_opcode_string = "OP2  ";
      default : _zz_instr_opcode_string = "?????";
    endcase
  end
  always @(*) begin
    case(fsm_stateReg)
      fsm_enumDef_BOOT : fsm_stateReg_string = "BOOT     ";
      fsm_enumDef_init : fsm_stateReg_string = "init     ";
      fsm_enumDef_decode : fsm_stateReg_string = "decode   ";
      fsm_enumDef_calc : fsm_stateReg_string = "calc     ";
      fsm_enumDef_read_reg : fsm_stateReg_string = "read_reg ";
      fsm_enumDef_write_reg : fsm_stateReg_string = "write_reg";
      default : fsm_stateReg_string = "?????????";
    endcase
  end
  always @(*) begin
    case(fsm_stateNext)
      fsm_enumDef_BOOT : fsm_stateNext_string = "BOOT     ";
      fsm_enumDef_init : fsm_stateNext_string = "init     ";
      fsm_enumDef_decode : fsm_stateNext_string = "decode   ";
      fsm_enumDef_calc : fsm_stateNext_string = "calc     ";
      fsm_enumDef_read_reg : fsm_stateNext_string = "read_reg ";
      fsm_enumDef_write_reg : fsm_stateNext_string = "write_reg";
      default : fsm_stateNext_string = "?????????";
    endcase
  end
  `endif

  assign instr_is_rtype = (inst_reg[2 : 0] == 3'b001);
  assign instr_is_itype = (inst_reg[2 : 0] == 3'b010);
  assign instr_is_peek = (instr_is_itype && (inst_reg[6 : 3] == 4'b0010));
  assign instr_is_poke = (instr_is_itype && (inst_reg[6 : 3] == 4'b0001));
  assign instr_imm = inst_reg[31 : 16];
  assign instr_rd = inst_reg[11 : 7];
  assign instr_rs1 = inst_reg[19 : 15];
  assign instr_rs2 = inst_reg[24 : 20];
  assign _zz_instr_opcode = inst_reg[6 : 3];
  assign instr_opcode = _zz_instr_opcode;
  always @(*) begin
    fsm_wantExit = 1'b0;
    case(fsm_stateReg)
      fsm_enumDef_init : begin
      end
      fsm_enumDef_decode : begin
        if(!instr_is_rtype) begin
          if(!instr_is_peek) begin
            if(!instr_is_poke) begin
              fsm_wantExit = 1'b1;
            end
          end
        end
      end
      fsm_enumDef_calc : begin
      end
      fsm_enumDef_read_reg : begin
        fsm_wantExit = 1'b1;
      end
      fsm_enumDef_write_reg : begin
        fsm_wantExit = 1'b1;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_wantStart = 1'b0;
    case(fsm_stateReg)
      fsm_enumDef_init : begin
      end
      fsm_enumDef_decode : begin
      end
      fsm_enumDef_calc : begin
      end
      fsm_enumDef_read_reg : begin
      end
      fsm_enumDef_write_reg : begin
      end
      default : begin
        fsm_wantStart = 1'b1;
      end
    endcase
  end

  assign fsm_wantKill = 1'b0;
  always @(*) begin
    fsm_stateNext = fsm_stateReg;
    case(fsm_stateReg)
      fsm_enumDef_init : begin
        if(io_step) begin
          fsm_stateNext = fsm_enumDef_decode;
        end
      end
      fsm_enumDef_decode : begin
        if(instr_is_rtype) begin
          fsm_stateNext = fsm_enumDef_calc;
        end else begin
          if(instr_is_peek) begin
            fsm_stateNext = fsm_enumDef_read_reg;
          end else begin
            if(instr_is_poke) begin
              fsm_stateNext = fsm_enumDef_write_reg;
            end else begin
              fsm_stateNext = fsm_enumDef_BOOT;
            end
          end
        end
      end
      fsm_enumDef_calc : begin
        fsm_stateNext = fsm_enumDef_write_reg;
      end
      fsm_enumDef_read_reg : begin
        fsm_stateNext = fsm_enumDef_BOOT;
      end
      fsm_enumDef_write_reg : begin
        fsm_stateNext = fsm_enumDef_BOOT;
      end
      default : begin
      end
    endcase
    if(fsm_wantStart) begin
      fsm_stateNext = fsm_enumDef_init;
    end
    if(fsm_wantKill) begin
      fsm_stateNext = fsm_enumDef_BOOT;
    end
  end

  always @(posedge sys_clk or posedge sys_reset) begin
    if(sys_reset) begin
      io_reg_file_we <= 1'b0;
      inst_reg <= 32'h00000000;
      fsm_stateReg <= fsm_enumDef_BOOT;
    end else begin
      fsm_stateReg <= fsm_stateNext;
      case(fsm_stateReg)
        fsm_enumDef_init : begin
          io_reg_file_we <= 1'b0;
          if(io_step) begin
            inst_reg <= io_dip_sw;
          end
        end
        fsm_enumDef_decode : begin
        end
        fsm_enumDef_calc : begin
        end
        fsm_enumDef_read_reg : begin
        end
        fsm_enumDef_write_reg : begin
          io_reg_file_we <= 1'b1;
        end
        default : begin
        end
      endcase
    end
  end

  always @(posedge sys_clk) begin
    case(fsm_stateReg)
      fsm_enumDef_init : begin
      end
      fsm_enumDef_decode : begin
        if(instr_is_rtype) begin
          io_reg_file_raddr_a <= instr_rs1;
          io_reg_file_raddr_b <= instr_rs2;
        end else begin
          if(instr_is_peek) begin
            io_reg_file_raddr_a <= instr_rd;
          end
        end
      end
      fsm_enumDef_calc : begin
        io_alu_a <= io_reg_file_rdata_a;
        io_alu_b <= io_reg_file_rdata_b;
        io_alu_op <= instr_opcode;
      end
      fsm_enumDef_read_reg : begin
        io_leds <= io_reg_file_rdata_a;
      end
      fsm_enumDef_write_reg : begin
        io_reg_file_waddr <= instr_rd;
        io_reg_file_wdata <= (instr_is_rtype ? io_alu_y : instr_imm);
      end
      default : begin
      end
    endcase
  end


endmodule

module Alu (
  input  wire [15:0]   io_a,
  input  wire [15:0]   io_b,
  input  wire [3:0]    io_op,
  output reg  [15:0]   io_y
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

  wire       [15:0]   _zz_io_y_5;
  wire       [15:0]   _zz_io_y_6;
  wire       [15:0]   _zz_io_y_7;
  wire       [15:0]   s_a;
  wire       [15:0]   s_b;
  wire       [3:0]    shamt;
  reg        [15:0]   _zz_io_y;
  reg        [15:0]   _zz_io_y_1;
  reg        [15:0]   _zz_io_y_2;
  reg        [15:0]   _zz_io_y_3;
  wire       [15:0]   _zz_io_y_4;
  `ifndef SYNTHESIS
  reg [39:0] io_op_string;
  `endif


  assign _zz_io_y_5 = ($signed(s_a) + $signed(s_b));
  assign _zz_io_y_6 = ($signed(s_a) - $signed(s_b));
  assign _zz_io_y_7 = ($signed(s_a) >>> shamt);
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
  assign shamt = io_b[3 : 0];
  always @(*) begin
    case(io_op)
      AluOp_OP1 : begin
        io_y = io_a;
      end
      AluOp_ADD : begin
        io_y = _zz_io_y_5;
      end
      AluOp_SUB : begin
        io_y = _zz_io_y_6;
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
        io_y = _zz_io_y_7;
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
    _zz_io_y = (shamt[3] ? {_zz_io_y_1[7 : 0],_zz_io_y_1[15 : 8]} : _zz_io_y_1);
  end

  always @(*) begin
    _zz_io_y_1 = _zz_io_y_2;
    _zz_io_y_1 = (shamt[2] ? {_zz_io_y_2[11 : 0],_zz_io_y_2[15 : 12]} : _zz_io_y_2);
  end

  always @(*) begin
    _zz_io_y_2 = _zz_io_y_3;
    _zz_io_y_2 = (shamt[1] ? {_zz_io_y_3[13 : 0],_zz_io_y_3[15 : 14]} : _zz_io_y_3);
  end

  always @(*) begin
    _zz_io_y_3 = _zz_io_y_4;
    _zz_io_y_3 = (shamt[0] ? {_zz_io_y_4[14 : 0],_zz_io_y_4[15 : 15]} : _zz_io_y_4);
  end

  assign _zz_io_y_4 = io_a;

endmodule

module RegFile (
  input  wire [4:0]    io_raddr_a,
  output wire [15:0]   io_rdata_a,
  input  wire [4:0]    io_raddr_b,
  output wire [15:0]   io_rdata_b,
  input  wire [4:0]    io_waddr,
  input  wire [15:0]   io_wdata,
  input  wire          io_we,
  input  wire          sys_clk,
  input  wire          sys_reset
);

  reg        [15:0]   _zz_io_rdata_a;
  reg        [15:0]   _zz_io_rdata_b;
  reg        [15:0]   mem_0;
  reg        [15:0]   mem_1;
  reg        [15:0]   mem_2;
  reg        [15:0]   mem_3;
  reg        [15:0]   mem_4;
  reg        [15:0]   mem_5;
  reg        [15:0]   mem_6;
  reg        [15:0]   mem_7;
  reg        [15:0]   mem_8;
  reg        [15:0]   mem_9;
  reg        [15:0]   mem_10;
  reg        [15:0]   mem_11;
  reg        [15:0]   mem_12;
  reg        [15:0]   mem_13;
  reg        [15:0]   mem_14;
  reg        [15:0]   mem_15;
  reg        [15:0]   mem_16;
  reg        [15:0]   mem_17;
  reg        [15:0]   mem_18;
  reg        [15:0]   mem_19;
  reg        [15:0]   mem_20;
  reg        [15:0]   mem_21;
  reg        [15:0]   mem_22;
  reg        [15:0]   mem_23;
  reg        [15:0]   mem_24;
  reg        [15:0]   mem_25;
  reg        [15:0]   mem_26;
  reg        [15:0]   mem_27;
  reg        [15:0]   mem_28;
  reg        [15:0]   mem_29;
  reg        [15:0]   mem_30;
  reg        [15:0]   mem_31;
  wire                when_RegFile_l34;
  wire       [31:0]   _zz_1;

  always @(*) begin
    case(io_raddr_a)
      5'b00000 : _zz_io_rdata_a = mem_0;
      5'b00001 : _zz_io_rdata_a = mem_1;
      5'b00010 : _zz_io_rdata_a = mem_2;
      5'b00011 : _zz_io_rdata_a = mem_3;
      5'b00100 : _zz_io_rdata_a = mem_4;
      5'b00101 : _zz_io_rdata_a = mem_5;
      5'b00110 : _zz_io_rdata_a = mem_6;
      5'b00111 : _zz_io_rdata_a = mem_7;
      5'b01000 : _zz_io_rdata_a = mem_8;
      5'b01001 : _zz_io_rdata_a = mem_9;
      5'b01010 : _zz_io_rdata_a = mem_10;
      5'b01011 : _zz_io_rdata_a = mem_11;
      5'b01100 : _zz_io_rdata_a = mem_12;
      5'b01101 : _zz_io_rdata_a = mem_13;
      5'b01110 : _zz_io_rdata_a = mem_14;
      5'b01111 : _zz_io_rdata_a = mem_15;
      5'b10000 : _zz_io_rdata_a = mem_16;
      5'b10001 : _zz_io_rdata_a = mem_17;
      5'b10010 : _zz_io_rdata_a = mem_18;
      5'b10011 : _zz_io_rdata_a = mem_19;
      5'b10100 : _zz_io_rdata_a = mem_20;
      5'b10101 : _zz_io_rdata_a = mem_21;
      5'b10110 : _zz_io_rdata_a = mem_22;
      5'b10111 : _zz_io_rdata_a = mem_23;
      5'b11000 : _zz_io_rdata_a = mem_24;
      5'b11001 : _zz_io_rdata_a = mem_25;
      5'b11010 : _zz_io_rdata_a = mem_26;
      5'b11011 : _zz_io_rdata_a = mem_27;
      5'b11100 : _zz_io_rdata_a = mem_28;
      5'b11101 : _zz_io_rdata_a = mem_29;
      5'b11110 : _zz_io_rdata_a = mem_30;
      default : _zz_io_rdata_a = mem_31;
    endcase
  end

  always @(*) begin
    case(io_raddr_b)
      5'b00000 : _zz_io_rdata_b = mem_0;
      5'b00001 : _zz_io_rdata_b = mem_1;
      5'b00010 : _zz_io_rdata_b = mem_2;
      5'b00011 : _zz_io_rdata_b = mem_3;
      5'b00100 : _zz_io_rdata_b = mem_4;
      5'b00101 : _zz_io_rdata_b = mem_5;
      5'b00110 : _zz_io_rdata_b = mem_6;
      5'b00111 : _zz_io_rdata_b = mem_7;
      5'b01000 : _zz_io_rdata_b = mem_8;
      5'b01001 : _zz_io_rdata_b = mem_9;
      5'b01010 : _zz_io_rdata_b = mem_10;
      5'b01011 : _zz_io_rdata_b = mem_11;
      5'b01100 : _zz_io_rdata_b = mem_12;
      5'b01101 : _zz_io_rdata_b = mem_13;
      5'b01110 : _zz_io_rdata_b = mem_14;
      5'b01111 : _zz_io_rdata_b = mem_15;
      5'b10000 : _zz_io_rdata_b = mem_16;
      5'b10001 : _zz_io_rdata_b = mem_17;
      5'b10010 : _zz_io_rdata_b = mem_18;
      5'b10011 : _zz_io_rdata_b = mem_19;
      5'b10100 : _zz_io_rdata_b = mem_20;
      5'b10101 : _zz_io_rdata_b = mem_21;
      5'b10110 : _zz_io_rdata_b = mem_22;
      5'b10111 : _zz_io_rdata_b = mem_23;
      5'b11000 : _zz_io_rdata_b = mem_24;
      5'b11001 : _zz_io_rdata_b = mem_25;
      5'b11010 : _zz_io_rdata_b = mem_26;
      5'b11011 : _zz_io_rdata_b = mem_27;
      5'b11100 : _zz_io_rdata_b = mem_28;
      5'b11101 : _zz_io_rdata_b = mem_29;
      5'b11110 : _zz_io_rdata_b = mem_30;
      default : _zz_io_rdata_b = mem_31;
    endcase
  end

  assign io_rdata_a = _zz_io_rdata_a;
  assign io_rdata_b = _zz_io_rdata_b;
  assign when_RegFile_l34 = (io_we && (io_waddr != 5'h00));
  assign _zz_1 = ({31'd0,1'b1} <<< io_waddr);
  always @(posedge sys_clk or posedge sys_reset) begin
    if(sys_reset) begin
      mem_0 <= 16'h0000;
      mem_1 <= 16'h0000;
      mem_2 <= 16'h0000;
      mem_3 <= 16'h0000;
      mem_4 <= 16'h0000;
      mem_5 <= 16'h0000;
      mem_6 <= 16'h0000;
      mem_7 <= 16'h0000;
      mem_8 <= 16'h0000;
      mem_9 <= 16'h0000;
      mem_10 <= 16'h0000;
      mem_11 <= 16'h0000;
      mem_12 <= 16'h0000;
      mem_13 <= 16'h0000;
      mem_14 <= 16'h0000;
      mem_15 <= 16'h0000;
      mem_16 <= 16'h0000;
      mem_17 <= 16'h0000;
      mem_18 <= 16'h0000;
      mem_19 <= 16'h0000;
      mem_20 <= 16'h0000;
      mem_21 <= 16'h0000;
      mem_22 <= 16'h0000;
      mem_23 <= 16'h0000;
      mem_24 <= 16'h0000;
      mem_25 <= 16'h0000;
      mem_26 <= 16'h0000;
      mem_27 <= 16'h0000;
      mem_28 <= 16'h0000;
      mem_29 <= 16'h0000;
      mem_30 <= 16'h0000;
      mem_31 <= 16'h0000;
    end else begin
      if(when_RegFile_l34) begin
        if(_zz_1[0]) begin
          mem_0 <= io_wdata;
        end
        if(_zz_1[1]) begin
          mem_1 <= io_wdata;
        end
        if(_zz_1[2]) begin
          mem_2 <= io_wdata;
        end
        if(_zz_1[3]) begin
          mem_3 <= io_wdata;
        end
        if(_zz_1[4]) begin
          mem_4 <= io_wdata;
        end
        if(_zz_1[5]) begin
          mem_5 <= io_wdata;
        end
        if(_zz_1[6]) begin
          mem_6 <= io_wdata;
        end
        if(_zz_1[7]) begin
          mem_7 <= io_wdata;
        end
        if(_zz_1[8]) begin
          mem_8 <= io_wdata;
        end
        if(_zz_1[9]) begin
          mem_9 <= io_wdata;
        end
        if(_zz_1[10]) begin
          mem_10 <= io_wdata;
        end
        if(_zz_1[11]) begin
          mem_11 <= io_wdata;
        end
        if(_zz_1[12]) begin
          mem_12 <= io_wdata;
        end
        if(_zz_1[13]) begin
          mem_13 <= io_wdata;
        end
        if(_zz_1[14]) begin
          mem_14 <= io_wdata;
        end
        if(_zz_1[15]) begin
          mem_15 <= io_wdata;
        end
        if(_zz_1[16]) begin
          mem_16 <= io_wdata;
        end
        if(_zz_1[17]) begin
          mem_17 <= io_wdata;
        end
        if(_zz_1[18]) begin
          mem_18 <= io_wdata;
        end
        if(_zz_1[19]) begin
          mem_19 <= io_wdata;
        end
        if(_zz_1[20]) begin
          mem_20 <= io_wdata;
        end
        if(_zz_1[21]) begin
          mem_21 <= io_wdata;
        end
        if(_zz_1[22]) begin
          mem_22 <= io_wdata;
        end
        if(_zz_1[23]) begin
          mem_23 <= io_wdata;
        end
        if(_zz_1[24]) begin
          mem_24 <= io_wdata;
        end
        if(_zz_1[25]) begin
          mem_25 <= io_wdata;
        end
        if(_zz_1[26]) begin
          mem_26 <= io_wdata;
        end
        if(_zz_1[27]) begin
          mem_27 <= io_wdata;
        end
        if(_zz_1[28]) begin
          mem_28 <= io_wdata;
        end
        if(_zz_1[29]) begin
          mem_29 <= io_wdata;
        end
        if(_zz_1[30]) begin
          mem_30 <= io_wdata;
        end
        if(_zz_1[31]) begin
          mem_31 <= io_wdata;
        end
      end
    end
  end


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
