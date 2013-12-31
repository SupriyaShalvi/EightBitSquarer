------------------------------------------------------
--
-- Library Name : Project COEN 6501
-- Unit Name : Booth Multiplier
-- Author: Supriya Shalvi and Oana Neagu
------------------------------------------------------
------------------------------------------------------
-- Description : Sixteen bit adder performs the
-- following:
-- It takes two sixteen bits input and add them.
--
------------------------------------------------------
------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;
use work.all;

entity sixteenbit_fa is
Port ( a : in STD_LOGIC_VECTOR (15 downto 0);
       b : in STD_LOGIC_VECTOR (15 downto 0);
-- cin : in STD_LOGIC;
yout : out STD_LOGIC_VECTOR (15 downto 0);
cout : out STD_LOGIC);
end sixteenbit_fa;
architecture Behavioral of sixteenbit_fa is
signal s: std_logic_vector(15 downto 0);
signal carry1: std_logic_vector(16 downto 0);
COMPONENT full_adder
PORT(
a : IN std_logic;
b : IN std_logic;
c_in : IN std_logic;
sum : OUT std_logic;
c_out : OUT std_logic
);
END COMPONENT;
begin
carry1(0)<='0';
g1 : for i in 0 to 15 generate
f0 : full_adder PORT MAP(a(i), b(i),carry1(i),yout(i), carry1(i+1));
-- inter_carr<=carry(i+1);
end generate g1;
cout<=carry1(16);
end Behavioral;