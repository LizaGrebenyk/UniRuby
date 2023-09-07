# Зробити невелику скрипт гру "камень ножиці папір".
# На вхід передаємо предмет у вигляді аргументу командного рядка
# На виході результат
#
# EX:
# input --> ruby game.rb Stone Paper
# output --> You lose

$choices=["Rock","Paper","Scissors"]
$win_comb=[["Rock","Scissors"],
          ["Paper","Rock"],
          ["Scissors","Paper"]]

def rock_paper_scissors()
  if ARGV.length != 2
    puts "Game needs only 2 values"
    exit
  else
    player1 = ARGV[0]
    player2 = ARGV[1]
  end

  check_choices(player1,player2)
  game_result(player1,player2)
end

private def check_choices(choice1,choice2)
  if !$choices.include?(choice1) || !$choices.include?(choice2)
    puts "Invalid values, options only include Rock, Paper or Scissors"
    exit
  end
end

private def game_result(player1,player2)
  if player1==player2
    puts "Tie"
  elsif $win_comb.include?([player1,player2])
    puts "You win"
  else
    puts "You lost"
  end
end

rock_paper_scissors()