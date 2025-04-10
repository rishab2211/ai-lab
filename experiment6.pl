% Predicate to remove punctuation from a string
remove_punctuation(Input, Output) :-
    string_chars(Input, Chars),
    exclude(is_punctuation, Chars, CleanChars),
    string_chars(Output, CleanChars).

% Helper predicate to check if a character is a punctuation mark
is_punctuation(Char) :-
    member(Char, ['.', ',', '!', '?', ';', ':', '-', '"', '''']).
