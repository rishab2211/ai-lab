% Define simple stemming rules
stem(Word, Stem) :-
    atom(Word),
    atom_concat(Root, 'ing', Word), !,
    Stem = Root.

stem(Word, Stem) :-
    atom(Word),
    atom_concat(Root, 'ed', Word), !,
    Stem = Root.

stem(Word, Stem) :-
    atom(Word),
    atom_concat(Root, 's', Word), !,
    Stem = Root.

% If no rule matches, the word remains unchanged
stem(Word, Word).

% Apply stemming to each word in the list (sentence)
stem_sentence([], []).
stem_sentence([Word|Rest], [StemmedWord|StemmedRest]) :-
    stem(Word, StemmedWord),
    stem_sentence(Rest, StemmedRest).
