#include "../so_long.h"
#include <stdio.h>
#include  <unistd.h>


typedef struct	s_data {
	void	*img;
	char	*addr;
	int		bits_per_pixel;
	int		line_length;
	int		endian;
}				t_data;


void	my_mlx_pixel_put(t_data *data, int x, int y, int color)
{
	char	*dst;

	dst = data->addr + (y * data->line_length + x * (data->bits_per_pixel / 8));
	*(unsigned int*)dst = color;
}


typedef struct	s_game{
	void *mlx;
	void *win;
	void *wall;
	void *goblin;

}				t_game;
 


static void	key_move_step(t_game *game, int y, int x)
{
	mlx_put_image_to_window(game->mlx, game->win, \
	game->wall, 500, \
	500);
	mlx_put_image_to_window(game->mlx, game->win, \
	game->goblin, x, \
	y);
}



int	key_hook_press(int keycode, t_game *game)
{
	// if (keycode == Esc)
	// {
	// 	ft_putstr("Выход через esc\n");
	// 	mlx_destroy_window(game->graphics.mlx, game->graphics.win);
	// 	exit (0);
	// }
	// printf("HEEEEKKOOOOOOOOOOOOOO");
	printf("%d - keycode\n",keycode );
	key_move_step(game, 55*10, 55*12);
	return (1);
}

// int	key_hook(int keycode, t_game *vars)
// {
// 	// printf("HEEEEKKOOOOOOOOOOOOOO");
// 	printf("%d - keycode\n",keycode );
// 	// key_move_step(vars, 55*10, 55*12);
// 	return (1);
// }
// wdsa - 13 2 1 0
int	main(void)
{
	// t_data	img;
	t_game game;

	game.mlx = mlx_init();

	int zoom = 55;
	int x = 990;
	int y= 990;
	game.win = mlx_new_window(game.mlx, x, y, "so_long");
	int width = zoom;
	int length = zoom;
	game.wall = mlx_xpm_file_to_image(game.mlx, "wall.xpm", &width, &length);
	game.goblin = mlx_xpm_file_to_image(game.mlx, "goblin.xpm", &width, &length);
	while (x)
	{
		while (y)
		{
			mlx_put_image_to_window(game.mlx, game.win , game.wall, y - zoom , x - zoom);
			y = y - zoom;
		}
		y = 990;
		x = x - zoom;
	}
	// printf("HEEEEKKOOOOOOOOOOOOOO2");
	mlx_put_image_to_window(game.mlx, game.win , game.goblin, zoom*10 , zoom *10);
	// mlx_hook(game.win, 2, 1L<<0, key_hook_press, &game);
	mlx_hook(game.win, 2, 1L<<0, key_hook_press, &game);
	// pri/ntf("HEEEEKKOOOOOOOOOOOOOO3");
	mlx_loop(game.mlx);

}

//2 вверх
// 1 вниз
// 17 влево
// вправо
	// Esc = 53,
	// Up = 13,
	// Down = 1,
	// Right = 2,
	// Left = 0,
// Создать карту
// Соорудить стены
// СДелать Невского 
// Сделать Баженова
// Сделать куриные крылья
