library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MEM is
  Port (clk : in STD_LOGIC;
        MemWrite : in STD_LOGIC;
        AluResIn : in STD_LOGIC_VECTOR(31 downto 0);
        rd2 : in STD_LOGIC_VECTOR(31 downto 0);
        BranchUC : in STD_LOGIC_VECTOR(2 downto 0);
        BranchEX : in STD_LOGIC_VECTOR(2 downto 0);
        MemData : out STD_LOGIC_VECTOR(31 downto 0);
        PCSrc : out STD_LOGIC);
end MEM;

architecture Behavioral of MEM is

    type mem_type is array(0 to 31) of std_logic_vector(31 downto 0);
    signal mem : mem_type := (x"00000003", x"00000003", x"00000005", x"00000004", x"00000006", x"0000000B", others => x"00000000");

    signal index_aluRes : integer;

begin

    PCsrc <= (BranchUC(2) AND BranchEX(2)) OR (BranchUC(1) AND BranchEX(1)) OR (BranchUC(0) AND BranchEX(0));

    index_aluRes <= conv_integer(AluResIn);

    process(clk)
    begin
    
        if(rising_edge(clk)) then
            if(MemWrite = '1') then
                mem(index_aluRes) <= rd2;
            end if;
        end if;
    
    end process;

    MemData <= mem(index_aluRes);

end Behavioral;
