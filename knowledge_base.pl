% Knowledge base for ITP-SL (Intelligent Travel Planning - Sri Lanka)
% Facts: cities, attractions, distances (km), modes, best seasons, budgets, avoid_month/region

% Cities: city(Name, Type, Region, Climate).
city(colombo, urban, west, tropical).
city(galle, beach, south, tropical).
city(mirissa, beach, south, tropical).
city(hambantota, beach, south, tropical).
city(kandy, cultural, central, mild).
city(nuwara_eliya, hill_country, central, cool).
city(ella, hill_country, uva, mild).
city(anuradhapura, historical, north_central, dry).
city(sigiriya, historical, north_central, dry).
city(yala, national_park, southeast, tropical).
city(horton_plains, national_park, central, cool).

% Attractions: attraction(City, Attraction).
attraction(kandy, temple_of_tooth).
attraction(nuwara_eliya, tea_plantations).
attraction(mirissa, whale_watching).
attraction(ella, nine_arches_bridge).
attraction(galle, galle_fort).
attraction(anuradhapura, ancient_ruins).
attraction(sigiriya, sigiriya_rock).
attraction(yala, wildlife_safari).
attraction(horton_plains, worlds_end).

% Distances (approx, km) - undirected
distance(colombo, kandy, 115).
distance(kandy, nuwara_eliya, 77).
distance(nuwara_eliya, ella, 60).
distance(colombo, mirissa, 155).
distance(colombo, galle, 119).
distance(galle, mirissa, 36).
distance(ella, yala, 130).
distance(colombo, anuradhapura, 205).
distance(anuradhapura, sigiriya, 22).
distance(kandy, sigiriya, 90).
distance(kandy, horton_plains, 60).

% Travel modes preferred
mode(colombo, kandy, train).
mode(kandy, ella, scenic_train).
mode(kandy, nuwara_eliya, car).
mode(colombo, mirissa, bus).
mode(colombo, galle, train).
mode(galle, mirissa, car).
mode(ella, yala, car).

% Best seasons: winter=Nov-Feb, summer=May-Aug, all_year
best_season(mirissa, winter).
best_season(ella, summer).
best_season(kandy, all_year).
best_season(nuwara_eliya, all_year).
best_season(galle, winter).
best_season(yala, winter).

% Budget indicators
budget(mirissa, moderate).
budget(nuwara_eliya, high).
budget(kandy, moderate).
budget(ella, budget).
budget(colombo, variable).

% Monsoon/avoid rules (simple examples)
avoid_month(mirissa, may).
avoid_region(mirissa, monsoon_southwest).

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

% Recommend trip: season, budget, start, End optional sightseeing list
recommend_trip(Season, Budget, Start, End, Route, TotalDistance) :-
    recommend_by_budget(Dest, Budget),
    best_season(Dest, Season),
    ( Start = StartCity -> true ; Start = colombo ),
    ( End = EndCity -> true ; End = Dest ),
    route(Start, End, Route, TotalDistance).

% Simple scoring example: score increases if city has beach and user likes beach
has_feature(City, beach) :- city(City, beach, _, _).
score(City, Score) :- has_feature(City, beach), Score is 10.
score(City, 5) :- \+ has_feature(City, beach).

% Allow dynamic additions
% Users can assert new facts dynamically using assert/1 in the Prolog REPL.

% Small dataset ready for queries
