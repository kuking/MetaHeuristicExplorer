;; Sample nsga-ii algorithm
(setf aa (PROGN (SETF G45912 (MAKE-INSTANCE (QUOTE CFG-MUTATION))) (SETF G45920 (MAKE-INSTANCE (QUOTE RUNNING-IMAGE-PLANIFIER))) (SETF G45913 (MAKE-INSTANCE (QUOTE CFG-MUTATION))) (SETF G45896 (MAKE-INSTANCE (QUOTE NSGA-II))) (SETF G45902 (MAKE-INSTANCE (QUOTE ENTITY-FUNCTION-X-EVALUATOR))) (SETF G45906 (MAKE-INSTANCE (QUOTE SUBTREE-CROSSOVER))) (SETF G45917 (MAKE-INSTANCE (QUOTE CONTEXT-FREE-GRAMMAR) :NAME (QUOTE SERIALIZED-VALID-GRAMMAR) :LEXER (QUOTE LISP-MATH-EXPRESSION-TOKEN-TYPE-LEXER) :PARSER-INITIALIZER (QUOTE INITIALIZE-LISP-MATH-EXPRESSION-PARSER))) (SETF G45911 (MAKE-INSTANCE (QUOTE MUTATION))) (SETF G45910 (MAKE-INSTANCE (QUOTE POINT-MUTATION))) (SETF G45919 (MAKE-INSTANCE (QUOTE N-RUNS-TASK-BUILDER))) (SETF G45908 (MAKE-INSTANCE (QUOTE SUBTREE-CROSSOVER))) (SETF G45904 (MAKE-INSTANCE (QUOTE SUBTREE-CROSSOVER))) (SETF G45898 (MAKE-INSTANCE (QUOTE GENOTYPE))) (SETF G45905 (MAKE-INSTANCE (QUOTE SUBTREE-CROSSOVER))) (SETF G45923 (MAKE-INSTANCE (QUOTE RANDOM-TREES-GENERATOR))) (SETF G45909 (MAKE-INSTANCE (QUOTE MUTATION))) (SETF G45921 (MAKE-INSTANCE (QUOTE TOURNAMENT-SELECTION))) (SETF G45903 (MAKE-INSTANCE (QUOTE CFG-TREE-LANGUAGE))) (SETF G45914 (MAKE-INSTANCE (QUOTE CFG-MUTATION))) (SETF G45901 (MAKE-INSTANCE (QUOTE GENOTYPE))) (SETF G45907 (MAKE-INSTANCE (QUOTE BRANCH-DELETE))) (SETF G45916 (MAKE-INSTANCE (QUOTE FIXED-SET-CONSTANTS-FACTORY))) (SETF G45915 (MAKE-INSTANCE (QUOTE CFG-MUTATION))) (SETF G45899 (MAKE-INSTANCE (QUOTE SEARCH-TASK))) (PROGN (SETF (PROPERTIES-VALUES G45896) (LET ((G45897 (MAKE-HASH-TABLE))) (SET-HASH G45897 (QUOTE PARETO-FRONT) NIL (QUOTE GENERATION) NIL (QUOTE SELECTION-METHOD) NIL (QUOTE CONTEXT) NIL (QUOTE POPULATION-SIZE) NIL (QUOTE BEST) NIL (QUOTE POPULATION) NIL (QUOTE ITERATION) NIL (QUOTE MAX-GENERATIONS) NIL (QUOTE local-optimization) NIL (QUOTE NAME) NIL (QUOTE INITIALIZATION-METHOD) NIL (QUOTE MAX-ITERATIONS) NIL) G45897) (GEN G45896) (PROGN (SETF (EXPRESION G45898) NIL (FITNESS G45898) NIL) G45898) (FITNESS G45896) 0 (FITNESS-ADJUSTED G45896) (INTERNKEY "FITNESS-ADJUSTED") (FITNESS-NORMALIZED G45896) (INTERNKEY "FITNESS-NORMALIZED") (DISTANCE G45896) (INTERNKEY "INF") (SIZE G45896) 0 (NON-LINEAR-COMPONENTS G45896) 0 (NAME G45896) (QUOTE SEARCH-ALGORITHM) (MAX-ITERATIONS G45896) 10000 (ITERATION G45896) 0 (CONTEXT G45896) (PROGN (SETF (PROPERTIES-VALUES G45899) (LET ((G45900 (MAKE-HASH-TABLE))) (SET-HASH G45900 (QUOTE RANDOM-SEED) NIL (QUOTE OBJETIVE-CLASS) NIL (QUOTE INITIAL-TIME) NIL (QUOTE TASK-PLANIFIER) NIL (QUOTE ALGORITHM) NIL (QUOTE BEST-SIZE) NIL (QUOTE PROGRESS-INDICATOR) NIL (QUOTE TASK-BUILDER) NIL (QUOTE PRIORITY) NIL (QUOTE DESCRIPTION) NIL (QUOTE STATE) NIL (QUOTE FITNESS-EVALUATOR) NIL (QUOTE RESULT) NIL (QUOTE LOG-DATA) NIL (QUOTE BEST-FITNESS) NIL (QUOTE FINAL-TIME) NIL (QUOTE MEDIUM-SIZE) NIL (QUOTE RUNNING-TIME) NIL (QUOTE NAME) NIL (QUOTE SEED) NIL (QUOTE CHILDREN) NIL (QUOTE LANGUAGE) NIL (QUOTE MEDIUM-FITNESS) NIL) G45900) (GEN G45899) (PROGN (SETF (EXPRESION G45901) NIL (FITNESS G45901) NIL) G45901) (FITNESS G45899) 0 (FITNESS-ADJUSTED G45899) (INTERNKEY "FITNESS-ADJUSTED") (FITNESS-NORMALIZED G45899) (INTERNKEY "FITNESS-NORMALIZED") (DISTANCE G45899) (INTERNKEY "INF") (SIZE G45899) 0 (NON-LINEAR-COMPONENTS G45899) 0 (NAME G45899) (QUOTE NEW) (DESCRIPTION G45899) (QUOTE NEW) (STATE G45899) (QUOTE RUNNING) (CHILDREN G45899) NIL (INPUT G45899) NIL (RESULT G45899) NIL (PRIORITY G45899) -50000 (RANDOM-SEED G45899) T (INITIAL-TIME G45899) 3605104515 (FINAL-TIME G45899) NIL (SEED G45899) 757362 (OBJETIVE-CLASS G45899) (QUOTE ENTITY-FUNCTION-X) (FITNESS-EVALUATOR G45899) (PROGN (SETF (PROPERTIES-VALUES G45902) (MAKE-HASH-TABLE) (NAME G45902) (QUOTE GROSS-0-10-FUNCTION-X-EVALUATOR) (DESCRIPTION G45902) "Gross 0-10" (SOLUTION-FITNESS G45902) 9.98 (MIN-FITNESS G45902) 0 (MAX-FITNESS G45902) 10 (FITNESS-VECTOR G45902) (MAKE-ARRAY (LIST 20) :INITIAL-CONTENTS (LIST (LIST 0 1) (LIST 1/2 31/16) (LIST 1 5) (LIST 3/2 211/16) (LIST 2 31) (LIST 5/2 1031/16) (LIST 3 121) (LIST 7/2 3355/16) (LIST 4 341) (LIST 9/2 8431/16) (LIST 5 781) (LIST 11/2 17891/16) (LIST 6 1555) (LIST 13/2 33751/16) (LIST 7 2801) (LIST 15/2 58411/16) (LIST 8 4681) (LIST 17/2 94655/16) (LIST 9 7381) (LIST 19/2 145651/16))) (FITNESS-FUNCTION G45902) (QUOTE EVALUATE-DISTANCE) (TARGET-PROGRAM G45902) (LIST (QUOTE +) 1 (QUOTE X) (LIST (QUOTE *) (QUOTE X) (QUOTE X)) (LIST (QUOTE *) (QUOTE X) (QUOTE X) (QUOTE X)) (LIST (QUOTE *) (QUOTE X) (QUOTE X) (QUOTE X) (QUOTE X))) (SAMPLES G45902) 20 (MEASURE-START G45902) 0 (MEASURE-END G45902) 10) G45902) (LANGUAGE G45899) (PROGN (SETF (PROPERTIES-VALUES G45903) (MAKE-HASH-TABLE) (NAME G45903) (QUOTE LISP-MATH-FUNCTION-X) (DESCRIPTION G45903) "Description" (SIMPLIFICATION-FUNCTION G45903) (QUOTE SIMPLIFY-STRATEGY) (SIMPLIFICATION-PATTERNS G45903) (LIST (LIST (LIST (QUOTE +) (QUOTE ?EXP) 0) (QUOTE ?1)) (LIST (LIST (QUOTE +) (QUOTE ?EXP) 0.0) (QUOTE ?1)) (LIST (LIST (QUOTE +) 0 (QUOTE ?EXP)) (QUOTE ?2)) (LIST (LIST (QUOTE +) 0.0 (QUOTE ?EXP)) (QUOTE ?2)) (LIST (LIST (QUOTE -) (QUOTE ?EXP) 0) (QUOTE ?1)) (LIST (LIST (QUOTE -) (QUOTE ?EXP) 0.0) (QUOTE ?1)) (LIST (LIST (QUOTE -) (QUOTE ?EXP) (QUOTE ?EXP)) 0) (LIST (LIST (QUOTE *) (QUOTE ?EXP) 0) 0) (LIST (LIST (QUOTE *) (QUOTE ?EXP) 0.0) 0) (LIST (LIST (QUOTE *) 0 (QUOTE ?EXP)) 0) (LIST (LIST (QUOTE *) 0.0 (QUOTE ?EXP)) 0) (LIST (LIST (QUOTE *) (QUOTE ?EXP) 1) (QUOTE ?1)) (LIST (LIST (QUOTE *) (QUOTE ?EXP) 1.0) (QUOTE ?1)) (LIST (LIST (QUOTE *) 1 (QUOTE ?EXP)) (QUOTE ?2)) (LIST (LIST (QUOTE *) 1.0 (QUOTE ?EXP)) (QUOTE ?2)) (LIST (LIST (QUOTE /-) (QUOTE ?EXP) 1) (QUOTE ?1)) (LIST (LIST (QUOTE /-) (QUOTE ?EXP) 1.0) (QUOTE ?1)) (LIST (LIST (QUOTE /-) 0 (QUOTE ?EXP)) 0) (LIST (LIST (QUOTE /-) 0.0 (QUOTE ?EXP)) 0) (LIST (LIST (QUOTE /-) (QUOTE ?EXP) 0) (QUOTE ?1)) (LIST (LIST (QUOTE /-) (QUOTE ?EXP) 0.0) (QUOTE ?1)) (LIST (LIST (QUOTE /-) (QUOTE ?EXP) (QUOTE ?EXP)) 1)) (VALID-NEW-EXPRESION-FUNCTION G45903) (QUOTE CREATE-NEW-RANDOM-VALID) (OPERATORS G45903) (LIST (LIST (PROGN (SETF (PROPERTIES-VALUES G45904) (MAKE-HASH-TABLE) (NAME G45904) (QUOTE CROSSOVER) (VALUE-FUNCTION G45904) (QUOTE CROSSOVER) (SOURCE-SELECTION-FUNCTION G45904) NIL (TARGET-SELECTION-FUNCTION G45904) NIL (MIN-SUBTREE-DEPTH G45904) 1) G45904) 0.0) (LIST (PROGN (SETF (PROPERTIES-VALUES G45905) (MAKE-HASH-TABLE) (NAME G45905) (QUOTE CROSSOVER-KOZA) (VALUE-FUNCTION G45905) (QUOTE CROSSOVER-KOZA) (SOURCE-SELECTION-FUNCTION G45905) NIL (TARGET-SELECTION-FUNCTION G45905) NIL (MIN-SUBTREE-DEPTH G45905) 2) G45905) 0.3) (LIST (PROGN (SETF (PROPERTIES-VALUES G45906) (MAKE-HASH-TABLE) (NAME G45906) (QUOTE CROSSOVER-CFG) (VALUE-FUNCTION G45906) (QUOTE CROSSOVER-CFG) (SOURCE-SELECTION-FUNCTION G45906) (QUOTE CROSSOVER-CFG-SOURCE-SELECTION) (TARGET-SELECTION-FUNCTION G45906) (QUOTE CROSSOVER-CFG-TARGET-SELECTION-WEIGHT-DEPTH) (MIN-SUBTREE-DEPTH G45906) NIL) G45906) 0.2) (LIST (PROGN (SETF (PROPERTIES-VALUES G45907) (MAKE-HASH-TABLE) (NAME G45907) (QUOTE BRANCH-DELETE) (NODE-SELECTION-FUNCTION G45907) 1) G45907) 0.2) (LIST (PROGN (SETF (PROPERTIES-VALUES G45908) (MAKE-HASH-TABLE) (NAME G45908) (QUOTE BRANCH-DELETE-CFG) (VALUE-FUNCTION G45908) (QUOTE MUTATE-BRANCH-DELETE-CFG) (SOURCE-SELECTION-FUNCTION G45908) (QUOTE BRANCH-DELETE-CFG-SOURCE-SELECTION) (TARGET-SELECTION-FUNCTION G45908) NIL (MIN-SUBTREE-DEPTH G45908) NIL) G45908) 0.0) (LIST (PROGN (SETF (PROPERTIES-VALUES G45909) (MAKE-HASH-TABLE) (NAME G45909) (QUOTE MUTATE) (SOURCE-SELECTION-FUNCTION G45909) (QUOTE LAMBDA-MUTATE-SELECTION-FUNCTION) (TREE-CREATION-FUNCTION G45909) 1 (VALUE-FUNCTION G45909) (QUOTE MUTATE)) G45909) 0.0) (LIST (PROGN (SETF (PROPERTIES-VALUES G45910) (MAKE-HASH-TABLE) (NAME G45910) (QUOTE MUTATE-POINT) (SOURCE-SELECTION-FUNCTION G45910) (QUOTE LAMBDA-POINT-MUTATION-SELECTION-FUNCTION) (VALUE-FUNCTION G45910) (QUOTE MUTATE-POINT)) G45910) 0.2) (LIST (PROGN (SETF (PROPERTIES-VALUES G45911) (MAKE-HASH-TABLE) (NAME G45911) (QUOTE MUTATE-KOZA) (SOURCE-SELECTION-FUNCTION G45911) 1 (TREE-CREATION-FUNCTION G45911) 1 (VALUE-FUNCTION G45911) (QUOTE MUTATE-KOZA)) G45911) 0.0) (LIST (PROGN (SETF (PROPERTIES-VALUES G45912) (MAKE-HASH-TABLE) (NAME G45912) (QUOTE MUTATE-CFG) (VALUE-FUNCTION G45912) (QUOTE MUTATE-CFG) (SOURCE-SELECTION-FUNCTION G45912) (QUOTE CROSSOVER-CFG-SOURCE-SELECTION) (TARGET-SELECTION-FUNCTION G45912) (QUOTE CROSSOVER-CFG-TARGET-SELECTION-WEIGHT-DEPTH) (MIN-SUBTREE-DEPTH G45912) NIL (PRODUCTION-SELECTION-WEIGHT-FUNCTION G45912) (QUOTE LAMBDA-WEIGHT-HEURISTIC-1-RANDOM-SELECTION-LIST)) G45912) 0.1) (LIST (PROGN (SETF (PROPERTIES-VALUES G45913) (MAKE-HASH-TABLE) (NAME G45913) (QUOTE MUTATE-REUSE-CFG) (VALUE-FUNCTION G45913) (QUOTE MUTATE-REUSE-CFG) (SOURCE-SELECTION-FUNCTION G45913) (QUOTE MUTATE-PRODUCTION-CFG-SOURCE-SELECTION) (TARGET-SELECTION-FUNCTION G45913) NIL (MIN-SUBTREE-DEPTH G45913) NIL (PRODUCTION-SELECTION-WEIGHT-FUNCTION G45913) (QUOTE LAMBDA-WEIGHT-EQUAL-RANDOM-SELECTION-LIST)) G45913) 0.0) (LIST (PROGN (SETF (PROPERTIES-VALUES G45914) (MAKE-HASH-TABLE) (NAME G45914) (QUOTE MUTATE-PRODUCTION-CFG) (VALUE-FUNCTION G45914) (QUOTE MUTATE-PRODUCTION-CFG) (SOURCE-SELECTION-FUNCTION G45914) (QUOTE MUTATE-PRODUCTION-CFG-SOURCE-SELECTION) (TARGET-SELECTION-FUNCTION G45914) NIL (MIN-SUBTREE-DEPTH G45914) NIL (PRODUCTION-SELECTION-WEIGHT-FUNCTION G45914) (QUOTE LAMBDA-WEIGHT-EQUAL-RANDOM-SELECTION-LIST)) G45914) 0.0) (LIST (PROGN (SETF (PROPERTIES-VALUES G45915) (MAKE-HASH-TABLE) (NAME G45915) (QUOTE RANDOM-CREATE-CFG) (VALUE-FUNCTION G45915) (QUOTE RANDOM-CREATE-CFG) (SOURCE-SELECTION-FUNCTION G45915) NIL (TARGET-SELECTION-FUNCTION G45915) NIL (MIN-SUBTREE-DEPTH G45915) NIL (PRODUCTION-SELECTION-WEIGHT-FUNCTION G45915) (QUOTE LAMBDA-WEIGHT-EQUAL-RANDOM-SELECTION-LIST)) G45915) 0.0)) (MAX-SIZE G45903) 18 (MAX-DEPTH G45903) 8 (MAX-DEPTH-NEW-INDIVIDUALS G45903) 4 (MAX-SIZE-NEW-INDIVIDUALS G45903) 10 (max-depth-crossover G45903) 4 (max-depth-mutated G45903) 4 (MAX-DEPTH-MUTATED-SUBTREE G45903) 3 (CONSTANTS-STRATEGY G45903) (PROGN (SETF (PROPERTIES-VALUES G45916) (MAKE-HASH-TABLE) (NAME G45916) (QUOTE DEFAULT-FIXED-SET-NUMERICAL-1) (DISTRIBUTION G45916) NIL (CONSTANTS-SET G45916) (LIST 0 1 2 3 4 5 6 7 8 9 10)) G45916) (FUNCTIONS G45903) (LIST (LIST (QUOTE +) 2) (LIST (QUOTE -) 2) (LIST (QUOTE *) 2) (LIST (QUOTE /-) 2) (LIST (QUOTE SIN) 1) (LIST (QUOTE COS) 1) (LIST (QUOTE SQR) 1) (LIST (QUOTE ABS) 1)) (VARIABLES G45903) (LIST (QUOTE X)) (TERMINALS G45903) (LIST (QUOTE X) (INTERNKEY "CONSTANT")) (TOKENS G45903) (LIST (LIST (QUOTE ABS) (INTERNKEY "1-ARY-OPERATOR")) (LIST (QUOTE SIN) (INTERNKEY "1-ARY-OPERATOR")) (LIST (QUOTE COS) (INTERNKEY "1-ARY-OPERATOR")) (LIST (QUOTE TAN) (INTERNKEY "1-ARY-OPERATOR")) (LIST (QUOTE SQR) (INTERNKEY "1-ARY-OPERATOR")) (LIST (QUOTE EXP) (INTERNKEY "1-ARY-OPERATOR")) (LIST (QUOTE LOG) (INTERNKEY "1-ARY-OPERATOR")) (LIST (QUOTE REAL-SQRT) (INTERNKEY "1-ARY-OPERATOR")) (LIST (QUOTE +) (INTERNKEY "2-ARY-OPERATOR")) (LIST (QUOTE -) (INTERNKEY "2-ARY-OPERATOR")) (LIST (QUOTE *) (INTERNKEY "2-ARY-OPERATOR")) (LIST (QUOTE /) (INTERNKEY "2-ARY-OPERATOR")) (LIST (QUOTE /-) (INTERNKEY "2-ARY-OPERATOR")) (LIST (QUOTE REAL-EXPT) (INTERNKEY "2-ARY-OPERATOR")) (LIST (QUOTE REAL-IF) (INTERNKEY "3-ARY-OPERATOR"))) (GRAMMAR G45903) (PROGN (SETF (NAME G45917) (QUOTE LISP-MATH-FUNCTION-GRAMMAR-X) (PRODUCTIONS G45917) (LIST (LIST (QUOTE START) (QUOTE EXPRESION)) (LIST (QUOTE EXPRESION) (INTERNKEY "OPEN") (QUOTE 1-ARY-OPERATOR) (QUOTE EXPRESION) (INTERNKEY "CLOSE")) (LIST (QUOTE EXPRESION) (INTERNKEY "OPEN") (QUOTE 2-ARY-OPERATOR) (QUOTE EXPRESION) (QUOTE EXPRESION) (INTERNKEY "CLOSE")) (LIST (QUOTE EXPRESION) (INTERNKEY "OPEN") (QUOTE 3-ARY-OPERATOR) (QUOTE EXPRESION) (QUOTE EXPRESION) (QUOTE EXPRESION) (INTERNKEY "CLOSE")) (LIST (QUOTE EXPRESION) (QUOTE CONSTANT)) (LIST (QUOTE EXPRESION) (QUOTE VAR)) (LIST (QUOTE CONSTANT) (INTERNKEY "CONSTANT")) (LIST (QUOTE VAR) (INTERNKEY "VAR"))) (UPDATED-PRODUCTIONS G45917) (LIST (LIST (QUOTE START) (QUOTE EXPRESION)) (LIST (QUOTE EXPRESION) (INTERNKEY "OPEN") (QUOTE 1-ARY-OPERATOR) (QUOTE EXPRESION) (INTERNKEY "CLOSE")) (LIST (QUOTE EXPRESION) (INTERNKEY "OPEN") (QUOTE 2-ARY-OPERATOR) (QUOTE EXPRESION) (QUOTE EXPRESION) (INTERNKEY "CLOSE")) (LIST (QUOTE EXPRESION) (INTERNKEY "OPEN") (QUOTE 3-ARY-OPERATOR) (QUOTE EXPRESION) (QUOTE EXPRESION) (QUOTE EXPRESION) (INTERNKEY "CLOSE")) (LIST (QUOTE EXPRESION) (QUOTE CONSTANT)) (LIST (QUOTE EXPRESION) (QUOTE VAR)) (LIST (QUOTE CONSTANT) (INTERNKEY "CONSTANT")) (LIST (QUOTE VAR) (INTERNKEY "VAR")) (LIST (QUOTE 1-ARY-OPERATOR) (QUOTE ABS)) (LIST (QUOTE ABS) (INTERNKEY "1-ARY-OPERATOR")) (LIST (QUOTE 1-ARY-OPERATOR) (QUOTE SIN)) (LIST (QUOTE SIN) (INTERNKEY "1-ARY-OPERATOR")) (LIST (QUOTE 1-ARY-OPERATOR) (QUOTE COS)) (LIST (QUOTE COS) (INTERNKEY "1-ARY-OPERATOR")) (LIST (QUOTE 1-ARY-OPERATOR) (QUOTE SQR)) (LIST (QUOTE SQR) (INTERNKEY "1-ARY-OPERATOR")) (LIST (QUOTE 2-ARY-OPERATOR) (QUOTE +)) (LIST (QUOTE +) (INTERNKEY "2-ARY-OPERATOR")) (LIST (QUOTE 2-ARY-OPERATOR) (QUOTE -)) (LIST (QUOTE -) (INTERNKEY "2-ARY-OPERATOR")) (LIST (QUOTE 2-ARY-OPERATOR) (QUOTE *)) (LIST (QUOTE *) (INTERNKEY "2-ARY-OPERATOR")) (LIST (QUOTE 2-ARY-OPERATOR) (QUOTE /-)) (LIST (QUOTE /-) (INTERNKEY "2-ARY-OPERATOR")) (LIST (QUOTE 3-ARY-OPERATOR) (QUOTE 3-ARY-OPERATOR)) (LIST (QUOTE 2-ARY-OPERATOR) (QUOTE 2-ARY-OPERATOR)) (LIST (QUOTE 1-ARY-OPERATOR) (QUOTE 1-ARY-OPERATOR)) (LIST (QUOTE 3-ARY-OPERATOR) (QUOTE 3-ARY-OPERATOR)) (LIST (QUOTE 2-ARY-OPERATOR) (QUOTE 2-ARY-OPERATOR)) (LIST (QUOTE 1-ARY-OPERATOR) (QUOTE 1-ARY-OPERATOR)) (LIST (QUOTE 3-ARY-OPERATOR) (QUOTE 3-ARY-OPERATOR))) (TOKENS G45917) (LIST (LIST (QUOTE X) (INTERNKEY "VAR")) (LIST (QUOTE ABS) (INTERNKEY "1-ARY-OPERATOR")) (LIST (QUOTE SIN) (INTERNKEY "1-ARY-OPERATOR")) (LIST (QUOTE COS) (INTERNKEY "1-ARY-OPERATOR")) (LIST (QUOTE TAN) (INTERNKEY "1-ARY-OPERATOR")) (LIST (QUOTE SQR) (INTERNKEY "1-ARY-OPERATOR")) (LIST (QUOTE EXP) (INTERNKEY "1-ARY-OPERATOR")) (LIST (QUOTE LOG) (INTERNKEY "1-ARY-OPERATOR")) (LIST (QUOTE REAL-SQRT) (INTERNKEY "1-ARY-OPERATOR")) (LIST (QUOTE +) (INTERNKEY "2-ARY-OPERATOR")) (LIST (QUOTE -) (INTERNKEY "2-ARY-OPERATOR")) (LIST (QUOTE *) (INTERNKEY "2-ARY-OPERATOR")) (LIST (QUOTE /) (INTERNKEY "2-ARY-OPERATOR")) (LIST (QUOTE /-) (INTERNKEY "2-ARY-OPERATOR")) (LIST (QUOTE REAL-EXPT) (INTERNKEY "2-ARY-OPERATOR")) (LIST (QUOTE REAL-IF) (INTERNKEY "3-ARY-OPERATOR")) (LIST (INTERNKEY "OPEN") (INTERNKEY "OPEN")) (LIST (INTERNKEY "CLOSE") (INTERNKEY "CLOSE"))) (MINIMUM-PRODUCTION-SIZES G45917) (LET ((G45918 (MAKE-HASH-TABLE))) (SET-HASH G45918 (QUOTE START) 1 (QUOTE 2-ARY-OPERATOR) 1 (QUOTE COS) 1 (QUOTE VAR) 1 (QUOTE EXPRESION) 1 (QUOTE 1-ARY-OPERATOR) 1 (QUOTE +) 1 (QUOTE CONSTANT) 1 (QUOTE *) 1 (QUOTE /-) 1 (QUOTE 3-ARY-OPERATOR) 1000000 (QUOTE ABS) 1 (QUOTE SQR) 1 (QUOTE SIN) 1 (QUOTE -) 1) G45918) (LEXER G45917) (QUOTE LISP-MATH-EXPRESSION-LEXER) (PARSER-INITIALIZER G45917) (QUOTE INITIALIZE-LISP-MATH-EXPRESSION-PARSER) (CROSSOVER-TOKENS G45917) (LIST (INTERNKEY "1-ARY-OPERATOR") (INTERNKEY "2-ARY-OPERATOR") (INTERNKEY "3-ARY-OPERATOR") (INTERNKEY "EXPRESION")) (SKIP-INITIALIZATION G45917) T) G45917) (SPECIALIZED-TOKENS G45903) NIL) G45903) (ALGORITHM G45899) G45896 (TASK-BUILDER G45899) (PROGN (SETF (PROPERTIES-VALUES G45919) (MAKE-HASH-TABLE) (NAME G45919) "N runs task builder" (RUNS G45919) 1) G45919) (TASK-PLANIFIER G45899) (PROGN (SETF (PROPERTIES-VALUES G45920) (MAKE-HASH-TABLE) (NAME G45920) (QUOTE GLOBAL-RUNNING-IMAGE-PLANIFIER) (CONNECTION-ADMINISTRATOR G45920) (SYSTEM-GET (QUOTE MAIN-CONNECTION-ADMINISTRATOR)) (MAX-SIMULTANEOUS-PROCESSES G45920) 1) G45920)) G45899) (POPULATION G45896) NIL (POPULATION-SIZE G45896) 100 (SELECTION-METHOD G45896) (PROGN (SETF (PROPERTIES-VALUES G45921) (LET ((G45922 (MAKE-HASH-TABLE))) (SET-HASH G45922 (QUOTE FILTER-FUNCTION) NIL) G45922) (NAME G45921) (QUOTE TOURNAMENT-SELECTION-METHOD)) G45921) (INITIALIZATION-METHOD G45896) (PROGN (SETF (PROPERTIES-VALUES G45923) (MAKE-HASH-TABLE) (NAME G45923) (QUOTE RANDOM-TREES-INITIALIZER) (MIN-SIZE G45923) 1 (MAX-SIZE G45923) 5 (MIN-DEPTH G45923) 1 (MAX-DEPTH G45923) 5 (REPEAT-CONTROL G45923) NIL) G45923) (local-optimization G45896) NIL (REGISTRY G45896) (MAKE-HASH-TABLE) (MAX-GENERATIONS G45896) 200 (GENERATION G45896) 0 (BEST G45896) NIL (FRONTS G45896) NIL (DOMINANCE G45896) NIL (DOMINATED-COUNT G45896) NIL (RANK G45896) NIL (INDIVIDUALS G45896) NIL) G45896)))


;; Basic, one run version
(defun test-nsga-ii (a generations size)
  (setf (max-generations a) generations
        (population-size a) size
        (objetives a) (default-objetives 'entity-function-x))
  (time (search-loop a 20))
  (values (distance (best a)) 
          (my-round-to-3 (fitness a))))

;; Test run
(test-nsga-ii aa 10 10)
