------------------------------------------------------
--
-- Library Name : Project COEN 6501
-- Unit Name : Booth Multiplier
-- Author: Supriya Shalvi and Oana Neagu
------------------------------------------------------
------------------------------------------------------
-- Description : Register A performs the
-- following:
-- > loads input A_in into register A
--
------------------------------------------------------
------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
entity registerA is
port (reset : in std_logic ;
 A_in : in std_logic_vector  (15 downto 0);
 clk : in std_logic ;
 RA : out std_logic_vector  (15 downto 0));
end;
------------------------------------------------------
architecture struc of registerA is



 component DFF
 port  (
 clk : in std_logic;
 clear : in std_logic;
 D : in std_logic;
 Q : out std_logic
 );
end component;
begin
DFFs: for i in 15 downto 0 generate
 DFFReg:DFF port map (clk,reset, A_in(i), RA(i));
end generate;

    

end struc;