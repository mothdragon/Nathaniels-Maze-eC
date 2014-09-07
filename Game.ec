public import "ecere"
import "MainProg"

#define TILESIZE 72
#define X_OFFSET (512 - (int)((program.levelW * (TILESIZE * (program.gameWin.levelScale / 100))) / 2))
#define Y_OFFSET 16
#define NORTH 0
#define SOUTH 1
#define EAST 2
#define WEST 3

BitmapResource tilesetGfx { ":Tileset.png" };
BitmapResource timesUpBouncer { ":Timesup.png" };

enum TileType
{ nothing, bush, floor; 
   void Render(Surface surface, Array<TileContents> contents, int x, int y, float scale) 
   { 
      int scaleX, scaleY;
      TileContents c = contents[this]; 
      scale = scale / 100;
      scaleX = (int)(c.size.x * scale + 0.5);
      scaleY = (int)(c.size.y * scale + 0.5);
      if(c) 
      { 
         Bitmap bmp = c.res ? c.res.bitmap : null; 
         if(bmp) 
         { 
            surface.Stretch(bmp, x + X_OFFSET, y + Y_OFFSET, c.src.x, c.src.y, scaleX, scaleY, c.size.x, c.size.y);
         }
      } 
    }
};

enum SpriteType
{ exit, bag, face, clock; 
   void Render(Surface surface, Array<Sprite> contents, float scale) 
   { 
      int scaleX, scaleY, xLoc, yLoc;
      Sprite s = contents[this]; 
      scale = scale / 100;
      scaleX = (int)(s.size.x * scale + 0.5);
      scaleY = (int)(s.size.y * scale + 0.5);
      xLoc = (int)(s.dest.x * scale + 0.5);
      yLoc = (int)(s.dest.y * scale + 0.5);

      if(s) 
      { 
         Bitmap bmp = s.res ? s.res.bitmap : null; 
         if(bmp) 
         { 
            if(GetTime()* 1000 - s.lastTime > 1)
            {
               int srcOffset;
               if(s.frameStep++ >= s.numFrames) s.frameStep = 0;
               srcOffset = s.frameStep * s.size.x;
               surface.Stretch(bmp, xLoc + X_OFFSET, yLoc + Y_OFFSET, s.src.x + srcOffset, s.src.y, scaleX, scaleY, s.size.x, s.size.y);
               s.lastTime = GetTime() * 1000;
            }
         }
      } 
   }
};



class Character
{
   int x, y, xMod, yMod;
   Time lastTime;
   Sprite s {tilesetGfx, {0, 72}, {TILESIZE, TILESIZE * 2}, numFrames = 3 };
   bool move;
   int moveDir;
   int moveStep;
   int frameNum;
   void setLoc(int setX, int setY)
   {
      x = setX;
      y = setY;
      s.dest.x = x * TILESIZE;
      s.dest.y = (y * TILESIZE) - TILESIZE;
      xMod = 0;
      yMod = 0;
      frameNum = 0;
      moveDir = SOUTH;
      moveStep = TILESIZE / 2;
   }
  
   void Move(int dir)
   {
      move = true;
      moveDir = dir;
   }

   void Animate()
   {
      if(((GetTime() * 1000) - lastTime > 1/10) && move)
      {
         switch(moveDir)
         {
            case NORTH:
            {
               yMod = yMod + moveStep;
               s.dest.y = y * (TILESIZE - 1) - (TILESIZE - 1) - yMod;
               s.src.x = 288;
               s.src.y = 72;
               if(s.frameStep++ >= s.numFrames) s.frameStep = 0;
               if(yMod >= TILESIZE)
               {
                  yMod = 0;
                  y--;
                  move = false;
                  s.dest.y = y * (TILESIZE - 1) - (TILESIZE - 1);
               }
               break;
            }
            case SOUTH:
            {
               yMod = yMod + moveStep;
               s.dest.y = y * (TILESIZE - 1) - (TILESIZE - 1) + yMod;
               s.src.x = 0;
               s.src.y = 72;
               if(s.frameStep++ >= s.numFrames) s.frameStep = 0;
               if(yMod >= TILESIZE)
               {
                  yMod = 0;
                  y++;
                  move = false;
                  s.dest.y = y * (TILESIZE - 1) - (TILESIZE - 1);
               }
               break;
            }
            case WEST:
            {
               xMod = xMod + moveStep;
               s.dest.x = x * (TILESIZE - 1) - xMod;
               s.src.x = 0;
               s.src.y = 216;
               if(s.frameStep++ >= s.numFrames) s.frameStep = 0;
               if(xMod >= TILESIZE)
               {
                  xMod = 0;
                  x--;
                  move = false;
                  s.dest.x = x * (TILESIZE - 1);
               }
               break;
            }
            case EAST:
            {
               xMod = xMod + moveStep;
               s.dest.x = x * (TILESIZE - 1) + xMod;
               s.src.x = 288;
               s.src.y = 216;
               if(s.frameStep++ >= s.numFrames) s.frameStep = 0;
               if(xMod >= TILESIZE)
               {
                  xMod = 0;
                  x++;
                  move = false;
                  s.dest.x = x * (TILESIZE - 1);
               }
               break;
            }
         }
         lastTime = GetTime();
      }
   }

