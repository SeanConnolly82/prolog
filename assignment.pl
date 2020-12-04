/* Sean Connolly - D20124903 */


flight(london,dublin,aerlingus,500,45,150).
flight(rome,london,ba,1500,150,400).
flight(rome,paris,airfrance,1200,120,500). 
flight(paris,dublin,airfrance,600,60,200).
flight(berlin,moscow,lufthansa,3000,300,900).
flight(paris,amsterdam,airfrance,400,30,100).
flight(berlin,dublin,lufthansa,1200,120,900).
flight(london,newyork,ba,5000,700,1100).
flight(dublin,newyork,aerlingus,4500,360,800).
flight(dublin,cork,ryanair,300,50,50).
flight(dublin,rome,ryanair,2000,150,70).
flight(dublin,chicago,aerlingus,5500,480,890).
flight(amsterdam,hongkong,klm,7000,660,750).
flight(london,hongkong,ba,7500,700,1000).
flight(dublin,amsterdam,ryanair,1000,90,60).
flight(moscow,newyork,aerflot,9000,720,1000).
flight(moscow,hongkong,aerflot,5500,420,500).
flight(newyork,chicago,aa,3000,240,430).
flight(dublin,london,aerlingus,500,45,150).
flight(london,rome,ba,1500,150,400).
flight(paris,rome,airfrance,1200,120,500). 
flight(dublin,paris,airfrance,600,60,200).
flight(moscow,berlin,lufthansa,3000,300,900).
flight(amsterdam,paris,airfrance,400,30,100).
flight(dublin,berlin,lufthansa,1200,120,900).
flight(newyork,london,ba,5000,700,1100).
flight(newyork,dublin,aerlingus,4500,360,800).
flight(cork,dublin,ryanair,300,50,50).
flight(rome,dublin,ryanair,2000,150,70).
flight(chicago,dublin,aerlingus,5500,480,890).
flight(hongkong,amsterdam,klm,7000,660,750).
flight(hongkong,london,ba,7500,700,1000).
flight(amsterdam,dublin,ryanair,1000,90,60).
flight(newyork,moscow,aerflot,9000,720,1000).
flight(hongkong,moscow,aerflot,5500,420,500).
flight(chicago,newyork,aa,3000,240,430).

country(dublin,ireland).
country(cork,ireland).
country(london,uk).
country(rome,italy).
country(moscow,russia).
country(hongkong,china).
country(amsterdam,holland).
country(berlin,germany).
country(paris,france).
country(newyork,usa).
country(chicago,usa).


/* Q1 */
list_airport(X,L):- findall(City, country(City, X), L).

/* Q2 */
trip(X,Y,T):- fly(X,Y,[],T). 
fly(X,Y,V,[X,Y]):- flight(X,Y,_,_,_,_), not(member(Y,V)).
fly(X,Y,V,[X|R]):- flight(X,Z,_,_,_,_), not(member(Z,V)), fly(Z,Y,[X|V],R).

/* Q3 */
all_trip(X,Y,T):- findall(Route, trip(X,Y,Route),T).

/* Q4 */
trip_dist(X,Y,[T,D]):- trip(X,Y,T), flight_dist(T,D).
flight_dist([_|[]],0).
flight_dist([H|[H1|T1]],D):- flight_dist([H1|T1],E1), flight(H,H1,_,E,_,_), D is E + E1.

/* Q5 */
trip_cost(X,Y,[T,C]):- trip(X,Y,T), flight_cost(T,C).
flight_cost([_|[]],0).
flight_cost([H|[H1|T1]],C):- flight_cost([H1|T1],D1), flight(H,H1,_,_,_,D), C is D + D1.

/* Q6 */
trip_change(X,Y,[T,I]):- trip(X,Y,T), flight_changes(T,I).
flight_changes([_|[]],-1).
flight_changes([_|T],D):- flight_changes(T,R), D is R + 1.

/* Q7 */
all_trip_noairline(X,Y,T,A):- findall(Route, no_airline(X,Y,[],Route,A),T).
no_airline(X,Y,V,[X,Y],A):- flight(X,Y,J,_,_,_), not(member(Y,V)), J\=A.
no_airline(X,Y,V,[X|R],A):- flight(X,Z,K,_,_,_), not(member(Z,V)), K\=A, no_airline(Z,Y,[X|V],R,A).

/* Q8 */
cheapest(X,Y,T,C):- findall(Costs, trip_cost(X,Y,Costs),L), find_min(L,T,C).
shortest(X,Y,T,C):- findall(Distances, trip_dist(X,Y,Distances),L), find_min(L,T,C).
fastest(X,Y,T,C):- findall(Times, trip_time(X,Y,Times),L), find_min(L,T,C).

