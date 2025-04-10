% ---------------------------
% HANGMAN GAME IN PROLOG
% ---------------------------

% Entry point to start the game
start_game :-
    Word = ['p', 'r', 'o', 'l', 'o', 'g'],       % Hidden word
    length(Word, L),
    create_blanks(L, Blanks),                   % Create initial blanks
    play(Word, Blanks, 6).                      % Start game with 6 attempts

% Create list of underscores as blanks
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
    ; write('💀 Game Over! The word was: '), write_word(Word), nl
    ).

% Update blanks if guessed letter is correct
update_blanks([], [], _, []).
update_blanks([H|T], [_|BT], H, [H|NewBT]) :- update_blanks(T, BT, H, NewBT).
update_blanks([H|T], [B|BT], L, [B|NewBT]) :- H \= L, update_blanks(T, BT, L, NewBT).

% Utility to print a list of characters with spaces
write_word([]).
write_word([H|T]) :-
    write(H), write(' '),
    write_word(T).
