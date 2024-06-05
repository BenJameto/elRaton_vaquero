% Dimensiones de la caja (N, M)
dimensiones(5, 5).
salida(4, 3).

% Contenido de las celdas: vacío, queso, queso_con_ron, queso_con_veneno
celda(0, 0, queso_con_veneno).
celda(0, 1, queso).
celda(0, 2, vacio).
celda(0, 3, queso_con_ron).
celda(0, 4, vacio).
celda(1, 0, queso).
celda(1, 1, vacio).
celda(1, 2, queso_con_veneno).
celda(1, 3, vacio).
celda(1, 4, queso_con_ron).
celda(2, 0, queso_con_ron).
celda(2, 1, vacio).
celda(2, 2, vacio).
celda(2, 3, queso_con_veneno).
celda(2, 4, queso).
celda(3, 0, vacio).
celda(3, 1, queso_con_ron).
celda(3, 2, queso).
celda(3, 3, vacio).
celda(3, 4, queso_con_veneno).
celda(4, 0, vacio).
celda(4, 1, vacio).
celda(4, 2, queso_con_ron).
celda(4, 3, salida).
celda(4, 4, queso).

% Direcciones
direccion(derecha, 1, 0).
direccion(izquierda, -1, 0).
direccion(arriba, 0, -1).
direccion(abajo, 0, 1).

% Posición inicial del ratón (X, Y, Dirección)
raton(0, 2, derecha).

% Movimiento del ratón en la misma dirección
mover(X, Y, D, NX, NY) :-
    direccion(D, DX, DY),
    NX is X + DX,
    NY is Y + DY.

% Movimiento al encontrar queso
encontrar_queso(X, Y, D, NX, NY, D) :-
    celda(X, Y, queso),
    mover(X, Y, D, NX, NY).

% Movimiento al encontrar queso con ron
encontrar_queso_con_ron(X, Y, _, NX, NY, ND) :-
    celda(X, Y, queso_con_ron),
    random_between(1, 4, R),
    random_direction(R, ND),
    mover_7(X, Y, ND, NX, NY).

% Movimiento al encontrar queso con veneno
encontrar_queso_con_veneno(X, Y, _, muerto) :-
    celda(X, Y, queso_con_veneno).

% Movimiento en una dirección aleatoria
random_direction(R, D) :-
    (R = 1 -> D = derecha;
     R = 2 -> D = izquierda;
     R = 3 -> D = arriba;
     R = 4 -> D = abajo).

% Mover 7 pasos en dirección aleatoria
mover_7(X, Y, D, NX, NY) :-
    direccion(D, DX, DY),
    NX is X + 7 * DX,
    NY is Y + 7 * DY.


% Movimiento al chocar con una pared estando sobrio
chocar_pared_sobrio(X, Y, D, NX, NY, ND) :-
    dimensiones(N, M),
    (X =< 0; Y =< 0; X >= N; Y >= M),
    girar_izquierda(D, ND),
    mover(X, Y, ND, NX, NY).

% Girar a la izquierda
girar_izquierda(derecha, arriba).
girar_izquierda(arriba, izquierda).
girar_izquierda(izquierda, abajo).
girar_izquierda(abajo, derecha).

% Movimiento al chocar con una pared estando borracho
chocar_pared_borracho(X, Y, _, NX, NY, ND) :-
    dimensiones(N, M),
    (X =< 0; Y =< 0; X >= N; Y >= M),
    random_between(1, 4, R),
    random_direction(R, ND),
    NX = X,
    NY = Y.

% Regla principal para mover el ratón
mover_raton(X, Y, D, NX, NY, ND) :-
    (encontrar_queso(X, Y, D, NX, NY, ND);
     encontrar_queso_con_ron(X, Y, D, NX, NY, ND);
     (encontrar_queso_con_veneno(X, Y, D, muerto) -> NX = X, NY = Y, ND = muerto);
     chocar_pared_sobrio(X, Y, D, NX, NY, ND);
     chocar_pared_borracho(X, Y, D, NX, NY, ND)),
    (celda(NX, NY, salida) -> ND = salida; true),
    \+ (ND = salida).

% Inicio del programa
inicio :-
    raton(X, Y, D),
    mover_raton(X, Y, D, NX, NY, ND),
    (ND = muerto ->
        write('El ratón ha muerto.'), nl
    ; ND = salida ->
        write('El ratón ha encontrado la salida.'), nl,
        halt
    ;
        write('Raton en: '), write(NX), write(','), write(NY), write(' dirección: '), write(ND), nl,
        inicio
    ).

