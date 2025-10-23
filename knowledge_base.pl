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
city(jaffna, urban, north, dry).
city(trincomalee, beach, east, tropical).
city(arugam_bay, beach, east, tropical).
city(polonnaruwa, historical, north_central, dry).
city(dambulla, historical, central, dry).
city(bentota, beach, west, tropical).
city(negombo, beach, west, tropical).
city(matara, urban, south, tropical).
city(badulla, hill_country, uva, mild).

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
attraction(jaffna, nallur_kandaswamy_temple).
attraction(trincomalee, pigeon_island).
attraction(arugam_bay, surfing).
attraction(polonnaruwa, gal_vihara).
attraction(dambulla, golden_temple).
attraction(bentota, water_sports).
attraction(negombo, fish_market).
attraction(matara, star_fort).
attraction(badulla, demodara_loop).

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
distance(mirissa, matara, 12).
distance(matara, hambantota, 80).
distance(hambantota, yala, 60).
distance(colombo, negombo, 34).
distance(negombo, kandy, 100).
distance(kandy, dambulla, 72).
distance(dambulla, sigiriya, 17).
distance(sigiriya, polonnaruwa, 60).
distance(polonnaruwa, trincomalee, 107).
distance(kandy, badulla, 137).
distance(badulla, ella, 28).
distance(trincomalee, anuradhapura, 110).
distance(anuradhapura, jaffna, 200).
distance(arugam_bay, yala, 160).
distance(arugam_bay, ella, 165).
distance(bentota, galle, 56).
distance(bentota, colombo, 65).

% Travel modes preferred
mode(colombo, kandy, train).
mode(kandy, ella, scenic_train).
mode(kandy, nuwara_eliya, car).
mode(colombo, mirissa, bus).
mode(colombo, galle, train).
mode(galle, mirissa, car).
mode(ella, yala, car).
mode(colombo, negombo, car).
mode(negombo, kandy, car).
mode(kandy, badulla, scenic_train).
mode(bentota, galle, train).
mode(sigiriya, polonnaruwa, car).
mode(polonnaruwa, trincomalee, bus).

% Best seasons: winter=Nov-Feb, summer=May-Aug, all_year
best_season(mirissa, winter).
best_season(ella, summer).
best_season(kandy, all_year).
best_season(nuwara_eliya, all_year).
best_season(galle, winter).
best_season(yala, winter).
best_season(arugam_bay, summer).
best_season(trincomalee, summer).
best_season(jaffna, summer).
best_season(negombo, all_year).
best_season(bentota, winter).
best_season(anuradhapura, all_year).
best_season(sigiriya, all_year).
best_season(polonnaruwa, all_year).
best_season(dambulla, all_year).
best_season(horton_plains, all_year).
best_season(matara, winter).
best_season(badulla, summer).

% Budget indicators
budget(mirissa, moderate).
budget(nuwara_eliya, high).
budget(kandy, moderate).
budget(ella, budget).
budget(colombo, variable).
budget(galle, moderate).
budget(negombo, budget).
budget(bentota, moderate).
budget(anuradhapura, budget).
budget(sigiriya, moderate).
budget(polonnaruwa, budget).
budget(dambulla, budget).
budget(trincomalee, moderate).
budget(jaffna, moderate).
budget(arugam_bay, budget).
budget(matara, budget).
budget(badulla, budget).

% Monsoon/avoid rules (simple examples)
avoid_month(mirissa, may).
avoid_region(mirissa, monsoon_southwest).
% Southwest monsoon: May-Sep affects west/south; Northeast: Nov-Feb affects north/east
avoid_month_region(west, may).
avoid_month_region(west, jun).
avoid_month_region(west, jul).
avoid_month_region(west, aug).
avoid_month_region(west, sep).
avoid_month_region(south, may).
avoid_month_region(south, jun).
avoid_month_region(south, jul).
avoid_month_region(south, aug).
avoid_month_region(south, sep).
avoid_month_region(east, nov).
avoid_month_region(east, dec).
avoid_month_region(east, jan).
avoid_month_region(east, feb).
avoid_month_region(north, nov).
avoid_month_region(north, dec).
avoid_month_region(north, jan).
avoid_month_region(north, feb).

% City coordinates (lat, lon)
city_coord(colombo, 6.9271, 79.8612).
city_coord(galle, 6.0535, 80.2210).
city_coord(mirissa, 5.9485, 80.4719).
city_coord(hambantota, 6.1246, 81.1210).
city_coord(kandy, 7.2906, 80.6337).
city_coord(nuwara_eliya, 6.9497, 80.7891).
city_coord(ella, 6.8755, 81.0460).
city_coord(anuradhapura, 8.3114, 80.4037).
city_coord(sigiriya, 7.9570, 80.7603).
city_coord(yala, 6.3667, 81.5167).
city_coord(horton_plains, 6.8020, 80.7998).
city_coord(jaffna, 9.6615, 80.0255).
city_coord(trincomalee, 8.5874, 81.2152).
city_coord(arugam_bay, 6.8390, 81.8386).
city_coord(polonnaruwa, 7.9396, 81.0003).
city_coord(dambulla, 7.8568, 80.6490).
city_coord(bentota, 6.4210, 80.0011).
city_coord(negombo, 7.2083, 79.8358).
city_coord(matara, 5.9549, 80.5550).
city_coord(badulla, 6.9897, 81.0550).

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
