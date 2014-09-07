import "ecere"
import "MainProg"

class form_HSMenu : Window
{
   caption = "High Scores";
   background = activeBorder;
   size = { 468, 348 };
   anchor = { left = (1024 - 468)/2, top = (768 - 348)/2 };
   autoCreate = false;

   Picture gr_HighScoresMenu { this, position = {  }, image = { ":HighScores.png" } };
   Label label1 { gr_HighScoresMenu, this, "1.", foreground = gold, font = { "Tahoma", 12 }, size = { 28, 21 }, position = { 64, 136 } };
   Label label2 { gr_HighScoresMenu, this, "2.", foreground = gold, font = { "Tahoma", 12 }, size = { 28, 21 }, position = { 64, 160 } };
   Label label3 { gr_HighScoresMenu, this, "3.", foreground = gold, font = { "Tahoma", 12 }, size = { 28, 21 }, position = { 64, 184 } };
   Label label4 { gr_HighScoresMenu, this, "4.", foreground = gold, font = { "Tahoma", 12 }, size = { 28, 21 }, position = { 64, 208 } };
   Label label5 { gr_HighScoresMenu, this, "5.", foreground = gold, font = { "Tahoma", 12 }, size = { 28, 21 }, position = { 64, 232 } };

   Label hScore1 { gr_HighScoresMenu, this, foreground = gold, font = { "Tahoma", 12 }, size = { 116, 21 }, position = { 96, 136 } };
   Label dots1 { gr_HighScoresMenu, this, "___________________________________________________________________", foreground = gold, font = { "Tahoma", 12 }, size = { 308, 21 }, position = { 96, 136 } };
   Label nScore1 { gr_HighScoresMenu, this, background = black, foreground = gold, font = { "Tahoma", 12 }, size = { 76, 21 }, position = { 328, 136 } };

   Label hScore2 { gr_HighScoresMenu, this, foreground = gold, font = { "Tahoma", 12 }, size = { 116, 21 }, position = { 96, 160 } };
   Label dots2 { gr_HighScoresMenu, this, "___________________________________________________________________", foreground = gold, font = { "Tahoma", 12 }, size = { 308, 21 }, position = { 96, 160 } };
   Label nScore2 { gr_HighScoresMenu, this, background = black, foreground = gold, font = { "Tahoma", 12 }, size = { 76, 21 }, position = { 328, 160 } };

   Label hScore3 { gr_HighScoresMenu, this, foreground = gold, font = { "Tahoma", 12 }, size = { 116, 21 }, position = { 96, 184 } };
   Label dots3 { gr_HighScoresMenu, this, "___________________________________________________________________", foreground = gold, font = { "Tahoma", 12 }, size = { 308, 21 }, position = { 96, 184 } };
   Label nScore3 { gr_HighScoresMenu, this, background = black, foreground = gold, font = { "Tahoma", 12 }, size = { 76, 21 }, position = { 328, 184 } };

   Label hScore4 { gr_HighScoresMenu, this, foreground = gold, font = { "Tahoma", 12 }, size = { 116, 21 }, position = { 96, 208 } };
   Label dots4 { gr_HighScoresMenu, this, "___________________________________________________________________", foreground = gold, font = { "Tahoma", 12 }, size = { 308, 21 }, position = { 96, 208 } };
   Label nScore4 { gr_HighScoresMenu, this, background = black, foreground = gold, font = { "Tahoma", 12 }, size = { 76, 21 }, position = { 328, 208 } };

   Label hScore5 { gr_HighScoresMenu, this, foreground = gold, font = { "Tahoma", 12 }, size = { 116, 21 }, position = { 96, 232 } };
   Label dots5 { gr_HighScoresMenu, this, "___________________________________________________________________", foreground = gold, font = { "Tahoma", 12 }, size = { 308, 21 }, position = { 96, 232 } };
   Label nScore5 { gr_HighScoresMenu, this, background = black, foreground = gold, font = { "Tahoma", 12 }, size = { 76, 21 }, position = { 328, 232 } };

   Button btn_Cancel { gr_HighScoresMenu, this, opacity = 0, size = { 450, 21 }, position = { 8, 264 }, bevel = false, bitmap = { ":Cancel Button.png" } ;
      bool NotifyClicked(Button button, int x, int y, Modifiers mods)
      {
			Destroy(0);
         program.mainMenu.Create();
			return true;
		}
	};

   bool OnCreate()
   {
      if(program.highScores[0])
      {
         hScore1.caption = program.hsList[0].text;
         nScore1.caption = PrintString(program.hsList[0].number);
      }
      else
         hScore1.caption = "Error";

      if(program.highScores[1])
      {
         hScore2.caption = program.hsList[1].text;
         nScore2.caption = PrintString(program.hsList[1].number);
      }
      else
         hScore2.caption = "Error";

      if(program.highScores[2])
      {
         hScore3.caption = program.hsList[2].text;
         nScore3.caption = PrintString(program.hsList[2].number);
      }
      else
         hScore3.caption = "Error";

      if(program.highScores[3])
      {
         hScore4.caption = program.hsList[3].text;
         nScore4.caption = PrintString(program.hsList[3].number);
      }
      else
         hScore4.caption = "Error";

      if(program.highScores[4])
      {
         hScore5.caption = program.hsList[4].text;
         nScore5.caption = PrintString(program.hsList[4].number);
      }
      else
         hScore5.caption = "Error";

      return true;
   }}
