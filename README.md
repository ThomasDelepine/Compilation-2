# README Projet Compilation M1 MPRI

## Structure

Le projet est décomposé en deux partie. La partie principale dans le répertoire `ImpOpt`, et la seconde partie dans le repertoire `Fun`. La première conciste en une traduction de Imp vers MIPS. La seconde consiste en une traduction de Fun vers Imp (avec un ajout de pointeurs).

## ImpOpt

Dans le répertoire ImpOpt, on retrouve les fichiers correspondants aux divers étapes de la traduction, ainsi qu'un répertoire `tests`. Dans ce dernier se trouve l'ensemble des tests et exemples sur lesquels la traduction fonctionne.

### Tests

Ces tests sont divisés en plusieurs catégories, reconnaissable par leur nom

- tOP.imp, tIF1.imp, tIF2.imp sont des petits tests d'opérations de base
- les fichiers t1.imp, t2.imp, ... sont des tests en vrac sur divers points traités par la traduction
- les fichiers tGLOBAL et tFONCTION01.imp, tFONCTION02.imp, ... se concentrent sur les appels de fonctions (sans return), la gestion des arguments, la lectures et la modifications de variables globales, ...
- les fichiers tRETURN01.imp, ... sont des exemples de fonctions avec return.
- les fichiers tREC01.imp, ... sont des exemples de fonctions récursives
- les fichiers circle.imp, circleMainNoArgs.imp, circleCall.imp, circleLocal.imp sont des exemples du plus complexe au plus simple d'un même programme
