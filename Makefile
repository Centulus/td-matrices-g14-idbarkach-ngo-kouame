CC = gcc
CFLAGS = -std=c11 -Wall -Wextra -Wpedantic -g

PROGRAMMES = demo_matrices test_ex1 test_ex2 test_ex3

all: $(PROGRAMMES)

# Programme de demonstration (sans -DMAT_TEST_ALLOC)
demo_matrices: main.o matrice.o matrice_alloc.o matrice_io.o matrice_calcul.o
	$(CC) $(CFLAGS) $^ -o $@

# Programmes de test : matrice_alloc est recompile avec -DMAT_TEST_ALLOC
test_ex1: test_ex1.o matrice.o matrice_alloc_test.o
	$(CC) $(CFLAGS) $^ -o $@

test_ex2: test_ex2.o matrice.o matrice_alloc_test.o matrice_io.o
	$(CC) $(CFLAGS) $^ -o $@

test_ex3: test_ex3.o matrice.o matrice_alloc_test.o matrice_calcul.o
	$(CC) $(CFLAGS) $^ -o $@

# Compilation separee
matrice.o: matrice.c matrice.h
	$(CC) $(CFLAGS) -c $< -o $@

matrice_alloc.o: matrice_alloc.c matrice_alloc.h matrice.h
	$(CC) $(CFLAGS) -c $< -o $@

matrice_alloc_test.o: matrice_alloc.c matrice_alloc.h matrice.h
	$(CC) $(CFLAGS) -DMAT_TEST_ALLOC -c $< -o $@

matrice_io.o: matrice_io.c matrice_io.h matrice_alloc.h matrice.h
	$(CC) $(CFLAGS) -c $< -o $@

matrice_calcul.o: matrice_calcul.c matrice_calcul.h matrice_alloc.h matrice.h
	$(CC) $(CFLAGS) -c $< -o $@

main.o: main.c matrice.h matrice_alloc.h matrice_io.h matrice_calcul.h
	$(CC) $(CFLAGS) -c $< -o $@

test_ex1.o: test_ex1.c matrice.h matrice_alloc.h
	$(CC) $(CFLAGS) -DMAT_TEST_ALLOC -c $< -o $@

test_ex2.o: test_ex2.c matrice.h matrice_alloc.h matrice_io.h
	$(CC) $(CFLAGS) -DMAT_TEST_ALLOC -c $< -o $@

test_ex3.o: test_ex3.c matrice.h matrice_alloc.h matrice_calcul.h
	$(CC) $(CFLAGS) -DMAT_TEST_ALLOC -c $< -o $@

clean:
	rm -f *.o $(PROGRAMMES)

.PHONY: all clean
