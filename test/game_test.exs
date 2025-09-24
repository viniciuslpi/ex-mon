defmodule ExMon.GameTest do
  use ExUnit.Case

  alias ExMon.{Game, Player}

  @expected_player %Player{
    life: 100,
    name: "John Doe",
    moves: %{move_heal: :heal, move_avg: :punch, move_rnd: :kick}
  }

  @expected_computer %{ @expected_player | name: "Robotinik" }

  describe "start/2" do
    test "starts the game state" do
      player = Player.build("John Doe", :kick, :punch, :heal)
      computer = Player.build("Robotinik",  :kick, :punch, :heal)

      assert {:ok, _game} = Game.start(computer, player)
    end
  end

  describe "info/0" do
    test "returns the current game state" do
      player = Player.build("John Doe", :kick, :punch, :heal)
      computer = Player.build("Robotinik", :kick, :punch, :heal)

      Game.start(computer, player)

      expected_response = %{
        status: :started,
        turn: :player,
        computer: @expected_computer,
        player: @expected_player
      }

      assert expected_response == Game.info()
    end
  end

  describe "update/1" do
    test "returns the game state updated" do
      player = Player.build("John Doe", :kick, :punch, :heal)
      computer = Player.build("Robotinik", :kick, :punch, :heal)

      Game.start(computer, player)

      expected_response = %{
        status: :started,
        turn: :player,
        computer: @expected_computer,
        player: @expected_player
      }

      assert expected_response == Game.info()

      new_state = %{
        status: :started,
        turn: :player,
        computer: @expected_computer,
        player: @expected_player
      }

      Game.update(new_state)

      expected_response = %{new_state | turn: :computer, status: :continue}
      assert expected_response == Game.info()
    end
  end

  describe "player/0" do
    test "returns a player" do
      player = Player.build("John Doe", :kick, :punch, :heal)
      computer = Player.build("Robotinik", :kick, :punch, :heal)

      Game.start(computer, player)

      assert @expected_player == Game.player()
    end
  end

  describe "fetch_player/1" do
    test "returns the player by key" do
      player = Player.build("John Doe", :kick, :punch, :heal)
      computer = Player.build("Robotinik", :kick, :punch, :heal)

      Game.start(computer, player)

      assert @expected_computer == Game.fetch_player(:computer)
    end
  end
end
