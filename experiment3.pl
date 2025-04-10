% Predicate to convert Celsius to Fahrenheit
c_to_f(C, F) :- F is (C * 9 / 5) + 32.

% Predicate to check if temperature is below freezing
below_freezing(C) :- C < 0.
