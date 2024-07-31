library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mpg is
    Port ( clk : in STD_LOGIC;
           btn : in STD_LOGIC;
           en : out STD_LOGIC);
end mpg;

architecture Behavioral of mpg is

    signal counter : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal QD_1 : STD_LOGIC := '0';
    signal QD_2 : STD_LOGIC := '0';
    signal QD_3 : STD_LOGIC := '0';

begin

    en <= not(QD_3) AND QD_2;

    process(clk)
    begin
    
        if(clk'event AND clk = '1') then
            counter <= counter + 1;
        end if;
    
    end process;

    process(clk)
    begin
    
        if(clk'event AND clk = '1') then
            QD_3 <= QD_2;
            QD_2 <= QD_1;
        end if;
    
    end process;
    
    process(clk)
    begin
    
        if(clk'event AND clk = '1') then
            if(counter(15 downto 0) = x"0000") then 
                QD_1 <= btn;
            end if;
        end if;
    
    end process;

end Behavioral;
