import "ecere"

class form_ScoreBar : Window
{
   caption = "Form4";
   background = black;
   size = { 1024, 16 };
   position = {  };

   Label levelLabel { this, caption = "Level:", background = black, foreground = gold, font = { "Tahoma", 10 }, size = { 36, 13 }, position = { 320 } };
   Label level { this, caption = "1", background = black, foreground = gold, font = { "Tahoma", 10 }, size = { 23, 16 }, position = { 360 } };
   Label timeLabel { this, caption = "Time:", background = black, foreground = gold, font = { "Tahoma", 10 }, position = { 600 } };
   Label time { this, caption = "9,999", background = black, foreground = gold, font = { "Tahoma", 10 }, size = { 40, 16 }, position = { 640 } };
   Label triesLabel { this, caption = "Tries Left:", background = black, foreground = gold, font = { "Tahoma", 10 }, position = { 8 } };
   Label tries { this, caption = "3", background = black, foreground = gold, font = { "Tahoma", 10 }, size = { 44, 13 }, position = { 80 } };
   Label scoreLabel { this, caption = "Score:", foreground = gold, font = { "Tahoma", 10 }, size = { 44, 21 }, position = { 896 } };
   Label score { this, caption = "000,000,000", background = black, foreground = gold, font = { "Tahoma", 10 }, position = { 944 } };
}
