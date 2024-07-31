library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity anod_mux is
  Port ( sel : in std_logic_vector(2 downto 0);
         anod : out std_logic_vector(7 downto 0));
end anod_mux;

architecture Behavioral of anod_mux is

begin

    anod <= "11111110" when sel = "000" else
            "11111101" when sel = "001" else 
            "11111011" when sel = "010" else
            "11110111" when sel = "011" else
            "11101111" when sel = "100" else
            "11011111" when sel = "101" else
            "10111111" when sel = "110" else
            "01111111";
           
end Behavioral;
