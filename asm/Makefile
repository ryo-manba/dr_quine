COLLEEN = Colleen
GRACE   = Grace
SULLY   = Sully

NAMES = $(COLLEEN) # $(GRACE) $(SULLY)
SRCS = Colleen.s # Grace.s Sully.s
OBJS = $(SRCS:.s=.o)
# CC = clang # clang was used in the subject sample
CC = gcc
CFLAGS = -Wall -Wextra -Werror

NASM = nasm
NASMFLAGS = -f elf64

.PHONY: all
all: $(NAMES)

%.o: %.s
	$(NASM) $(NASMFLAGS) $< -o $@

.PHONY: clean
clean:
	rm -rf $(OBJS)

.PHONY: fclean
fclean: clean
	rm -rf $(NAMES)
	rm -rf tmp_Colleen Grace_kid.s Sully_*

.PHONY: re
re: fclean all

.PHONY: test
test: test-c test-g test-s

$(COLLEEN): Colleen.s
	$(NASM) $(NASMFLAGS) Colleen.s -o Colleen.o
	$(CC) $(CFLAGS) Colleen.o -o Colleen

c: $(COLLEEN)

.PHONY: test-colleen test-c
test-colleen: $(COLLEEN)
	./Colleen > tmp_Colleen ; diff tmp_Colleen Colleen.s

test-c: test-colleen

.PHONY: test-grace test-g
test-grace: $(GRACE)
	./Grace ; diff Grace_kid.s Grace.s

test-g: test-grace

.PHONY: test-sully test-s
test-sully: $(SULLY)
	./Sully
	for n in {5..0}; do \
		diff Sully.s Sully_$$n.s || echo "Difference found in Sully_$$n.s"; \
	done

test-s: test-sully