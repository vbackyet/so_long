# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: maxell <maxell@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/01/16 14:29:08 by rvoltigo          #+#    #+#              #
#    Updated: 2021/04/24 18:10:48 by maxell           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #



# Project config
NAME	= so_long

SRC_DIR	= src
LIB_DIR	= lib
OBJ_DIR	= obj
BIN_DIR	= .

# Sources
INCLUDE	= include

SRC		=	main.c							


SRC		:= $(addprefix $(SRC_DIR)/, $(SRC))

OBJ		:= $(SRC:$(SRC_DIR)/%.c=$(OBJ_DIR)/%.o)

# Compilation
CC			= clang

export	_CCFLAGS	?= -O3
export	_CPPFLAGS	?= -Wall -Werror -Wextra

bonus:	_CPPFLAGS	+= -D BONUS

# External libraries
LIBS	+= LIBFT

LIBFT			= $(LIBFT_DIR)/libft.a
LIBFT_DIR		= $(LIB_DIR)/libft
LIBFT_FLAGS		= -L$(LIBFT_DIR) -lft
LIBFT_INCLUDE	= $(LIBFT_DIR)/include
LIBFT_CLEAN		= $(MAKE) clean -C $(LIBFT_DIR)

LIBS	+= MLX

MLX				= $(MLX_DIR)/libmlx.a
MLX_DIR			= $(LIB_DIR)/libmlx-linux
MLX_FLAGS		= -L$(MLX_DIR) -lmlx -L/usr/lib -lXext -lX11 -lm -lz
MLX_INCLUDE		= $(MLX_DIR)
MLX_CLEAN		= $(MAKE) clean -C $(MLX_DIR)

# Some magic
LIB_FLAGS	= $(foreach LIB, $(LIBS), $($(LIB)_FLAGS))
LIB_FILES	= $(foreach LIB, $(LIBS), $($(LIB)))

INCLUDE		+= $(foreach LIB, $(LIBS), $($(LIB)_INCLUDE))

_CCFLAGS	+= $(addprefix -I, $(INCLUDE))

# Build targets
.PHONY:			all bonus
all bonus:
	$(foreach LIB, $(LIBS),			\
		$(MAKE) -C $($(LIB)_DIR);	\
	)
	$(MAKE) $(NAME)

$(NAME): 		$(OBJ) $(LIB_FILES) | $(BIN_DIR)
	$(CC) $(_CCFLAGS) $(filter-out $(LIB_FILES), $?) $(LIB_FLAGS) -o $@

$(OBJ_DIR)/%.o:	$(SRC_DIR)/%.c | $(OBJ_DIR)
	mkdir -p $(@D)
	$(CC) $(_CCFLAGS) $(_CPPFLAGS) -c $< -o $@

$(OBJ_DIR) 		$(BIN_DIR):
	mkdir -p $@

# Utility targets
.PHONY:		clean
clean:
	$(RM) -rf $(OBJ)
	$(RM) -rf $(OBJ_DIR)/*
	$(foreach LIB, $(LIBS),			\
		$($(LIB)_CLEAN) ;			\
	)

.PHONY:		fclean
fclean:		clean
	$(RM) -rf $(NAME)
	$(foreach LIB, $(LIBS),			\
		$(RM) -rf $($(LIB)) ;		\
	)

.PHONY:		re
re:			fclean
	$(MAKE)