import "ecere"
import "MainProg"

class YouMadeHS : Window
{
   caption = "Form7";
   background = activeBorder;
   size = { 468, 348 };
   autoCreate = false;

   Picture picture1 { this, caption = "picture1", position = {  }, image = { ":YouMadeHSMenu.png" } };
   EditBox winnerName { this, caption = "editBox1", font = { "Tahoma", 12 }, size = { 246, 27 }, position = { 112, 232 }, maxLineSize = 15, 1 };
   Button button1 { this, this, isDefault = true, opacity = 0, size = { 66, 21 }, position = { 192, 280 }, bevel = false, bitmap = { ":Save Button.png" };
      bool NotifyClicked(Button button, int x, int y, Modifiers mods)
      {
         char location[MAX_LOCATION];
         String user = getenv("USERPROFILE");
         File file_highScores;

         MyList tmpList {winnerName.contents, "...", program.gameScore};
         int index = 0, rev;

         if(user) strcpy(location, user); else location[0] = 0;
         PathCat(location, "NsMazeHighScores.txt");
         file_highScores = FileOpen(location, write);

         for(i : program.hsList)
         {
            if(program.gameScore > program.hsList[index].number) 
            {
// --==[[ Slide all the highscores down one, and then put in the new one ]]=--
               for(rev = 3; rev >= index; rev--)
               {
                  int check = rev + 1;
                  program.hsList[check] = program.hsList[rev];
               }
               program.hsList[index] = tmpList;
               program.highScores[index] = PrintString(program.hsList[index].text, program.hsList[index].junk, program.hsList[index].number);
               break;
            }
            index++;
         }
         for(index = 0; index < 5; index++)
         {
            program.highScores[index] = PrintString(program.hsList[index].text, "^", program.hsList[index].number);
         }

         if(file_highScores)
         {
            for(index = 0; index < 5; index++)
            {
               file_highScores.PrintLn(program.highScores[index]);
            }
            delete file_highScores;
         }
         Destroy(0);
         program.highscoresMenu.Create();
         return true;
      }      
   };

   bool OnCreate()
   {
      winnerName.MakeActive();
      return true;
   }
}
/*
Nobody^0
Nobody^0
Nobody^0
Nobody^0
Nobody^0
*/

/* Notes from Jerome:

ESphynx> you're still doing stuff  you shouldn't be doing in OnRedraw :P
<ESphynx>             if((sprites[0].dest.x / TILESIZE) == player.x - 1 && (sprites[0].dest.y/TILESIZE) == player.y - 1)
<ESphynx>             {
<ESphynx>                Destroy(0);
<ESphynx> things like this is a no-no :P
<ESphynx> not in OnRedraw... should be in a timer, or in the GuiApplication() cycle... right after updating the position
<ESphynx> imagine a window in the middle of trying to render itself, and its rendering code commits suicide :P
<ESphynx> I'll also giv eyou a suggestion to rewrite
<ESphynx>          if(GetKeyState(left))  
<ESphynx>          {
<ESphynx>             if(program.gameWin.level[program.gameWin.player.y * program.levelW + (program.gameWin.player.x - 1)] == floor) program.gameWin.player.Move(WEST); 
<ESphynx>          }
<ESphynx> etc.
00:37 <ESphynx>          GameWindow gameWin = program.gameWin;
<ESphynx>          Character player = gameWin.player;
<ESphynx>          Array<TileType> level = gameWin.level;
00:38 <ESphynx>          if(GetKeyState(left) && player.x > 1 &&level[player.y * program.levelW + (player.x - 1)] == floor) player.Move(WEST); 
<ESphynx> it should check for player.c > 1 before access with player.x-1
*/