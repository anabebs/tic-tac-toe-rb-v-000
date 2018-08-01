board = [" ", " ", " ", "", " ", " ", " ", "", ""] #empty spaces
# board = ["X", "O", "X", "O", "X", "X", "O", "X", "O"] #draw
# board = ["X", " ", " ", " ", "X", " ", " ", " ", "X"] #diagWIN
# board = [" ", " ", "O", " ", "O", " ", "O", " ", " "] #diag_win
# board = ["X", "O", " ", " ", " ", " ", " ", "O", "X"] #nil no winner


#win combinations constant
WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
]

def display_board(input)
  puts " #{input[0]} | #{input[1]} | #{input[2]} \n-----------\n #{input[3]} | #{input[4]} | #{input[5]} \n-----------\n #{input[6]} | #{input[7]} | #{input[8]} \n"
end

# Define won?, full?, draw?, over?, and winner below
def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    board[combo[0]] == board[combo[1]] &&
    board[combo[1]] == board[combo[2]] &&
    position_taken?(board, combo[0])
  end
end

def full?(board)
  board.all?{|token| token == "X" || token == "O"}
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || full?(board)
end

def winner(board)
  if winning_combo = won?(board)
    board[winning_combo.first]
  end
end


def input_to_index(user_input)
  index = user_input.to_i
  index -= 1
  return index
end

def move(arr, index, val)
  arr[index] = val
  return arr
end

# def position_taken?(board, index)
#   !(board[index].nil? || board[index] == " ")
# end

def position_taken?(arr, index)
  if arr[index] == "X" || arr[index] == "O"
    return true
  else arr[index] == " " || arr[index] == "" || arr[index] == nil
    return false
  end
end

def valid_move?(arr, index)
  if !position_taken?(arr, index) && index.between?(0, 10)
    return true
  else
    return false
  end
end

def turn_count(arr)
  turns_taken = 0
  arr.each_with_index do |x, index|
    if position_taken?(arr, index)
      turns_taken += 1
    end
  end
  return turns_taken
end

def current_player(arr)
  turn_tally = turn_count(arr)

  if turn_tally % 2 == 0
    puts "It is now X's turn"
    return "X"
  else
    puts "It is now O's turn"
    return "O"
  end
end



# ask for input
# get input
# convert input to index
# if move is valid
#   make the move for index and show board
# else
#   ask for input again until you get a valid move
# end

def turn(arr)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)

  if valid_move?(arr, index)
    token = current_player(arr)
    move(arr, index, token)
    display_board(arr)
  else
    while !(valid_move?(arr, index))
      puts "Invalid move! Please enter 1-9:"
      input = gets.strip
      index = input_to_index(input)
    end
  end
end

def play(arr)
  until over?(arr)
      turn(arr)
    end

  if won?(arr)
    win_token = winner(arr)
    puts "Congratulations #{win_token}!"
  elsif draw?(arr)
    puts "Cats Game!"
  end
end


play(board)