find_min([[H1|T1]|[]],H1,T1).
find_min([[_|T1]|T],R1,R2):- find_min(T,R1,R2), T1 > R2.
find_min([[H1|T1]|T],H1,T1):- find_min(T,_,R2), T1 =< R2.

trip_time(X,Y,[T,D]):- trip(X,Y,T), flight_time(T,D).
flight_time([_|[]],0).
flight_time([H|[H1|T1]],D):- flight_time([H1|T1],E1), flight(H,H1,_,_,E,_), D is E + E1.

/* Q9 */
trip_to_nation(X,Y,T):- list_airport(Y,L), connections(X,L,T).
connections(X,[A|_],T):- trip(X,A,T).
connections(X,[_|B],T):- connections(X,B,T).

/* Q10 */
all_trip_to_nation(X,Y,T):- findall(Trips, trip_to_nation(X,Y,Trips),T).

    
/*** PART 2 ***/ 

/* Q1 */
print_status([]).
print_status([H|T]):- write(' | '), print_list(H), nl, print_status(T).
print_list([]).
print_list([H|T]):- write(H), write(' | '), print_list(T).

/* Q2 */
high([A|_],X,H):- level(A,X,H).
high([_|B],X,H):- high(B,X,H).

/* Q3 */
all_same_height([],_,[]).
all_same_height([H|_],X,[]):- len_list(H,Z), Z =< X.
all_same_height([H|T],X,[L|R]):- level(H,L,X), all_same_height(T,X,R).

/* Q4 */
same_height(B,X,Y):- high(B,X,I), high(B,Y,J), I=J.

len_list([],0).
len_list([_|T],R):- len_list(T,R1) , R is R1 + 1.

level([H|_],X,0):- H = X.
level([_|T],X,Y):- level(T,X,R), Y is R + 1.

/* Q5 */
moveblock(L,X,Y,Z):- 
    write('Before'), nl, nl, print_status(L), nl,
    remove_by_stack(L,[X|_],Y,Z,Removed,_),
    add_by_stack(Removed,X,Y,Z,Output,_),
    write('After'), nl, nl, print_status(Output).


remove_by_stack(L,X,Y,_,A,D):- Y=D, loop_and_remove_from_top(L,X,_,_,A,D).
add_by_stack(L,X,_,Z,A,D):- Z=D, loop_and_add_to_top(L,X,_,_,A,D).

loop_and_remove_from_top([[]|T],[],_,_,[[]|T],1).
loop_and_remove_from_top([H|T],[X],_,_,[R|T],1):- remove_from_top(H,R,X).
loop_and_remove_from_top([H|T],X,_,_,[H|R1],D):- loop_and_remove_from_top(T,X,_,_,R1,R2), D is R2+1.

remove_from_top([],[],_).
remove_from_top(L,R,X):- reverse(L,[A|B]), A=X, reverse(B,R).

loop_and_add_to_top([[]|T],X,_,_,[[X]|T],1).
loop_and_add_to_top([H|T],X,_,_,[R|T],1):- reverse(H,[A|_]), A\=X, append(H,[X],R).
loop_and_add_to_top([H|T],X,_,_,[H|R1],D):- loop_and_add_to_top(T,X,_,_,R1,R2), D is R2+1.



/*
    The methodology I have used is:
	
    1. Basecase is if the blocks match the required order;
    2. Move stack 1 to 3;
    3. Move stack 2 to 3;
    4. Move blocks from stack 3 to stack 1 if they match the required stack 1, otherwise move to stack 2;
    5. Move stack 3 to stack 2;
    6. Move stack 2 to stack 1;
    7. Move blocks from stack 1 to stack 2 if they match the required stack 2, otherwise move to stack 3;
    8. Move stack 1 to 3;
    9. Move stack 2 to 3;
    10. Move blocks from stack 3 to stack 1 if they match the required stack 1, otherwise move to stack 2;
    11. Go to step 1 and repeat.

    I have successfully tested on the following scenarios:

    Input:  [[b,c,f],[a,d,g],[h,e]]
    Order:  [[a,b,c],[d,e,f],[g,h]]

    Input:  [[b,c,f],[a,d,g],[h,e]]
    Order:  [[a,d,f],[e,h,b],[c,g]]

    Input:  [[b,c,f],[a,d,g],[h,e]]
    Order:  [[f,a,b],[c,d,g],[e,h]]

*/

order_blocks(B,B_Order,0):- 
    B=B_Order.
