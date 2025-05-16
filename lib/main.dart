import 'dart:io';

void main() {
  print('play Tic Tac Toe and have fun!');
  bool play = true;
  while (play) {
    //choose players symbols x or o
    List<String> players = chooseSymbols();
    //start the game with selected symbols
    playGame(players[0], players[1]);
    //Question if the player wants to play Again
    play = PlayAgain();
  }
}

// function that allows the first player to choose x or o
List<String> chooseSymbols() {
  while (true) {
    stdout.write('Do you want to be X or O: ');
    String? input = stdin.readLineSync()?.toLowerCase();
    if (input == 'x') return ['X', 'O'];
    if (input == 'o') return ['O', 'X'];
  }
}

//play the game function and start playing
void playGame(String players1, String players2) {
  List<String> board = List.generate(9, (index) => (index + 1).toString());
  String player = players1;
  bool gameOver = false;
  while (!gameOver) {
    printGame(board);
    int move = PlayerMove(player, board);
    //put the plasyer symbol in the required field
    board[move - 1] = player;
    if (checkWin(board, player)) {
      printGame(board);
      print('Player $player wins!');
      gameOver = true;
    } else if (checkDraw(board)) {
      printGame(board);
      print('The Player is Draw');
      gameOver = true;
    } else {
      //player switch
      player = player == players1 ? players2 : players1;
    }
  }
}

// current board printing function
void printGame(List<String> board) {
  print('${board[0]} | ${board[1]} |${board[2]}');
  print('--|---|--');
  print('${board[3]} | ${board[4]} |${board[5]}');
  print('--|---|--');
  print('${board[6]} | ${board[7]} |${board[8]}');
}

//function of obtaining and validating the players movement
int PlayerMove(String player, List<String> board) {
  while (true) {
    stdout.write('Player $player,Enter your move(1-9):  ');
    String? input = stdin.readLineSync();
    if (input == null || input.isEmpty) {
      print('Enter a number Between 1 and 9');
      continue;
    }
    int? move = int.tryParse(input);
    if (move == null || move < 1 || move > 9) {
      print('Enter a valid number Between 1 and 9');
      continue;
    }
    if (board[move - 1] == 'X' || board[move - 1] == 'O') {
      print('The Position is already taken , Choose another one');
      continue;
    }
    return move;
  }
}

// winner verification function after every move
bool checkWin(List<String> board, String player) {
  //checking the rows
  for (int i = 0; i < 9; i += 3) {
    if (board[i] == player &&
        board[i + 1] == player &&
        board[i + 2] == player) {
      return true;
    }
  }
  //checking the columns
  for (int i = 0; i < 3; i++) {
    if (board[i] == player &&
        board[i + 3] == player &&
        board[i + 6] == player) {
      return true;
    }
  }
  //checking the main diagonals
  if (board[0] == player && board[4] == player && board[8] == player) {
    return true;
  }
  if (board[2] == player && board[4] == player && board[6] == player) {
    return true;
  }
  return false;
}

bool checkDraw(List<String> board) {
  for (String index in board) {
    if (index != 'X' && index != 'O') {
      return false;
    }
  }
  return true;
}

//function asks the player if he wants to play Again
bool PlayAgain() {
  while (true) {
    print('Do you Want to play again? (yes/No): ');
    String? input = stdin.readLineSync()?.toLowerCase();
    if (input == 'yes') {
      return true;
    } else if (input == 'no') {
      return false;
    } else {
      print('Enter "yes" or "No"');
    }
  }
}
