% Predicate to sort words in a sentence alphabetically
sort_sentence(Input, Output) :-
    split_string(Input, " ", "", Words),        % Step 1: Tokenize sentence into words
    sort(Words, SortedWords),                   % Step 2: Sort words alphabetically
    atomic_list_concat(SortedWords, ' ', Output). % Step 3: Reconstruct the sentence