order_blocks(B,B_Order,N):-    
    move_all_to_three(B,R,D1),
    re_order_stack(R,B_Order,1,2,3,A,D2),
    move_stack(A,_,3,2,Z1,D3),
    move_stack(Z1,_,2,1,Z2,D4),
    re_order_stack(Z2,B_Order,2,3,1,Z3,D5),
    move_all_to_three(Z3,Z4,D6),
    re_order_stack(Z4,B_Order,1,2,3,Out,D7),
    order_blocks(Out,B_Order,All), N is All+D1+D2+D3+D4+D5+D6+D7.

move_stack(L,_,Y,_,L,0):- nth1(Y,L,Stack), Stack=[].
move_stack(L,_,Y,Z,Final,D):-
    order_blocks_remove_by_stack(L,[X|_],Y,_,Removed,_),
    order_blocks_add_by_stack(Removed,X,_,Z,Output,_),
    move_stack(Output,_,Y,Z,Final,R),D is R+1.

move_all_to_three(L,B,D):- 
    move_stack(L,_,1,3,A,R),
    move_stack(A,_,2,3,B,R1),
    D is R+R1.

re_order_stack(R,L,X,_,_,R,0):- 
    nth1(X,L,[]).
re_order_stack(L,_,_,_,Z,L,0):- 
    nth1(Z,L,[]).
re_order_stack(L,B,X,Y,Z,Result,D):- 
    nth1(X,B,[First|_]),
    nth1(Z,L,S3),
    reverse(S3,[M|_]),
    M=First,
    order_blocks_remove_by_stack(L,[M],Z,_,Removed,_),
    remove_item_loop(B,First,B_Update),
    order_blocks_add_by_stack(Removed,First,_,X,Added,_),
    re_order_stack(Added,B_Update,X,Y,Z,Result,R1), D is R1+1.
re_order_stack(L,B,X,Y,Z,Result,D):- 
    nth1(X,B,[First|_]),
    nth1(Z,L,S3),
    reverse(S3,[M|_]),
    M\=First,
    order_blocks_remove_by_stack(L,[M],Z,_,Removed,_),
    order_blocks_add_by_stack(Removed,M,_,Y,Added,_),
    re_order_stack(Added,B,X,Y,Z,Result,R1), D is R1+1.
 
remove_item_loop([],_,[]).
remove_item_loop([H|T],I,[R|R1]):- remove_item(H,I,R), remove_item_loop(T,I,R1).

remove_item([],_,[]).
remove_item([H|T],I,T):- H=I.
remove_item([H|T],I,[H|R1]):- H\=I, remove_item(T,I,R1).

order_blocks_remove_by_stack(L,X,Y,_,A,D):- Y=D, 
    order_blocks_loop_and_remove_from_top(L,X,_,_,A,D),
    write('Moved '), write(X), write(' from Stack '), write(Y).

order_blocks_add_by_stack(L,X,_,Z,A,D):- Z=D, 
    order_blocks_loop_and_add_to_top(L,X,_,_,A,D),
    write(' to Stack '), write(Z), nl, nl,
   	order_blocks_print_status(A), nl.

order_blocks_loop_and_remove_from_top([[]|T],[],_,_,[[]|T],1).
order_blocks_loop_and_remove_from_top([H|T],[X],_,_,[R|T],1):- order_blocks_remove_from_top(H,R,X).
order_blocks_loop_and_remove_from_top([H|T],X,_,_,[H|R1],D):- order_blocks_loop_and_remove_from_top(T,X,_,_,R1,R2), D is R2+1.

order_blocks_remove_from_top([],[],_).
order_blocks_remove_from_top(L,R,X):- reverse(L,[A|B]), A=X, reverse(B,R).

order_blocks_loop_and_add_to_top([[]|T],X,_,_,[[X]|T],1).
order_blocks_loop_and_add_to_top([H|T],X,_,_,[R|T],1):- reverse(H,[A|_]), A\=X, append(H,[X],R).
order_blocks_loop_and_add_to_top([H|T],X,_,_,[H|R1],D):- order_blocks_loop_and_add_to_top(T,X,_,_,R1,R2), D is R2+1.

order_blocks_print_status([]).
order_blocks_print_status([H|T]):- write(' | '), order_blocks_print_list(H), nl, order_blocks_print_status(T).
order_blocks_print_list([]).
order_blocks_print_list([H|T]):- write(H), write(' | '), order_blocks_print_list(T).

order_blocks_len_list([],0).
order_blocks_len_list([_|T],R):- order_blocks_len_list(T,R1), R is R1 + 1.