   void Render(Surface surface, float scale) 
   { 
      int scaleX, scaleY, xLoc, yLoc;
      scale = scale / 100;
      scaleX = (int)(s.size.x * scale);
      scaleY = (int)(s.size.y * scale);
      xLoc = (int)(s.dest.x * scale);
      yLoc = (int)(s.dest.y * scale);

      if(s) 
      { 
         Bitmap bmp = s.res ? s.res.bitmap : null; 
         if(bmp) 
         { 
            if(GetTime()* 1000 - s.lastTime > 1)
            {
               int srcOffset;
               srcOffset = s.frameStep * s.size.x;
               surface.Stretch(bmp, xLoc + X_OFFSET, yLoc + Y_OFFSET, s.src.x + srcOffset, s.src.y, scaleX, scaleY, s.size.x, s.size.y);
               s.lastTime = GetTime() * 1000;
            }
         }
      } 
   }
}

struct Cell
{
   bool visited;
   int dir[4];
};

class TileContents
{
public:
   BitmapResource res;
   Point src, size;
}

class Sprite : TileContents
{
   int numFrames, frameStep;
   Point dest;
   Time lastTime;
   void setDest(int x, int y)
   {
      dest.x = x;
      dest.y = y;
   }
}

class GameWindow : Window
{
   background = black;
   clientSize = { 1024, 768 };
   autoCreate = false;

   int levelW, levelH;
   float levelScale;

   String sLevel;
   String sLevelTime;
   String sGameScore;
   String sGameTries;

   Timer screenRefresh 
   { 
      this;
      delay = 0.01;
      started = true;
      bool DelayExpired()
      {
         Update(null);
         return true;
      }
   };

   Array<TileContents> tiles 
   {[ 
      null, //nothing
      { tilesetGfx, {0, 0}, {TILESIZE, TILESIZE} }, //bush
      { tilesetGfx, {72, 0}, {TILESIZE, TILESIZE} }  //floor
   ]};

   Array<Sprite> sprites
   {[ 
      {tilesetGfx, {144, 0}, {TILESIZE, TILESIZE}, numFrames = 3 }, //exit
      {tilesetGfx, {438, 0}, {TILESIZE, TILESIZE} }, //Money Bag
      {tilesetGfx, {504, 0}, {TILESIZE, TILESIZE} }, //Extra Try
      {tilesetGfx, {576, 0}, {TILESIZE, TILESIZE} } //Pause Clock     
   ]};

   Array<int> dMoveX{[0, 0, 2, -2]};
   Array<int> dMoveY{[-2, 2, 0, 0]};

   levelScale = 100;
   Array<TileType> level { };
   //then you can access a spot in the level as level[levelW * y + x]
   Array<Cell> maze{ };
   Array<SpriteType> spriteList { size = 5 };
   
   Character player {};

