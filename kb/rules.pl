% Helper: undirected distance/mode
connected(A,B,D) :- distance(A,B,D).
connected(A,B,D) :- distance(B,A,D).
mode_pref(A,B,M) :- mode(A,B,M).
mode_pref(A,B,M) :- mode(B,A,M).

% Recommend by season
recommend(D, Season) :- city(D, _, _, _), best_season(D, Season).

% Budget recommendation
recommend_by_budget(D, Budget) :- budget(D, Budget).

% Attraction query passthrough
has_attraction(C, A) :- attraction(C, A).

% Route finder: path and total distance (DFS)
route(X, Y, Path, Distance) :- travel(X, Y, [X], Q, Distance), reverse(Q, Path).

travel(X, Y, Visited, [Y|Visited], D) :- connected(X, Y, D).
travel(X, Y, Visited, Path, D) :- connected(X, Z, D1), Z \== Y, \+ member(Z, Visited), travel(Z, Y, [Z|Visited], Path, D2), D is D1 + D2.

% Recommend trip: season, budget, start, end (defaults if variables are unbound)
recommend_trip(Season, Budget, Start, End, Route, TotalDistance) :-
    recommend_by_budget(Dest, Budget),
    best_season(Dest, Season),
    ( var(Start) -> S = colombo ; S = Start ),
    ( var(End) -> E = Dest ; E = End ),
    route(S, E, Route, TotalDistance).

% Simple scoring example
has_feature(City, beach) :- city(City, beach, _, _).
score(City, Score) :- has_feature(City, beach), Score is 10.
score(City, 5) :- \+ has_feature(City, beach).
