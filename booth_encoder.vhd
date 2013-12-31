------------------------------------------------------
--
-- Library Name : Project COEN 6501
-- Unit Name : Booth Encoder
-- Author: Supriya Shalvi and Oana Neagu
------------------------------------------------------
------------------------------------------------------
-- Description : Booth encoder performs the
-- following:
-- > Take a and 3 bits of a which needed for encoding as input
-- > multiply the encoded value with with necessary shifting
-- give the output as the product
--
------------------------------------------------------
------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;
use ieee.numeric_std.all;
use work.all;

entity booth_encoder is

Port ( a : in std_logic_vector(7 downto 0);
       arg : in std_logic_vector(2 downto 0);
      pprod : out std_logic_vector(15 downto 0));
end booth_encoder;

architecture Behavioral of booth_encoder is
function encoder(arg1 : std_logic_vector(2 downto 0);
                  data : std_logic_vector(7 downto 0))
return std_logic_vector is
variable temp,temp1,temp2: std_logic_vector(8 downto 0);
variable sign: std_logic;
begin
case arg1 is
when "001"|"010" =>
if data <0 then
temp:='1'& data;
else
temp:='0'&data;
end if;
when "011" =>
if data<0 then
temp1:='1'&data;
temp:=temp1(7 downto 0)&'0';
else
temp:='0'&data(6 downto 0)&'0';
end if ;
when "100" =>
if data<0 then
temp1:='1'&data;
temp2:=(not temp1)+"000000001";
temp:=(temp2(7 downto 0)&'0');
else
temp1:='0'&data;
temp2:=(not temp1)+"000000001";
temp:=(temp2(7 downto 0)&'0');
end if;
when "101"|"110" =>
if data < 0 then
temp1:='1'&data;
temp:=not(temp1)+"000000001";
else
temp1:='0'&data;
temp:=(not temp1)+"000000001";
end if;
when others =>
temp:="000000000";
--"(others=>'0');
end case;
return temp;
end encoder;
signal s1: std_logic_vector(8 downto 0);
signal s2: std_logic;
begin
s1<=encoder(arg,a);

pprod<=sxt(s1,16);
end Behavioral;