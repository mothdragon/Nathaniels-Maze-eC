import "ecere"
import "MainProg"

class form_PauseMenu : Window
{
   caption = "Pause";
   background = activeBorder;
   size = { 468, 348 };
   anchor = { left = 278, top = 210 };
   mergeMenus = false;
   autoCreate = false;

   Picture gr_PauseMenu { this, position = {  }, image = { ":PauseMenu.png" } };
   Button btn_Resume 
   { 
      gr_PauseMenu, this, opacity = 0, size = { 450, 21 }, position = { 8, 152 }, bevel = false, bitmap = { ":Resume Button.png" };
      bool NotifyClicked(Button button, int x, int y, Modifiers mods)
      {
         Destroy(0);
         return true;
      }
   };
   Button btn_Restart 
   { 
      gr_PauseMenu, this, opacity = 0, size = { 450, 21 }, position = { 8, 184 }, bevel = false, bitmap = { ":Restart Button.png" };
      bool NotifyClicked(Button button, int x, int y, Modifiers mods)
      {
         if(MessageBox { type = yesNo, caption = "Restart?", contents = "Do you really want to start the Level again?" }.Modal() == yes)
         {
            program.gameScore -= 100;
            program.gameTries--;
            program.levelTime = 30 + (program.level * 15);
            if(program.gameTries < 0) program.gameOverFlag = true;
            program.gameWin.Destroy(0);
            program.gameWin.Create();
            Destroy(0);
         }
         return true;
      }
   };
   Button btn_PauseQuit 
   { 
      gr_PauseMenu, this, opacity = 0, size = { 450, 21 }, position = { 8, 216 }, bevel = false, bitmap = { ":Quit Button.png" };
      bool NotifyClicked(Button button, int x, int y, Modifiers mods)
      {
         if(MessageBox { type = yesNo, caption = "Quit?", contents = "Do you really want to quit?" }.Modal() == yes)
         {
            program.gameWin.Destroy(0);
            program.mainMenu.Create();
            Destroy(0);
         }
         return true;
      }
   };
   bool OnCreate()
   {
      program.gameWin.screenRefresh.Stop();
      return true;
   }

   void OnDestroy()
   {
      program.gameWin.screenRefresh.Start();
   }


}
