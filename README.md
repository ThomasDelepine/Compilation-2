# README Projet Compilation M1 MPRI

## Structure

Le projet est décomposé en deux partie. La partie principale dans le répertoire `ImpOpt`, et la seconde partie dans le repertoire `Fun`. La première conciste en une traduction de Imp vers MIPS. La seconde consiste en une traduction de Fun vers Imp (avec un ajout de pointeurs).

## ImpOpt

Dans le répertoire ImpOpt, on retrouve les fichiers correspondants aux divers étapes de la traduction, ainsi qu'un répertoire `tests`. Dans ce dernier se trouve l'ensemble des tests et exemples sur lesquels la traduction fonctionne.

### Tests

Ces tests sont divisés en plusieurs catégories, reconnaissable par leur nom

- [tOP.imp](ImpOpt/tests/tOP.imp), [tIF1.imp](ImpOpt/tests/tIF1.imp), [tIF2.imp](ImpOpt/tests/tIF2.imp), [tIF3.imp](ImpOpt/tests/tIF3.imp) sont des petits tests d'opérations de base
- les fichiers [t1.imp](ImpOpt/tests/t1.imp), [t2.imp](ImpOpt/tests/t2.imp), [t3.imp](ImpOpt/tests/t3.imp), [t4.imp](ImpOpt/tests/t4.imp), [t5.imp](ImpOpt/tests/t5.imp) sont des tests en vrac sur divers points traités par la traduction
- les fichiers [tGLOBAL.imp](ImpOpt/tests/tGLOBAL.imp) et [tFONCTION01.imp](ImpOpt/tests/tFONCTION01.imp), [tFONCTION02.imp](ImpOpt/tests/tFONCTION02.imp), [tFONCTION03.imp](ImpOpt/tests/tFONCTION03.imp), [tFONCTION04.imp](ImpOpt/tests/tFONCTION04.imp), [tFONCTION05.imp](ImpOpt/tests/tFONCTION05.imp), [tFONCTION06.imp](ImpOpt/tests/tFONCTION06.imp), [tFONCTION07.imp](ImpOpt/tests/tFONCTION07.imp), [tFONCTION08.imp](ImpOpt/tests/tFONCTION08.imp), [tFONCTION09.imp](ImpOpt/tests/tFONCTION09.imp) se concentrent sur les appels de fonctions (sans return), la gestion des arguments, la lectures et la modifications de variables globales, ...
- les fichiers [tRETURN01.imp](ImpOpt/tests/tRETURN01.imp) sont des exemples de fonctions avec return.
- les fichiers [tREC01.imp](ImpOpt/tests/tREC01.imp), [tREC02.imp](ImpOpt/tests/tREC02.imp), [tREC03.imp](ImpOpt/tests/tREC03.imp), [tREC04.imp](ImpOpt/tests/tREC04.imp), [fibo.imp](ImpOpt/tests/fibo.imp) sont des exemples de fonctions récursives
- les fichiers [circle.imp](ImpOpt/tests/circle.imp), [circleMainNoArgs.imp](ImpOpt/tests/circleMainNoArgs.imp), [circleCall.imp](ImpOpt/tests/circleCall.imp), [circleLocal.imp](ImpOpt/tests/circleLocal.imp) sont des exemples du plus complexe au plus simple d'un même programme

### Imp

La version de Imp qu'il est possible de traduire gère les cas suivants

- les opération arithmétiques `+`, `*`
- l'opération booléenne `<`
- l'affichage de charactères `putchar(_)`
- les conditions `if(_){_}else{_}`et boucles `while(_){_}`, et leurs imbrications
- les variables globales (déclarées en tête de programme `var _;`) et les variables locales (déclarée en tête de fonction `var _;`), dont les valeurs peuvent être initialisée/modifiée `label = _;`
- la modification d'une variable globale la modifie pour tout le monde partout
- l'appel de fonction, les fonctions peuvent prendre des paramètres, et peuvent renvoyer une valeur `return _;` ou non
- les arguments de la fonction main sont pris en compte, et à entrer en input au début de l'exécution du programme
- les appels récursifs