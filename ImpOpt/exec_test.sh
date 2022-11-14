ocamlbuild impc.native


# Différentes versions de circle (de la plus simple à la plus complexe)
#./impc.native tests/circleLocal.imp
#./impc.native tests/circleCall.imp
#./impc.native tests/circleMainNoArgs.imp

# test de bases (arithmétique, variables)
#./impc.native tests/t0.imp
#./impc.native tests/t1.imp
#./impc.native tests/t2.imp
#./impc.native tests/t3.imp
#./impc.native tests/t4.imp

# tests IF cas des 2 branchements :
#./impc.native tests/tIF1.imp
#./impc.native tests/tIF2.imp
#./impc.native tests/tOP.imp

# Test variables globales et appels de fonctions :
#./impc.native tests/tGLOBAL.imp
#./impc.native tests/tFONCTION01.imp
#./impc.native tests/tFONCTION02.imp
#./impc.native tests/tFONCTION03.imp
#./impc.native tests/tFONCTION04.imp
#./impc.native tests/tFONCTION05.imp
#./impc.native tests/tFONCTION06.imp
#./impc.native tests/tFONCTION07.imp
#./impc.native tests/tFONCTION08.imp
#./impc.native tests/tFONCTION09.imp

# Test fonctions avec return
#./impc.native tests/tRETURN01.imp


# Test fonctions avec appels récursifs
#./impc.native tests/tREC01.imp


# Work in progress

#./impc.native tests/tREC02.imp
#./impc.native tests/circle.imp

