defmodule ExMonTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  alias ExMon.Player

  describe "create_player/4" do
    test "returns a player" do
      expected_response = %Player{
        life: 100,
        name: "John Doe",
        moves: %{move_heal: :heal, move_avg: :punch, move_rnd: :kick}
      }

      assert expected_response == ExMon.create_player("John Doe", :kick, :punch, :heal)
    end
  end

  describe "start_game/1" do
    test "when the game is started, returns the message" do
      player = Player.build("John Doe", :kick, :punch, :heal)

     messages =
      capture_io(fn ->
        assert ExMon.start_game(player) == :ok
      end)

      assert messages =~ "The game is started!"
    end
  end

  describe "make_move/1" do
    setup do
      player = Player.build("John Doe", :kick, :punch, :heal)

      capture_io(fn ->
        ExMon.start_game(player)
      end)

      {:ok, player: player}
    end

    test "when the move is valid, do the move and the computer makes a move", %{player: _} do
     messages =
      capture_io(fn ->
        ExMon.make_move(:kick)
      end)

      assert messages =~ "The player attacked the computer"
      assert messages =~ "It's computer turn."
      assert messages =~ "It's player turn."
      assert messages =~ "status: :continue"
    end


    test "when the move is invalid, returns an error message", %{player: _} do
      messages =
       capture_io(fn ->
         ExMon.make_move(:wrong_move)
       end)

       assert messages =~ "Invalid move: wrong_move"
     end
  end
end
