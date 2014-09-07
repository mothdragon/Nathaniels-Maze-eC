import "ecere"
import "MainProg"

class GameOver : Window
{
   caption = "Game Over";
   background = activeBorder;
   opacity = 0;
   size = { 299, 38 };
   position = { 381, -38 };
   autoCreate = false;

   String sLevel, sLevelTime, sGameScore, sGameTries;

   Picture picture1 { this, caption = "picture1", position = {  }, image = { ":GameOver.png" } };

   bool OnCreate()
   {
      sLevel = PrintString(program.level);
      sLevelTime = PrintString(program.levelTime);
      sGameScore = PrintString(program.gameScore);
      sGameTries = PrintString(program.gameTries);

      program.scoreBar.tries.caption = sGameTries;
      program.scoreBar.score.caption = sGameScore;
      program.scoreBar.time.caption = sLevelTime;
      program.scoreBar.level.caption = sLevel;

      program.gameRunningFlag = false;

      return true;
   }

   ~GameOver()
   {
      delete sLevel;
      delete sLevelTime;
      delete sGameScore;
      delete sGameTries;
   }

   bool OnKeyHit(Key key, unichar ch)
   {
      switch(key)
      {
         case escape:
         case enter:
         {
            program.gameWin.Destroy(0);
            program.gameOver.Destroy(0);
            program.gameOver.position.y = -38;
            if(program.gameScore >= program.hsList[4].number) 
               program.youMadeHS.Create();
            else
               program.highscoresMenu.Create();
            break;
         }
      }
      return true;
   }
}
