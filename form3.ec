import "ecere"
import "MainProg"

class form_OptionsMenu : Window
{
   caption = "Options";
   background = activeBorder;
   size = { 468, 348 };
   position = { 278, 210 };
   autoCreate = false;

   Picture gr_OptionsMenu { this, position = {  }, image = { ":OptionsMenu.png" } };
   EditBox eb_Level { this, caption = "editBox1", font = { "Tahoma", 12 }, size = { 94, 19 }, position = { 240, 171 }, maxLineSize = 15, 1 };
   EditBox eb_Seed { this, caption = "editBox1", font = { "Tahoma", 12 }, size = { 94, 19 }, position = { 240, 195 }, maxLineSize = 15, 1 };
   Button btn_Randomize { gr_OptionsMenu, this, opacity = 0, size = { 450, 21 }, position = { 8, 216 }, bevel = false, bitmap = { ":Randomize Button.png" };
      bool NotifyClicked(Button button, int x, int y, Modifiers mods)
      {
         eb_Seed.contents = PrintString(GetRandom(0, 9999999));
         return true;
      }
   };

   Button btn_Save { gr_OptionsMenu, this, opacity = 0, size = { 450, 21 }, position = { 8, 240 }, bevel = false, bitmap = { ":Save Button.png" };
      bool NotifyClicked(Button button, int x, int y, Modifiers mods)
      {
         program.level = atoi(eb_Level.contents);
         program.randSeed = atoi(eb_Seed.contents);
			Destroy(0);
			return true;
		}
   };

   Button btn_Cancel { gr_OptionsMenu, this, opacity = 0, size = { 450, 21 }, position = { 8, 264 }, bevel = false, bitmap = { ":Cancel Button.png" } ;
      bool NotifyClicked(Button button, int x, int y, Modifiers mods)
      {
			Destroy(0);
			return true;
		}
	};

   bool OnCreate()
   {
      if (!program.level) eb_Level.contents = "1"; else eb_Level.contents = PrintString(program.level);
      eb_Seed.contents = PrintString(program.randSeed);
      return true;
   }
}
