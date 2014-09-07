import "ecere"
import "MainProg"

class Form8 : Window
{
   caption = "Form8";
   background = activeBorder;
   size = { 1020, 756 };
   autoCreate = false;

   Picture picture1 { this, caption = "picture1", anchor = { left = 0 }, {  }, image = { ":WinScreen.png" } };

   bool OnKeyHit(Key key, unichar ch)
   {
      if(key == escape || key == enter)
      {
         program.gameWonFlag = false;
         Destroy(0);
      }
      return true;
   }

   bool OnCreate()
   {
      program.gameRunningFlag = false;
      return true;
   }
}
