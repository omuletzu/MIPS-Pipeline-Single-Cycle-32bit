library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity test_env is
    Port ( clk : in STD_LOGIC;
           btn : in STD_LOGIC_VECTOR (4 downto 0);
           sw : in STD_LOGIC_VECTOR (15 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0);
           an : out STD_LOGIC_VECTOR (7 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0));
end test_env;

architecture Behavioral of test_env is  

    -- IFetch
    signal PCSrc : STD_LOGIC := '0';
    signal Jump : STD_LOGIC := '0';
    signal branch_adress : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal jump_adress : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal instruction : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal PC_4 : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');

    -- IDecod
    signal RegWrite : STD_LOGIC := '0';
    signal Instr: STD_LOGIC_VECTOR(25 downto 0) := (others => '0');
    signal RegDst : STD_LOGIC := '0';
    signal ExtOp : STD_LOGIC := '0';
    signal rd1 : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal rd2 : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal wd : STD_LOGIC_VECTOR(31 downto 0);
    signal Ext_Imm : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal func : STD_LOGIC_VECTOR(5 downto 0) := (others => '0');
    signal sa : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');

    -- UC
    signal AluSrc : STD_LOGIC := '0';
    signal AluOp : STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
    signal Branch : STD_LOGIC := '0';    
    signal MemWrite : STD_LOGIC := '0';
    signal MemToReg : STD_LOGIC := '0'; 
    signal Bgez : STD_LOGIC := '0';
    signal Bgtz : STD_LOGIC := '0';

    -- EX
    signal zero : STD_LOGIC := '0';
    signal AluRes : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal bgez_out : STD_LOGIC := '0';
    signal bgtz_out : STD_LOGIC := '0';
    signal outputRegDst : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');

    -- MEM
    signal MemData : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');

    -- SSD
    signal ssd_output : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    
    -- Buttons
    signal enable_fetch : STD_LOGIC := '0';
    signal enable_reset : STD_LOGIC := '0';

    -- Registers
    signal IF_ID : STD_LOGIC_VECTOR(63 downto 0) := (others => '0');   
    -- (63 - 32 PC_4, 31 - 0 instruction)
    signal ID_EX : STD_LOGIC_VECTOR(159 downto 0) := (others => '0');  
    -- (159 MemToReg, 158 RegWrite, 157 MemWrite, 156 Branch, 155 Bgez, 154 Bgtz, 153 - 151 AluOP, 150 AluSrc, 149 RegDst, 148 - 117 PC_4(IF_ID 63 - 32), 116 - 85 rd1, 84 - 53 rd2, 52 - 48 sa, 47 - 16 Ext_Imm, 15 - 10 func, 9 - 5 ra2, 4 - 0 ra3)
    signal EX_MEM : STD_LOGIC_VECTOR(109 downto 0) := (others => '0');
    -- (109, MemToReg ,108 RegWrite, 107 MemWrite, 106 Branch, 105 Bgez, 104 Bgtz, 103 - 72 branch_address, 71 zero, 70 Bgez_out, 69 Bgtz_out, 68 - 37 AluRes, 36 - 5 rd2_wa, 4 - 0 rd2_rd3)
    signal MEM_WB : STD_LOGIC_VECTOR(70 downto 0) := (others => '0');
    -- (70 MemToReg, 69 RegWrite, 68 - 37 MemData, 36 - 5 AluRes, 4 - 0 rd2_rd3)

