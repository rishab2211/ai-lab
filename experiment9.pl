% Hangman game in Prolog

% Start the game
start_game :-
    Word = ['p', 'r', 'o', 'l', 'o', 'g'],
    length(Word, L),
    create_blanks(L, Blanks),
    play(Word, Blanks, 6).

% Create blanks for the hidden word
create_blanks(0, []).
create_blanks(N, ['_'|T]) :-
    N > 0,
    N1 is N - 1,
    create_blanks(N1, T).

% Game loop
play(Word, Blanks, Attempts) :-
    ( Blanks == Word ->
        write('Congratulations! You guessed the word: '), write_word(Word), nl
    ; Attempts > 0 ->
        write('Current state: '), write_word(Blanks), nl,
        write('Attempts left: '), write(Attempts), nl,
        write('Enter a letter: '),
        read(Letter),
        ( member(Letter, Word) ->
            update_blanks(Word, Blanks, Letter, NewBlanks),
            play(Word, NewBlanks, Attempts)
        ; NewAttempts is Attempts - 1,
          write('Wrong guess!'), nl,
          play(Word, Blanks, NewAttempts)
        )
    ; write('Game Over! The word was: '), write_word(Word), nl
    ).

% Update revealed word with correctly guessed letter
update_blanks([], [], _, []).
update_blanks([H|T], [_|BT], H, [H|NewBT]) :- update_blanks(T, BT, H, NewBT).
update_blanks([H|T], [B|BT], L, [B|NewBT]) :- H \= L, update_blanks(T, BT, L, NewBT).

% Utility to write list of characters with spaces
write_word([]).
write_word([H|T]) :-
    write(H), write(' '),
    write_word(T).
