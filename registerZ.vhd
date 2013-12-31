------------------------------------------------------
--
-- Library Name : Project COEN 6501
-- Unit Name : Booth Multiplier
-- Author: Supriya Shalvi and Oana Neagu
------------------------------------------------------
------------------------------------------------------
-- Description : Register Z performs the
-- following:
-- > loads squarer output RZ into the output register 
-- 
--
------------------------------------------------------
------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use work.all;
entity registerZ is
port (reset : in std_logic ;
 y : in std_logic_vector  (31 downto 0);
 clk : in std_logic ;

 RZ : out std_logic_vector  (31 downto 0));
end;
------------------------------------------------------
architecture struc of registerZ is




  component DFF
 port  (
 clk : in std_logic;
 clear : in std_logic;
 D : in std_logic;
 Q : out std_logic
 );
end component;
begin
DFFs: for i in 31 downto 0 generate
 DFFReg:DFF port map (clk,reset, y(i), RZ(i));
end generate;


end struc;
 

