module sin_LUT(input [9:0] angleX, input [9:0] angleY, output reg signed [1:0] ratioX, output reg signed [17:0] ratioY);

        always @(*) begin
                case(angle)
                        20'b00000000000000000000: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000000000000000000;
                        end
                        20'b00000000000101110111: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000000001010001110;
                        end
                        20'b00000000001011101110: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000000010100011101;
                        end
                        20'b00000000010001111101: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000000011110101011;
                        end
                        20'b00000000010111110100: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000000101000111010;
                        end
                        20'b00000000011101101011: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000000110011001000;
                        end
                        20'b00000000100011111010: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000000111101010110;
                        end
                        20'b00000000101001110001: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000001000111100100;
                        end
                        20'b00000000110000000000: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000001010001110010;
                        end
                        20'b00000000110101110111: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000001011011111111;
                        end
                        20'b00000000111011101110: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000001100110001100;
                        end
                        20'b00000001000001111101: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000001110000011001;
                        end
                        20'b00000001000111110100: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000001111010100110;
                        end
                        20'b00000001001101101011: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000010000100110010;
                        end
                        20'b00000001010011111010: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000010001110111110;
                        end
                        20'b00000001011001110001: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000010011001001010;
                        end
                        20'b00000001100000000000: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000010100011010101;
                        end
                        20'b00000001100101110111: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000010101101100000;
                        end
                        20'b00000001101011101110: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000010110111101010;
                        end
                        20'b00000001110001111101: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000011000001110011;
                        end
                        20'b00000001110111110100: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000011001011111101;
                        end
                        20'b00000001111101101011: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000011010110000101;
                        end
                        20'b00000010000011111010: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000011100000001101;
                        end
                        20'b00000010001001110001: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000011101010010101;
                        end
                        20'b00000010010000000000: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000011110100011011;
                        end
                        20'b00000010010101110111: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000011111110100010;
                        end
                        20'b00000010011011101110: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000100001000100111;
                        end
                        20'b00000010100001111101: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000100010010101100;
                        end
                        20'b00000010100111110100: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000100011100110000;
                        end
                        20'b00000010101101101011: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000100100110110011;
                        end
                        20'b00000010110011111010: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000100110000110101;
                        end
                        20'b00000010111001110001: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000100111010110111;
                        end
                        20'b00000011000000000000: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000101000100110111;
                        end
                        20'b00000011000101110111: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000101001110110111;
                        end
                        20'b00000011001011101110: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000101011000110110;
                        end
                        20'b00000011010001111101: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000101100010110100;
                        end
                        20'b00000011010111110100: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000101101100110001;
                        end
                        20'b00000011011101101011: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000101110110101100;
                        end
                        20'b00000011100011111010: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000110000000100111;
                        end
                        20'b00000011101001110001: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000110001010100001;
                        end
                        20'b00000011110000000000: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000110010100011010;
                        end
                        20'b00000011110101110111: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000110011110010010;
                        end
                        20'b00000011111011101110: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000110101000001000;
                        end
                        20'b00000100000001111101: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000110110001111101;
                        end
                        20'b00000100000111110100: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000110111011110010;
                        end
                        20'b00000100001101101011: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000111000101100100;
                        end
                        20'b00000100010011111010: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000111001111010110;
                        end
                        20'b00000100011001110001: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000111011001000111;
                        end
                        20'b00000100100000000000: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000111100010110110;
                        end
                        20'b00000100100101110111: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000111101100100011;
                        end
                        20'b00000100101011101110: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000111110110010000;
                        end
                        20'b00000100110001111101: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000111111111111011;
                        end
                        20'b00000100110111110100: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001000001001100101;
                        end
                        20'b00000100111101101011: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001000010011001101;
                        end
                        20'b00000101000011111010: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001000011100110100;
                        end
                        20'b00000101001001110001: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001000100110011001;
                        end
                        20'b00000101010000000000: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001000101111111101;
                        end
                        20'b00000101010101110111: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001000111001011111;
                        end
                        20'b00000101011011101110: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001001000011000000;
                        end
                        20'b00000101100001111101: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001001001100011111;
                        end
                        20'b00000101100111110100: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001001010101111100;
                        end
                        20'b00000101101101101011: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001001011111011000;
                        end
                        20'b00000101110011111010: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001001101000110010;
                        end
                        20'b00000101111001110001: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001001110010001011;
                        end
                        20'b00000110000000000000: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001001111011100010;
                        end
                        20'b00000110000101110111: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001010000100110111;
                        end
                        20'b00000110001011101110: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001010001110001010;
                        end
                        20'b00000110010001111101: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001010010111011011;
                        end
                        20'b00000110010111110100: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001010100000101011;
                        end
                        20'b00000110011101101011: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001010101001111001;
                        end
                        20'b00000110100011111010: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001010110011000101;
                        end
                        20'b00000110101001110001: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001010111100001111;
                        end
                        20'b00000110110000000000: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001011000101010111;
                        end
                        20'b00000110110101110111: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001011001110011101;
                        end
                        20'b00000110111011101110: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001011010111100001;
                        end
                        20'b00000111000001111101: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001011100000100100;
                        end
                        20'b00000111000111110100: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001011101001100100;
                        end
                        20'b00000111001101101011: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001011110010100010;
                        end
                        20'b00000111010011111010: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001011111011011110;
                        end
                        20'b00000111011001110001: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001100000100011000;
                        end
                        20'b00000111100000000000: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001100001101010000;
                        end
                        20'b00000111100101110111: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001100010110000110;
                        end
                        20'b00000111101011101110: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001100011110111001;
                        end
                        20'b00000111110001111101: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001100100111101011;
                        end
                        20'b00000111110111110100: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001100110000011010;
                        end
                        20'b00000111111101101011: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001100111001000111;
                        end
                        20'b00001000000011111010: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001101000001110001;
                        end
                        20'b00001000001001110001: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001101001010011010;
                        end
                        20'b00001000010000000000: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001101010011000000;
                        end
                        20'b00001000010101110111: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001101011011100100;
                        end
                        20'b00001000011011101110: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001101100100000101;
                        end
                        20'b00001000100001111101: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001101101100100100;
                        end
                        20'b00001000100111110100: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001101110101000001;
                        end
                        20'b00001000101101101011: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001101111101011011;
                        end
                        20'b00001000110011111010: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001110000101110011;
                        end
                        20'b00001000111001110001: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001110001110001000;
                        end
                        20'b00001001000000000000: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001110010110011011;
                        end
                        20'b00001001000101110111: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001110011110101011;
                        end
                        20'b00001001001011101110: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001110100110111000;
                        end
                        20'b00001001010001111101: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001110101111000100;
                        end
                        20'b00001001010111110100: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001110110111001100;
                        end
                        20'b00001001011101101011: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001110111111010010;
                        end
                        20'b00001001100011111010: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001111000111010101;
                        end
                        20'b00001001101001110001: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001111001111010110;
                        end
                        20'b00001001110000000000: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001111010111010100;
                        end
                        20'b00001001110101110111: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001111011111001111;
                        end
                        20'b00001001111011101110: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001111100111001000;
                        end
                        20'b00001010000001111101: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001111101110111110;
                        end
                        20'b00001010000111110100: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001111110110110001;
                        end
                        20'b00001010001101101011: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001111111110100001;
                        end
                        20'b00001010010011111010: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010000000110001111;
                        end
                        20'b00001010011001110001: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010000001101111001;
                        end
                        20'b00001010100000000000: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010000010101100001;
                        end
                        20'b00001010100101110111: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010000011101000110;
                        end
                        20'b00001010101011101110: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010000100100101000;
                        end
                        20'b00001010110001111101: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010000101100000111;
                        end
                        20'b00001010110111110100: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010000110011100011;
                        end
                        20'b00001010111101101011: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010000111010111101;
                        end
                        20'b00001011000011111010: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010001000010010011;
                        end
                        20'b00001011001001110001: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010001001001100110;
                        end
                        20'b00001011010000000000: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010001010000110111;
                        end
                        20'b00001011010101110111: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010001011000000100;
                        end
                        20'b00001011011011101110: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010001011111001110;
                        end
                        20'b00001011100001111101: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010001100110010101;
                        end
                        20'b00001011100111110100: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010001101101011001;
                        end
                        20'b00001011101101101011: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010001110100011010;
                        end
                        20'b00001011110011111010: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010001111011011000;
                        end
                        20'b00001011111001110001: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010010000010010011;
                        end
                        20'b00001100000000000000: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010010001001001010;
                        end
                        20'b00001100000101110111: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010010001111111111;
                        end
                        20'b00001100001011101110: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010010010110110000;
                        end
                        20'b00001100010001111101: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010010011101011110;
                        end
                        20'b00001100010111110100: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010010100100001001;
                        end
                        20'b00001100011101101011: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010010101010110000;
                        end
                        20'b00001100100011111010: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010010110001010100;
                        end
                        20'b00001100101001110001: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010010110111110101;
                        end
                        20'b00001100110000000000: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010010111110010011;
                        end
                        20'b00001100110101110111: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010011000100101101;
                        end
                        20'b00001100111011101110: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010011001011000100;
                        end
                        20'b00001101000001111101: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010011010001010111;
                        end
                        20'b00001101000111110100: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010011010111100111;
                        end
                        20'b00001101001101101011: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010011011101110100;
                        end
                        20'b00001101010011111010: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010011100011111101;
                        end
                        20'b00001101011001110001: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010011101010000011;
                        end
                        20'b00001101100000000000: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010011110000000110;
                        end
                        20'b00001101100101110111: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010011110110000101;
                        end
                        20'b00001101101011101110: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010011111100000000;
                        end
                        20'b00001101110001111101: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010100000001111000;
                        end
                        20'b00001101110111110100: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010100000111101101;
                        end
                        20'b00001101111101101011: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010100001101011110;
                        end
                        20'b00001110000011111010: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010100010011001011;
                        end
                        20'b00001110001001110001: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010100011000110101;
                        end
                        20'b00001110010000000000: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010100011110011011;
                        end
                        20'b00001110010101110111: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010100100011111110;
                        end
                        20'b00001110011011101110: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010100101001011101;
                        end
                        20'b00001110100001111101: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010100101110111000;
                        end
                        20'b00001110100111110100: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010100110100010000;
                        end
                        20'b00001110101101101011: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010100111001100100;
                        end
                        20'b00001110110011111010: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010100111110110101;
                        end
                        20'b00001110111001110001: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010101000100000001;
                        end
                        20'b00001111000000000000: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010101001001001011;
                        end
                        20'b00001111000101110111: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010101001110010000;
                        end
                        20'b00001111001011101110: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010101010011010010;
                        end
                        20'b00001111010001111101: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010101011000010000;
                        end
                        20'b00001111010111110100: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010101011101001010;
                        end
                        20'b00001111011101101011: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010101100010000000;
                        end
                        20'b00001111100011111010: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010101100110110011;
                        end
                        20'b00001111101001110001: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010101101011100010;
                        end
                        20'b00001111110000000000: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010101110000001101;
                        end
                        20'b00001111110101110111: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010101110100110100;
                        end
                        20'b00001111111011101110: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010101111001010111;
                        end
                        20'b00010000000001111101: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010101111101110111;
                        end
                        20'b00010000000111110100: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010110000010010011;
                        end
                        20'b00010000001101101011: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010110000110101010;
                        end
                        20'b00010000010011111010: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010110001010111110;
                        end
                        20'b00010000011001110001: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010110001111001110;
                        end
                        20'b00010000100000000000: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010110010011011011;
                        end
                        20'b00010000100101110111: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010110010111100011;
                        end
                        20'b00010000101011101110: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010110011011100111;
                        end
                        20'b00010000110001111101: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010110011111101000;
                        end
                        20'b00010000110111110100: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010110100011100100;
                        end
                        20'b00010000111101101011: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010110100111011100;
                        end
                        20'b00010001000011111010: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010110101011010001;
                        end
                        20'b00010001001001110001: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010110101111000001;
                        end
                        20'b00010001010000000000: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010110110010101110;
                        end
                        20'b00010001010101110111: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010110110110010111;
                        end
                        20'b00010001011011101110: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010110111001111011;
                        end
                        20'b00010001100001111101: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010110111101011100;
                        end
                        20'b00010001100111110100: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010111000000111000;
                        end
                        20'b00010001101101101011: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010111000100010001;
                        end
                        20'b00010001110011111010: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010111000111100101;
                        end
                        20'b00010001111001110001: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010111001010110101;
                        end
                        20'b00010010000000000000: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010111001110000010;
                        end
                        20'b00010010000101110111: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010111010001001010;
                        end
                        20'b00010010001011101110: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010111010100001110;
                        end
                        20'b00010010010001111101: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010111010111001110;
                        end
                        20'b00010010010111110100: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010111011010001010;
                        end
                        20'b00010010011101101011: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010111011101000010;
                        end
                        20'b00010010100011111010: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010111011111110110;
                        end
                        20'b00010010101001110001: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010111100010100101;
                        end
                        20'b00010010110000000000: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010111100101010001;
                        end
                        20'b00010010110101110111: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010111100111111000;
                        end
                        20'b00010010111011101110: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010111101010011011;
                        end
                        20'b00010011000001111101: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010111101100111010;
                        end
                        20'b00010011000111110100: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010111101111010101;
                        end
                        20'b00010011001101101011: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010111110001101100;
                        end
                        20'b00010011010011111010: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010111110011111110;
                        end
                        20'b00010011011001110001: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010111110110001101;
                        end
                        20'b00010011100000000000: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010111111000010111;
                        end
                        20'b00010011100101110111: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010111111010011101;
                        end
                        20'b00010011101011101110: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010111111100011111;
                        end
                        20'b00010011110001111101: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010111111110011100;
                        end
                        20'b00010011110111110100: begin
                                ratioX = 2'b00;
                                ratioY = 18'b011000000000010101;
                        end
                        20'b00010011111101101011: begin
                                ratioX = 2'b00;
                                ratioY = 18'b011000000010001011;
                        end
                        20'b00010100000011111010: begin
                                ratioX = 2'b00;
                                ratioY = 18'b011000000011111100;
                        end
                        20'b00010100001001110001: begin
                                ratioX = 2'b00;
                                ratioY = 18'b011000000101101000;
                        end
                        20'b00010100010000000000: begin
                                ratioX = 2'b00;
                                ratioY = 18'b011000000111010001;
                        end
                        20'b00010100010101110111: begin
                                ratioX = 2'b00;
                                ratioY = 18'b011000001000110101;
                        end
                        20'b00010100011011101110: begin
                                ratioX = 2'b00;
                                ratioY = 18'b011000001010010101;
                        end
                        20'b00010100100001111101: begin
                                ratioX = 2'b00;
                                ratioY = 18'b011000001011110001;
                        end
                        20'b00010100100111110100: begin
                                ratioX = 2'b00;
                                ratioY = 18'b011000001101001000;
                        end
                        20'b00010100101101101011: begin
                                ratioX = 2'b00;
                                ratioY = 18'b011000001110011100;
                        end
                        20'b00010100110011111010: begin
                                ratioX = 2'b00;
                                ratioY = 18'b011000001111101011;
                        end
                        20'b00010100111001110001: begin
                                ratioX = 2'b00;
                                ratioY = 18'b011000010000110110;
                        end
                        20'b00010101000000000000: begin
                                ratioX = 2'b00;
                                ratioY = 18'b011000010001111100;
                        end
                        20'b00010101000101110111: begin
                                ratioX = 2'b00;
                                ratioY = 18'b011000010010111110;
                        end
                        20'b00010101001011101110: begin
                                ratioX = 2'b00;
                                ratioY = 18'b011000010011111100;
                        end
                        20'b00010101010001111101: begin
                                ratioX = 2'b00;
                                ratioY = 18'b011000010100110110;
                        end
                        20'b00010101010111110100: begin
                                ratioX = 2'b00;
                                ratioY = 18'b011000010101101100;
                        end
                        20'b00010101011101101011: begin
                                ratioX = 2'b00;
                                ratioY = 18'b011000010110011101;
                        end
                        20'b00010101100011111010: begin
                                ratioX = 2'b00;
                                ratioY = 18'b011000010111001010;
                        end
                        20'b00010101101001110001: begin
                                ratioX = 2'b00;
                                ratioY = 18'b011000010111110011;
                        end
                        20'b00010101110000000000: begin
                                ratioX = 2'b00;
                                ratioY = 18'b011000011000010111;
                        end
                        20'b00010101110101110111: begin
                                ratioX = 2'b00;
                                ratioY = 18'b011000011000110111;
                        end
                        20'b00010101111011101110: begin
                                ratioX = 2'b00;
                                ratioY = 18'b011000011001010011;
                        end
                        20'b00010110000001111101: begin
                                ratioX = 2'b00;
                                ratioY = 18'b011000011001101010;
                        end
                        20'b00010110000111110100: begin
                                ratioX = 2'b00;
                                ratioY = 18'b011000011001111110;
                        end
                        20'b00010110001101101011: begin
                                ratioX = 2'b00;
                                ratioY = 18'b011000011010001101;
                        end
                        20'b00010110010011111010: begin
                                ratioX = 2'b00;
                                ratioY = 18'b011000011010010111;
                        end
                        20'b00010110011001110001: begin
                                ratioX = 2'b00;
                                ratioY = 18'b011000011010011110;
                        end
                        20'b00010110100000000000: begin
                                ratioX = 2'b01;
                                ratioY = 18'b000000000000000000;
                        end
                        20'b00010110100101110111: begin
                                ratioX = 2'b00;
                                ratioY = 18'b011000011010011110;
                        end
                        20'b00010110101011101110: begin
                                ratioX = 2'b00;
                                ratioY = 18'b011000011010010111;
                        end
                        20'b00010110110001111101: begin
                                ratioX = 2'b00;
                                ratioY = 18'b011000011010001101;
                        end
                        20'b00010110110111110100: begin
                                ratioX = 2'b00;
                                ratioY = 18'b011000011001111110;
                        end
                        20'b00010110111101101011: begin
                                ratioX = 2'b00;
                                ratioY = 18'b011000011001101010;
                        end
                        20'b00010111000011111010: begin
                                ratioX = 2'b00;
                                ratioY = 18'b011000011001010011;
                        end
                        20'b00010111001001110001: begin
                                ratioX = 2'b00;
                                ratioY = 18'b011000011000110111;
                        end
                        20'b00010111010000000000: begin
                                ratioX = 2'b00;
                                ratioY = 18'b011000011000010111;
                        end
                        20'b00010111010101110111: begin
                                ratioX = 2'b00;
                                ratioY = 18'b011000010111110011;
                        end
                        20'b00010111011011101110: begin
                                ratioX = 2'b00;
                                ratioY = 18'b011000010111001010;
                        end
                        20'b00010111100001111101: begin
                                ratioX = 2'b00;
                                ratioY = 18'b011000010110011101;
                        end
                        20'b00010111100111110100: begin
                                ratioX = 2'b00;
                                ratioY = 18'b011000010101101100;
                        end
                        20'b00010111101101101011: begin
                                ratioX = 2'b00;
                                ratioY = 18'b011000010100110110;
                        end
                        20'b00010111110011111010: begin
                                ratioX = 2'b00;
                                ratioY = 18'b011000010011111100;
                        end
                        20'b00010111111001110001: begin
                                ratioX = 2'b00;
                                ratioY = 18'b011000010010111110;
                        end
                        20'b00011000000000000000: begin
                                ratioX = 2'b00;
                                ratioY = 18'b011000010001111100;
                        end
                        20'b00011000000101110111: begin
                                ratioX = 2'b00;
                                ratioY = 18'b011000010000110110;
                        end
                        20'b00011000001011101110: begin
                                ratioX = 2'b00;
                                ratioY = 18'b011000001111101011;
                        end
                        20'b00011000010001111101: begin
                                ratioX = 2'b00;
                                ratioY = 18'b011000001110011100;
                        end
                        20'b00011000010111110100: begin
                                ratioX = 2'b00;
                                ratioY = 18'b011000001101001000;
                        end
                        20'b00011000011101101011: begin
                                ratioX = 2'b00;
                                ratioY = 18'b011000001011110001;
                        end
                        20'b00011000100011111010: begin
                                ratioX = 2'b00;
                                ratioY = 18'b011000001010010101;
                        end
                        20'b00011000101001110001: begin
                                ratioX = 2'b00;
                                ratioY = 18'b011000001000110101;
                        end
                        20'b00011000110000000000: begin
                                ratioX = 2'b00;
                                ratioY = 18'b011000000111010001;
                        end
                        20'b00011000110101110111: begin
                                ratioX = 2'b00;
                                ratioY = 18'b011000000101101000;
                        end
                        20'b00011000111011101110: begin
                                ratioX = 2'b00;
                                ratioY = 18'b011000000011111100;
                        end
                        20'b00011001000001111101: begin
                                ratioX = 2'b00;
                                ratioY = 18'b011000000010001011;
                        end
                        20'b00011001000111110100: begin
                                ratioX = 2'b00;
                                ratioY = 18'b011000000000010101;
                        end
                        20'b00011001001101101011: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010111111110011100;
                        end
                        20'b00011001010011111010: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010111111100011111;
                        end
                        20'b00011001011001110001: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010111111010011101;
                        end
                        20'b00011001100000000000: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010111111000010111;
                        end
                        20'b00011001100101110111: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010111110110001101;
                        end
                        20'b00011001101011101110: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010111110011111110;
                        end
                        20'b00011001110001111101: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010111110001101100;
                        end
                        20'b00011001110111110100: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010111101111010101;
                        end
                        20'b00011001111101101011: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010111101100111010;
                        end
                        20'b00011010000011111010: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010111101010011011;
                        end
                        20'b00011010001001110001: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010111100111111000;
                        end
                        20'b00011010010000000000: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010111100101010001;
                        end
                        20'b00011010010101110111: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010111100010100101;
                        end
                        20'b00011010011011101110: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010111011111110110;
                        end
                        20'b00011010100001111101: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010111011101000010;
                        end
                        20'b00011010100111110100: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010111011010001010;
                        end
                        20'b00011010101101101011: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010111010111001110;
                        end
                        20'b00011010110011111010: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010111010100001110;
                        end
                        20'b00011010111001110001: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010111010001001010;
                        end
                        20'b00011011000000000000: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010111001110000010;
                        end
                        20'b00011011000101110111: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010111001010110101;
                        end
                        20'b00011011001011101110: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010111000111100101;
                        end
                        20'b00011011010001111101: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010111000100010001;
                        end
                        20'b00011011010111110100: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010111000000111000;
                        end
                        20'b00011011011101101011: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010110111101011100;
                        end
                        20'b00011011100011111010: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010110111001111011;
                        end
                        20'b00011011101001110001: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010110110110010111;
                        end
                        20'b00011011110000000000: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010110110010101110;
                        end
                        20'b00011011110101110111: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010110101111000001;
                        end
                        20'b00011011111011101110: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010110101011010001;
                        end
                        20'b00011100000001111101: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010110100111011100;
                        end
                        20'b00011100000111110100: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010110100011100100;
                        end
                        20'b00011100001101101011: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010110011111101000;
                        end
                        20'b00011100010011111010: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010110011011100111;
                        end
                        20'b00011100011001110001: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010110010111100011;
                        end
                        20'b00011100100000000000: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010110010011011011;
                        end
                        20'b00011100100101110111: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010110001111001110;
                        end
                        20'b00011100101011101110: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010110001010111110;
                        end
                        20'b00011100110001111101: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010110000110101010;
                        end
                        20'b00011100110111110100: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010110000010010011;
                        end
                        20'b00011100111101101011: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010101111101110111;
                        end
                        20'b00011101000011111010: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010101111001010111;
                        end
                        20'b00011101001001110001: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010101110100110100;
                        end
                        20'b00011101010000000000: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010101110000001101;
                        end
                        20'b00011101010101110111: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010101101011100010;
                        end
                        20'b00011101011011101110: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010101100110110011;
                        end
                        20'b00011101100001111101: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010101100010000000;
                        end
                        20'b00011101100111110100: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010101011101001010;
                        end
                        20'b00011101101101101011: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010101011000010000;
                        end
                        20'b00011101110011111010: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010101010011010010;
                        end
                        20'b00011101111001110001: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010101001110010000;
                        end
                        20'b00011110000000000000: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010101001001001011;
                        end
                        20'b00011110000101110111: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010101000100000001;
                        end
                        20'b00011110001011101110: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010100111110110101;
                        end
                        20'b00011110010001111101: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010100111001100100;
                        end
                        20'b00011110010111110100: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010100110100010000;
                        end
                        20'b00011110011101101011: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010100101110111000;
                        end
                        20'b00011110100011111010: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010100101001011101;
                        end
                        20'b00011110101001110001: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010100100011111110;
                        end
                        20'b00011110110000000000: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010100011110011011;
                        end
                        20'b00011110110101110111: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010100011000110101;
                        end
                        20'b00011110111011101110: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010100010011001011;
                        end
                        20'b00011111000001111101: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010100001101011110;
                        end
                        20'b00011111000111110100: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010100000111101101;
                        end
                        20'b00011111001101101011: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010100000001111000;
                        end
                        20'b00011111010011111010: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010011111100000000;
                        end
                        20'b00011111011001110001: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010011110110000101;
                        end
                        20'b00011111100000000000: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010011110000000110;
                        end
                        20'b00011111100101110111: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010011101010000011;
                        end
                        20'b00011111101011101110: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010011100011111101;
                        end
                        20'b00011111110001111101: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010011011101110100;
                        end
                        20'b00011111110111110100: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010011010111100111;
                        end
                        20'b00011111111101101011: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010011010001010111;
                        end
                        20'b00100000000011111010: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010011001011000100;
                        end
                        20'b00100000001001110001: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010011000100101101;
                        end
                        20'b00100000010000000000: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010010111110010011;
                        end
                        20'b00100000010101110111: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010010110111110101;
                        end
                        20'b00100000011011101110: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010010110001010100;
                        end
                        20'b00100000100001111101: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010010101010110000;
                        end
                        20'b00100000100111110100: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010010100100001001;
                        end
                        20'b00100000101101101011: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010010011101011110;
                        end
                        20'b00100000110011111010: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010010010110110000;
                        end
                        20'b00100000111001110001: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010010001111111111;
                        end
                        20'b00100001000000000000: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010010001001001010;
                        end
                        20'b00100001000101110111: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010010000010010011;
                        end
                        20'b00100001001011101110: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010001111011011000;
                        end
                        20'b00100001010001111101: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010001110100011010;
                        end
                        20'b00100001010111110100: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010001101101011001;
                        end
                        20'b00100001011101101011: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010001100110010101;
                        end
                        20'b00100001100011111010: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010001011111001110;
                        end
                        20'b00100001101001110001: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010001011000000100;
                        end
                        20'b00100001110000000000: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010001010000110111;
                        end
                        20'b00100001110101110111: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010001001001100110;
                        end
                        20'b00100001111011101110: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010001000010010011;
                        end
                        20'b00100010000001111101: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010000111010111101;
                        end
                        20'b00100010000111110100: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010000110011100011;
                        end
                        20'b00100010001101101011: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010000101100000111;
                        end
                        20'b00100010010011111010: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010000100100101000;
                        end
                        20'b00100010011001110001: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010000011101000110;
                        end
                        20'b00100010100000000000: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010000010101100001;
                        end
                        20'b00100010100101110111: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010000001101111001;
                        end
                        20'b00100010101011101110: begin
                                ratioX = 2'b00;
                                ratioY = 18'b010000000110001111;
                        end
                        20'b00100010110001111101: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001111111110100001;
                        end
                        20'b00100010110111110100: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001111110110110001;
                        end
                        20'b00100010111101101011: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001111101110111110;
                        end
                        20'b00100011000011111010: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001111100111001000;
                        end
                        20'b00100011001001110001: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001111011111001111;
                        end
                        20'b00100011010000000000: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001111010111010100;
                        end
                        20'b00100011010101110111: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001111001111010110;
                        end
                        20'b00100011011011101110: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001111000111010101;
                        end
                        20'b00100011100001111101: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001110111111010010;
                        end
                        20'b00100011100111110100: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001110110111001100;
                        end
                        20'b00100011101101101011: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001110101111000100;
                        end
                        20'b00100011110011111010: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001110100110111000;
                        end
                        20'b00100011111001110001: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001110011110101011;
                        end
                        20'b00100100000000000000: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001110010110011011;
                        end
                        20'b00100100000101110111: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001110001110001000;
                        end
                        20'b00100100001011101110: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001110000101110011;
                        end
                        20'b00100100010001111101: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001101111101011011;
                        end
                        20'b00100100010111110100: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001101110101000001;
                        end
                        20'b00100100011101101011: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001101101100100100;
                        end
                        20'b00100100100011111010: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001101100100000101;
                        end
                        20'b00100100101001110001: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001101011011100100;
                        end
                        20'b00100100110000000000: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001101010011000000;
                        end
                        20'b00100100110101110111: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001101001010011010;
                        end
                        20'b00100100111011101110: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001101000001110001;
                        end
                        20'b00100101000001111101: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001100111001000111;
                        end
                        20'b00100101000111110100: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001100110000011010;
                        end
                        20'b00100101001101101011: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001100100111101011;
                        end
                        20'b00100101010011111010: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001100011110111001;
                        end
                        20'b00100101011001110001: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001100010110000110;
                        end
                        20'b00100101100000000000: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001100001101010000;
                        end
                        20'b00100101100101110111: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001100000100011000;
                        end
                        20'b00100101101011101110: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001011111011011110;
                        end
                        20'b00100101110001111101: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001011110010100010;
                        end
                        20'b00100101110111110100: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001011101001100100;
                        end
                        20'b00100101111101101011: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001011100000100100;
                        end
                        20'b00100110000011111010: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001011010111100001;
                        end
                        20'b00100110001001110001: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001011001110011101;
                        end
                        20'b00100110010000000000: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001011000101010111;
                        end
                        20'b00100110010101110111: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001010111100001111;
                        end
                        20'b00100110011011101110: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001010110011000101;
                        end
                        20'b00100110100001111101: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001010101001111001;
                        end
                        20'b00100110100111110100: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001010100000101011;
                        end
                        20'b00100110101101101011: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001010010111011011;
                        end
                        20'b00100110110011111010: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001010001110001010;
                        end
                        20'b00100110111001110001: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001010000100110111;
                        end
                        20'b00100111000000000000: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001001111011100010;
                        end
                        20'b00100111000101110111: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001001110010001011;
                        end
                        20'b00100111001011101110: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001001101000110010;
                        end
                        20'b00100111010001111101: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001001011111011000;
                        end
                        20'b00100111010111110100: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001001010101111100;
                        end
                        20'b00100111011101101011: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001001001100011111;
                        end
                        20'b00100111100011111010: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001001000011000000;
                        end
                        20'b00100111101001110001: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001000111001011111;
                        end
                        20'b00100111110000000000: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001000101111111101;
                        end
                        20'b00100111110101110111: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001000100110011001;
                        end
                        20'b00100111111011101110: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001000011100110100;
                        end
                        20'b00101000000001111101: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001000010011001101;
                        end
                        20'b00101000000111110100: begin
                                ratioX = 2'b00;
                                ratioY = 18'b001000001001100101;
                        end
                        20'b00101000001101101011: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000111111111111011;
                        end
                        20'b00101000010011111010: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000111110110010000;
                        end
                        20'b00101000011001110001: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000111101100100011;
                        end
                        20'b00101000100000000000: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000111100010110110;
                        end
                        20'b00101000100101110111: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000111011001000111;
                        end
                        20'b00101000101011101110: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000111001111010110;
                        end
                        20'b00101000110001111101: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000111000101100100;
                        end
                        20'b00101000110111110100: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000110111011110010;
                        end
                        20'b00101000111101101011: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000110110001111101;
                        end
                        20'b00101001000011111010: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000110101000001000;
                        end
                        20'b00101001001001110001: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000110011110010010;
                        end
                        20'b00101001010000000000: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000110010100011010;
                        end
                        20'b00101001010101110111: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000110001010100001;
                        end
                        20'b00101001011011101110: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000110000000100111;
                        end
                        20'b00101001100001111101: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000101110110101100;
                        end
                        20'b00101001100111110100: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000101101100110001;
                        end
                        20'b00101001101101101011: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000101100010110100;
                        end
                        20'b00101001110011111010: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000101011000110110;
                        end
                        20'b00101001111001110001: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000101001110110111;
                        end
                        20'b00101010000000000000: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000101000100110111;
                        end
                        20'b00101010000101110111: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000100111010110111;
                        end
                        20'b00101010001011101110: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000100110000110101;
                        end
                        20'b00101010010001111101: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000100100110110011;
                        end
                        20'b00101010010111110100: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000100011100110000;
                        end
                        20'b00101010011101101011: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000100010010101100;
                        end
                        20'b00101010100011111010: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000100001000100111;
                        end
                        20'b00101010101001110001: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000011111110100010;
                        end
                        20'b00101010110000000000: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000011110100011011;
                        end
                        20'b00101010110101110111: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000011101010010101;
                        end
                        20'b00101010111011101110: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000011100000001101;
                        end
                        20'b00101011000001111101: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000011010110000101;
                        end
                        20'b00101011000111110100: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000011001011111101;
                        end
                        20'b00101011001101101011: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000011000001110011;
                        end
                        20'b00101011010011111010: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000010110111101010;
                        end
                        20'b00101011011001110001: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000010101101100000;
                        end
                        20'b00101011100000000000: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000010100011010101;
                        end
                        20'b00101011100101110111: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000010011001001010;
                        end
                        20'b00101011101011101110: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000010001110111110;
                        end
                        20'b00101011110001111101: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000010000100110010;
                        end
                        20'b00101011110111110100: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000001111010100110;
                        end
                        20'b00101011111101101011: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000001110000011001;
                        end
                        20'b00101100000011111010: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000001100110001100;
                        end
                        20'b00101100001001110001: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000001011011111111;
                        end
                        20'b00101100010000000000: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000001010001110010;
                        end
                        20'b00101100010101110111: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000001000111100100;
                        end
                        20'b00101100011011101110: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000000111101010110;
                        end
                        20'b00101100100001111101: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000000110011001000;
                        end
                        20'b00101100100111110100: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000000101000111010;
                        end
                        20'b00101100101101101011: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000000011110101011;
                        end
                        20'b00101100110011111010: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000000010100011101;
                        end
                        20'b00101100111001110001: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000000001010001110;
                        end
                        20'b00101101000000000000: begin
                                ratioX = 2'b00;
                                ratioY = 18'b000000000000000000;
                        end
                        20'b00101101000101110111: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000000001010001110;
                        end
                        20'b00101101001011101110: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000000010100011101;
                        end
                        20'b00101101010001111101: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000000011110101011;
                        end
                        20'b00101101010111110100: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000000101000111010;
                        end
                        20'b00101101011101101011: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000000110011001000;
                        end
                        20'b00101101100011111010: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000000111101010110;
                        end
                        20'b00101101101001110001: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000001000111100100;
                        end
                        20'b00101101110000000000: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000001010001110010;
                        end
                        20'b00101101110101110111: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000001011011111111;
                        end
                        20'b00101101111011101110: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000001100110001100;
                        end
                        20'b00101110000001111101: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000001110000011001;
                        end
                        20'b00101110000111110100: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000001111010100110;
                        end
                        20'b00101110001101101011: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000010000100110010;
                        end
                        20'b00101110010011111010: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000010001110111110;
                        end
                        20'b00101110011001110001: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000010011001001010;
                        end
                        20'b00101110100000000000: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000010100011010101;
                        end
                        20'b00101110100101110111: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000010101101100000;
                        end
                        20'b00101110101011101110: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000010110111101010;
                        end
                        20'b00101110110001111101: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000011000001110011;
                        end
                        20'b00101110110111110100: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000011001011111101;
                        end
                        20'b00101110111101101011: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000011010110000101;
                        end
                        20'b00101111000011111010: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000011100000001101;
                        end
                        20'b00101111001001110001: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000011101010010101;
                        end
                        20'b00101111010000000000: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000011110100011011;
                        end
                        20'b00101111010101110111: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000011111110100010;
                        end
                        20'b00101111011011101110: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000100001000100111;
                        end
                        20'b00101111100001111101: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000100010010101100;
                        end
                        20'b00101111100111110100: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000100011100110000;
                        end
                        20'b00101111101101101011: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000100100110110011;
                        end
                        20'b00101111110011111010: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000100110000110101;
                        end
                        20'b00101111111001110001: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000100111010110111;
                        end
                        20'b00110000000000000000: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000101000100110111;
                        end
                        20'b00110000000101110111: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000101001110110111;
                        end
                        20'b00110000001011101110: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000101011000110110;
                        end
                        20'b00110000010001111101: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000101100010110100;
                        end
                        20'b00110000010111110100: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000101101100110001;
                        end
                        20'b00110000011101101011: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000101110110101100;
                        end
                        20'b00110000100011111010: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000110000000100111;
                        end
                        20'b00110000101001110001: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000110001010100001;
                        end
                        20'b00110000110000000000: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000110010100011010;
                        end
                        20'b00110000110101110111: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000110011110010010;
                        end
                        20'b00110000111011101110: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000110101000001000;
                        end
                        20'b00110001000001111101: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000110110001111101;
                        end
                        20'b00110001000111110100: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000110111011110010;
                        end
                        20'b00110001001101101011: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000111000101100100;
                        end
                        20'b00110001010011111010: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000111001111010110;
                        end
                        20'b00110001011001110001: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000111011001000111;
                        end
                        20'b00110001100000000000: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000111100010110110;
                        end
                        20'b00110001100101110111: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000111101100100011;
                        end
                        20'b00110001101011101110: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000111110110010000;
                        end
                        20'b00110001110001111101: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000111111111111011;
                        end
                        20'b00110001110111110100: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001000001001100101;
                        end
                        20'b00110001111101101011: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001000010011001101;
                        end
                        20'b00110010000011111010: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001000011100110100;
                        end
                        20'b00110010001001110001: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001000100110011001;
                        end
                        20'b00110010010000000000: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001000101111111101;
                        end
                        20'b00110010010101110111: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001000111001011111;
                        end
                        20'b00110010011011101110: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001001000011000000;
                        end
                        20'b00110010100001111101: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001001001100011111;
                        end
                        20'b00110010100111110100: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001001010101111100;
                        end
                        20'b00110010101101101011: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001001011111011000;
                        end
                        20'b00110010110011111010: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001001101000110010;
                        end
                        20'b00110010111001110001: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001001110010001011;
                        end
                        20'b00110011000000000000: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001001111011100010;
                        end
                        20'b00110011000101110111: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001010000100110111;
                        end
                        20'b00110011001011101110: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001010001110001010;
                        end
                        20'b00110011010001111101: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001010010111011011;
                        end
                        20'b00110011010111110100: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001010100000101011;
                        end
                        20'b00110011011101101011: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001010101001111001;
                        end
                        20'b00110011100011111010: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001010110011000101;
                        end
                        20'b00110011101001110001: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001010111100001111;
                        end
                        20'b00110011110000000000: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001011000101010111;
                        end
                        20'b00110011110101110111: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001011001110011101;
                        end
                        20'b00110011111011101110: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001011010111100001;
                        end
                        20'b00110100000001111101: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001011100000100100;
                        end
                        20'b00110100000111110100: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001011101001100100;
                        end
                        20'b00110100001101101011: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001011110010100010;
                        end
                        20'b00110100010011111010: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001011111011011110;
                        end
                        20'b00110100011001110001: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001100000100011000;
                        end
                        20'b00110100100000000000: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001100001101010000;
                        end
                        20'b00110100100101110111: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001100010110000110;
                        end
                        20'b00110100101011101110: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001100011110111001;
                        end
                        20'b00110100110001111101: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001100100111101011;
                        end
                        20'b00110100110111110100: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001100110000011010;
                        end
                        20'b00110100111101101011: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001100111001000111;
                        end
                        20'b00110101000011111010: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001101000001110001;
                        end
                        20'b00110101001001110001: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001101001010011010;
                        end
                        20'b00110101010000000000: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001101010011000000;
                        end
                        20'b00110101010101110111: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001101011011100100;
                        end
                        20'b00110101011011101110: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001101100100000101;
                        end
                        20'b00110101100001111101: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001101101100100100;
                        end
                        20'b00110101100111110100: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001101110101000001;
                        end
                        20'b00110101101101101011: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001101111101011011;
                        end
                        20'b00110101110011111010: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001110000101110011;
                        end
                        20'b00110101111001110001: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001110001110001000;
                        end
                        20'b00110110000000000000: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001110010110011011;
                        end
                        20'b00110110000101110111: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001110011110101011;
                        end
                        20'b00110110001011101110: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001110100110111000;
                        end
                        20'b00110110010001111101: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001110101111000100;
                        end
                        20'b00110110010111110100: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001110110111001100;
                        end
                        20'b00110110011101101011: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001110111111010010;
                        end
                        20'b00110110100011111010: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001111000111010101;
                        end
                        20'b00110110101001110001: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001111001111010110;
                        end
                        20'b00110110110000000000: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001111010111010100;
                        end
                        20'b00110110110101110111: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001111011111001111;
                        end
                        20'b00110110111011101110: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001111100111001000;
                        end
                        20'b00110111000001111101: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001111101110111110;
                        end
                        20'b00110111000111110100: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001111110110110001;
                        end
                        20'b00110111001101101011: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001111111110100001;
                        end
                        20'b00110111010011111010: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010000000110001111;
                        end
                        20'b00110111011001110001: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010000001101111001;
                        end
                        20'b00110111100000000000: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010000010101100001;
                        end
                        20'b00110111100101110111: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010000011101000110;
                        end
                        20'b00110111101011101110: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010000100100101000;
                        end
                        20'b00110111110001111101: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010000101100000111;
                        end
                        20'b00110111110111110100: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010000110011100011;
                        end
                        20'b00110111111101101011: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010000111010111101;
                        end
                        20'b00111000000011111010: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010001000010010011;
                        end
                        20'b00111000001001110001: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010001001001100110;
                        end
                        20'b00111000010000000000: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010001010000110111;
                        end
                        20'b00111000010101110111: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010001011000000100;
                        end
                        20'b00111000011011101110: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010001011111001110;
                        end
                        20'b00111000100001111101: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010001100110010101;
                        end
                        20'b00111000100111110100: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010001101101011001;
                        end
                        20'b00111000101101101011: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010001110100011010;
                        end
                        20'b00111000110011111010: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010001111011011000;
                        end
                        20'b00111000111001110001: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010010000010010011;
                        end
                        20'b00111001000000000000: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010010001001001010;
                        end
                        20'b00111001000101110111: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010010001111111111;
                        end
                        20'b00111001001011101110: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010010010110110000;
                        end
                        20'b00111001010001111101: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010010011101011110;
                        end
                        20'b00111001010111110100: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010010100100001001;
                        end
                        20'b00111001011101101011: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010010101010110000;
                        end
                        20'b00111001100011111010: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010010110001010100;
                        end
                        20'b00111001101001110001: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010010110111110101;
                        end
                        20'b00111001110000000000: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010010111110010011;
                        end
                        20'b00111001110101110111: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010011000100101101;
                        end
                        20'b00111001111011101110: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010011001011000100;
                        end
                        20'b00111010000001111101: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010011010001010111;
                        end
                        20'b00111010000111110100: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010011010111100111;
                        end
                        20'b00111010001101101011: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010011011101110100;
                        end
                        20'b00111010010011111010: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010011100011111101;
                        end
                        20'b00111010011001110001: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010011101010000011;
                        end
                        20'b00111010100000000000: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010011110000000110;
                        end
                        20'b00111010100101110111: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010011110110000101;
                        end
                        20'b00111010101011101110: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010011111100000000;
                        end
                        20'b00111010110001111101: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010100000001111000;
                        end
                        20'b00111010110111110100: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010100000111101101;
                        end
                        20'b00111010111101101011: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010100001101011110;
                        end
                        20'b00111011000011111010: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010100010011001011;
                        end
                        20'b00111011001001110001: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010100011000110101;
                        end
                        20'b00111011010000000000: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010100011110011011;
                        end
                        20'b00111011010101110111: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010100100011111110;
                        end
                        20'b00111011011011101110: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010100101001011101;
                        end
                        20'b00111011100001111101: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010100101110111000;
                        end
                        20'b00111011100111110100: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010100110100010000;
                        end
                        20'b00111011101101101011: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010100111001100100;
                        end
                        20'b00111011110011111010: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010100111110110101;
                        end
                        20'b00111011111001110001: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010101000100000001;
                        end
                        20'b00111100000000000000: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010101001001001011;
                        end
                        20'b00111100000101110111: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010101001110010000;
                        end
                        20'b00111100001011101110: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010101010011010010;
                        end
                        20'b00111100010001111101: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010101011000010000;
                        end
                        20'b00111100010111110100: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010101011101001010;
                        end
                        20'b00111100011101101011: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010101100010000000;
                        end
                        20'b00111100100011111010: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010101100110110011;
                        end
                        20'b00111100101001110001: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010101101011100010;
                        end
                        20'b00111100110000000000: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010101110000001101;
                        end
                        20'b00111100110101110111: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010101110100110100;
                        end
                        20'b00111100111011101110: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010101111001010111;
                        end
                        20'b00111101000001111101: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010101111101110111;
                        end
                        20'b00111101000111110100: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010110000010010011;
                        end
                        20'b00111101001101101011: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010110000110101010;
                        end
                        20'b00111101010011111010: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010110001010111110;
                        end
                        20'b00111101011001110001: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010110001111001110;
                        end
                        20'b00111101100000000000: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010110010011011011;
                        end
                        20'b00111101100101110111: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010110010111100011;
                        end
                        20'b00111101101011101110: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010110011011100111;
                        end
                        20'b00111101110001111101: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010110011111101000;
                        end
                        20'b00111101110111110100: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010110100011100100;
                        end
                        20'b00111101111101101011: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010110100111011100;
                        end
                        20'b00111110000011111010: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010110101011010001;
                        end
                        20'b00111110001001110001: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010110101111000001;
                        end
                        20'b00111110010000000000: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010110110010101110;
                        end
                        20'b00111110010101110111: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010110110110010111;
                        end
                        20'b00111110011011101110: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010110111001111011;
                        end
                        20'b00111110100001111101: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010110111101011100;
                        end
                        20'b00111110100111110100: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010111000000111000;
                        end
                        20'b00111110101101101011: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010111000100010001;
                        end
                        20'b00111110110011111010: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010111000111100101;
                        end
                        20'b00111110111001110001: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010111001010110101;
                        end
                        20'b00111111000000000000: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010111001110000010;
                        end
                        20'b00111111000101110111: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010111010001001010;
                        end
                        20'b00111111001011101110: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010111010100001110;
                        end
                        20'b00111111010001111101: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010111010111001110;
                        end
                        20'b00111111010111110100: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010111011010001010;
                        end
                        20'b00111111011101101011: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010111011101000010;
                        end
                        20'b00111111100011111010: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010111011111110110;
                        end
                        20'b00111111101001110001: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010111100010100101;
                        end
                        20'b00111111110000000000: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010111100101010001;
                        end
                        20'b00111111110101110111: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010111100111111000;
                        end
                        20'b00111111111011101110: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010111101010011011;
                        end
                        20'b01000000000001111101: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010111101100111010;
                        end
                        20'b01000000000111110100: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010111101111010101;
                        end
                        20'b01000000001101101011: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010111110001101100;
                        end
                        20'b01000000010011111010: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010111110011111110;
                        end
                        20'b01000000011001110001: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010111110110001101;
                        end
                        20'b01000000100000000000: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010111111000010111;
                        end
                        20'b01000000100101110111: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010111111010011101;
                        end
                        20'b01000000101011101110: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010111111100011111;
                        end
                        20'b01000000110001111101: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010111111110011100;
                        end
                        20'b01000000110111110100: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b011000000000010101;
                        end
                        20'b01000000111101101011: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b011000000010001011;
                        end
                        20'b01000001000011111010: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b011000000011111100;
                        end
                        20'b01000001001001110001: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b011000000101101000;
                        end
                        20'b01000001010000000000: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b011000000111010001;
                        end
                        20'b01000001010101110111: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b011000001000110101;
                        end
                        20'b01000001011011101110: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b011000001010010101;
                        end
                        20'b01000001100001111101: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b011000001011110001;
                        end
                        20'b01000001100111110100: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b011000001101001000;
                        end
                        20'b01000001101101101011: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b011000001110011100;
                        end
                        20'b01000001110011111010: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b011000001111101011;
                        end
                        20'b01000001111001110001: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b011000010000110110;
                        end
                        20'b01000010000000000000: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b011000010001111100;
                        end
                        20'b01000010000101110111: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b011000010010111110;
                        end
                        20'b01000010001011101110: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b011000010011111100;
                        end
                        20'b01000010010001111101: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b011000010100110110;
                        end
                        20'b01000010010111110100: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b011000010101101100;
                        end
                        20'b01000010011101101011: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b011000010110011101;
                        end
                        20'b01000010100011111010: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b011000010111001010;
                        end
                        20'b01000010101001110001: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b011000010111110011;
                        end
                        20'b01000010110000000000: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b011000011000010111;
                        end
                        20'b01000010110101110111: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b011000011000110111;
                        end
                        20'b01000010111011101110: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b011000011001010011;
                        end
                        20'b01000011000001111101: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b011000011001101010;
                        end
                        20'b01000011000111110100: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b011000011001111110;
                        end
                        20'b01000011001101101011: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b011000011010001101;
                        end
                        20'b01000011010011111010: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b011000011010010111;
                        end
                        20'b01000011011001110001: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b011000011010011110;
                        end
                        20'b01000011100000000000: begin
                                ratioX = -(2'b01);
                                ratioY = 18'b000000000000000000;
                        end
                        20'b01000011100101110111: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b011000011010011110;
                        end
                        20'b01000011101011101110: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b011000011010010111;
                        end
                        20'b01000011110001111101: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b011000011010001101;
                        end
                        20'b01000011110111110100: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b011000011001111110;
                        end
                        20'b01000011111101101011: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b011000011001101010;
                        end
                        20'b01000100000011111010: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b011000011001010011;
                        end
                        20'b01000100001001110001: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b011000011000110111;
                        end
                        20'b01000100010000000000: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b011000011000010111;
                        end
                        20'b01000100010101110111: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b011000010111110011;
                        end
                        20'b01000100011011101110: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b011000010111001010;
                        end
                        20'b01000100100001111101: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b011000010110011101;
                        end
                        20'b01000100100111110100: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b011000010101101100;
                        end
                        20'b01000100101101101011: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b011000010100110110;
                        end
                        20'b01000100110011111010: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b011000010011111100;
                        end
                        20'b01000100111001110001: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b011000010010111110;
                        end
                        20'b01000101000000000000: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b011000010001111100;
                        end
                        20'b01000101000101110111: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b011000010000110110;
                        end
                        20'b01000101001011101110: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b011000001111101011;
                        end
                        20'b01000101010001111101: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b011000001110011100;
                        end
                        20'b01000101010111110100: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b011000001101001000;
                        end
                        20'b01000101011101101011: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b011000001011110001;
                        end
                        20'b01000101100011111010: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b011000001010010101;
                        end
                        20'b01000101101001110001: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b011000001000110101;
                        end
                        20'b01000101110000000000: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b011000000111010001;
                        end
                        20'b01000101110101110111: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b011000000101101000;
                        end
                        20'b01000101111011101110: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b011000000011111100;
                        end
                        20'b01000110000001111101: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b011000000010001011;
                        end
                        20'b01000110000111110100: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b011000000000010101;
                        end
                        20'b01000110001101101011: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010111111110011100;
                        end
                        20'b01000110010011111010: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010111111100011111;
                        end
                        20'b01000110011001110001: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010111111010011101;
                        end
                        20'b01000110100000000000: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010111111000010111;
                        end
                        20'b01000110100101110111: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010111110110001101;
                        end
                        20'b01000110101011101110: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010111110011111110;
                        end
                        20'b01000110110001111101: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010111110001101100;
                        end
                        20'b01000110110111110100: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010111101111010101;
                        end
                        20'b01000110111101101011: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010111101100111010;
                        end
                        20'b01000111000011111010: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010111101010011011;
                        end
                        20'b01000111001001110001: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010111100111111000;
                        end
                        20'b01000111010000000000: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010111100101010001;
                        end
                        20'b01000111010101110111: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010111100010100101;
                        end
                        20'b01000111011011101110: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010111011111110110;
                        end
                        20'b01000111100001111101: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010111011101000010;
                        end
                        20'b01000111100111110100: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010111011010001010;
                        end
                        20'b01000111101101101011: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010111010111001110;
                        end
                        20'b01000111110011111010: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010111010100001110;
                        end
                        20'b01000111111001110001: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010111010001001010;
                        end
                        20'b01001000000000000000: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010111001110000010;
                        end
                        20'b01001000000101110111: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010111001010110101;
                        end
                        20'b01001000001011101110: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010111000111100101;
                        end
                        20'b01001000010001111101: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010111000100010001;
                        end
                        20'b01001000010111110100: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010111000000111000;
                        end
                        20'b01001000011101101011: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010110111101011100;
                        end
                        20'b01001000100011111010: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010110111001111011;
                        end
                        20'b01001000101001110001: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010110110110010111;
                        end
                        20'b01001000110000000000: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010110110010101110;
                        end
                        20'b01001000110101110111: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010110101111000001;
                        end
                        20'b01001000111011101110: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010110101011010001;
                        end
                        20'b01001001000001111101: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010110100111011100;
                        end
                        20'b01001001000111110100: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010110100011100100;
                        end
                        20'b01001001001101101011: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010110011111101000;
                        end
                        20'b01001001010011111010: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010110011011100111;
                        end
                        20'b01001001011001110001: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010110010111100011;
                        end
                        20'b01001001100000000000: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010110010011011011;
                        end
                        20'b01001001100101110111: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010110001111001110;
                        end
                        20'b01001001101011101110: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010110001010111110;
                        end
                        20'b01001001110001111101: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010110000110101010;
                        end
                        20'b01001001110111110100: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010110000010010011;
                        end
                        20'b01001001111101101011: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010101111101110111;
                        end
                        20'b01001010000011111010: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010101111001010111;
                        end
                        20'b01001010001001110001: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010101110100110100;
                        end
                        20'b01001010010000000000: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010101110000001101;
                        end
                        20'b01001010010101110111: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010101101011100010;
                        end
                        20'b01001010011011101110: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010101100110110011;
                        end
                        20'b01001010100001111101: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010101100010000000;
                        end
                        20'b01001010100111110100: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010101011101001010;
                        end
                        20'b01001010101101101011: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010101011000010000;
                        end
                        20'b01001010110011111010: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010101010011010010;
                        end
                        20'b01001010111001110001: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010101001110010000;
                        end
                        20'b01001011000000000000: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010101001001001011;
                        end
                        20'b01001011000101110111: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010101000100000001;
                        end
                        20'b01001011001011101110: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010100111110110101;
                        end
                        20'b01001011010001111101: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010100111001100100;
                        end
                        20'b01001011010111110100: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010100110100010000;
                        end
                        20'b01001011011101101011: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010100101110111000;
                        end
                        20'b01001011100011111010: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010100101001011101;
                        end
                        20'b01001011101001110001: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010100100011111110;
                        end
                        20'b01001011110000000000: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010100011110011011;
                        end
                        20'b01001011110101110111: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010100011000110101;
                        end
                        20'b01001011111011101110: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010100010011001011;
                        end
                        20'b01001100000001111101: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010100001101011110;
                        end
                        20'b01001100000111110100: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010100000111101101;
                        end
                        20'b01001100001101101011: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010100000001111000;
                        end
                        20'b01001100010011111010: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010011111100000000;
                        end
                        20'b01001100011001110001: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010011110110000101;
                        end
                        20'b01001100100000000000: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010011110000000110;
                        end
                        20'b01001100100101110111: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010011101010000011;
                        end
                        20'b01001100101011101110: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010011100011111101;
                        end
                        20'b01001100110001111101: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010011011101110100;
                        end
                        20'b01001100110111110100: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010011010111100111;
                        end
                        20'b01001100111101101011: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010011010001010111;
                        end
                        20'b01001101000011111010: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010011001011000100;
                        end
                        20'b01001101001001110001: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010011000100101101;
                        end
                        20'b01001101010000000000: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010010111110010011;
                        end
                        20'b01001101010101110111: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010010110111110101;
                        end
                        20'b01001101011011101110: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010010110001010100;
                        end
                        20'b01001101100001111101: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010010101010110000;
                        end
                        20'b01001101100111110100: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010010100100001001;
                        end
                        20'b01001101101101101011: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010010011101011110;
                        end
                        20'b01001101110011111010: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010010010110110000;
                        end
                        20'b01001101111001110001: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010010001111111111;
                        end
                        20'b01001110000000000000: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010010001001001010;
                        end
                        20'b01001110000101110111: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010010000010010011;
                        end
                        20'b01001110001011101110: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010001111011011000;
                        end
                        20'b01001110010001111101: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010001110100011010;
                        end
                        20'b01001110010111110100: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010001101101011001;
                        end
                        20'b01001110011101101011: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010001100110010101;
                        end
                        20'b01001110100011111010: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010001011111001110;
                        end
                        20'b01001110101001110001: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010001011000000100;
                        end
                        20'b01001110110000000000: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010001010000110111;
                        end
                        20'b01001110110101110111: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010001001001100110;
                        end
                        20'b01001110111011101110: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010001000010010011;
                        end
                        20'b01001111000001111101: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010000111010111101;
                        end
                        20'b01001111000111110100: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010000110011100011;
                        end
                        20'b01001111001101101011: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010000101100000111;
                        end
                        20'b01001111010011111010: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010000100100101000;
                        end
                        20'b01001111011001110001: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010000011101000110;
                        end
                        20'b01001111100000000000: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010000010101100001;
                        end
                        20'b01001111100101110111: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010000001101111001;
                        end
                        20'b01001111101011101110: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b010000000110001111;
                        end
                        20'b01001111110001111101: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001111111110100001;
                        end
                        20'b01001111110111110100: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001111110110110001;
                        end
                        20'b01001111111101101011: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001111101110111110;
                        end
                        20'b01010000000011111010: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001111100111001000;
                        end
                        20'b01010000001001110001: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001111011111001111;
                        end
                        20'b01010000010000000000: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001111010111010100;
                        end
                        20'b01010000010101110111: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001111001111010110;
                        end
                        20'b01010000011011101110: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001111000111010101;
                        end
                        20'b01010000100001111101: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001110111111010010;
                        end
                        20'b01010000100111110100: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001110110111001100;
                        end
                        20'b01010000101101101011: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001110101111000100;
                        end
                        20'b01010000110011111010: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001110100110111000;
                        end
                        20'b01010000111001110001: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001110011110101011;
                        end
                        20'b01010001000000000000: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001110010110011011;
                        end
                        20'b01010001000101110111: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001110001110001000;
                        end
                        20'b01010001001011101110: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001110000101110011;
                        end
                        20'b01010001010001111101: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001101111101011011;
                        end
                        20'b01010001010111110100: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001101110101000001;
                        end
                        20'b01010001011101101011: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001101101100100100;
                        end
                        20'b01010001100011111010: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001101100100000101;
                        end
                        20'b01010001101001110001: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001101011011100100;
                        end
                        20'b01010001110000000000: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001101010011000000;
                        end
                        20'b01010001110101110111: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001101001010011010;
                        end
                        20'b01010001111011101110: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001101000001110001;
                        end
                        20'b01010010000001111101: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001100111001000111;
                        end
                        20'b01010010000111110100: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001100110000011010;
                        end
                        20'b01010010001101101011: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001100100111101011;
                        end
                        20'b01010010010011111010: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001100011110111001;
                        end
                        20'b01010010011001110001: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001100010110000110;
                        end
                        20'b01010010100000000000: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001100001101010000;
                        end
                        20'b01010010100101110111: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001100000100011000;
                        end
                        20'b01010010101011101110: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001011111011011110;
                        end
                        20'b01010010110001111101: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001011110010100010;
                        end
                        20'b01010010110111110100: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001011101001100100;
                        end
                        20'b01010010111101101011: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001011100000100100;
                        end
                        20'b01010011000011111010: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001011010111100001;
                        end
                        20'b01010011001001110001: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001011001110011101;
                        end
                        20'b01010011010000000000: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001011000101010111;
                        end
                        20'b01010011010101110111: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001010111100001111;
                        end
                        20'b01010011011011101110: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001010110011000101;
                        end
                        20'b01010011100001111101: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001010101001111001;
                        end
                        20'b01010011100111110100: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001010100000101011;
                        end
                        20'b01010011101101101011: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001010010111011011;
                        end
                        20'b01010011110011111010: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001010001110001010;
                        end
                        20'b01010011111001110001: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001010000100110111;
                        end
                        20'b01010100000000000000: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001001111011100010;
                        end
                        20'b01010100000101110111: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001001110010001011;
                        end
                        20'b01010100001011101110: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001001101000110010;
                        end
                        20'b01010100010001111101: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001001011111011000;
                        end
                        20'b01010100010111110100: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001001010101111100;
                        end
                        20'b01010100011101101011: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001001001100011111;
                        end
                        20'b01010100100011111010: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001001000011000000;
                        end
                        20'b01010100101001110001: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001000111001011111;
                        end
                        20'b01010100110000000000: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001000101111111101;
                        end
                        20'b01010100110101110111: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001000100110011001;
                        end
                        20'b01010100111011101110: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001000011100110100;
                        end
                        20'b01010101000001111101: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001000010011001101;
                        end
                        20'b01010101000111110100: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b001000001001100101;
                        end
                        20'b01010101001101101011: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000111111111111011;
                        end
                        20'b01010101010011111010: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000111110110010000;
                        end
                        20'b01010101011001110001: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000111101100100011;
                        end
                        20'b01010101100000000000: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000111100010110110;
                        end
                        20'b01010101100101110111: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000111011001000111;
                        end
                        20'b01010101101011101110: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000111001111010110;
                        end
                        20'b01010101110001111101: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000111000101100100;
                        end
                        20'b01010101110111110100: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000110111011110010;
                        end
                        20'b01010101111101101011: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000110110001111101;
                        end
                        20'b01010110000011111010: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000110101000001000;
                        end
                        20'b01010110001001110001: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000110011110010010;
                        end
                        20'b01010110010000000000: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000110010100011010;
                        end
                        20'b01010110010101110111: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000110001010100001;
                        end
                        20'b01010110011011101110: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000110000000100111;
                        end
                        20'b01010110100001111101: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000101110110101100;
                        end
                        20'b01010110100111110100: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000101101100110001;
                        end
                        20'b01010110101101101011: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000101100010110100;
                        end
                        20'b01010110110011111010: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000101011000110110;
                        end
                        20'b01010110111001110001: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000101001110110111;
                        end
                        20'b01010111000000000000: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000101000100110111;
                        end
                        20'b01010111000101110111: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000100111010110111;
                        end
                        20'b01010111001011101110: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000100110000110101;
                        end
                        20'b01010111010001111101: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000100100110110011;
                        end
                        20'b01010111010111110100: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000100011100110000;
                        end
                        20'b01010111011101101011: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000100010010101100;
                        end
                        20'b01010111100011111010: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000100001000100111;
                        end
                        20'b01010111101001110001: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000011111110100010;
                        end
                        20'b01010111110000000000: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000011110100011011;
                        end
                        20'b01010111110101110111: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000011101010010101;
                        end
                        20'b01010111111011101110: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000011100000001101;
                        end
                        20'b01011000000001111101: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000011010110000101;
                        end
                        20'b01011000000111110100: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000011001011111101;
                        end
                        20'b01011000001101101011: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000011000001110011;
                        end
                        20'b01011000010011111010: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000010110111101010;
                        end
                        20'b01011000011001110001: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000010101101100000;
                        end
                        20'b01011000100000000000: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000010100011010101;
                        end
                        20'b01011000100101110111: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000010011001001010;
                        end
                        20'b01011000101011101110: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000010001110111110;
                        end
                        20'b01011000110001111101: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000010000100110010;
                        end
                        20'b01011000110111110100: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000001111010100110;
                        end
                        20'b01011000111101101011: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000001110000011001;
                        end
                        20'b01011001000011111010: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000001100110001100;
                        end
                        20'b01011001001001110001: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000001011011111111;
                        end
                        20'b01011001010000000000: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000001010001110010;
                        end
                        20'b01011001010101110111: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000001000111100100;
                        end
                        20'b01011001011011101110: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000000111101010110;
                        end
                        20'b01011001100001111101: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000000110011001000;
                        end
                        20'b01011001100111110100: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000000101000111010;
                        end
                        20'b01011001101101101011: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000000011110101011;
                        end
                        20'b01011001110011111010: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000000010100011101;
                        end
                        20'b01011001111001110001: begin
                                ratioX = -(2'b00);
                                ratioY = 18'b000000001010001110;
                        end
                        default: begin
											ratioX = 2'b0;
											ratioY = 18'b0;
											end
                endcase
        end
endmodule
