% Define word categories
noun(dog).
noun(cat).
noun(boy).
noun(girl).
noun(apple).

verb(eats).
verb(runs).
verb(jumps).
verb(plays).

adjective(quick).
adjective(lazy).
adjective(happy).
adjective(smart).

% Rule to assign POS tags based on predefined categories
pos_tag(Word, 'Noun') :- noun(Word), !.
pos_tag(Word, 'Verb') :- verb(Word), !.
pos_tag(Word, 'Adjective') :- adjective(Word), !.
pos_tag(_, 'Unknown').

% Rule to process a sentence and tag each word
sentence_pos_tags([], []).
sentence_pos_tags([Word|Rest], [(Word, Tag)|TaggedRest]) :-
    pos_tag(Word, Tag),
    sentence_pos_tags(Rest, TaggedRest).
