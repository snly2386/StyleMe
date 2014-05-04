# require 'spec_helper'

# describe 'Gameplay' do
#   let(:game) { RabbitDice.db.create_game :players => ['Alice', 'Bob', 'Carl'] }

#   def rig_dice(*dice_results)
#     RabbitDice::Roll.any_instance.stub(:roll_die).and_return(*dice_results)
#   end

#   def play_move(move)
#     result = RabbitDice::PlayMove.run(:game_id => game.id, :move => move)
#     result.game
#   end

#   def count_die_color(dice_cup, die_color)
#     dice_cup.instance_variable_get(:@dice).select {|color| color == die_color }.count
#   end

#   before do
#     game.turns.first.player = 'Alice'
#   end

#   xit "removes dice from the dice cup after multiple plays" do
#     # In order for the dice count to reduce by 3 every time,
#     # we need to ensure there are no paws (runners)
#     rig_dice('meat')

#     expect(game.dice_cup.dice_count).to eq 13
#     game = play_move('roll_dice')
#     expect(game.dice_cup.dice_count).to eq 10
#     game = play_move('roll_dice')
#     expect(game.dice_cup.dice_count).to eq 7
#   end

#   xit "creates a roll with the correct dice" do
#     rig_dice('meat')

#     expect(game.dice_cup.dice_count).to eq 13
#     game = play_move('roll_dice')
#     expect(game.dice_cup.dice_count).to eq 10

#     roll = game.turns.last.rolls.last
#     expect(roll.results.first).to be_a RabbitDice::Die
#     expect(roll.results.map &:type).to eq ['meat', 'meat', 'meat']
#   end

#   xit "calculates score" do
#     rig_dice('meat')

#     play_move('roll_dice')
#     game = play_move('roll_dice')
#     expect(game.score_for 'Alice').to eq(6)
#     expect(game.score_for 'Bob').to eq(0)
#     expect(game.score_for 'Carl').to eq(0)
#   end

#   describe 'Overblasting' do

#     before do
#       # First give them some points
#       rig_dice('meat')
#       game = play_move('roll_dice')
#       expect(game.score_for 'Alice').to eq(3)

#       # Now really give it to 'em!
#       rig_dice('blast')
#       game = play_move('roll_dice')
#     end

#     xit "does not score when the player rolls three blasts" do
#       expect(game.score_for 'Alice').to eq(0)
#     end

#     xit "creates the next player's turn when the current player rolls three blasts" do
#       expect(game.turns.count).to eq(2)
#       expect(game.turns.last.player).to eq 'Bob'
#     end
#   end

#   xit "ends the turn if the current player chooses to do so" do
#     # First give them some points
#     rig_dice('meat')
#     game = play_move('roll_dice')
#     expect(game.current_player).to eq 'Alice'
#     expect(game.score_for 'Alice').to eq(3)

#     # Now end the turn
#     game = play_move('stop')
#     expect(game.turns.count).to eq(2)
#     expect(game.current_player).to eq 'Bob'

#     # Double check score
#     expect(game.score_for 'Alice').to eq(3)
#     expect(game.turns.first.score).to eq(3)
#   end

#   xit "declares a winner once someone gets 13 meat" do
#     # To make things interesting, let's pass the turn to Carl
#     2.times { play_move('stop') }

#     # Win that game
#     rig_dice('meat')
#     # 3meat x 4 = 12meat
#     4.times { play_move('roll_dice') }
#     # 12 + 3 = 15
#     game = play_move('roll_dice')
#     expect(game.winner).to eq 'Carl'
#   end

#   xit "ends the turn when there are no more dice left to draw" do
#     rig_dice('meat')
#     # 3meat x 4 = 12meat
#     4.times { play_move('roll_dice') }
#     expect(game.current_player).to eq 'Alice'
#     expect(game.dice_cup.dice_count).to eq 1

#     # Avoid three blasts to avoid (wrongly) ending the turn by death
#     # Wrongly because there should only be one die rolled
#     rig_dice('blast', 'blast', 'paws')
#     turn = game.turns.last
#     game = play_move('roll_dice')
#     expect(game.current_player).to eq 'Bob'
#     expect(game.dice_cup.dice_count).to eq 13
#   end

#   xit "subtracts less dice from the cup when there are paws (runners)" do
#     rig_dice('paws')
#     game = play_move('roll_dice')

#     expect(game.dice_cup.dice_count).to eq 10

#     game = play_move('roll_dice')
#     # Since all three dice were runners, we shouldn't need to draw more dice
#     expect(game.dice_cup.dice_count).to eq 10

#     # Modify the last roll results to contain 2 paws instead of 3
#     die = game.turns.last.rolls.last.results.last
#     die.type = 'meat'

#     game = play_move('roll_dice')
#     expect(game.dice_cup.dice_count).to eq 9
#   end
# end
