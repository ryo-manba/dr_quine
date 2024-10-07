COLLEEN = Colleen
GRACE = Grace

NAMES = $(COLLEEN) $(GRACE)
SRCS = Colleen.c Grace.c
OBJS = $(SRCS:.c=.o)
CC = gcc
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
	rm -rf tmp_Colleen Grace_kid.c

.PHONY: re
re: fclean all

.PHONY: test
test: test-colleen

.PHONY: test-colleen
test-colleen: $(COLLEEN)
	./Colleen > tmp_Colleen ; diff tmp_Colleen Colleen.c

.PHONY: test-c
test-c: test-colleen

.PHONY: test-grace test-g
test-grace: $(GRACE)
	./Grace ; diff Grace_kid.c Grace.c

test-g: test-grace
