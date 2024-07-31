library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity UC is
  Port (Instr : in STD_LOGIC_VECTOR(5 downto 0);
        RegDst : out STD_LOGIC;
        ExtOp : out STD_LOGIC;
        ALUSrc : out STD_LOGIC;
        Branch : out STD_LOGIC;
        Jump : out STD_LOGIC;
        ALUOp : out STD_LOGIC_VECTOR(2 downto 0);
        MemWrite : out STD_LOGIC;
        MemToReg : out STD_LOGIC;
        RegWrite : out STD_LOGIC;
        Bgez : out STD_LOGIC;
        Bgtz : out STD_LOGIC);
end UC;

architecture Behavioral of UC is

begin

    process(Instr)
    begin
        
        RegDst <= '0';
        ExtOp <= '0';
        ALUSrc <= '0';
        Branch <= '0';
        Jump <= '0';
        ALUOp <= "000";
        MemWrite <= '0';
        MemToReg <= '0';
        RegWrite <= '0';
        Bgez <= '0';
        Bgtz <= '0';
            
        case Instr is    
         
            when "000000" =>    -- tip R
            
                ExtOp <= '1';
                RegDst <= '1';
		        RegWrite <= '1';
            
            when "001000" =>    -- addi
            
                RegWrite <= '1';
                ExtOp <= '1';
                AluSrc <= '1';
                AluOp <= "101";
            
            when "100011" =>    -- lw
            
                MemToReg <= '1';
                RegWrite <= '1';
                ExtOp <= '1';
                AluSrc <= '1';
                AluOp <= "001";
            
            when "101011" =>    -- sw
            
                MemWrite <= '1';
                ExtOp <= '1';
                AluSrc <= '1';
                AluOp <= "001";
            
            when "000001" =>   -- bgez
            
                Bgez <= '1';
                ExtOp <= '1';
                AluOp <= "010";
            
            when "000111" =>    -- bgtz
            
                Bgtz <= '1';
                ExtOp <= '1';
                AluOp <= "011";
            
            when "000010" =>    -- j
            
                Jump <= '1';
                AluOp <= "100";
         
            when "000100" =>    -- beq
            
                Branch <= '1';
                ExtOp <= '1';
                AluOp <= "110";
         
            when others =>
         
        end case;
         
    end process;

end Behavioral;
