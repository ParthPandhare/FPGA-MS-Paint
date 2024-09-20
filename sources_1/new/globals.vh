parameter pixel_size = 10;

// 120 to 617 horizontal
// 60 to 419 vertical
parameter initial_x = 7'd29; // actual 0 is 15
parameter initial_y = 7'd12; // actual 0 is 4
parameter min_x = 7'd15;
parameter min_y = 7'd4;
parameter max_x = 7'd76;
parameter max_y = 7'd47; // end
// x goes from 15 to 78 (inclusive)
// y goes from 4 to 47 (inclusive)
// total "pixels": 128 * 96 = 12288 = 14'b110000000000

// video structure constants
parameter hpixels = 800;// horizontal pixels per line
parameter vlines = 525; //521 // vertical lines per frame
parameter hpulse = 96; 	// hsync pulse length
parameter vpulse = 2; 	// vsync pulse length
parameter hbp = 144; 	// end of horizontal back porch
parameter hfp = 784; 	// beginning of horizontal front porch
parameter vbp = 35; //31 		// end of vertical back porch
parameter vfp = 515; 	// beginning of vertical front porch
// active horizontal video is therefore: 784 - 144 = 640
// active vertical video is therefore: 515 - 35 = 480


// brush size bitmaps
parameter [98:0] medium_size = 99'b111000000000000000000000000000000000000000000000111000000000000000000000000000000000000000000000111;