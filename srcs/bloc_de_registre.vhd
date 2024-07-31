library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity reg_file is
port ( clk : in std_logic;
    enable_fetch : in std_logic;
    ra1 : in std_logic_vector(4 downto 0);
    ra2 : in std_logic_vector(4 downto 0);
    wa : in std_logic_vector(4 downto 0);
    wd : in std_logic_vector(31 downto 0);
    regwr : in std_logic;
    rd1 : out std_logic_vector(31 downto 0);
    rd2 : out std_logic_vector(31 downto 0));
end reg_file;
    
architecture Behavioral of reg_file is
    
    type reg_array is array(0 to 31) of std_logic_vector(31 downto 0);
    signal reg_file : reg_array := (others => x"00000000");
    
    signal index_wa : integer;
    signal index_ra1 : integer;
    signal index_ra2 : integer;
    
begin

    index_wa <= conv_integer(wa);
    index_ra1 <= conv_integer(ra1);
    index_ra2 <= conv_integer(ra2);

    process(clk)
    begin
        if rising_edge(clk) then
            if enable_fetch = '1' then
                if regwr = '1' then
                    reg_file(index_wa) <= wd;
                end if;
            end if;
        end if;
    end process;
    
    rd1 <= reg_file(index_ra1);
    rd2 <= reg_file(index_ra2);

end Behavioral;