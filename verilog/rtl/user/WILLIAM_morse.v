`timescale 1ns / 1ps
module WILLIAM_morse (
    input clk,
    input rst,
    output reg [7:0] led
);
    reg [27:0] timer;
    reg [4:0] ptr;
    // 摩斯密碼 W I L L I A M (長度14)
    localparam [2:0] code[0:13] = '{
        3'd3, 3'd1, 3'd1, // W .--
        3'd1, 3'd1,       // I ..
        3'd1, 3'd3, 3'd1, 3'd1, // L .-..
        3'd1, 3'd3, 3'd1, 3'd1, // L .-..
        3'd1, 3'd1,       // I ..
        3'd1, 3'd3,       // A .-
        3'd3, 3'd3        // M --
    };
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            timer <= 0;
            ptr <= 0;
            led <= 8'b0;
        end else begin
            timer <= timer + 1;
            if (timer == 28'd25_000_000) begin // 1秒
                timer <= 0;
                ptr <= (ptr == 13) ? 0 : ptr + 1;
            end
            case (code[ptr])
                1: led <= (timer < 28'd6_250_000) ? 8'hFF : 8'h00; // 短點 0.25s
                3: led <= (timer < 28'd18_750_000) ? 8'hFF : 8'h00; // 長劃 0.75s
                default: led <= 8'h00;
            endcase
        end
    end
endmodule
