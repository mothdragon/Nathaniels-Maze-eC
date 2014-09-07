import "ecere"
import "Game" 
import "form1"
import "form2"
import "form3"
import "form4"
import "form5"
import "form6"
import "form7"
import "form8"
import "Highscores"


enum Bonus { moneyBag, extraTry, extraTime };

struct MyList
{
   String text;
   String junk;
   int number;
};

class MainFrame : Window
{
   icon = { ":MazeIcon.png" };
   caption = "Nathaniel's Maze";
   background = black;
   foreground = white;
   borderStyle = fixed;
   hasClose = true;
   clientSize = { 1024, 768 };
   nativeDecorations = false;

   int level, levelW, levelH;
   float levelTime;
   int gameScore;
   int gameTries;
   bool gameWonFlag;
   bool gameOverFlag;
   bool gameRunningFlag;
   int randSeed;
   Array<String>highScores {size = 5};
   Array<MyList>hsList {size = 5};

   form_MainMenu mainMenu {this};
   form_PauseMenu pauseMenu {this};
   form_OptionsMenu optionsMenu {this};
   GameWindow gameWin {this};
   form_ScoreBar scoreBar {gameWin};
   TimesUp timesUp {gameWin};
   GameOver gameOver {gameWin};
   form_HSMenu highscoresMenu {this};
   YouMadeHS youMadeHS{this};
   Form8 gameWon{this};

   bool OnCreate()
   {
      int i = 0;

      char location[MAX_LOCATION];
      String user = getenv("USERPROFILE");
      File file_highScores;
      if(user) strcpy(location, user); else location[0] = 0;
      PathCat(location, "NsMazeHighScores.txt");

      //File file_highScores = FileOpen("C:\\Users\\Charlie\\Documents\\Programming\\ecMaze\\Data\\HighScores.txt", readWrite);
      file_highScores = FileOpen(location, readWrite);
      if(file_highScores)
      {
         highScores.Free();
         while(!file_highScores.eof)
         {
            char buffer[1024];
            if(file_highScores.GetLine(buffer, sizeof(buffer)))
               highScores.Add(CopyString(buffer));
         }
         delete file_highScores;
         for(r : highScores)
         {
            char* hsTokens[2];
            char* tmpToken;
            TokenizeWith(highScores[i], 2, hsTokens, "^", false);
            hsList[i].text = hsTokens[0];
            hsList[i].number = atoi(hsTokens[1]);
            highScores[i] = PrintString(hsTokens[0], "^", hsTokens[1]);
            i++;
         }
        
      }
      level = 0;
      RandomSeed((uint)(GetTime() * 1000));
      randSeed = GetRandom(0, 9999999);
      return true;
   }

   ~MainFrame()
   {
      highScores.Free();
      hsList.Free();
   }
}

MainFrame program { };

