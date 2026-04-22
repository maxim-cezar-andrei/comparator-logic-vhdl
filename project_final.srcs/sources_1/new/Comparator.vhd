library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Comparator is
    Port (
        A : in std_logic_vector(3 downto 0);
        B : in std_logic_vector(3 downto 0);
        C : in std_logic_vector(3 downto 0);

        an : out std_logic_vector(3 downto 0);
        
        seg : out std_logic_vector(6 downto 0)
    );
end entity;

architecture Behavioral of Comparator is

    signal A_u, B_u, C_u : unsigned(3 downto 0);

    signal A_less_B, A_equal_B, A_greater_B : std_logic;
    signal A_less_C, A_equal_C, A_greater_C : std_logic;

    signal disp_select : std_logic_vector(3 downto 0);

begin

    -- Conversie la unsigned pentru comparaČ›ii
    A_u <= unsigned(A);
    B_u <= unsigned(B);
    C_u <= unsigned(C);

    -- Comparator A vs B
    process(A_u, B_u)
    begin
        if A_u < B_u then
            A_less_B <= '1';
            A_equal_B <= '0';
            A_greater_B <= '0';
        elsif A_u = B_u then
            A_less_B <= '0';
            A_equal_B <= '1';
            A_greater_B <= '0';
        else
            A_less_B <= '0';
            A_equal_B <= '0';
            A_greater_B <= '1';
        end if;
    end process;

    -- Comparator A vs C
    process(A_u, C_u)
    begin
        if A_u < C_u then
            A_less_C <= '1';
            A_equal_C <= '0';
            A_greater_C <= '0';
        elsif A_u = C_u then
            A_less_C <= '0';
            A_equal_C <= '1';
            A_greater_C <= '0';
        else
            A_less_C <= '0';
            A_equal_C <= '0';
            A_greater_C <= '1';
        end if;
    end process;

    -- Afisare pe 7 seg
    process(A_less_B, A_equal_B, A_greater_B, A_less_C, A_equal_C, A_greater_C)
    begin
--        disp_select <= "1111";
        seg(0) <= '1'; 
        seg(1) <= '1'; 
        seg(2) <= '1'; 
        seg(3) <= '1';
        seg(4) <= '1'; 
        seg(5) <= '1'; 
        seg(6) <= '1';

        if (A_less_B = '1') or (A_less_C = '1') then
            -- A < B sau A < C -> C intors pe AN0 (a,b,c,d)
            disp_select <= "1110"; 
            seg(0) <= '0'; 
            seg(1) <= '0'; 
            seg(2) <= '0'; 
            seg(3) <= '0';

        elsif (A_equal_B = '1') or (A_equal_C = '1') then
            -- A = B sau A = C -> = pe AN1 (a,g)
            disp_select <= "1110";
            seg(0) <= '0'; 
            seg(6) <= '0'; 

        elsif (A_greater_B = '1') or (A_greater_C = '1') then
            -- A > B sau A > C -> C pe AN3 (a,d,e,f)
            disp_select <= "1110";
            seg(0) <= '0'; 
            seg(3) <= '0'; 
            seg(4) <= '0'; 
            seg(5) <= '0';

        else
            disp_select <= "1110";
            seg(0) <= '1'; 
            seg(1) <= '1'; 
            seg(2) <= '1'; 
            seg(3) <= '1';
            seg(4) <= '1'; 
            seg(5) <= '1'; 
            seg(6) <= '1';
        end if;
    end process;

an(0) <= disp_select(0);
an(1) <= disp_select(1);
an(2) <= disp_select(2);
an(3) <= disp_select(3);
--AN1 <= disp_select(1);
--AN2 <= disp_select(2);
--AN3 <= disp_select(3);

end Behavioral;
