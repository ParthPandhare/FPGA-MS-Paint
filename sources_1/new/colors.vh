parameter [8:0] RED = { 3'b111, 3'b0, 3'b0 };
parameter [8:0] GREEN = { 3'b0, 3'b111, 3'b0 };
parameter [8:0] BLUE = { 3'b0, 3'b0, 3'b111 };
parameter [8:0] GRAY = { 3'd4, 3'd4, 3'd4 };
parameter [8:0] BLACK = { 3'd0, 3'd0, 3'd0 };
parameter [8:0] WHITE = { 3'b111, 3'b111, 3'b111 };
parameter [8:0] PURPLE = { 3'b111, 3'b0, 3'b111 };
parameter [8:0] YELLO = { 3'b111, 3'b111, 3'b0 };
parameter [8:0] CYAN = { 3'b0, 3'b111, 3'b111 };

parameter [0:224] untitled_paint = 225'b000000001001010010000000100001110000010000010000000001100011010111000100001010001000000011101011101001010010111011101101110111010111010101010101001010010100010100001000101010101010111010101101011010111011100001000111010101011;

parameter [0:24] x_sign = 25'b1000101010001000101010001;
// reg [24:0] RED_BITMAP = {
    
// };

// const reg [2:0] YELLO_BITMAP [0:4][0:4] = {
//     {3'b000, 3'b000, 3'b000, 3'b000, 3'b000 },
//     {3'b000, 3'b110, 3'b110, 3'b110, 3'b000 },
//     {3'b000, 3'b110, 3'b110, 3'b110, 3'b000 },
//     {3'b000, 3'b110, 3'b110, 3'b110, 3'b000 },
//     {3'b000, 3'b000, 3'b000, 3'b000, 3'b000 }
// };
// const reg [2:0] GREEN_BITMAP [0:4][0:4] = {
//     {3'b000, 3'b000, 3'b000, 3'b000, 3'b000 },
//     {3'b000, 3'b010, 3'b010, 3'b010, 3'b000 },
//     {3'b000, 3'b010, 3'b010, 3'b010, 3'b000 },
//     {3'b000, 3'b010, 3'b010, 3'b010, 3'b000 },
//     {3'b000, 3'b000, 3'b000, 3'b000, 3'b000 }
// };
// const reg [2:0] CYAN_BITMAP [0:4][0:4] = {
//     {3'b000, 3'b000, 3'b000, 3'b000, 3'b000 },
//     {3'b000, 3'b011, 3'b011, 3'b011, 3'b000 },
//     {3'b000, 3'b011, 3'b011, 3'b011, 3'b000 },
//     {3'b000, 3'b011, 3'b011, 3'b011, 3'b000 },
//     {3'b000, 3'b000, 3'b000, 3'b000, 3'b000 }
// };
// const reg [2:0] BLUE_BITMAP [0:4][0:4] = {
//     {3'b000, 3'b000, 3'b000, 3'b000, 3'b000 },
//     {3'b000, 3'b001, 3'b001, 3'b001, 3'b000 },
//     {3'b000, 3'b001, 3'b001, 3'b001, 3'b000 },
//     {3'b000, 3'b001, 3'b001, 3'b001, 3'b000 },
//     {3'b000, 3'b000, 3'b000, 3'b000, 3'b000 }
// };

// const reg [2:0] PURPLE_BITMAP [0:4][0:4] = {
//     {3'b000, 3'b000, 3'b000, 3'b000, 3'b000 },
//     {3'b000, 3'b101, 3'b101, 3'b101, 3'b000 },
//     {3'b000, 3'b101, 3'b101, 3'b101, 3'b000 },
//     {3'b000, 3'b101, 3'b101, 3'b101, 3'b000 },
//     {3'b000, 3'b000, 3'b000, 3'b000, 3'b000 }
// };

// const reg [2:0] WHITE_BITMAP [0:4][0:4] = {
//     {3'b000, 3'b000, 3'b000, 3'b000, 3'b000 },
//     {3'b000, 3'b111, 3'b111, 3'b111, 3'b000 },
//     {3'b000, 3'b111, 3'b111, 3'b111, 3'b000 },
//     {3'b000, 3'b111, 3'b111, 3'b111, 3'b000 },
//     {3'b000, 3'b000, 3'b000, 3'b000, 3'b000 }
// };

// const reg [2:0] BLACK_BITMAP [0:4][0:4] = {
//     {3'b000, 3'b000, 3'b000, 3'b000, 3'b000 },
//     {3'b000, 3'b000, 3'b000, 3'b000, 3'b000 },
//     {3'b000, 3'b000, 3'b000, 3'b000, 3'b000 },
//     {3'b000, 3'b000, 3'b000, 3'b000, 3'b000 },
//     {3'b000, 3'b000, 3'b000, 3'b000, 3'b000 }
// };