   bool OnCreate()
   {
      sLevel = PrintString(program.level);
      sLevelTime = PrintString(program.levelTime);
      sGameScore = PrintString(program.gameScore);
      sGameTries = PrintString(program.gameTries);

      program.levelW = 11 + (program.level * 2);
      program.levelH = 9 + (program.level * 2);
      level.size = program.levelW * program.levelH;

      levelScale = (768 / ((float)program.levelH * TILESIZE)) * 100;
      maze.size = program.levelW * program.levelH;
      RandomSeed(program.randSeed);
      if(program.level > 30)
      {
         program.gameOverFlag = true;
         program.gameWonFlag = true;
      }
      screenRefresh.Start();

      spriteList[0] = exit;//exit;
      spriteList[1] = bag;//bag;
      sprites[1].dest.x = -80;
      sprites[1].dest.y = -80;
      spriteList[2] = face;
      sprites[2].dest.x = -80;
      sprites[2].dest.y = -80;
      spriteList[3] = clock;
      sprites[3].dest.x = -80;
      sprites[3].dest.y = -80;


      doMaze();
      return true;
   }

   bool OnLoadGraphics()
   {
      AddResource(tilesetGfx);
      return true;
   }

   void OnUnloadGraphics()
   {
      RemoveResource(tilesetGfx);
   }

   void OnDestroy()
   {

   }

   void OnRedraw(Surface surface)
   {
      if(program.gameWonFlag) program.gameWon.Create();
      if(program.gameOverFlag) 
      {
         program.gameOver.Create();
         if(program.gameOver.position.y < 365) program.gameOver.position.y += 5;
      }
      if(!program.gameOverFlag)
      {
         int y;    
/*
//--==[[ Time's Up, so tell the player ]]==--
         if(program.levelTime <= 0) 
         {
            program.timesUp.Create();
            if(program.timesUp.position.y < 365) program.timesUp.position.y += 5;
         }
         else
         {
            program.levelTime = program.levelTime - 0.1;
            delete sLevelTime; // Make sure that this string is empty for us
            sLevelTime = PrintString((int)program.levelTime);
            delete sGameScore;
            sGameScore = PrintString((int)program.gameScore);
            delete sGameTries;
            sGameTries = PrintString((int)program.gameTries);

            program.scoreBar.tries.caption = sGameTries;
            program.scoreBar.score.caption = sGameScore;
            program.scoreBar.time.caption = sLevelTime;
            program.scoreBar.level.caption = sLevel;
   
            //--==[[ Has Player reached the exit? ]]==--
            if((sprites[0].dest.x / TILESIZE) == player.x - 1 && (sprites[0].dest.y/TILESIZE) == player.y - 1)
            {
               Destroy(0);
               program.level++;
               program.gameScore = program.gameScore + 100 + (program.levelTime * 2);
               program.levelTime = 30 + (program.level * 15);
               Create();
               screenRefresh.Start();
            }
//--==[[ Player got a money Bag so reward them ]]==--
            else if((sprites[1].dest.x / TILESIZE) == player.x - 1 && (sprites[1].dest.y/TILESIZE) == player.y - 1)
            {
               sprites[1].dest.x = -80;
               sprites[1].dest.y = -80;
               program.gameScore += 100;
            }
//--==[[ Player got an extra try ]]==--
            else if((sprites[2].dest.x / TILESIZE) == player.x - 1 && (sprites[2].dest.y/TILESIZE) == player.y - 1)
            {
               sprites[2].dest.x = -80;
               sprites[2].dest.y = -80;
               program.gameTries++;
            }
//--==[[ Player got some extra time ]]==--
            else if((sprites[3].dest.x / TILESIZE) == player.x - 1 && (sprites[3].dest.y/TILESIZE) == player.y - 1)
            {
               sprites[3].dest.x = -80;
               sprites[3].dest.y = -80;
               program.levelTime += 50;
            }
         }
*/
         //--==[[ Render the level ]]==--
         for(y = 0; y < program.levelH; y++) 
         { 
            int x, xLoc, yLoc; 
            for(x = 0; x < program.levelW; x++) 
            { 
               xLoc = (int)((x * (TILESIZE - 1)) * (levelScale / 100));
               yLoc = (int)((y * (TILESIZE - 1)) * (levelScale / 100));
               level[y * program.levelW + x].Render(surface, tiles, xLoc, yLoc, levelScale); 
            } 
         }

         //--==[[ Render the Sprites ]]==--
         for(r : spriteList)
         {
            spriteList[r].Render(surface, sprites, levelScale);
         }
         player.Animate();
         player.Render(surface, levelScale);
      }
   }

   bool OnKeyHit(Key key, unichar ch)
   {
      if(program.levelTime > 0)
      {
         switch(key)
         {
            case escape:
            {
               program.pauseMenu.Create();
               break;
            }
         }
      }
      return true;
   }

