% Define the possible operations on the jugs
move(state(_, Y), fill_4, state(4, Y)).                        % Fill 4-liter jug
move(state(X, _), fill_3, state(X, 3)).                        % Fill 3-liter jug
move(state(_, Y), empty_4, state(0, Y)).                       % Empty 4-liter jug
move(state(X, _), empty_3, state(X, 0)).                       % Empty 3-liter jug

% Pour from 4L to 3L jug
move(state(X, Y), pour_4_3, state(X1, Y1)) :-
    Total is X + Y,
    (   Total >= 3 -> Y1 = 3, X1 is Total - 3
    ;   Y1 is Total, X1 = 0).

% Pour from 3L to 4L jug
move(state(X, Y), pour_3_4, state(X1, Y1)) :-
    Total is X + Y,
    (   Total >= 4 -> X1 = 4, Y1 is Total - 4
    ;   X1 is Total, Y1 = 0).

% BFS Solver
solve(Jug1, Jug2, Goal, Path) :-
    bfs([[state(0, 0)]], Jug1, Jug2, Goal, RevPath),
    reverse(RevPath, Path).

bfs([[state(Goal, _) | Path] | _], _, _, Goal, [state(Goal, _) | Path]).
bfs([[state(_, Goal) | Path] | _], _, _, Goal, [state(_, Goal) | Path]).
bfs([CurrentPath | OtherPaths], Jug1, Jug2, Goal, Solution) :-
    CurrentPath = [CurrentState | _],
    findall([NextState | CurrentPath],
            (move(CurrentState, _, NextState), \+ member(NextState, CurrentPath)),
            NewPaths),
    append(OtherPaths, NewPaths, UpdatedPaths),
    bfs(UpdatedPaths, Jug1, Jug2, Goal, Solution).
