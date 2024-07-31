library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ssd_full is
    Port (clk : in std_logic;
          test_env_counter : std_logic_vector(31 downto 0);
          catod : out std_logic_vector(6 downto 0);
          anod : out std_logic_vector(7 downto 0));
end ssd_full;

architecture Behavioral of ssd_full is

    signal counter : std_logic_vector(16 downto 0) := (others => '0');
    signal cat_out : std_logic_vector(3 downto 0) := (others => '0');

begin

    process(clk)
    begin
    
        if(clk'event and clk = '1') then
            counter <= counter + 1;
        end if;
    
    end process;
    
    eth_cat: entity work.cat_mux PORT MAP (test_env_counter, counter(16 downto 14), cat_out);
    eth_an: entity work.anod_mux PORT MAP (counter(16 downto 14), anod);
    eth_ssd: entity work.hex_to_ssd PORT MAP (cat_out, catod);
    
end Behavioral;
