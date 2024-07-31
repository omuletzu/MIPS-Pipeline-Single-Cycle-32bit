library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity IDecod is
  Port (clk : in STD_LOGIC;
        enable_fetch : in STD_LOGIC;
        RegWrite : in STD_LOGIC;
        Instr: in STD_LOGIC_VECTOR(25 downto 0);
        ExtOp : in STD_LOGIC;
        rd1 : out STD_LOGIC_VECTOR(31 downto 0);
        rd2 : out STD_LOGIC_VECTOR(31 downto 0);
        wd : in STD_LOGIC_VECTOR(31 downto 0);
        wa : in STD_LOGIC_VECTOR(4 downto 0);
        Ext_Imm : out STD_LOGIC_VECTOR(31 downto 0);
        func : out STD_LOGIC_VECTOR(5 downto 0);
        sa : out STD_LOGIC_VECTOR(4 downto 0));
end IDecod;

architecture Behavioral of IDecod is

    signal ReadAdr1 : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
    signal ReadAdr2 : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');

begin

    ReadAdr1 <= Instr(25 downto 21);
    ReadAdr2 <= Instr(20 downto 16);

    Ext_Imm(15 downto 0) <= Instr(15 downto 0);
    Ext_Imm(31 downto 16) <= (others => Instr(15)) when ExtOp = '1' else (others => '0');

    func <= Instr(5 downto 0);
    sa <= Instr(10 downto 6);

    eth_regFile: entity work.reg_file PORT MAP (clk, enable_fetch, ReadAdr1, ReadAdr2, wa, wd, RegWrite, rd1, rd2);

end Behavioral;
