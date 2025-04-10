% Initialize the empty board
initial_board([['_', '_', '_'], ['_', '_', '_'], ['_', '_', '_']]).

% Display the board
display_board([Row1, Row2, Row3]) :-
    writeln(Row1),
    writeln(Row2),
    writeln(Row3),
    nl.

% Check if a player has won
win(Player, Board) :- row_win(Player, Board).
win(Player, Board) :- column_win(Player, Board).
win(Player, Board) :- diagonal_win(Player, Board).

% Row win condition
row_win(Player, [Row|_]) :- all_same(Player, Row).
row_win(Player, [_|Rest]) :- row_win(Player, Rest).

% Column win condition using transpose
column_win(Player, Board) :-
    transpose(Board, Transposed),
    row_win(Player, Transposed).

% Diagonal win condition
diagonal_win(Player, [[P, _, _], [_, P, _], [_, _, P]]) :- P \= '_', Player = P.
diagonal_win(Player, [[_, _, P], [_, P, _], [P, _, _]]) :- P \= '_', Player = P.

% Transpose matrix
transpose([[A, B, C], [D, E, F], [G, H, I]],
          [[A, D, G], [B, E, H], [C, F, I]]).

% Check if all elements in a list are the same
all_same(_, []).
all_same(X, [X|Xs]) :- all_same(X, Xs).

% Check if the board is full
board_full(Board) :-
    flatten(Board, Flat),
    \+ member('_', Flat).

% Make a move if the cell is empty
make_move(Player, Row, Col, Board, NewBoard) :-
    nth0(Row, Board, OldRow),
    nth0(Col, OldRow, '_'), % Only allow if empty
    replace(Row, Col, Player, Board, NewBoard).

% Replace element at (Row, Col)
replace(0, Col, Player, [Row|Rest], [NewRow|Rest]) :-
    replace_col(Col, Player, Row, NewRow).
replace(RowIndex, Col, Player, [Row|Rest], [Row|NewRest]) :-
    RowIndex > 0,
    RowIndex1 is RowIndex - 1,
    replace(RowIndex1, Col, Player, Rest, NewRest).

replace_col(0, Player, [_|Rest], [Player|Rest]).
replace_col(Col, Player, [X|Rest], [X|NewRest]) :-
    Col > 0,
    Col1 is Col - 1,
    replace_col(Col1, Player, Rest, NewRest).

% Switch player
switch_player('X', 'O').
switch_player('O', 'X').

% Game loop
play :-
    initial_board(Board),
    play_game(Board, 'X').

play_game(Board, Player) :-
    display_board(Board),
    ( win('X', Board) -> writeln('X wins!'), ! ;
      win('O', Board) -> writeln('O wins!'), ! ;
      board_full(Board) -> writeln('It\'s a draw!'), ! ;
      format("~w's turn. Enter row (0-2) and column (0-2):~n", [Player]),
      read(Row), read(Col),
      ( make_move(Player, Row, Col, Board, NewBoard) ->
            switch_player(Player, NextPlayer),
            play_game(NewBoard, NextPlayer)
      ; writeln('Invalid move, try again.'), play_game(Board, Player) )
    ).