   void doMaze()
   {
      //Initialize the maze!
      int initX, initY;

   	for(initX = 0; initX < program.levelW; initX++)
      {
   		for(initY = 0; initY < program.levelH; initY++)
   		{
            int index;
            index = initY * program.levelW + initX;
            maze[index].dir[0] = NORTH;
            maze[index].dir[1] = SOUTH;
            maze[index].dir[2] = EAST;
            maze[index].dir[3] = WEST;

            maze[index].visited = false;
            
   			level[initY * program.levelW + initX] = bush;
   		}
      }
      makeMaze();
   	placeExit();
      placeStart();
      return;
   }

   void makeMaze()
   {
      int x, y;
      x = GetRandom(1, (program.levelW - 2) / 2) * 2 - 1;
      y = GetRandom(1, (program.levelH - 2) / 2) * 2 - 1;
      grow(x, y);
   }

   void grow(int cx, int cy)
   {
      int index, chkDir;
      index = cy * program.levelW + cx;

      maze[index].visited = true;
      level[index] = floor;
      shuffle(maze[index].dir, 4);
      for(chkDir = 0; chkDir < 4; chkDir++)
      {
         int x = cx + dMoveX[maze[index].dir[chkDir]];
         int y = cy + dMoveY[maze[index].dir[chkDir]];
         if(inRange(x, 1, program.levelW - 1) && inRange(y, 1, program.levelH - 1) && !maze[y * program.levelW + x].visited)
         {
            int newX, newY;
            newX = cx + (dMoveX[maze[index].dir[chkDir]] / 2);
            newY = cy + (dMoveY[maze[index].dir[chkDir]] / 2);
            level[newY * program.levelW + newX] = floor;
            grow(x, y);
         }
      }
   }

   void shuffle(int list[], int size)
   {
      int inc;
      for(inc = 0; inc < size; inc++)
      {
         int temp, index;
         temp = list[inc];
         index = GetRandom(0, size - 1);
         list[inc] = list[index];
         list[index] = temp;
      }
   }

   bool inRange(int test, int lo, int hi)
   {
      if (test >= lo && test <= hi) return true;
      return false;
   }

   void placeExit()
   {
      bool test = false;

      while(!test)
      {
         int y = GetRandom(1, program.levelH - 2);
         if(level[y * program.levelW + (program.levelW - 2)] == floor)
         {
            level[y * program.levelW + (program.levelW - 1)] = floor;
            sprites[0].setDest((program.levelW - 1) * (TILESIZE - 1), y * (TILESIZE - 1));
            test = true;
         }
      } 
   }

   void placeStart()
   {
      bool test = false;
      while(!test)
      {
         int y = GetRandom(1, program.levelH - 2), x = 1;
         if(level[y * program.levelW + 1] == floor)
         {
            player.setLoc(1, y);
            test = true;
         }
      }
   }

   void placePowerUp(Bonus bonus)
   {
      bool test = false;
      while(!test)
      {
         int y = GetRandom(1, program.levelH - 1);
         int x = GetRandom(1, program.levelW - 1);
         if(level[y * program.levelW + x] == floor)
         {
            switch(bonus)
            {
               case moneyBag:
               {
                  sprites[1].setDest(x * (TILESIZE-1), y * (TILESIZE-1));
                  break;
               }
               case extraTry:
               {
                  sprites[2].setDest(x * (TILESIZE-1), y * (TILESIZE-1));
                  break;
               }
               case extraTime:
               {
                  sprites[3].setDest(x * (TILESIZE-1), y * (TILESIZE-1));
                  break;
               }
            }
            test = true;
         }
      }
   }

