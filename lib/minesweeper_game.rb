# Handles the logic of managing the game state and interacting with the player
#     Copyright (C) 2021  Thomas Pierce Bosley

#     This program is free software: you can redistribute it and/or modify
#     it under the terms of the GNU General Public License as published by
#     the Free Software Foundation, either version 3 of the License, or
#     (at your option) any later version.

#     This program is distributed in the hope that it will be useful,
#     but WITHOUT ANY WARRANTY; without even the implied warranty of
#     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#     GNU General Public License for more details.

#     You should have received a copy of the GNU General Public License
#     along with this program.  If not, see <https://www.gnu.org/licenses/>.

# I can be reached by email at pierce-bosley@gmail.comrequire_relative "board"

module Minesweeper
  DIFFICULTY_LEVELS = {
    "beginner" => [[9, 9], 10],
    "intermediate" => [[16, 16],	40],
    "expert" => [[16,	30],	99]
  }
  COMMANDS = ["flag", "f", "reveal", "r", "help"]
  private_constant :DIFFICULTY_LEVELS, :COMMANDS

  class MineGame
    def self.get_difficulty
      difficulty = ""

      until DIFFICULTY_LEVELS.has_key?(difficulty)
        puts "Choose a difficulty level:"
        puts "beginner, intermediate, or expert"
        difficulty = gets.chomp.downcase
      end

      DIFFICULTY_LEVELS[difficulty]
    end

    def initialize(difficulty)
      @board = Board.new(*difficulty)
    end

    def run
      player_action = get_player_action
    end

    private

    def get_player_action
      action = ""

      until valid_input?(action)
        puts "Enter an action (or \"help\" for instructions)"
        action = gets.chomp.downcase
      end

      parse_action(action)
    end

    def valid_input?(input)
      command, position = input.split(" ")
      return true if command == "help"
      return false if position.nil?

      position = position.split(",")
      return false unless position.length == 2

      row, col = position
      return false unless row.match?(/^\d+$/) && col.match?(/^\d+$/)
      COMMANDS.include?(command) && @board.valid_position?(position.map(&:to_i))
    end

    def parse_action(action)
      temp_command, temp_position = action.split(" ")

      case temp_command
      when "reveal", "r"
        command = "reveal"
      when "flag", "f"
        command = "flag"
      else
        command = "help"
      end
      position = temp_position.split(",").map(&:to_i)

      [command, position]
    end
  end
end
