NAME = Colleen
SRCS = Colleen.c
OBJS = $(SRCS:.c=.o)
CC = gcc
CFLAGS = -Wall -Wextra -Werror

all: $(NAME)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -rf $(OBJS)

fclean: clean
	rm -rf $(NAME)

re: fclean all

test: re
	./Colleen > tmp_Colleen ; diff tmp_Colleen Colleen.c

.PHONY: all clean fclean re
