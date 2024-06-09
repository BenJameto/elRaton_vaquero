% Dimensiones de la caja (N, M)
dimensiones(5, 5).

% Contenido de las celdas: vacío, queso, queso_con_ron, queso_con_veneno
celda(0, 0, queso_con_veneno).
celda(0, 1, queso).
celda(0, 2, vacio).
celda(0, 3, queso).
celda(0, 4, vacio).
celda(1, 0, queso).
celda(1, 1, vacio).
celda(1, 2, queso_con_veneno).
celda(1, 3, vacio).
celda(1, 4, queso).
celda(2, 0, queso).
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
celda(4, 2, queso).
celda(4, 3, salida).
celda(4, 4, queso).

% Así se ven las celdas
% [
%     [veneno, queso , queso , vacio , vacio ],
%     [queso , vacio , vacio , ron   , vacio ],
%     [vacio , veneno, vacio , queso , queso ],
%     [queso , vacio , veneno, vacio , salida],
%     [vacio , queso , queso , veneno, queso ]
% ]

% Cambia el estado del tablero (si hay algun queso) [Esto no se hizo gg]
% Cambia su contador borracho a 7 (si hay ron)
% Cambia dirección a muerto (si borracho -= 0 y hay veneno)
% Cambia dirección a salida (si llegó a salida)
% Mantiene dirección, contador y estado en otros casos
revisa_celda(Raton, NRaton) :- 
    Raton = raton(X, Y, D, B),
    celda(X, Y, TipoCelda),
    (
        TipoCelda = queso_con_ron -> NRaton = raton(X, Y, D, 7), write('Comiendo queso con ron.'), nl;
        TipoCelda = queso_con_veneno, B > 0 -> NRaton = raton(X, Y, muerto, B), write('Comiendo queso con veneno.'), nl;
        TipoCelda = salida -> NRaton = raton(X, Y, salida, B), write('Sobre la salida.'), nl;
        NRaton = Raton
    ).

% Insica si el ratón está pegado a una pared y su dirección es hacia esa pared
viendo_pared(Raton) :-
    Raton = raton(X, Y, D, _),
    dimensiones(N, M),
    LN is N - 1,
    LM is M - 1,
    (
        D = derecha, X = LN;
        D = izquierda, X = 0;
        D = arriba, Y = 0;
        D = abajo, Y = LM
    ).

% Movimiento en una dirección aleatoria
random_direction(D) :-
    random_between(1, 4, R),
    (R = 1 -> D = derecha;
     R = 2 -> D = izquierda;
     R = 3 -> D = arriba;
     R = 4 -> D = abajo).

% Girar a la izquierda
girar_izquierda(derecha, arriba).
girar_izquierda(arriba, izquierda).
girar_izquierda(izquierda, abajo).
girar_izquierda(abajo, derecha).

% (si está en direccion de pared y no borracho) gira_izquierda hasta que la condición no se cumpla
% (si no está en dirección de pared y borracho) gira aleatorio
% Mantiene todo igual en otros casos
revisa_direccion(Raton, NRaton) :- 
    Raton = raton(X, Y, D, B),
    (
        viendo_pared(Raton), B = 0 -> girar_izquierda(D, ND), revisa_direccion(raton(X, Y, ND, B), NRaton);
        not(viendo_pared(Raton)), B > 0 -> random_direction(ND), NRaton = raton(X, Y, ND, B);
        NRaton = Raton
    ).

% Avanzar al raton dependiendo de su dirección
avanza(X, Y, arriba, X, NY) :- NY is Y - 1.
avanza(X, Y, abajo, X, NY) :- NY is Y + 1.
avanza(X, Y, izquierda, NX, Y) :- NX is X - 1.
avanza(X, Y, derecha, NX, Y) :- NX is X + 1.

% (si está en direccion de pared y borracho) se mantiene todo y borracho -= 1
% (si borracho) avanza y borracho -= 1
% avanza en otros casos
mover(Raton, NRaton) :- 
    Raton = raton(X, Y, D, B),
    NB is B - 1,
    avanza(X, Y, D, NX, NY),
    (
        viendo_pared(Raton), B > 0 -> NRaton = raton(X, Y, D, NB);
        B > 0 -> NRaton = raton(NX, NY, D, NB);
        NRaton = raton(NX, NY, D, B)
    ).

% Acciones del raton en cada paso
accion_raton(Raton, NRaton) :-
    % Quita el queso de las celdas y cambia el estado del raton dependiendo del queso que había en la celda
    revisa_celda(Raton, QRaton), 
    QRaton = raton(_, _, Final, _),
    (
        Final = salida -> NRaton = QRaton;
        Final = muerto -> NRaton = QRaton;
        % Si no ha terminado hace las siguientes dos acciones
        % Cambia la dirección del raton dependiendo si está en pared o borracho
        revisa_direccion(QRaton, DRaton),
        % Mueve al raton
        mover(DRaton, NRaton)
    ).

% Ejecutamos la acción del raton e imprimimos su estado en cada paso
loop(Raton) :-
    accion_raton(Raton, NRaton),
    NRaton = raton(X, Y, D, B),
    (
        D = muerto -> write('El ratón ha muerto.'), nl;
        D = salida -> write('El ratón ha encontrado la salida.'), nl;
        write('Raton en: '), write(X), write(','), write(Y),
        write(' dirección: '), write(D),
        write(' pasos borracho faltantes: '), write(B), nl,
        loop(NRaton)
    ).

inicio :-
    % posición inicial del raton: raton(X,Y,D,B)
    % X: coordenada en X del tablero
    % Y: coordenada en Y del tablero
    % D: dirección en la que comienza viendo [derecha, izquierda, arriba, abajo]
    % B: Grado de alcohol, comienza en 0. Va reduciendo en 1 a cada paso y sube a 7 cuando come queso_con_ron
    Raton = raton(0,1,derecha,0),
    % Iniciamos la ejecución
    loop(Raton).