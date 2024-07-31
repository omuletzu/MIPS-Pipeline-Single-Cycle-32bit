library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity cat_mux is
  Port ( input : in std_logic_vector(31 downto 0);
         sel : in std_logic_vector(2 downto 0);
         output : out std_logic_vector(3 downto 0));
end cat_mux;

architecture Behavioral of cat_mux is
begin

    output <= input(3 downto 0) when sel = "000" else
              input(7 downto 4) when sel = "001" else
              input(11 downto 8) when sel = "010" else
              input(15 downto 12) when sel = "011" else
              input(19 downto 16) when sel ="100" else
              input(23 downto 20) when sel = "101" else
              input(27 downto 24) when sel = "110" else
              input(31 downto 28);

end Behavioral;
