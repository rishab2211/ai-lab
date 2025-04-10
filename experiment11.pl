% Define stop words
stop_word(the).
stop_word(is).
stop_word(and).
stop_word(of).
stop_word(a).
stop_word(to).
stop_word(in).

% Remove stop words from a list
remove_stop_words([], []).
remove_stop_words([H|T], Result) :-
    stop_word(H), !,
    remove_stop_words(T, Result).
remove_stop_words([H|T], [H|Result]) :-
    remove_stop_words(T, Result).

% Read from file and process text
process_file(InputFile, Output) :-
    open(InputFile, read, Stream),
    read_string(Stream, _, String),
    close(Stream),
    split_string(String, " ", "", WordList),
    maplist(atom_string, WordAtoms, WordList),
    remove_stop_words(WordAtoms, FilteredWords),
    Output = FilteredWords,
    write('Filtered Text: '), write(Output), nl.
