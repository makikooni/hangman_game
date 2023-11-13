import random
import string 
from words import words 

# import words
def get_valid_word(words):
    word = random.choice(words)
    while '-' in word or ' ' in word:
        word = random.choice(words)
    return word.upper()

def play_again():
    user_agreement = input("Would you like to play again? Y/N ").upper()
    if user_agreement == 'Y' or user_agreement == 'YES':
        hangman()
    else:
        print("Okay! Bye!")
        
def hangman():
    word = get_valid_word(words)
    word_letters = set(word)
    alphabet = set(string.ascii_uppercase)
    used_letters = set()
    user_lives = 5
    print(f'Your word has {len(word_letters)} letters.')
    
    #getting user input
    while user_lives > 0 and word_letters: 
        user_letter = input("Guess a letter: ").upper()
        if user_letter in alphabet - used_letters:
            used_letters.add(user_letter)
            if user_letter in word_letters:
                word_letters.remove(user_letter)
                print("Good guess!")
                print(f'Your word: ')
                print(f'Your used letters: {used_letters}')
            else:
                user_lives -= 1
                print(f'Your letter {user_letter} is not in the word.\nYou lost one life. You have {user_lives} lives remaining.\nYour used letters: {used_letters}')
                if user_lives <= 0:
                    print("Game over. You lost all your lives.")
                    play_again()
        else:
            print(f'You cannot reuse the same letter.\nYour used letters: {used_letters}') 

   
        
hangman()