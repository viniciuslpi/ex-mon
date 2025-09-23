defmodule ExMon.Player do
  @required_keys [:life, :name, :moves]
  @max_life 100

  @enforce_keys @required_keys # enforce keys guarantee that the struct is always created with these keys
  defstruct @required_keys # definition of the struct

  # object criation function
  def build(name, move_rnd, move_avg, move_heal) do
    %ExMon.Player{
      life: @max_life, # module variable
      name: name,
      moves: %{
        move_rnd: move_rnd,
        move_avg: move_avg,
        move_heal: move_heal
      }
    }
  end
end
