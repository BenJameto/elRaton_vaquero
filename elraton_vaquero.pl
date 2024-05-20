% Definición de un tablero (ejemplo)
board([
    [empty, cheese(venom), empty],
    [empty, cheese(rum), empty],
    [exit, empty, cheese(rum)]
]).

% Regla para mover el ratón
move(Mouse, Board, NewMouse) :-
    Mouse = mouse(X, Y, Direction, Sober),
    move_direction(X, Y, Direction, NewX, NewY),
    within_bounds(NewX, NewY, Board),
    handle_position(NewX, NewY, Sober, Board, NewMouse).

% Regla para manejar la posición del ratón
handle_position(X, Y, Sober, Board, NewMouse) :-
    get_position(X, Y, Board, Position),
    ( Position = exit -> NewMouse = mouse(X, Y, none, Sober);
      Position = cheese(Type) -> handle_cheese(Type, Sober, X, Y, NewMouse)
    ).

% Regla para manejar el tipo de queso
handle_cheese(venom, sober, X, Y, mouse(X, Y, dead, sober)) :- !.
handle_cheese(rum, sober, X, Y, mouse(X, Y, random, drunk)) :- !.
handle_cheese(_, sober, X, Y, mouse(X, Y, Direction, sober)) :- !.

% Reglas auxiliares
move_direction(X, Y, north, X, Y1) :- Y1 is Y - 1.
move_direction(X, Y, south, X, Y1) :- Y1 is Y + 1.
move_direction(X, Y, east, X1, Y) :- X1 is X + 1.
move_direction(X, Y, west, X1, Y) :- X1 is X - 1.

within_bounds(X, Y, Board) :-
    length(Board, Rows),
    nth0(0, Board, FirstRow),
    length(FirstRow, Cols),
    X >= 0, X < Cols,
    Y >= 0, Y < Rows.

get_position(X, Y, Board, Position) :-
    nth0(Y, Board, Row),
    nth0(X, Row, Position).
