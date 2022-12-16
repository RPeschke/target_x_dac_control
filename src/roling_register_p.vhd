library IEEE;
  use IEEE.std_logic_1164.all;
  use IEEE.numeric_std.all;

package roling_register_p is

  type registerT is record 
    address : std_logic_vector(15 downto 0);
    value   : std_logic_vector(15 downto 0);

  end record;

  constant registerT_null : registerT := (
    address => (others => '0'),
    value   => (others => '0')

  );

  type registerT_a is array (natural range <>) of registerT;

  procedure read_data_s(self : in registerT; signal value :out  STD_LOGIC_VECTOR ; addr :in integer);



  type register_val_t is record
    Global_reset    : integer; 
    Global_update   : integer; 
    DAC_LOAD_PERIOD : integer;
    DAC_LATCH_PERIOD_PERIOD   : integer;
    DAC_Wait                  : integer;

  end record;

  constant register_val : register_val_t := (
    Global_reset                 => 12345,
    Global_update                => 12346,
    DAC_LOAD_PERIOD              => 100,
    DAC_LATCH_PERIOD_PERIOD      => 101,
    DAC_Wait                     => 102
  
  );



  constant gRegisterDelay: integer := 10;
end package;

package body roling_register_p is
  

  
  procedure read_data_s(self : in registerT;signal value :out  std_logic_vector ; addr :in integer) is 
    variable m1 : integer := 0;
    variable m2 : integer := 0;
    variable m : integer := 0;
  begin
    m1 := value'length;
    m2 := self.value'length;

    if (m1 < m2) then 
      m := m1;
    else 
      m := m2;
    end if;

    if to_integer(signed(self.address)) = addr then
      value(m - 1 downto 0) <= self.value(  m - 1 downto 0);
    end if; 
  end procedure;


end package body;