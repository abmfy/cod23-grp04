### BranchPredict 组件
接口

* IN

| name           | value                   |
| -------------- | ----------------------- |
| is_branch      | EXE的branch             |
| branch_addr    | EXE段跳转的目标地址     |
| branch_instr   | EXE段跳转指令的原始指令 |
| predict_result | EXE段计算出来的成功与否 |
| IF_instr       | IF段读到的指令          |
| current_pc     | 当前PC                  |

* OUT

| name       | value                              |
| ---------- | ---------------------------------- |
| next_pc    | 下个周期IF取指的PC（直接接到PC上） |
| next_taken | 是否采用了                         |

* BTB表项设计

1024* 32大小，每一项存历史记录的跳转PC【30位，末两位输出时补0】，以及2bit的历史跳转信息BHT（为了方便直接放在这里了）

【备用方案：BTB 32位完整PC， BHT 2位另存一块】

demo: 16*32, 读取用[5:2]

* 查表逻辑
* 当EXE执行到branch的时候，不管跳没跳，都存起来当前branch的跳转目标PC[31:2], 然后根据跳转结果更新饱和寄存器
  * 00
    * ! br.we  -> 00
    * br_we -> 01
  * 01
    *  !br_we -> 00
    * br_we -> 10
  * 10
    *  br_we && next_pc == br_addr -> 11
    * otherwise -> 01
  * 11
    * br_we &&
* 当IF段遇到跳转指令时, if bht >= 2 then br



当 br说自己要跳转时，如果exe算出来要跳转，那么优先exe，否则接