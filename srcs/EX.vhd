library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity EX is
  Port (rd1 : in STD_LOGIC_VECTOR(31 downto 0);
        ALUSrc : in STD_LOGIC;
        rd2 : in STD_LOGIC_VECTOR(31 downto 0);
        Ext_Imm : in STD_LOGIC_VECTOR(31 downto 0);
        sa : in STD_LOGIC_VECTOR(4 downto 0);
        func : in STD_LOGIC_VECTOR(5 downto 0);
        ALUOp : in STD_LOGIC_VECTOR(2 downto 0);
        PC_4 : in STD_LOGIC_VECTOR(31 downto 0);
        ra2 : in STD_LOGIC_VECTOR(4 downto 0);
        ra3 : in STD_LOGIC_VECTOR(4 downto 0);
        regDst : in STD_LOGIC;
        zero : out STD_LOGIC;
        ALURes : out STD_LOGIC_VECTOR(31 downto 0);
        BranchAdr : out STD_LOGIC_VECTOR(31 downto 0);
        bgez_out : out STD_LOGIC;
        bgtz_out : out STD_LOGIC;
        outputRegDst : out STD_LOGIC_vector(4 downto 0));
end EX;

architecture Behavioral of EX is

    signal op1 : STD_LOGIC_VECTOR(31 downto 0);
    signal op2 : STD_LOGIC_VECTOR(31 downto 0);
    signal AluRes_output : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal zeroFlag : STD_LOGIC := '0';
    signal bgez : STD_LOGIC := '0';
    signal bgtz : STD_LOGIC := '0';

    signal op1_int : INTEGER;
    signal op2_int : INTEGER;

begin

    op1 <= rd1;
    op2 <= rd2 when ALUSrc = '0' else Ext_Imm;  

    BranchAdr <= PC_4 + (Ext_Imm(29 downto 0) & "00");
    outputRegDst <= ra2 when RegDst = '0' else ra3;

    process(ALUOp)
    begin
    
        zeroFlag <= '0';
        bgez <= '0';
        bgtz <= '0';
        
        case ALUOp is
        
            when "000" =>   -- tip R
            
                case func is
                
                    when "100000" => AluRes_output <= op1 + op2;    -- add

                    when "100010" => AluRes_output <= op1 - op2;    -- sub
                        
                    when "000011" => AluRes_output <= to_stdlogicvector(to_bitvector(op2) sra conv_integer(sa));    -- sra
                    
                    when "000000" => AluRes_output <= to_stdlogicvector(to_bitvector(op2) sll conv_integer(sa));    -- sll
                    
                    when "000010" => AluRes_output <= to_stdlogicvector(to_bitvector(op2) sll conv_integer(sa));    -- srl
                    
                    when "100100" => AluRes_output <= to_stdlogicvector(to_bitvector(op1) and to_bitvector(op2));   -- and
                        
                    when "100101" => AluRes_output <= to_stdlogicvector(to_bitvector(op1) or to_bitvector(op2));    -- or
                        
                    when "100110" => AluRes_output <= to_stdlogicvector(to_bitvector(op1) xor to_bitvector(op2));    -- xor   
                        
                    when others =>
                end case;
                
                if(AluRes_output = x"00000000") then 
                      zeroFlag <= '1';
                end if;
            
            when "001" =>   -- lw / sw
            
                AluRes_output <= op1 + op2;
            
            when "010" =>   -- bgez
                
                bgez <= not op1(31);
            
                if(op1 = x"00000000") then
                    bgez <= '1';
                end if;
            
            when "011" =>   -- bgtz
            
                bgtz <= not op1(31);
               
            when "100" =>   -- j
                
            when "101" =>   -- addi
            
                AluRes_output <= op1 + op2;
                       
                if(AluRes_output = x"00000000") then
                   zeroFlag <= '1';
                end if;
               
            when "110" =>   -- beq
                        
                if((op1_int - op2_int) = 0) then
                   zeroFlag <= '1';
                end if;
                        
            when others =>  
        
        end case;
    
    end process;

    AluRes <= AluRes_output;
    zero <= zeroFlag;
    bgez_out <= bgez;
    bgtz_out <= bgtz;

end Behavioral;