   void ProcessStuff()
   {
      if(program.gameWonFlag) program.gameWon.Create();
      if(program.gameOverFlag) 
      {
         program.gameOver.Create();
         if(program.gameOver.position.y < 365) program.gameOver.position.y += 5;
      }
      if(!program.gameOverFlag)
      {
         int y;    
//--==[[ Time's Up, so tell the player ]]==--
         if(program.levelTime <= 0) 
         {
            program.timesUp.Create();
            if(program.timesUp.position.y < 365) program.timesUp.position.y += 5;
         }
         else
         {
            program.levelTime = program.levelTime - 0.1f;
            delete sLevelTime; // Make sure that this string is empty for us
            sLevelTime = PrintString((int)program.levelTime);
            delete sGameScore;
            sGameScore = PrintString((int)program.gameScore);
            delete sGameTries;
            sGameTries = PrintString((int)program.gameTries);

            program.scoreBar.tries.caption = sGameTries;
            program.scoreBar.score.caption = sGameScore;
            program.scoreBar.score.size = {0, 0};
            program.scoreBar.time.caption = sLevelTime;
            program.scoreBar.level.caption = sLevel;
   
            //--==[[ Has Player reached the exit? ]]==--
            if((sprites[0].dest.x / TILESIZE) == player.x - 1 && (sprites[0].dest.y/TILESIZE) == player.y - 1)
            {
               Destroy(0);
               program.level++;
               program.gameScore = program.gameScore + 100 + (int)(program.levelTime * 2);
               program.levelTime = 30 + (program.level * 15);
               Create();
               screenRefresh.Start();
            }
//--==[[ Player got a money Bag so reward them ]]==--
            else if((sprites[1].dest.x / TILESIZE) == player.x - 1 && (sprites[1].dest.y/TILESIZE) == player.y - 1)
            {
               sprites[1].dest.x = -80;
               sprites[1].dest.y = -80;
               program.gameScore += 100;
            }
//--==[[ Player got an extra try ]]==--
            else if((sprites[2].dest.x / TILESIZE) == player.x - 1 && (sprites[2].dest.y/TILESIZE) == player.y - 1)
            {
               sprites[2].dest.x = -80;
               sprites[2].dest.y = -80;
               program.gameTries++;
            }
//--==[[ Player got some extra time ]]==--
            else if((sprites[3].dest.x / TILESIZE) == player.x - 1 && (sprites[3].dest.y/TILESIZE) == player.y - 1)
            {
               sprites[3].dest.x = -80;
               sprites[3].dest.y = -80;
               program.levelTime += 50;
            }
         }
      }
   }

   ~GameWindow()
   {
      delete sGameTries;
      delete sLevel;
      delete sLevelTime;
      delete sGameScore;

      screenRefresh.started = false;
      tiles.Free();
      sprites.Free();
   }
}

define moveSpeed = 10.0; // 10 pixels per seconds

class SampleApp : GuiApplication
{
   bool Cycle(bool idle)
   {
      int chanceOfPowerUps;
 
      if(program.pauseMenu.created) return true;
      program.gameWin.ProcessStuff();
      if(program.levelTime > 0 && !program.gameWin.player.move)
      {
         static Time lastTime;
         Time diffTime = GetTime() - lastTime;
    
         if(diffTime >= 1 / moveSpeed)
         {
            if(GetKeyState(left))  
            {
               if(program.gameWin.player.x > 1 && program.gameWin.level[program.gameWin.player.y * program.levelW + (program.gameWin.player.x - 1)] == floor) program.gameWin.player.Move(WEST); 
            }
            if(GetKeyState(right)) 
            { 
               if(program.gameWin.player.x < program.levelW && program.gameWin.level[program.gameWin.player.y * program.levelW + (program.gameWin.player.x + 1)] == floor) program.gameWin.player.Move(EAST);
            }
            if(GetKeyState(up))    
            { 
               if(program.gameWin.player.y > 1 && program.gameWin.level[(program.gameWin.player.y - 1) * program.levelW + program.gameWin.player.x] == floor) program.gameWin.player.Move(NORTH);
            }
            if(GetKeyState(down))  
            { 
               if(program.gameWin.player.y < program.levelH && program.gameWin.level[(program.gameWin.player.y + 1) * program.levelW + program.gameWin.player.x] == floor) program.gameWin.player.Move(SOUTH);
            }
            lastTime = GetTime();
         }
         if(program.gameRunningFlag)
         {
            chanceOfPowerUps = GetRandom(0, 1000);
            if(chanceOfPowerUps < 10)
            {
               program.gameWin.placePowerUp(moneyBag);
            }
            else if(chanceOfPowerUps > 10 && chanceOfPowerUps < 15)
            {
               program.gameWin.placePowerUp(extraTry);
            }
            else if(chanceOfPowerUps > 15 && chanceOfPowerUps < 20)
            {
               program.gameWin.placePowerUp(extraTime);
            }

         }
      }
      return true;
   }
}
