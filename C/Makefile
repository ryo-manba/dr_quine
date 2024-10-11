COLLEEN = Colleen
GRACE   = Grace
SULLY   = Sully

NAMES = $(COLLEEN) $(GRACE) $(SULLY)
SRCS = Colleen.c Grace.c Sully.c
OBJS = $(SRCS:.c=.o)
CC = clang # clang was used in the subject sample
CFLAGS = -Wall -Wextra -Werror

.PHONY: all
all: $(NAMES)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

.PHONY: clean
clean:
	rm -rf $(OBJS)

.PHONY: fclean
fclean: clean
	rm -rf $(NAMES)
	rm -rf tmp_Colleen Grace_kid.c Sully_*

.PHONY: re
re: fclean all

.PHONY: test
test: test-c test-g test-s

.PHONY: test-colleen test-c
test-colleen: $(COLLEEN)
	./Colleen > tmp_Colleen ; diff tmp_Colleen Colleen.c

test-c: test-colleen

.PHONY: test-grace test-g
test-grace: $(GRACE)
	./Grace ; diff Grace_kid.c Grace.c

test-g: test-grace

.PHONY: test-sully test-s
test-sully: $(SULLY)
	./Sully
	for n in {5..0}; do \
		diff Sully.c Sully_$$n.c || echo "Difference found in Sully_$$n.c"; \
	done


test-s: test-sully