import "ecere"
import "MainProg"

class TimesUp : Window
{
   caption = "Time's Up!";
   background = activeBorder;
   opacity = 0;
   size = { 263, 38 };
   position = { 381, -38 };
   autoCreate = false; 

   Picture picture1 { this, caption = "picture1", position = {  }, image = { ":Timesup.png" } };

   bool OnKeyHit(Key key, unichar ch)
   {
      if(key == escape)
      {
         program.gameWin.Destroy(0);
         program.timesUp.Destroy(0);
         program.timesUp.position.y = -38;
         program.gameScore = program.gameScore - 100;
         program.levelTime = 30 + (program.level * 15);
         program.gameTries--;
         if(program.gameTries < 0) program.gameOverFlag = true;
         program.gameWin.screenRefresh.Start();
         program.gameWin.Create();
         return false;
      }
      
      return true;
   }
}
