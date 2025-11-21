`include "user_project_defines.v"
module user_project_wrapper (
    `ifdef USE_POWER_PINS
        inout vdda1, vdda2, vssa1, vssa2, vccd1, vccd2, vssd1,
    `endif
    input [37:0] io_in,
    output [37:0] io_out,
    output [37:0] io_oeb
);
    WILLIAM_morse william (
        .clk(io_in[0]),
        .rst(io_in[1]),
        .led(io_out[9:2])
    );
    assign io_out[37:10] = 0;
    assign io_oeb = 0;
endmodule
存成檔案名：user_project_wrapper.v
檔案 3：config.json（覆蓋原本的 openlane/user_project_wrapper/config.json）
JSON{
  "DESIGN_NAME": "user_project_wrapper",
  "VERILOG_FILES": [
    "dir::verilog/rtl/user_project_wrapper.v",
    "dir::verilog/rtl/user/WILLIAM_morse.v"
  ],
  "CLOCK_PORT": "io_in[0]",
  "CLOCK_PERIOD": 25.0,
  "PDK": "sky130A",
  "DIE_AREA": "0 0 2920 3520",
  "PL_TARGET_DENSITY": 0.4,
  "FP_SIZING": "absolute",
  "SYNTH_STRATEGY": "DELAY 0"
`default_nettype wire
