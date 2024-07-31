library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity hex_to_ssd is
    Port (digit : in STD_LOGIC_VECTOR(3 downto 0);
          catod : out STD_lOGIC_VECTOR(6 downto 0));
end hex_to_ssd;

architecture Behavioral of hex_to_ssd is

begin

    catod <= "1000000" when digit = "0000" else
           "1111001" when digit = "0001" else
           "0100100" when digit = "0010" else
           "0110000" when digit = "0011" else
           "0011001" when digit = "0100" else
           "0010010" when digit = "0101" else
           "0000010" when digit = "0110" else
           "1111000" when digit = "0111" else
           "0000000" when digit = "1000" else
           "0010000" when digit = "1001" else
           "0001000" when digit = "1010" else
           "0000011" when digit = "1011" else
           "1000110" when digit = "1100" else
           "0100001" when digit = "1101" else
           "0000110" when digit = "1110" else
           "0001110";

end Behavioral;
