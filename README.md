# Equipo11

  

## Integrantes:

- Comas Castañeda Mauricio 320215988

- Martínez Osorio Benjamín 312063678

- Medina Peralta Joaquín 320202513

  

## El ratón vaquero

  

## Instrucciones

  

### Para esta práctica necesitan tener instalado Prolog.

  

### Linux:

Por lo general, el paquete que necesitan tiene el nombre `swi-prolog`, esto puede variar para cada distribución.

  

#### - Debian:

```
sudo  apt  install  swi-prolog-full
```

  

#### - Fedora: 

```
sudo dnf install pl
```


#### - Mac:
```
brew install swi-prolog
```

### Windows:

En la página [SWI-Prolog](https://www.swi-prolog.org/download/stable) descargar la versión correspondiente con su sistema.

## Ejecución
- Abrir una terminal `Alt + Ctrl + t`.   
- Una vez clonado el repositorio, hay que posicionarse en la dirección correspondiente, por ejemplo `/home/usr/Downloads/proyecto_final`.    
- Ejecutar en la consola: `swipl`  

- Para cargar el archivo:
		`?- [raton_mini].`
		
- Para iniciar el programa:
`[inicio].`  
  
**bash**
```
usr@usr:~/Downloads/logica/proyecto_final$ swipl
Welcome to SWI-Prolog (threaded, 64 bits, version 9.0.4)
SWI-Prolog comes with ABSOLUTELY NO WARRANTY. This is free software.
Please run ?- license. for legal details.

For online help and background, visit https://www.swi-prolog.org
For built-in help, use ?- help(Topic). or ?- apropos(Word).

?- [raton_mini].
true.

?- inicio.
Raton en: 1,1 dirección: derecha pasos borracho faltantes: 0
Raton en: 2,1 dirección: derecha pasos borracho faltantes: 0
Raton en: 3,1 dirección: derecha pasos borracho faltantes: 0
Comiendo queso con ron.
Raton en: 3,0 dirección: arriba pasos borracho faltantes: 6
Raton en: 3,0 dirección: arriba pasos borracho faltantes: 5
Raton en: 3,0 dirección: arriba pasos borracho faltantes: 4
Raton en: 3,0 dirección: arriba pasos borracho faltantes: 3
Raton en: 3,0 dirección: arriba pasos borracho faltantes: 2
Raton en: 3,0 dirección: arriba pasos borracho faltantes: 1
Raton en: 3,0 dirección: arriba pasos borracho faltantes: 0
Raton en: 2,0 dirección: izquierda pasos borracho faltantes: 0
Raton en: 1,0 dirección: izquierda pasos borracho faltantes: 0
Raton en: 0,0 dirección: izquierda pasos borracho faltantes: 0
Raton en: 0,1 dirección: abajo pasos borracho faltantes: 0
Raton en: 0,2 dirección: abajo pasos borracho faltantes: 0
Raton en: 0,3 dirección: abajo pasos borracho faltantes: 0
Raton en: 0,4 dirección: abajo pasos borracho faltantes: 0
Raton en: 1,4 dirección: derecha pasos borracho faltantes: 0
Raton en: 2,4 dirección: derecha pasos borracho faltantes: 0
Raton en: 3,4 dirección: derecha pasos borracho faltantes: 0
Raton en: 4,4 dirección: derecha pasos borracho faltantes: 0
Raton en: 4,3 dirección: arriba pasos borracho faltantes: 0
Sobre la salida.
El ratón ha encontrado la salida.
true .
```