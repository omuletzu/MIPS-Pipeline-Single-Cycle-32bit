library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity IFetch is
  Port ( clk : in STD_LOGIC;
         enable_fetch : in STD_LOGIC;
         enable_reset : in STD_LOGIC;
         PCSrc : in STD_LOGIC;
         Jump : in STD_LOGIC;
         jump_adress : in STD_LOGIC_VECTOR(31 downto 0);
         branch_adress : in STD_LOGIC_VECTOR(31 downto 0);
         instruction : out STD_LOGIC_VECTOR(31 downto 0);
         PC_4 : out STD_LOGIC_VECTOR(31 downto 0));
end IFetch;

architecture Behavioral of IFetch is  

    signal output_pc : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal output_rom : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal output_pc_incremented : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    --signal jump_adress : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal instruction_aux : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');

    signal output_mux1 : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal output_mux2 : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');

    type matrix is array(0 to 63) of STD_LOGIC_VECTOR(31 downto 0);
    
    signal rom : matrix := (x"8C020000",  -- citire date din memorie  
                            x"8C030001",
                            x"8C040002",
                            
                            x"00000020",    -- NOOP
                            
                            x"00432820",
                            
                            x"00000020",    -- NOOP
                            x"00000020",    -- NOOP
                            
                            x"20A5FFFF",
                            
                            x"00000020",    -- NOOP
                            x"00000020",    -- NOOP
                            
                            x"8CA60000",    -- inceput bucla prelucare
                            
                            x"00000020",    -- NOOP
                            x"00000020",    -- NOOP
                            
                            x"00C43822",
                            
                            x"00000020",    -- NOOP
                            x"00000020",    -- NOOP
                            
                            x"1CE00006",
                            
                            x"00000020",    -- NOOP
                            x"00000020",    -- NOOP
                            x"00000020",    -- NOOP
                            
                            x"00063043",
                            x"0800001B",
                            
                            x"00000020",    -- NOOP
                            
                            x"00C63820",
                            
                            x"00000020",    -- NOOP
                            x"00000020",    -- NOOP
                            
                            x"00E63020",
                            
                            x"00000020",    -- NOOP
                            x"00000020",    -- NOOP
                            
                            x"ACA60000",
                            
                            x"20A5FFFF",
                            
                            x"00000020",    -- NOOP
                            x"00000020",    -- NOOP
                            
                            x"00A23822",
                            
                            x"00000020",    -- NOOP
                            x"00000020",    -- NOOP
                            
                            x"04E0FFE5",    -- final bucla prelucrare
                            
                            x"00000020",    -- NOOP
                            x"00000020",    -- NOOP
                            x"00000020",    -- NOOP
                            
                            x"00432820",    -- inceput bucla afisare
                            
                            x"00000020",    -- NOOP
                            x"00000020",    -- NOOP
                            
                            x"20A5FFFF",
                            
                            x"00000020",    -- NOOP
                            x"00000020",    -- NOOP
                            
                            x"8CA60000",
                            
                            x"00000020",    -- NOOP
                            x"00000020",    -- NOOP
                            
                            x"20C60000",
                            x"20A5FFFF",
                            
                            x"00000020",    -- NOOP
                            x"00000020",    -- NOOP
                            
                            x"00A23822",
                            
                            x"00000020",    -- NOOP
                            x"00000020",    -- NOOP
                            
                            x"04E0FFF5",    -- final bucla afisare
                            x"00000020",    -- NOOP
                            x"00000020",    -- NOOP
                            x"00000020",    -- NOOP
             
                            others => x"00000000");
                            
    signal index : integer;

begin
        
    output_pc_incremented <= output_pc + 4;
    PC_4 <= output_pc_incremented;
    
    --jump_adress <= output_pc_incremented(31 downto 28) & instruction_aux(25 downto 0) & "00";
    
    output_mux1 <= output_pc_incremented when PCSrc = '0' else branch_adress;
    output_mux2 <= output_mux1 when Jump = '0' else jump_adress;
    
    process(clk)
    begin
    
        if(rising_edge(clk)) then
            if(enable_fetch = '1') then 
        	   output_pc <= output_mux2; 
        	end if;
        	
        	if(enable_reset = '1') then
        	   output_pc <= (others => '0');
        	end if;
        end if;
    
    end process; 
    
    index <= conv_integer(output_pc(7 downto 2));

    process(output_pc)
    begin
    
        instruction_aux <= rom(index);
    
    end process;  
    
    instruction <= instruction_aux;
    
end Behavioral;