------------------------------------------------------
--
-- Library Name : Project COEN 6501
-- Unit Name : Booth Multiplier
-- Author: Supriya Shalvi and Oana Neagu
------------------------------------------------------
------------------------------------------------------
------------------------------------------------------
-- Description : D flip flop performs the
-- following:
-- > on the clock load the input from port Q D to Q
-- > on reset, fill the output with "0"
--
------------------------------------------------------
------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
entity DFF is
port (
 clk : in std_logic ;
 clear : in std_logic;
 D : in std_logic ;
 Q : out std_logic);
end;
------------------------------------------------------
architecture struc of DFF is
  begin
    process(D,clk,clear)
      begin
        if(clk'event and clk='1')
        then
          if clear ='1' then
            Q<='0';
          else
          Q<=D;
        end if;
      end if;
      end process;
    end struc;