begin

    process(clk)
    begin
    
        if(falling_edge(clk) and enable_fetch = '1') then
            
            -- MEM_WB
            MEM_WB(70 downto 69) <= EX_MEM(109 downto 108);
            MEM_WB(68 downto 37) <= MemData;
            MEM_WB(36 downto 5) <=  EX_MEM(68 downto 37);
            MEM_WB(4 downto 0) <= EX_MEM(4 downto 0);
            
            -- EX_MEM
            EX_MEM(109 downto 104) <= ID_EX(159 downto 154);
            EX_MEM(103 downto 72) <= branch_adress;
            EX_MEM(71) <= zero;
            EX_MEM(70) <= bgez_out;
            EX_MEM(69) <= bgtz_out;
            EX_MEM(68 downto 37) <= AluRes;
            EX_MEM(36 downto 5) <= ID_EX(84 downto 53);
            EX_MEM(4 downto 0) <= outputRegDst;
            
            -- ID_EX
            ID_EX(159) <= MemToReg;
            ID_EX(158) <= RegWrite;
            ID_EX(157) <= MemWrite;
            ID_EX(156) <= Branch;
            ID_EX(155) <= Bgez; 
            ID_EX(154) <= Bgtz;
            ID_EX(153 downto 151) <= AluOp;
            ID_EX(150) <= AluSrc;
            ID_EX(149) <= RegDst;
            ID_EX(148 downto 117) <= IF_ID(63 downto 32);
            ID_EX(116 downto 85) <= rd1;
            ID_EX(84 downto 53) <= rd2;
            ID_EX(52 downto 48) <= sa;
            ID_EX(47 downto 16) <= Ext_Imm;
            ID_EX(15 downto 10) <= func;
            ID_EX(9 downto 5) <= IF_ID(20 downto 16);
            ID_EX(4 downto 0) <= IF_ID(15 downto 11);
            
            -- IF_ID
            IF_ID(63 downto 32) <= PC_4;
            IF_ID(31 downto 0) <= instruction;
            
        end if;
    
    end process;   

    eth_fetch: entity work.MPG PORT MAP (clk, btn(0), enable_fetch);
    eth_reset: entity work.MPG PORT MAP (clk, btn(1), enable_reset);

    eth_IFetch: entity work.IFetch PORT MAP(clk, enable_fetch, enable_reset, PCSrc, Jump, jump_adress, EX_MEM(103 downto 72), instruction, PC_4);
    eth_IDecod: entity work.IDecod PORT MAP(clk, enable_fetch, MEM_WB(69), IF_ID(25 downto 0), ExtOp, rd1, rd2, wd, MEM_WB(4 downto 0), Ext_Imm, func, sa);
    eth_UC: entity work.UC PORT MAP(IF_ID(31 downto 26), RegDst, ExtOp, AluSrc, Branch, Jump, AluOp, MemWrite, MemToReg, RegWrite, Bgez, Bgtz);
    eth_EX: entity work.EX PORT MAP(ID_EX(116 downto 85), ID_EX(150), ID_EX(84 downto 53), ID_EX(47 downto 16), ID_EX(52 downto 48), ID_EX(15 downto 10), ID_EX(153 downto 151), ID_EX(148 downto 117), ID_EX(9 downto 5), ID_EX(4 downto 0), ID_EX(149), zero, AluRes, branch_adress, bgez_out, bgtz_out, outputRegDst);
    eth_MEM: entity work.MEM PORT MAP(clk, EX_MEM(107), EX_MEM(68 downto 37), EX_MEM(36 downto 5), EX_MEM(106 downto 104), EX_MEM(71 downto 69), MemData, PCSrc);

--    eth_IFetch: entity work.IFetch PORT MAP(clk, enable_fetch, enable_reset, PCSrc, Jump, branch_adress, instruction, PC_4);
--    eth_IDecod: entity work.IDecod PORT MAP(clk, enable_fetch, RegWrite, instruction(25 downto 0), RegDst, ExtOp, rd1, rd2, wd, Ext_Imm, func, sa);
--    eth_UC: entity work.UC PORT MAP(instruction(31 downto 26), RegDst, ExtOp, AluSrc, Branch, Jump, AluOp, MemWrite, MemToReg, RegWrite, Bgez, Bgtz);
--    eth_EX: entity work.EX PORT MAP(rd1, AluSrc, rd2, Ext_Imm, sa, func, AluOp, PC_4, zero, AluRes, branch_adress, bgez_out, bgtz_out);
--    eth_MEM: entity work.MEM PORT MAP(clk, MemWrite, AluRes, rd2, MemData);
    
    eth_ssd_full: entity work.ssd_full PORT MAP(clk, ssd_output, cat, an);
    
    jump_adress <= IF_ID(63 downto 60) & IF_ID(25 downto 0) & "00";
    
    wd <= MEM_WB(68 downto 37) when MEM_WB(70) = '1' else MEM_WB(36 downto 5); 
    
    led(0) <= Bgtz;
    led(1) <= bgtz_out;
    
    led(3) <= Bgez;
    led(4) <= bgez_out;
    
    process(sw(7 downto 5))
    begin
    
        case sw(7 downto 5) is
            
            when "000" =>   ssd_output <= instruction;
            when "001" =>   ssd_output <= PC_4;
            when "010" =>   ssd_output <= rd1;
            when "011" =>   ssd_output <= rd2;
            when "100" =>   ssd_output <= Ext_Imm;
            when "101" =>   ssd_output <= AluRes;
            when "110" =>   ssd_output <= MemData;
            when "111" =>   ssd_output <= wd;
            
        end case;
    
    end process;
        
end Behavioral;

