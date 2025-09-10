import 'dart:math';
import 'dart:io';
import 'listWord.dart';

void main() {
  // ambil kata random dari daftar kata
  List<String> listWord = WordList.words;
  var random = Random();
  var randomWord = listWord[random.nextInt(listWord.length)].toLowerCase();

  List<String> letterGuess = [];
  List<String> wrongGuesses = [];
  int lives = 6;

  // isi letterGuess dengan "_"
  for (int i = 0; i < randomWord.length; i++) {
    letterGuess.add("_");
  }

  print("Welcome to Hangman, let's start playing!");
  print(letterGuess.join(" "));

  // Game loop
  while (letterGuess.join("") != randomWord && lives > 0) {
    stdout.write("Guess a letter: ");
    String? userInput = stdin.readLineSync();

    if (userInput == null || userInput.isEmpty) {
      print("Please enter a letter.");
      continue;
    }

    if (userInput.length > 1) {
      print("One letter at a time please, try again.");
      continue;
    }

    userInput = userInput.toLowerCase();

    if (letterGuess.contains(userInput) || wrongGuesses.contains(userInput)) {
      print("You already chose this letter. Try another one.");
      continue;
    }

    if (randomWord.contains(userInput)) {
      for (int i = 0; i < randomWord.length; i++) {
        if (randomWord[i] == userInput) {
          letterGuess[i] = userInput;
        }
      }
      print("Good guess!");
    } else {
      lives--;
      wrongGuesses.add(userInput);
      print("Wrong guess! You have $lives lives left.");
    }

    print(letterGuess.join(" "));

    if lives > 0 {
      print("Well done, the word was $randomWord");
    }; else {
      print("No more lives. You lost");
    }
  }
}