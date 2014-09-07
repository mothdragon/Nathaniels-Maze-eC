import "ecere"
import "MainProg"

class form_MainMenu : Window
{
   background = black;
   borderStyle = none;
   clientSize = { 468, 348 };
   anchor = { left = (1024 - 468)/2, top = (768 - 348)/2 };

   Picture gr_MainMenu { this, position = { 0, 0 }, image = { ":MainMenu.png" } };
   Button btn_Start 
   { 
      gr_MainMenu, this, opacity = 0, size = { 450, 21 }, position = { 8, 152 }, bevel = false, bitmap = { ":Start Button.png" };
      bool NotifyClicked(Button button, int x, int y, Modifiers mods)
      {
         Destroy(0);
         program.gameRunningFlag = true;
         if(!program.level) program.level = 1;
         program.gameScore = 0;
         program.levelTime = 30 + (program.level * 15);
         program.gameTries = 2;
         program.gameOverFlag = false;
         if(program.level > 30) program.gameOverFlag = true;
         program.gameWin.Create();
         
         return true;
      }
   };
   Button btn_Options 
   { 
      gr_MainMenu, this, opacity = 0, size = { 450, 21 }, position = { 8, 184 }, bevel = false, bitmap = { ":Options Button.png" };
      bool NotifyClicked(Button button, int x, int y, Modifiers mods)
      {
         program.optionsMenu.Create();
         return true;
      }
   };
   Button btn_HighScores 
   { 
      gr_MainMenu, this, opacity = 0, size = { 450, 21 }, position = { 8, 216 }, bevel = false, bitmap = { ":HighScores Button.png" }; 
      bool NotifyClicked(Button button, int x, int y, Modifiers mods)
      {
         Destroy(0);
         program.highscoresMenu.Create();
         return true;
      }
   };
   Button btn_Quit 
   {
      gr_MainMenu, this, opacity = 0, size = { 450, 21 }, position = { 8, 248 }, bevel = false, bitmap = { ":Quit Button.png" };

      bool NotifyClicked(Button button, int x, int y, Modifiers mods)
      {
         if(MessageBox { type = yesNo, caption = "Quit?", contents = "Do you really want to quit?" }.Modal() == yes)
            program.Destroy(0);
         return true;
      }
   };
}
