//	official Autosplitter for Abe's Oddysee for PC. Any version. Any language. Any category. Any IL. Loadless time.
//	Created by LegnaX. 14-07-2020

state("AbeWin", "1.3.6")
{
	// ORIGINAL GoG EN BYTES
	byte EN_LEVEL_ID : 0x107BA8;
	byte EN_PATH_ID : 0x107BAA;
	byte EN_CAM_ID : 0x107BAC;
	short EN_abeX : 0x107678, 0xAA;
	short EN_abeY : 0x107678, 0xAE; // Needed for the Zulag 4 split.
	long EN_gnFrame : 0x107670; // Ingame frame counter.
	byte EN_IsGameRunning : 0x1080E4; // Paused game = 1
	byte EN_IsGameBeaten : 0x1055AE; // When variable 70 is true on the Boardroom. Game beaten = 1.
	byte EN_IsCinematicPlaying : 0x5F309C; // 1 = cinematic is playing

	// SPANISH
	byte ES_LEVEL_ID : 0x108332;
	byte ES_PATH_ID : 0x108334;
	byte ES_CAM_ID : 0x108336;
	short ES_abeX : 0x107DF8, 0xAA; // NUEVO.
	short ES_abeY : 0x107DF8, 0xAE; // NUEVO.
	long ES_gnFrame : 0x107DF0; // Ingame frame counter.
	byte ES_IsGameRunning : 0x108864; // Paused game = 1
	byte ES_IsGameBeaten : 0x105D2E; // When variable 70 is true on the Boardroom. Game beaten = 1.

	// FRENCH
	byte FR_LEVEL_ID : 0x108382;
	byte FR_PATH_ID : 0x108384;
	byte FR_CAM_ID : 0x108386;
	short FR_abeX : 0x107E48, 0xAA; // NUEVO.
	short FR_abeY : 0x107E48, 0xAE; // NUEVO.
	long FR_gnFrame : 0x107E40; // Ingame frame counter.
	byte FR_IsGameRunning : 0x1088B4; // Paused game = 1
	byte FR_IsGameBeaten : 0x105D7E; // When variable 70 is true on the Boardroom. Game beaten = 1.

	// JAPANESE
	byte JP_LEVEL_ID : 0x108B32;
	byte JP_PATH_ID : 0x108B34;
	byte JP_CAM_ID : 0x108B36;
	short JP_abeX : 0x1085F8, 0xAA; // DIFFERENCE 548 (substract from original)
	short JP_abeY : 0x1085F8, 0xAE; // DIFFERENCE 548 (substract from original)
	long JP_gnFrame : 0x1085F0; // Ingame frame counter.
	byte JP_IsGameRunning : 0x109084; // Paused game = 1 (+40 hex)
	byte JP_IsGameBeaten : 0x10652E; // When variable 70 is true on the Boardroom. Game beaten = 1.

	// GERMAN
	byte DE_LEVEL_ID : 0x108342;
	byte DE_PATH_ID : 0x108344;
	byte DE_CAM_ID : 0x108346;
	short DE_abeX : 0x107E0C, 0xAA; // DIFFERENCE 548 (substract from original)
	short DE_abeY : 0x107E0C, 0xAE; // DIFFERENCE 548 (substract from original)
	long DE_gnFrame : 0x107E00; // Ingame frame counter.
	byte DE_IsGameRunning : 0x108874; // Paused game = 1
	byte DE_IsGameBeaten : 0x105D3E; // When variable 70 is true on the Boardroom. Game beaten = 1.

	// ITALIAN
	byte IT_LEVEL_ID : 0x108222;
	byte IT_PATH_ID : 0x108224;
	byte IT_CAM_ID : 0x108226;
	short IT_abeX : 0x107CE8, 0xAA; // Needed for the Zulag 4 split.
	short IT_abeY : 0x107CE8, 0xAE; // Needed for the Zulag 4 split.
	long IT_gnFrame : 0x107CE0; // Ingame frame counter.
	byte IT_IsGameRunning : 0x108754; // Paused game = 1
	byte IT_IsGameBeaten : 0x105C1E; // When variable 70 is true on the Boardroom. Game beaten = 1.
}


startup
{	
	// ++++++++++ GENERAL SETTINGS ++++++++++
	
	settings.Add("Version", true, "Official Version 1.3.6 (July 14th 2020) - LegnaX#7777 - CHANGELOG");
	settings.SetToolTip("Version", "-- CHANGELOG --\n- Optimized the code in order to prevent getting stuck on the trials.\n- Added extra refresh rate options and updated tooltip descriptions.\n- Improved some split descriptions and names.\n- Added several checks for the trials on Zulag 2 and 3. Should prevent premature splits.\n- Fixed an issue with the chrono variable not being properly resetted when manually resetting the livesplit being inside the pause menu.\n- Fixed a faulty check on Zulag 3 trial 1.\n- Added individual levels!\n- Fixed a missing split on Zulag 1 (last one) for ILs.\n- Optimized how ILs work, and as soon as the last split is done, the variable Log will output your precise RTA and IGT times.\n- Added Monsaic Lines as new IL, and split Scrabania, Paramonia and Zulag 1. Now The main level and the temple are separated, and FFZ it's a separated level from Zulag 1.\n- Created new variable: GNFrame, which can be used and displayed during runs to see the amount of frames elapsed during the actual run (useful for ILs).\n- The code was broken. It has been restructured. Sorry!\n- Adjusted the last split of Paramonia Temple IL to spam split just in case.\n- Fixed a major glitch happening with users that didn't have the autosplitter before. The 'C:/Autosplit Backup Files/' directory wasn't getting created properly, so the autosplitter was unable to start.\n- Added 50/50 and Max Cas NMS to the categories list.\n- Fixed an issue with the language not getting saved properly.\n- The entire exit sequence was commented! So nothing was being saved upon game restart. Now it does! My bad.");
	
	settings.Add("NoSplitNames", false, "LIGHT VERSION");
	settings.SetToolTip("NoSplitNames", "No split names or zones. Just loadless time and autosplitter. \nThis should make the code of the autosplitter way lighter, at least when starting the execution.");
	
	settings.Add("RealGameTime", true, "Time displayed on the variable 'Log' is IGT.");
	settings.SetToolTip("RealGameTime", "This game is the difference between frames since Abe starts on RuptureFarms and until the last split happens (or when the livesplit splits the last split).\nThis will be used on Any% for getting the actual REAL ingame time.");	
	
	
	// ++++++++++ FREQUENCY SETTINGS ++++++++++
	
	settings.Add("nag", true, "REFRESH RATE OF THE AUTOSPLITTER");
	settings.SetToolTip("nag", "Select one for using that one. By default it will use 40.");
	
	settings.Add("10Rate", false, "10 refreshes per second", "nag");
	settings.SetToolTip("10Rate", "Sets the autosplitter to refresh 10 times per second. Should reduce the CPU impact a lot.\nSome times may get innacurate splits, so be warned.");
	
	settings.Add("30Rate", false, "30 refreshes per second", "nag");
	settings.SetToolTip("30Rate", "Sets the autosplitter to refresh 30 times per second. Should reduce the CPU impact a bit.");
	
	settings.Add("40Rate", true, "40 refreshes per second (DEFAULT)", "nag");
	settings.SetToolTip("40Rate", "Sets the autosplitter to refresh 40 times per second. Leaving all options unckeched will set refresh rate to 40 by default anyway.");
	
	settings.Add("50Rate", false, "50 refreshes per second", "nag");
	settings.SetToolTip("50Rate", "Sets the autosplitter to refresh 50 times per second. Should help getting very accurate times.");
	
	settings.Add("100Rate", false, "100 refreshes per second", "nag");
	settings.SetToolTip("100Rate", "Sets the autosplitter to refresh 100 times per second. R U crazy or wut m8?");	
	
	// ++++++++++ AUTOSPLITTER SETTINGS ++++++++++
	
	settings.Add("UsingAutosplit", false, "AUTOSPLIT GAME CATEGORY - Select ONE or NONE");
	settings.SetToolTip("UsingAutosplit", "Leave all the following options unchecked for no autosplitter feature (just loadless time feature). \nYou need the splits file for the splits to work correctly. \nDOWNLOAD THEM AT http://tiny.cc/Splits1 !");
	
	settings.Add("SplitsAny%", false, "Any%", "UsingAutosplit");
	settings.SetToolTip("SplitsAny%", "Use the Any% splits file!\nAutosplitter will split accordingly those splits.");
	
	settings.Add("SplitsAny%NMS", false, "Any% NMS", "UsingAutosplit");
	settings.SetToolTip("SplitsAny%NMS", "Use the Any% NMS splits file!\nAutosplitter will split accordingly those splits.\nBoth variants are supported: Scrabania first, or Paramonia first.");
	
	settings.Add("Splits100%", false, "100% | 100% NMS | Max Cas | Max Cas NMS | 50/50", "UsingAutosplit");
	settings.SetToolTip("Splits100%", "Use the 100% | 100% NMS | Max Cas | Max Cas NMS | 50/50 splits file!\nAutosplitter will split accordingly those splits.\nBoth variants are supported: Scrabania first, or Paramonia first.");
	
	settings.Add("SplitsGoodEnding", false, "Good Ending", "UsingAutosplit");
	settings.SetToolTip("SplitsGoodEnding", "Use the Good Ending splits file!\nAutosplitter will split accordingly those splits.\nBoth variants are supported: Scrabania first, or Paramonia first.");
	
	
	// ++++++++++ INDIVIDUAL LEVEL SETTINGS ++++++++++
	
	settings.Add("UsingIL", false, "INDIVIDUAL LEVELS - Check this to activate");
	settings.SetToolTip("UsingIL", "Leave this option unchecked to not use.\nAutosplit will priorize autosplit category over Individual Levels, so make sure you disable AUTOSPLIT GAME CATEGORY if you want to use ILs!\nYou need the splits file for the IL splits to work correctly. \nDOWNLOAD THEM AT http://tiny.cc/Splits1 !\nExcept for RuptureFarms, you need to use the Cheat Code in order for the autosplit to start.\nCHEAT CODE: Keep pressed run button and press ↓ → ← → ← → ← ↑ on the main menu.\n-> INDIVIDUAL LEVEL LIST <-\n- RuptureFarms (start a new game)\n- Stockyards\n- Monsaic Lines\n- Paramonia\n- Paramonian Temple\n- Scrabania\n- Scrabanian Temple\n- Free Fire Zone\n- Zulag 1\n- Zulag 2\n- Zulag 3\n- Zulag 4");
}

init
{	
	vars.REAL_TIME_AND_LOADLESS_TIME = "Both timers\nwill be displayed here";
	vars.REAL_TIME = "Real time will be displayed here";
	vars.LOADLESS_TIME = "Loadless time will be displayed here";
	version = "1.3.6" ;
	
	vars.LoadTexts = false;
	vars.ModuleMemory = modules.First().ModuleMemorySize; // So we know the ModuleMemory of this game (UNUSED).
	if (settings["10Rate"]){
		refreshRate = 10;
	} else if (settings["30Rate"]){
		refreshRate = 30;
	} else if (settings["50Rate"]){
		refreshRate = 50;
	} else if (settings["100Rate"]){
		refreshRate = 100;
	} else {
		refreshRate = 40;	
	}
	vars.PrimeraVez = true; // If true, loads the level names on memory and sets itself to False.
	string[] splitt = new string[70]; // Creates the array for the split names.
	vars.split = splitt; // Split names.
	bool[] trialCheckk = new bool[7]; // 0 = 2-1. 1 = 2-2. 2 = 2-3. 3 = 3-1. 4 = 3-2. 5 = 3-3. 6 = 4-1.
	vars.trialCheck = trialCheckk; // Used to check the trials in order to verify if the screen with the lever that flags the level as completed was visited.
	vars.ResetStatus = 0; // If 1, the autosplit will reset.
	vars.StartgnFrame = 0;
	vars.gnFrameCurrent = 0;
	vars.gnBeforeMainMenu = 0;
	vars.Epoch = 0;
	vars.MillisecondsPaused = 0;
	vars.PauseStartTime = -1;
	vars.ParamoniaFirst = true;
	vars.GNFrame = 0;
	vars.fps = 30.3; // FPS of the game. proven to be 30.3 doing performance checks.
	vars.ILtype = -1; // 0 = RuptureFarms | 1 = Stockyards | 2 = Paramonia | 3 = Scrabania | 4 = Zulag 1 | 5 = Zulag 2 | 6 = Zulag 3 | 7 = Zulag 4
	
	if (File.Exists(@"C:\Autosplit Backup Files\n")) { // We conveniently recover the Oddysee current split 
		vars.n = Int32.Parse(File.ReadAllText(@"C:\Autosplit Backup Files\n"));
	} else {		
		vars.n = 0;		// A counting variable that tracks progress (only resets if game loads on proper way).
	}
	
	if (File.Exists(@"C:\Autosplit Backup Files\lang")) { // We conveniently recover the Oddysee current lang		
		vars.LangDetected = File.ReadAllText(@"C:\Autosplit Backup Files\lang");
	} else {		
		vars.LangDetected = "Not yet";
	}
	
	if (File.Exists(@"C:\Autosplit Backup Files\previousTime")) { // We conveniently recover the previous time spent on the run (this resets if you start a new game)		
		vars.PreviousTime = double.Parse(File.ReadAllText(@"C:\Autosplit Backup Files\previousTime"));
	} else {		
		vars.PreviousTime = 0;
	}	
}
 

start
{	
	if (settings["UsingIL"]){ 		
			vars.StartgnFrame = 0;
	// We start on RuptureFarms, normal. 0
		// if (settings["ILRupturefarms"]){ 
			if (old.EN_LEVEL_ID == 0 && old.EN_PATH_ID == 1 && old.EN_CAM_ID == 21 && current.EN_LEVEL_ID == 1 && current.EN_PATH_ID == 15 && current.EN_CAM_ID == 1) {
				vars.StartgnFrame = current.EN_gnFrame;
				vars.LangDetected = "English";	
				vars.ILtype = 0;	
			} else 
			
			// SPANISH
			if (old.ES_LEVEL_ID == 0 && old.ES_PATH_ID == 1 && old.ES_CAM_ID == 21 && current.ES_LEVEL_ID == 1 && current.ES_PATH_ID == 15 && current.ES_CAM_ID == 1) {
				vars.StartgnFrame = current.ES_gnFrame;
				vars.LangDetected = "Spanish";
				vars.ILtype = 0;	
			} else
			
			// FRENCH
			if (old.FR_LEVEL_ID == 0 && old.FR_PATH_ID == 1 && old.FR_CAM_ID == 21 && current.FR_LEVEL_ID == 1 && current.FR_PATH_ID == 15 && current.FR_CAM_ID == 1) {
				vars.StartgnFrame = current.FR_gnFrame;
				vars.LangDetected = "French";
				vars.ILtype = 0;	
			} else
			
			// JAPANESE
			if (old.JP_LEVEL_ID == 0 && old.JP_PATH_ID == 1 && old.JP_CAM_ID == 21 && current.JP_LEVEL_ID == 1 && current.JP_PATH_ID == 15 && current.JP_CAM_ID == 1) {
				vars.StartgnFrame = current.JP_gnFrame;
				vars.LangDetected = "Japanese";
				vars.ILtype = 0;	
			} else
			
			// GERMAN
			if (old.DE_LEVEL_ID == 0 && old.DE_PATH_ID == 1 && old.DE_CAM_ID == 21 && current.DE_LEVEL_ID == 1 && current.DE_PATH_ID == 15 && current.DE_CAM_ID == 1) {
				vars.StartgnFrame = current.DE_gnFrame;
				vars.LangDetected = "German";
				vars.ILtype = 0;	
			} else
			
			// ITALIAN
			if (old.IT_LEVEL_ID == 0 && old.IT_PATH_ID == 1 && old.IT_CAM_ID == 21 && current.IT_LEVEL_ID == 1 && current.IT_PATH_ID == 15 && current.IT_CAM_ID == 1) {
				vars.StartgnFrame = current.IT_gnFrame;
				vars.LangDetected = "Italian";
				vars.ILtype = 0;	
			}
			
	// We start on Stockyards, cheat code.
		// } else if (settings["ILStockyards"]){ 
			int l = 5;
			int p = 6;
			int c = 6;
			if (old.EN_LEVEL_ID == 0 && old.EN_PATH_ID == 1 && old.EN_CAM_ID == 21 && current.EN_LEVEL_ID == l && current.EN_PATH_ID == p && current.EN_CAM_ID == c) {
				vars.StartgnFrame = current.EN_gnFrame;
				vars.LangDetected = "English";	
				vars.ILtype = 1;		
			} else 
			
			// SPANISH
			if (old.ES_LEVEL_ID == 0 && old.ES_PATH_ID == 1 && old.ES_CAM_ID == 21 && current.ES_LEVEL_ID == l && current.ES_PATH_ID == p && current.ES_CAM_ID == c) {
				vars.StartgnFrame = current.ES_gnFrame;
				vars.LangDetected = "Spanish";
				vars.ILtype = 1;	
			} else
			
			// FRENCH
			if (old.FR_LEVEL_ID == 0 && old.FR_PATH_ID == 1 && old.FR_CAM_ID == 21 && current.FR_LEVEL_ID == l && current.FR_PATH_ID == p && current.FR_CAM_ID == c) {
				vars.StartgnFrame = current.FR_gnFrame;
				vars.LangDetected = "French";
				vars.ILtype = 1;	
			} else
			
			// JAPANESE
			if (old.JP_LEVEL_ID == 0 && old.JP_PATH_ID == 1 && old.JP_CAM_ID == 21 && current.JP_LEVEL_ID == l && current.JP_PATH_ID == p && current.JP_CAM_ID == c) {
				vars.StartgnFrame = current.JP_gnFrame;
				vars.LangDetected = "Japanese";
				vars.ILtype = 1;	
			} else
			
			// GERMAN
			if (old.DE_LEVEL_ID == 0 && old.DE_PATH_ID == 1 && old.DE_CAM_ID == 21 && current.DE_LEVEL_ID == l && current.DE_PATH_ID == p && current.DE_CAM_ID == c) {
				vars.StartgnFrame = current.DE_gnFrame;
				vars.LangDetected = "German";
				vars.ILtype = 1;	
			} else
			
			// ITALIAN
			if (old.IT_LEVEL_ID == 0 && old.IT_PATH_ID == 1 && old.IT_CAM_ID == 21 && current.IT_LEVEL_ID == l && current.IT_PATH_ID == p && current.IT_CAM_ID == c) {
				vars.StartgnFrame = current.IT_gnFrame;
				vars.LangDetected = "Italian";
				vars.ILtype = 1;	
			}
			
	// We start on Paramonia, cheat code.
		// } else if (settings["ILParamonia"]){ 
			l = 3;
			p = 1;
			c = 1;
			if (old.EN_LEVEL_ID == 0 && old.EN_PATH_ID == 1 && old.EN_CAM_ID == 21 && current.EN_LEVEL_ID == l && current.EN_PATH_ID == p && current.EN_CAM_ID == c) {
				vars.StartgnFrame = current.EN_gnFrame;
				vars.LangDetected = "English";	
				vars.ILtype = 2;		
			} else 
			
			// SPANISH
			if (old.ES_LEVEL_ID == 0 && old.ES_PATH_ID == 1 && old.ES_CAM_ID == 21 && current.ES_LEVEL_ID == l && current.ES_PATH_ID == p && current.ES_CAM_ID == c) {
				vars.StartgnFrame = current.ES_gnFrame;
				vars.LangDetected = "Spanish";
				vars.ILtype = 2;	
			} else
			
			// FRENCH
			if (old.FR_LEVEL_ID == 0 && old.FR_PATH_ID == 1 && old.FR_CAM_ID == 21 && current.FR_LEVEL_ID == l && current.FR_PATH_ID == p && current.FR_CAM_ID == c) {
				vars.StartgnFrame = current.FR_gnFrame;
				vars.LangDetected = "French";
				vars.ILtype = 2;	
			} else
			
			// JAPANESE
			if (old.JP_LEVEL_ID == 0 && old.JP_PATH_ID == 1 && old.JP_CAM_ID == 21 && current.JP_LEVEL_ID == l && current.JP_PATH_ID == p && current.JP_CAM_ID == c) {
				vars.StartgnFrame = current.JP_gnFrame;
				vars.LangDetected = "Japanese";
				vars.ILtype = 2;	
			} else
			
			// GERMAN
			if (old.DE_LEVEL_ID == 0 && old.DE_PATH_ID == 1 && old.DE_CAM_ID == 21 && current.DE_LEVEL_ID == l && current.DE_PATH_ID == p && current.DE_CAM_ID == c) {
				vars.StartgnFrame = current.DE_gnFrame;
				vars.LangDetected = "German";
				vars.ILtype = 2;	
			} else
			
			// ITALIAN
			if (old.IT_LEVEL_ID == 0 && old.IT_PATH_ID == 1 && old.IT_CAM_ID == 21 && current.IT_LEVEL_ID == l && current.IT_PATH_ID == p && current.IT_CAM_ID == c) {
				vars.StartgnFrame = current.IT_gnFrame;
				vars.LangDetected = "Italian";
				vars.ILtype = 2;	
			}
			
	// We start on Scrabania, cheat code.
		// } else if (settings["ILScrabania"]){ 
			l = 8;
			p = 1;
			c = 1;
			if (old.EN_LEVEL_ID == 0 && old.EN_PATH_ID == 1 && old.EN_CAM_ID == 21 && current.EN_LEVEL_ID == l && current.EN_PATH_ID == p && current.EN_CAM_ID == c) {
				vars.StartgnFrame = current.EN_gnFrame;
				vars.LangDetected = "English";	
				vars.ILtype = 3;		
			} else 
			
			// SPANISH
			if (old.ES_LEVEL_ID == 0 && old.ES_PATH_ID == 1 && old.ES_CAM_ID == 21 && current.ES_LEVEL_ID == l && current.ES_PATH_ID == p && current.ES_CAM_ID == c) {
				vars.StartgnFrame = current.ES_gnFrame;
				vars.LangDetected = "Spanish";
				vars.ILtype = 3;
			} else
			
			// FRENCH
			if (old.FR_LEVEL_ID == 0 && old.FR_PATH_ID == 1 && old.FR_CAM_ID == 21 && current.FR_LEVEL_ID == l && current.FR_PATH_ID == p && current.FR_CAM_ID == c) {
				vars.StartgnFrame = current.FR_gnFrame;
				vars.LangDetected = "French";
				vars.ILtype = 3;
			} else
			
			// JAPANESE
			if (old.JP_LEVEL_ID == 0 && old.JP_PATH_ID == 1 && old.JP_CAM_ID == 21 && current.JP_LEVEL_ID == l && current.JP_PATH_ID == p && current.JP_CAM_ID == c) {
				vars.StartgnFrame = current.JP_gnFrame;
				vars.LangDetected = "Japanese";
				vars.ILtype = 3;
			} else
			
			// GERMAN
			if (old.DE_LEVEL_ID == 0 && old.DE_PATH_ID == 1 && old.DE_CAM_ID == 21 && current.DE_LEVEL_ID == l && current.DE_PATH_ID == p && current.DE_CAM_ID == c) {
				vars.StartgnFrame = current.DE_gnFrame;
				vars.LangDetected = "German";
				vars.ILtype = 3;
			} else
			
			// ITALIAN
			if (old.IT_LEVEL_ID == 0 && old.IT_PATH_ID == 1 && old.IT_CAM_ID == 21 && current.IT_LEVEL_ID == l && current.IT_PATH_ID == p && current.IT_CAM_ID == c) {
				vars.StartgnFrame = current.IT_gnFrame;
				vars.LangDetected = "Italian";
				vars.ILtype = 3;
			}
			
	// We start on Zulag 1, cheat code.
		// } else if (settings["ILZulag1"]){ 
			l = 6;
			p = 4;
			c = 7;
			if (old.EN_LEVEL_ID == 0 && old.EN_PATH_ID == 1 && old.EN_CAM_ID == 21 && current.EN_LEVEL_ID == l && current.EN_PATH_ID == p && current.EN_CAM_ID == c) {
				vars.StartgnFrame = current.EN_gnFrame;
				vars.LangDetected = "English";
				vars.ILtype = 4;		
			} else 
			
			// SPANISH
			if (old.ES_LEVEL_ID == 0 && old.ES_PATH_ID == 1 && old.ES_CAM_ID == 21 && current.ES_LEVEL_ID == l && current.ES_PATH_ID == p && current.ES_CAM_ID == c) {
				vars.StartgnFrame = current.ES_gnFrame;
				vars.LangDetected = "Spanish";
				vars.ILtype = 4;		
			} else
			
			// FRENCH
			if (old.FR_LEVEL_ID == 0 && old.FR_PATH_ID == 1 && old.FR_CAM_ID == 21 && current.FR_LEVEL_ID == l && current.FR_PATH_ID == p && current.FR_CAM_ID == c) {
				vars.StartgnFrame = current.FR_gnFrame;
				vars.LangDetected = "French";
				vars.ILtype = 4;		
			} else
			
			// JAPANESE
			if (old.JP_LEVEL_ID == 0 && old.JP_PATH_ID == 1 && old.JP_CAM_ID == 21 && current.JP_LEVEL_ID == l && current.JP_PATH_ID == p && current.JP_CAM_ID == c) {
				vars.StartgnFrame = current.JP_gnFrame;
				vars.LangDetected = "Japanese";
				vars.ILtype = 4;		
			} else
			
			// GERMAN
			if (old.DE_LEVEL_ID == 0 && old.DE_PATH_ID == 1 && old.DE_CAM_ID == 21 && current.DE_LEVEL_ID == l && current.DE_PATH_ID == p && current.DE_CAM_ID == c) {
				vars.StartgnFrame = current.DE_gnFrame;
				vars.LangDetected = "German";
				vars.ILtype = 4;		
			} else
			
			// ITALIAN
			if (old.IT_LEVEL_ID == 0 && old.IT_PATH_ID == 1 && old.IT_CAM_ID == 21 && current.IT_LEVEL_ID == l && current.IT_PATH_ID == p && current.IT_CAM_ID == c) {
				vars.StartgnFrame = current.IT_gnFrame;
				vars.LangDetected = "Italian";
				vars.ILtype = 4;		
			}
			
	// We start on Zulag 2, cheat code.
		// } else if (settings["ILZulag2"]){ 
			l = 13;
			p = 1;
			c = 1;
			if (old.EN_LEVEL_ID == 0 && old.EN_PATH_ID == 1 && old.EN_CAM_ID == 21 && current.EN_LEVEL_ID == l && current.EN_PATH_ID == p && current.EN_CAM_ID == c) {
				vars.StartgnFrame = current.EN_gnFrame;
				vars.LangDetected = "English";	
				vars.ILtype = 5;			
			} else 
			
			// SPANISH
			if (old.ES_LEVEL_ID == 0 && old.ES_PATH_ID == 1 && old.ES_CAM_ID == 21 && current.ES_LEVEL_ID == l && current.ES_PATH_ID == p && current.ES_CAM_ID == c) {
				vars.StartgnFrame = current.ES_gnFrame;
				vars.LangDetected = "Spanish";
				vars.ILtype = 5;	
			} else
			
			// FRENCH
			if (old.FR_LEVEL_ID == 0 && old.FR_PATH_ID == 1 && old.FR_CAM_ID == 21 && current.FR_LEVEL_ID == l && current.FR_PATH_ID == p && current.FR_CAM_ID == c) {
				vars.StartgnFrame = current.FR_gnFrame;
				vars.LangDetected = "French";
				vars.ILtype = 5;	
			} else
			
			// JAPANESE
			if (old.JP_LEVEL_ID == 0 && old.JP_PATH_ID == 1 && old.JP_CAM_ID == 21 && current.JP_LEVEL_ID == l && current.JP_PATH_ID == p && current.JP_CAM_ID == c) {
				vars.StartgnFrame = current.JP_gnFrame;
				vars.LangDetected = "Japanese";
				vars.ILtype = 5;	
			} else
			
			// GERMAN
			if (old.DE_LEVEL_ID == 0 && old.DE_PATH_ID == 1 && old.DE_CAM_ID == 21 && current.DE_LEVEL_ID == l && current.DE_PATH_ID == p && current.DE_CAM_ID == c) {
				vars.StartgnFrame = current.DE_gnFrame;
				vars.LangDetected = "German";
				vars.ILtype = 5;	
			} else
			
			// ITALIAN
			if (old.IT_LEVEL_ID == 0 && old.IT_PATH_ID == 1 && old.IT_CAM_ID == 21 && current.IT_LEVEL_ID == l && current.IT_PATH_ID == p && current.IT_CAM_ID == c) {
				vars.StartgnFrame = current.IT_gnFrame;
				vars.LangDetected = "Italian";
				vars.ILtype = 5;	
			}
			
	// We start on Zulag 3, cheat code.
		// } else if (settings["ILZulag3"]){ 
			l = 13;
			p = 13;
			c = 1;
			if (old.EN_LEVEL_ID == 0 && old.EN_PATH_ID == 1 && old.EN_CAM_ID == 21 && current.EN_LEVEL_ID == l && current.EN_PATH_ID == p && current.EN_CAM_ID == c) {
				vars.StartgnFrame = current.EN_gnFrame;
				vars.LangDetected = "English";	
				vars.ILtype = 6;		
			} else 
			
			// SPANISH
			if (old.ES_LEVEL_ID == 0 && old.ES_PATH_ID == 1 && old.ES_CAM_ID == 21 && current.ES_LEVEL_ID == l && current.ES_PATH_ID == p && current.ES_CAM_ID == c) {
				vars.StartgnFrame = current.ES_gnFrame;
				vars.LangDetected = "Spanish";
				vars.ILtype = 6;		
			} else
			
			// FRENCH
			if (old.FR_LEVEL_ID == 0 && old.FR_PATH_ID == 1 && old.FR_CAM_ID == 21 && current.FR_LEVEL_ID == l && current.FR_PATH_ID == p && current.FR_CAM_ID == c) {
				vars.StartgnFrame = current.FR_gnFrame;
				vars.LangDetected = "French";
				vars.ILtype = 6;		
			} else
			
			// JAPANESE
			if (old.JP_LEVEL_ID == 0 && old.JP_PATH_ID == 1 && old.JP_CAM_ID == 21 && current.JP_LEVEL_ID == l && current.JP_PATH_ID == p && current.JP_CAM_ID == c) {
				vars.StartgnFrame = current.JP_gnFrame;
				vars.LangDetected = "Japanese";
				vars.ILtype = 6;		
			} else
			
			// GERMAN
			if (old.DE_LEVEL_ID == 0 && old.DE_PATH_ID == 1 && old.DE_CAM_ID == 21 && current.DE_LEVEL_ID == l && current.DE_PATH_ID == p && current.DE_CAM_ID == c) {
				vars.StartgnFrame = current.DE_gnFrame;
				vars.LangDetected = "German";
				vars.ILtype = 6;		
			} else
			
			// ITALIAN
			if (old.IT_LEVEL_ID == 0 && old.IT_PATH_ID == 1 && old.IT_CAM_ID == 21 && current.IT_LEVEL_ID == l && current.IT_PATH_ID == p && current.IT_CAM_ID == c) {
				vars.StartgnFrame = current.IT_gnFrame;
				vars.LangDetected = "Italian";
				vars.ILtype = 6;		
			}
			
	// We start on Zulag 4, cheat code.
		// } else if (settings["ILZulag4"]){ 
			l = 13;
			p = 14;
			c = 1;
			if (old.EN_LEVEL_ID == 0 && old.EN_PATH_ID == 1 && old.EN_CAM_ID == 21 && current.EN_LEVEL_ID == l && current.EN_PATH_ID == p && current.EN_CAM_ID == c) {
				vars.StartgnFrame = current.EN_gnFrame;
				vars.LangDetected = "English";	
				vars.ILtype = 7;			
			} else 
			
			// SPANISH
			if (old.ES_LEVEL_ID == 0 && old.ES_PATH_ID == 1 && old.ES_CAM_ID == 21 && current.ES_LEVEL_ID == l && current.ES_PATH_ID == p && current.ES_CAM_ID == c) {
				vars.StartgnFrame = current.ES_gnFrame;
				vars.LangDetected = "Spanish";
				vars.ILtype = 7;			
			} else
			
			// FRENCH
			if (old.FR_LEVEL_ID == 0 && old.FR_PATH_ID == 1 && old.FR_CAM_ID == 21 && current.FR_LEVEL_ID == l && current.FR_PATH_ID == p && current.FR_CAM_ID == c) {
				vars.StartgnFrame = current.FR_gnFrame;
				vars.LangDetected = "French";
				vars.ILtype = 7;			
			} else
			
			// JAPANESE
			if (old.JP_LEVEL_ID == 0 && old.JP_PATH_ID == 1 && old.JP_CAM_ID == 21 && current.JP_LEVEL_ID == l && current.JP_PATH_ID == p && current.JP_CAM_ID == c) {
				vars.StartgnFrame = current.JP_gnFrame;
				vars.LangDetected = "Japanese";
				vars.ILtype = 7;			
			} else
			
			// GERMAN
			if (old.DE_LEVEL_ID == 0 && old.DE_PATH_ID == 1 && old.DE_CAM_ID == 21 && current.DE_LEVEL_ID == l && current.DE_PATH_ID == p && current.DE_CAM_ID == c) {
				vars.StartgnFrame = current.DE_gnFrame;
				vars.LangDetected = "German";
				vars.ILtype = 7;			
			} else
			
			// ITALIAN
			if (old.IT_LEVEL_ID == 0 && old.IT_PATH_ID == 1 && old.IT_CAM_ID == 21 && current.IT_LEVEL_ID == l && current.IT_PATH_ID == p && current.IT_CAM_ID == c) {
				vars.StartgnFrame = current.IT_gnFrame;
				vars.LangDetected = "Italian";
				vars.ILtype = 7;			
			}
			
			
			// This is for Monsaic lines (ID 8)
			l = 2;
			p = 1;
			c = 14;
			if (old.EN_LEVEL_ID == 0 && old.EN_PATH_ID == 1 && old.EN_CAM_ID == 21 && current.EN_LEVEL_ID == l && current.EN_PATH_ID == p && current.EN_CAM_ID == c) {
				vars.StartgnFrame = current.EN_gnFrame;
				vars.LangDetected = "English";	
				vars.ILtype = 8;			
			} else 
			
			// SPANISH
			if (old.ES_LEVEL_ID == 0 && old.ES_PATH_ID == 1 && old.ES_CAM_ID == 21 && current.ES_LEVEL_ID == l && current.ES_PATH_ID == p && current.ES_CAM_ID == c) {
				vars.StartgnFrame = current.ES_gnFrame;
				vars.LangDetected = "Spanish";
				vars.ILtype = 8;			
			} else
			
			// FRENCH
			if (old.FR_LEVEL_ID == 0 && old.FR_PATH_ID == 1 && old.FR_CAM_ID == 21 && current.FR_LEVEL_ID == l && current.FR_PATH_ID == p && current.FR_CAM_ID == c) {
				vars.StartgnFrame = current.FR_gnFrame;
				vars.LangDetected = "French";
				vars.ILtype = 8;			
			} else
			
			// JAPANESE
			if (old.JP_LEVEL_ID == 0 && old.JP_PATH_ID == 1 && old.JP_CAM_ID == 21 && current.JP_LEVEL_ID == l && current.JP_PATH_ID == p && current.JP_CAM_ID == c) {
				vars.StartgnFrame = current.JP_gnFrame;
				vars.LangDetected = "Japanese";
				vars.ILtype = 8;			
			} else
			
			// GERMAN
			if (old.DE_LEVEL_ID == 0 && old.DE_PATH_ID == 1 && old.DE_CAM_ID == 21 && current.DE_LEVEL_ID == l && current.DE_PATH_ID == p && current.DE_CAM_ID == c) {
				vars.StartgnFrame = current.DE_gnFrame;
				vars.LangDetected = "German";
				vars.ILtype = 8;			
			} else
			
			// ITALIAN
			if (old.IT_LEVEL_ID == 0 && old.IT_PATH_ID == 1 && old.IT_CAM_ID == 21 && current.IT_LEVEL_ID == l && current.IT_PATH_ID == p && current.IT_CAM_ID == c) {
				vars.StartgnFrame = current.IT_gnFrame;
				vars.LangDetected = "Italian";
				vars.ILtype = 8;			
			}
			
			
			// This is for Paramonian Temple (ID 9)
			l = 4;
			p = 1;
			c = 1;
			if (old.EN_LEVEL_ID == 0 && old.EN_PATH_ID == 1 && old.EN_CAM_ID == 21 && current.EN_LEVEL_ID == l && current.EN_PATH_ID == p && current.EN_CAM_ID == c) {
				vars.StartgnFrame = current.EN_gnFrame;
				vars.LangDetected = "English";	
				vars.ILtype = 9;			
			} else 
			
			// SPANISH
			if (old.ES_LEVEL_ID == 0 && old.ES_PATH_ID == 1 && old.ES_CAM_ID == 21 && current.ES_LEVEL_ID == l && current.ES_PATH_ID == p && current.ES_CAM_ID == c) {
				vars.StartgnFrame = current.ES_gnFrame;
				vars.LangDetected = "Spanish";
				vars.ILtype = 9;			
			} else
			
			// FRENCH
			if (old.FR_LEVEL_ID == 0 && old.FR_PATH_ID == 1 && old.FR_CAM_ID == 21 && current.FR_LEVEL_ID == l && current.FR_PATH_ID == p && current.FR_CAM_ID == c) {
				vars.StartgnFrame = current.FR_gnFrame;
				vars.LangDetected = "French";
				vars.ILtype = 9;			
			} else
			
			// JAPANESE
			if (old.JP_LEVEL_ID == 0 && old.JP_PATH_ID == 1 && old.JP_CAM_ID == 21 && current.JP_LEVEL_ID == l && current.JP_PATH_ID == p && current.JP_CAM_ID == c) {
				vars.StartgnFrame = current.JP_gnFrame;
				vars.LangDetected = "Japanese";
				vars.ILtype = 9;			
			} else
			
			// GERMAN
			if (old.DE_LEVEL_ID == 0 && old.DE_PATH_ID == 1 && old.DE_CAM_ID == 21 && current.DE_LEVEL_ID == l && current.DE_PATH_ID == p && current.DE_CAM_ID == c) {
				vars.StartgnFrame = current.DE_gnFrame;
				vars.LangDetected = "German";
				vars.ILtype = 9;			
			} else
			
			// ITALIAN
			if (old.IT_LEVEL_ID == 0 && old.IT_PATH_ID == 1 && old.IT_CAM_ID == 21 && current.IT_LEVEL_ID == l && current.IT_PATH_ID == p && current.IT_CAM_ID == c) {
				vars.StartgnFrame = current.IT_gnFrame;
				vars.LangDetected = "Italian";
				vars.ILtype = 9;			
			}
			
			
			// This is for Scrabanian Temple (ID 10)
			l = 9;
			p = 1;
			c = 1;
			if (old.EN_LEVEL_ID == 0 && old.EN_PATH_ID == 1 && old.EN_CAM_ID == 21 && current.EN_LEVEL_ID == l && current.EN_PATH_ID == p && current.EN_CAM_ID == c) {
				vars.StartgnFrame = current.EN_gnFrame;
				vars.LangDetected = "English";	
				vars.ILtype = 10;			
			} else 
			
			// SPANISH
			if (old.ES_LEVEL_ID == 0 && old.ES_PATH_ID == 1 && old.ES_CAM_ID == 21 && current.ES_LEVEL_ID == l && current.ES_PATH_ID == p && current.ES_CAM_ID == c) {
				vars.StartgnFrame = current.ES_gnFrame;
				vars.LangDetected = "Spanish";
				vars.ILtype = 10;			
			} else
			
			// FRENCH
			if (old.FR_LEVEL_ID == 0 && old.FR_PATH_ID == 1 && old.FR_CAM_ID == 21 && current.FR_LEVEL_ID == l && current.FR_PATH_ID == p && current.FR_CAM_ID == c) {
				vars.StartgnFrame = current.FR_gnFrame;
				vars.LangDetected = "French";
				vars.ILtype = 10;			
			} else
			
			// JAPANESE
			if (old.JP_LEVEL_ID == 0 && old.JP_PATH_ID == 1 && old.JP_CAM_ID == 21 && current.JP_LEVEL_ID == l && current.JP_PATH_ID == p && current.JP_CAM_ID == c) {
				vars.StartgnFrame = current.JP_gnFrame;
				vars.LangDetected = "Japanese";
				vars.ILtype = 10;			
			} else
			
			// GERMAN
			if (old.DE_LEVEL_ID == 0 && old.DE_PATH_ID == 1 && old.DE_CAM_ID == 21 && current.DE_LEVEL_ID == l && current.DE_PATH_ID == p && current.DE_CAM_ID == c) {
				vars.StartgnFrame = current.DE_gnFrame;
				vars.LangDetected = "German";
				vars.ILtype = 10;			
			} else
			
			// ITALIAN
			if (old.IT_LEVEL_ID == 0 && old.IT_PATH_ID == 1 && old.IT_CAM_ID == 21 && current.IT_LEVEL_ID == l && current.IT_PATH_ID == p && current.IT_CAM_ID == c) {
				vars.StartgnFrame = current.IT_gnFrame;
				vars.LangDetected = "Italian";
				vars.ILtype = 10;			
			}
			
			
			// This is for Zulag 1 (ID 11)
			l = 13;
			p = 19;
			c = 3;
			if (old.EN_LEVEL_ID == 0 && old.EN_PATH_ID == 1 && old.EN_CAM_ID == 21 && current.EN_LEVEL_ID == l && current.EN_PATH_ID == p && current.EN_CAM_ID == c) {
				vars.StartgnFrame = current.EN_gnFrame;
				vars.LangDetected = "English";	
				vars.ILtype = 11;			
			} else 
			
			// SPANISH
			if (old.ES_LEVEL_ID == 0 && old.ES_PATH_ID == 1 && old.ES_CAM_ID == 21 && current.ES_LEVEL_ID == l && current.ES_PATH_ID == p && current.ES_CAM_ID == c) {
				vars.StartgnFrame = current.ES_gnFrame;
				vars.LangDetected = "Spanish";
				vars.ILtype = 11;			
			} else
			
			// FRENCH
			if (old.FR_LEVEL_ID == 0 && old.FR_PATH_ID == 1 && old.FR_CAM_ID == 21 && current.FR_LEVEL_ID == l && current.FR_PATH_ID == p && current.FR_CAM_ID == c) {
				vars.StartgnFrame = current.FR_gnFrame;
				vars.LangDetected = "French";
				vars.ILtype = 11;			
			} else
			
			// JAPANESE
			if (old.JP_LEVEL_ID == 0 && old.JP_PATH_ID == 1 && old.JP_CAM_ID == 21 && current.JP_LEVEL_ID == l && current.JP_PATH_ID == p && current.JP_CAM_ID == c) {
				vars.StartgnFrame = current.JP_gnFrame;
				vars.LangDetected = "Japanese";
				vars.ILtype = 11;			
			} else
			
			// GERMAN
			if (old.DE_LEVEL_ID == 0 && old.DE_PATH_ID == 1 && old.DE_CAM_ID == 21 && current.DE_LEVEL_ID == l && current.DE_PATH_ID == p && current.DE_CAM_ID == c) {
				vars.StartgnFrame = current.DE_gnFrame;
				vars.LangDetected = "German";
				vars.ILtype = 11;			
			} else
			
			// ITALIAN
			if (old.IT_LEVEL_ID == 0 && old.IT_PATH_ID == 1 && old.IT_CAM_ID == 21 && current.IT_LEVEL_ID == l && current.IT_PATH_ID == p && current.IT_CAM_ID == c) {
				vars.StartgnFrame = current.IT_gnFrame;
				vars.LangDetected = "Italian";
				vars.ILtype = 11;			
			}
		// }
	} else { // NORMAL GAME START HERE!
		
		// ENGLISH		
		if (old.EN_LEVEL_ID == 0 && old.EN_PATH_ID == 1 && old.EN_CAM_ID == 21 && current.EN_LEVEL_ID == 1 && current.EN_PATH_ID == 15 && current.EN_CAM_ID == 1) {
			vars.StartgnFrame = current.EN_gnFrame;
			vars.LangDetected = "English";		
		} else 
		
		// SPANISH
		if (old.ES_LEVEL_ID == 0 && old.ES_PATH_ID == 1 && old.ES_CAM_ID == 21 && current.ES_LEVEL_ID == 1 && current.ES_PATH_ID == 15 && current.ES_CAM_ID == 1) {
			vars.StartgnFrame = current.ES_gnFrame;
			vars.LangDetected = "Spanish";
		} else
		
		// FRENCH
		if (old.FR_LEVEL_ID == 0 && old.FR_PATH_ID == 1 && old.FR_CAM_ID == 21 && current.FR_LEVEL_ID == 1 && current.FR_PATH_ID == 15 && current.FR_CAM_ID == 1) {
			vars.StartgnFrame = current.FR_gnFrame;
			vars.LangDetected = "French";
		} else
		
		// JAPANESE
		if (old.JP_LEVEL_ID == 0 && old.JP_PATH_ID == 1 && old.JP_CAM_ID == 21 && current.JP_LEVEL_ID == 1 && current.JP_PATH_ID == 15 && current.JP_CAM_ID == 1) {
			vars.StartgnFrame = current.JP_gnFrame;
			vars.LangDetected = "Japanese";
		} else
		
		// GERMAN
		if (old.DE_LEVEL_ID == 0 && old.DE_PATH_ID == 1 && old.DE_CAM_ID == 21 && current.DE_LEVEL_ID == 1 && current.DE_PATH_ID == 15 && current.DE_CAM_ID == 1) {
			vars.StartgnFrame = current.DE_gnFrame;
			vars.LangDetected = "German";
		} else
		
		// ITALIAN
		if (old.IT_LEVEL_ID == 0 && old.IT_PATH_ID == 1 && old.IT_CAM_ID == 21 && current.IT_LEVEL_ID == 1 && current.IT_PATH_ID == 15 && current.IT_CAM_ID == 1) {
			vars.StartgnFrame = current.IT_gnFrame;
			vars.LangDetected = "Italian";
		} else {
			vars.StartgnFrame = 0;
		}
	}
	
	if (vars.StartgnFrame > 10){
		vars.n = 0; // First split if you press on start game
		vars.PauseStartTime = -1;
		vars.MillisecondsPaused = 0;
		vars.PreviousTime = 0;
		vars.StartEpochTime = (DateTime.UtcNow.Ticks - 621355968000000000) / 10000;		
		bool[] trialCheckk = new bool[7]; // 0 = 2-1. 1 = 2-2. 2 = 2-3. 3 = 3-1. 4 = 3-2. 5 = 3-3. 6 = 4-1.
		vars.trialCheck = trialCheckk;
		var dir = @"C:\Autosplit Backup Files\";  // folder location 		
		if (!Directory.Exists(dir)){  // if it doesn't exist, create
			Directory.CreateDirectory(dir);
		}	
		if (vars.ILtype > -1) {			
			vars.LoadTexts = true;
		} else {
			File.Delete(@"C:\Autosplit Backup Files\n"); // Important!! 
			File.Delete(@"C:\Autosplit Backup Files\lang"); // Important!! 
			File.Delete(@"C:\Autosplit Backup Files\previousTime"); // Important!!
		}
		File.WriteAllText(dir + "lang", "" + vars.LangDetected); // Backup for keeping the Lang in Oddysee incase of a game crash.	
		// File.WriteAllText(dir + "lang", "" + 0); // Backup for keeping the Lang in Oddysee incase of a game crash.	
		return true;		
	}	
}

exit
{	
	var dir = @"C:\Autosplit Backup Files\";  // folder location
	if (!Directory.Exists(dir)){  // if it doesn't exist, create
		Directory.CreateDirectory(dir);
	}		
	File.WriteAllText(@"C:\Autosplit Backup Files\n", "" + vars.n); // Backup for keeping the splits in Oddysee incase of a game crash.	
	File.WriteAllText(@"C:\Autosplit Backup Files\lang", "" + vars.LangDetected); // Backup for keeping the Lang in Oddysee incase of a game crash.	
	if (vars.gnBeforeMainMenu > 0) { // Did we go back to the main menu? :/
		File.WriteAllText(@"C:\Autosplit Backup Files\previousTime", "" + (((vars.gnBeforeMainMenu - vars.StartgnFrame) * 1000 / vars.fps) + vars.MillisecondsPaused + vars.PreviousTime)); // Backup for keeping the previous time in Oddysee incase of a game crash.	
	} else { // If we just closed the game.
		File.WriteAllText(@"C:\Autosplit Backup Files\previousTime", "" + (((vars.gnFrameCurrent - vars.StartgnFrame) * 1000 / vars.fps) + vars.MillisecondsPaused + vars.PreviousTime)); // Backup for keeping the previous time in Oddysee incase of a game crash.			
	}	
	vars.StartgnFrame = 0;
	vars.Log = "Game has closed.";
}

reset
{
	if (vars.ResetStatus == 2){ // Start on main menu
		vars.ResetStatus = 0;
		vars.StartgnFrame = 0;
		vars.PauseStartTime = -1;
		return true;		
	} else {
		return false;
	}
}


isLoading
{		
	if (settings["10Rate"]){
		refreshRate = 10;
	} else if (settings["30Rate"]){
		refreshRate = 30;
	} else if (settings["50Rate"]){
		refreshRate = 50;
	} else if (settings["100Rate"]){
		refreshRate = 100;
	} else {
		refreshRate = 40;	
	}
	
	long gnFrame = 0;
	short IsGameRunning = 0;
	int LEVEL_ID = -1;
	int abeY = -1;
	if (vars.LangDetected == "English"){
		IsGameRunning = current.EN_IsGameRunning;
		gnFrame = current.EN_gnFrame;
		LEVEL_ID = current.EN_LEVEL_ID;
		abeY = current.EN_abeY;
	} else if (vars.LangDetected == "Spanish"){
		IsGameRunning = current.ES_IsGameRunning;
		gnFrame = current.ES_gnFrame;
		LEVEL_ID = current.ES_LEVEL_ID;
		abeY = current.ES_abeY;
	} else if (vars.LangDetected == "French"){
		IsGameRunning = current.FR_IsGameRunning;
		gnFrame = current.FR_gnFrame;
		LEVEL_ID = current.FR_LEVEL_ID;
		abeY = current.FR_abeY;
	} else if (vars.LangDetected == "Japanese"){
		IsGameRunning = current.JP_IsGameRunning;
		gnFrame = current.JP_gnFrame;
		LEVEL_ID = current.JP_LEVEL_ID;
		abeY = current.JP_abeY;
	} else if (vars.LangDetected == "German"){
		IsGameRunning = current.DE_IsGameRunning;
		gnFrame = current.DE_gnFrame;
		LEVEL_ID = current.DE_LEVEL_ID;
		abeY = current.DE_abeY;
	} else if (vars.LangDetected == "Italian"){
		IsGameRunning = current.IT_IsGameRunning;
		gnFrame = current.IT_gnFrame;
		LEVEL_ID = current.IT_LEVEL_ID;
		abeY = current.IT_abeY;
	}
	
	if (LEVEL_ID == 0){ // MAIN SCREEN
		if (vars.gnBeforeMainMenu == 0){
			vars.gnBeforeMainMenu = gnFrame;
		}
		return true;
	} else {
		vars.gnBeforeMainMenu = 0;
	}
	
	if (gnFrame > 0) {
		if (IsGameRunning == 1){ // if the game is paused...
			vars.REAL_TIME = System.Convert.ToString(timer.CurrentTime.RealTime).Replace("0000", "").Replace("00:", "");
			vars.GNFrame = gnFrame - vars.StartgnFrame;
			vars.LOADLESS_TIME = TimeSpan.FromMilliseconds(((vars.GNFrame) * 1000 / vars.fps) + vars.MillisecondsPaused + (vars.Epoch - vars.PauseStartTime) + vars.PreviousTime).ToString(@"mm\:ss\.fff");
			vars.REAL_TIME_AND_LOADLESS_TIME = "Real time = " + vars.REAL_TIME + " \nLoadless time = " + vars.LOADLESS_TIME;
			if ((TimeSpan.FromMilliseconds(((gnFrame - vars.StartgnFrame) * 1000 / vars.fps) + vars.MillisecondsPaused + (vars.Epoch - vars.PauseStartTime) + vars.PreviousTime).TotalMilliseconds) < (timer.CurrentTime.GameTime.Value.TotalSeconds * 1000)){ // Is the ingame timer bigger than the gnFrame timer? We will pause it this frame.
				return true;
			} else {
				return false;
			}
		} else {
			vars.REAL_TIME = System.Convert.ToString(timer.CurrentTime.RealTime).Replace("0000", "").Replace("00:", "");
			vars.GNFrame = gnFrame - vars.StartgnFrame;
			vars.LOADLESS_TIME = TimeSpan.FromMilliseconds(((vars.GNFrame) * 1000 / vars.fps) + vars.MillisecondsPaused + vars.PreviousTime).ToString(@"mm\:ss\.fff");
			vars.REAL_TIME_AND_LOADLESS_TIME = "Real time = " + vars.REAL_TIME + " \nLoadless time = " + vars.LOADLESS_TIME;
			if ((TimeSpan.FromMilliseconds(((gnFrame - vars.StartgnFrame) * 1000 / vars.fps) + vars.MillisecondsPaused + vars.PreviousTime).TotalMilliseconds) < (timer.CurrentTime.GameTime.Value.TotalSeconds * 1000)){ // Is the ingame timer bigger than the gnFrame timer? We will pause it this frame.
				return true;
			} else {
				return false;
			}
		}
	} else {
		return true; // :shrug: 
	}
}

split
{		
	int LEVEL_ID = -1;
	int O_PATH_ID = -1;
	int C_PATH_ID = -1;
	int O_CAM_ID = -1;
	int C_CAM_ID = -1;
	int abeY = -1;
	int IsGameRunning = -1;
	long gnFrame = -1;
	int IsGameBeaten = -1;	
	
	if (current.EN_LEVEL_ID == 0 && old.EN_CAM_ID == 1 && (current.EN_CAM_ID == 21 || current.EN_CAM_ID == 31)){ // Reset? On English?
		vars.ResetStatus = 2;
	}
	if (current.ES_LEVEL_ID == 0 && old.ES_CAM_ID == 1 && (current.ES_CAM_ID == 21 || current.ES_CAM_ID == 31)){ // Reset? On Spanish?
		vars.ResetStatus = 2;
	}
	if (current.FR_LEVEL_ID == 0 && old.FR_CAM_ID == 1 && (current.FR_CAM_ID == 21 || current.FR_CAM_ID == 31)){ // Reset? On French?
		vars.ResetStatus = 2;
	}
	if (current.JP_LEVEL_ID == 0 && old.JP_CAM_ID == 1 && (current.JP_CAM_ID == 21 || current.JP_CAM_ID == 31)){ // Reset? On Japanese?
		vars.ResetStatus = 2;
	}
	if (current.DE_LEVEL_ID == 0 && old.DE_CAM_ID == 1 && (current.DE_CAM_ID == 21 || current.DE_CAM_ID == 31)){ // Reset? On German?
		vars.ResetStatus = 2;
	}
	if (current.IT_LEVEL_ID == 0 && old.IT_CAM_ID == 1 && (current.IT_CAM_ID == 21 || current.IT_CAM_ID == 31)){ // Reset? On Italian?
		vars.ResetStatus = 2;
	}
	
	if (vars.LangDetected == "English"){
		LEVEL_ID = current.EN_LEVEL_ID;
		O_PATH_ID = old.EN_PATH_ID;
		C_PATH_ID = current.EN_PATH_ID;
		O_CAM_ID = old.EN_CAM_ID;
		C_CAM_ID = current.EN_CAM_ID;
		abeY = current.EN_abeY;
		IsGameRunning = current.EN_IsGameRunning;
		gnFrame = current.EN_gnFrame;
		IsGameBeaten = current.EN_IsGameBeaten;
	} else if (vars.LangDetected == "Spanish"){
		LEVEL_ID = current.ES_LEVEL_ID;
		O_PATH_ID = old.ES_PATH_ID;
		C_PATH_ID = current.ES_PATH_ID;
		O_CAM_ID = old.ES_CAM_ID;
		C_CAM_ID = current.ES_CAM_ID;
		abeY = current.ES_abeY;
		IsGameRunning = current.ES_IsGameRunning;
		gnFrame = current.ES_gnFrame;
		IsGameBeaten = current.ES_IsGameBeaten;
	} else if (vars.LangDetected == "French"){
		LEVEL_ID = current.FR_LEVEL_ID;
		O_PATH_ID = old.FR_PATH_ID;
		C_PATH_ID = current.FR_PATH_ID;
		O_CAM_ID = old.FR_CAM_ID;
		C_CAM_ID = current.FR_CAM_ID;
		abeY = current.FR_abeY;
		IsGameRunning = current.FR_IsGameRunning;
		gnFrame = current.FR_gnFrame;
		IsGameBeaten = current.FR_IsGameBeaten;
	} else if (vars.LangDetected == "Japanese"){
		LEVEL_ID = current.JP_LEVEL_ID;
		O_PATH_ID = old.JP_PATH_ID;
		C_PATH_ID = current.JP_PATH_ID;
		O_CAM_ID = old.JP_CAM_ID;
		C_CAM_ID = current.JP_CAM_ID;
		abeY = current.JP_abeY;
		IsGameRunning = current.JP_IsGameRunning;
		gnFrame = current.JP_gnFrame;
		IsGameBeaten = current.JP_IsGameBeaten;
	} else if (vars.LangDetected == "German"){
		LEVEL_ID = current.DE_LEVEL_ID;
		O_PATH_ID = old.DE_PATH_ID;
		C_PATH_ID = current.DE_PATH_ID;
		O_CAM_ID = old.DE_CAM_ID;
		C_CAM_ID = current.DE_CAM_ID;
		abeY = current.DE_abeY;
		IsGameRunning = current.DE_IsGameRunning;
		gnFrame = current.DE_gnFrame;
		IsGameBeaten = current.DE_IsGameBeaten;
	} else if (vars.LangDetected == "Italian"){
		LEVEL_ID = current.IT_LEVEL_ID;
		O_PATH_ID = old.IT_PATH_ID;
		C_PATH_ID = current.IT_PATH_ID;
		O_CAM_ID = old.IT_CAM_ID;
		C_CAM_ID = current.IT_CAM_ID;
		abeY = current.IT_abeY;
		IsGameRunning = current.IT_IsGameRunning;
		gnFrame = current.IT_gnFrame;
		IsGameBeaten = current.IT_IsGameBeaten;
	}
	
	if (gnFrame >= 0){		
	
		vars.gnFrameCurrent = gnFrame;
		
		if (LEVEL_ID > 0 && vars.PreviousTime > 0 && vars.StartgnFrame == 0) { // WE JUST RESTARTED THE GAME AND LOADED!!
			vars.StartgnFrame = gnFrame; 
			File.Delete(@"C:\Autosplit Backup Files\previousTime"); // Important!! 
		}		
		
		if (IsGameRunning == 1){ // if the game is paused...
			vars.Epoch = (DateTime.UtcNow.Ticks - 621355968000000000) / 10000;
			if (vars.PauseStartTime == -1){ // Paused for the first time.
				vars.PauseStartTime = vars.Epoch;
			}		
			
		} else {		
		
			if (vars.PauseStartTime > 0){ // Unpaused for the first time.
				vars.MillisecondsPaused = vars.MillisecondsPaused + (vars.Epoch - vars.PauseStartTime);
				vars.PauseStartTime = -1;
			}
			
		}

		if (settings["UsingAutosplit"]){
			if (settings["SplitsAny%"]){
				if (vars.n <= 3){ // RuptureFarms 0-3
				// RF First part
					if (LEVEL_ID == 1 && C_CAM_ID == 1 && C_PATH_ID == 16 && vars.n == 0) {
						++vars.n;
						return true;
					}
				// RF Second part
					if (LEVEL_ID == 1 && C_CAM_ID == 10 && C_PATH_ID == 18 && vars.n == 1) {
						++vars.n;
						return true;
					}
				// RF Third part
					if (LEVEL_ID == 1 && C_CAM_ID == 1 && C_PATH_ID == 19 && vars.n == 2) {
						++vars.n;
						return true;
					}
				// RuptureFarms
					if (LEVEL_ID == 5 && C_CAM_ID == 6 && C_PATH_ID == 6 && vars.n == 3) {
						++vars.n;
						return true;
					}
				}

				if (vars.n >= 4 && vars.n <= 6){ // Stockyards 4-6
				// S Scrab part
					if (LEVEL_ID == 5 && C_CAM_ID == 1 && C_PATH_ID == 1 && vars.n == 4) {
						++vars.n;
						return true;
					}
				// S Slig Part
					if (LEVEL_ID == 5 && C_CAM_ID == 1 && C_PATH_ID == 4 && vars.n == 5) {
						++vars.n;
						return true;
					}
				// Stockyards
					if (LEVEL_ID == 2 && C_CAM_ID == 14 && C_PATH_ID == 1 && vars.n == 6) {
						++vars.n;
						return true;
					}
				}
				
				if (vars.n >= 7 && vars.n <= 9){ // Monsaic Lines
				// ML Slig part
					if (LEVEL_ID == 2 && C_CAM_ID == 8 && C_PATH_ID == 2 && vars.n == 7) {
						++vars.n;
						return true;
					}
				// ML DDG Bees
					if (LEVEL_ID == 2 && C_CAM_ID == 1 && C_PATH_ID == 6 && vars.n == 8) {
						++vars.n;
						return true;
					}
				// Monsaic Lines
					if (LEVEL_ID == 6 && C_CAM_ID == 7 && C_PATH_ID == 4 && vars.n == 9) {
						++vars.n;
						return true;
					}
				}
				
				if (vars.n == 10 || vars.n == 11){ // Return to RuptureFarms
				// RtR First Part
					if (LEVEL_ID == 6 && C_CAM_ID == 4 && C_PATH_ID == 2 && vars.n == 10) {
						++vars.n;
						return true;
					}
				// Return to Rupturefarms
					if (LEVEL_ID == 13 && C_CAM_ID == 3 && C_PATH_ID == 19 && vars.n == 11) {
						++vars.n;
						return true;
					}
				}	
				
				if (vars.n >= 12 && vars.n <= 17){ // Zulags
				// Zulag I
					if (LEVEL_ID == 13 && C_CAM_ID == 4 && C_PATH_ID == 1 && vars.n == 12) {
						++vars.n;
						return true;
					}
				// Zulag II
					if (LEVEL_ID == 13 && C_CAM_ID == 5 && C_PATH_ID == 13 && vars.n == 13) {
						++vars.n;
						return true;
					}
					
				// Zulag III
					if (LEVEL_ID == 13 && C_CAM_ID == 5 && C_PATH_ID == 14 && vars.n == 14) {
						++vars.n;
						return true;
					}
					
				// Slog Kennels
					if (LEVEL_ID == 13 && C_CAM_ID == 6 && C_PATH_ID == 4 && O_PATH_ID == 8 && vars.n == 15) {
						++vars.n;
						return true;
					}
					
				// Main Section
					if (LEVEL_ID == 13 && C_CAM_ID == 1 && C_PATH_ID == 11 && vars.n == 16) {
						++vars.n;
						return true;
					}
					
				// Zulag IV
					if (LEVEL_ID == 12 && C_CAM_ID == 2 && C_PATH_ID == 6 && abeY > 235 && vars.n == 17) {
						++vars.n;
						return true;
					}					
				}
			
			
			} else if (settings["SplitsAny%NMS"]){
				if (vars.n <= 3){ // RuptureFarms 0-3
				// Tutorials
					if (LEVEL_ID == 1 && C_CAM_ID == 1 && C_PATH_ID == 16 && vars.n == 0) {
						++vars.n;
						return true;
					}
				// Meat grinder
					if (LEVEL_ID == 1 && C_CAM_ID == 10 && C_PATH_ID == 18 && vars.n == 1) {
						++vars.n;
						return true;
					}
				// Sligs
					if (LEVEL_ID == 1 && C_CAM_ID == 1 && C_PATH_ID == 19 && vars.n == 2) {
						++vars.n;
						return true;
					}
				// RuptureFarms
					if (LEVEL_ID == 5 && C_CAM_ID == 6 && C_PATH_ID == 6 && vars.n == 3) {
						++vars.n;
						return true;
					}
				}
				
				if (vars.n >= 4 && vars.n <= 6){ // Stockyards 4-6
				// Scrab part
					if (LEVEL_ID == 5 && C_CAM_ID == 1 && C_PATH_ID == 1 && vars.n == 4) {
						++vars.n;
						return true;
					}
				// Slig Part
					if (LEVEL_ID == 5 && C_CAM_ID == 1 && C_PATH_ID == 4 && vars.n == 5) {
						++vars.n;
						return true;
					}
				// Stockyards
					if (LEVEL_ID == 2 && C_CAM_ID == 14 && C_PATH_ID == 1 && vars.n == 6) {
						++vars.n;
						return true;
					}
				}
				
				if (vars.n == 7 || vars.n == 8){ // Monsaic Lines
				// Natives
					if (LEVEL_ID == 2 && C_CAM_ID == 8 && C_PATH_ID == 2 && vars.n == 7) {
						++vars.n;
						return true;
					}
				// Monsaic Lines (to Paramonia)
					if (LEVEL_ID == 3 && C_CAM_ID == 1 && C_PATH_ID == 1 && vars.n == 8) {
						++vars.n;
						vars.ParamoniaFirst = true;
						if (!settings["NoLog"]){ 
							vars.LoadTexts = true; // We make sure that the texts are updated to be Paramonia first.
						}
						return true;
					}
					
				// Monsaic Lines (to Scrabania)
					if (LEVEL_ID == 8 && C_CAM_ID == 1 && C_PATH_ID == 1 && vars.n == 8) {
						++vars.n;			
						vars.ParamoniaFirst = false;
						if (!settings["NoLog"]){ 
							vars.LoadTexts = true; // We make sure that the texts are updated to be Scrabania first.
						}
						return true;
					}
				}
				
				if (vars.ParamoniaFirst){		
					
					if (LEVEL_ID == 3 && vars.n >= 23 && vars.n <= 27){ // If we restart the game and the variable is wrong, this will fix it (or SHOULD).
						vars.ParamoniaFirst = false;			
						if (!settings["NoLog"]){ 
							vars.LoadTexts = true; // We make sure that the texts are updated to be Paramonia first.	
						}
					}
					
					if (vars.n >= 9 && vars.n <= 13){ // Paramonia
					// Get the Elum
						if (LEVEL_ID == 3 && C_CAM_ID == 1 && C_PATH_ID == 2 && vars.n == 9) {
							++vars.n;
							return true;
						}
						
					// Honey and Sligs
						if (LEVEL_ID == 3 && C_CAM_ID == 9 && C_PATH_ID == 5 && vars.n == 10) {
							++vars.n;
							return true;
						}
						
					// Platforms and Bees
						if (LEVEL_ID == 3 && C_CAM_ID == 1 && C_PATH_ID == 6 && vars.n == 11) {
							++vars.n;
							return true;
						}
						
					// Passwords and Sligs
						if (LEVEL_ID == 3 && C_CAM_ID == 1 && C_PATH_ID == 9 && vars.n == 12) {
							++vars.n;
							return true;
						}
						
					// Paramonia
						if (LEVEL_ID == 4 && C_CAM_ID == 1 && C_PATH_ID == 1 && vars.n == 13) {
							++vars.n;
							return true;
						}	
					}
					
					if (LEVEL_ID == 4 && C_PATH_ID == 1 && vars.n <= 13) { // Split if the autosplitter gets stuck and the runner gets inside Paramonian temple (entry)
						++vars.n;
						return true;			
					} else {
						if (LEVEL_ID == 4 && C_PATH_ID > 1 && vars.n < 15) { // Split if the autosplitter gets stuck and the runner gets inside Paramonian temple (AFTER entry)
							++vars.n;
							return true;			
						}
					}
					
					if (vars.n >= 14 && vars.n <= 22){ // Paramonian Temple
					// Entry
						if (LEVEL_ID == 4 && C_CAM_ID == 1 && C_PATH_ID == 8 && vars.n == 14) {
							++vars.n;
							return true;
						}
						
					// Trial 1
						if (C_PATH_ID == 8 && O_PATH_ID == 4 && O_CAM_ID == 6) { // https://i.imgur.com/CThhUM5.jpg
							++vars.n;
							return true;
						}
						
					// Trial 2
						if (C_PATH_ID == 8 && O_PATH_ID == 2 && O_CAM_ID == 8) { // https://i.imgur.com/C1CPF36.jpg
							++vars.n;
							return true;
						}
						
					// Trial 3 (now it's 5)
						if (C_PATH_ID == 8 && O_PATH_ID == 6 && O_CAM_ID == 7) { // https://i.imgur.com/A8IVuGp.jpg
							++vars.n;
							return true;
						}
						
					// Trial 4 (now it's 6)
						if (C_PATH_ID == 8 && O_PATH_ID == 7 && O_CAM_ID == 5) { // https://i.imgur.com/lPrWDD2.jpg
							++vars.n;
							return true;
						}
						
					// Trial 5  (now it's 3)
						if (C_PATH_ID == 8 && O_PATH_ID == 5 && O_CAM_ID == 2) { // https://i.imgur.com/ku9rf3g.jpg
							++vars.n;
							return true;
						}
						
					// Trial 6 (now it's 4)
						if (C_PATH_ID == 8 && O_PATH_ID == 3 && O_CAM_ID == 1) { // https://i.imgur.com/LtYPFNm.jpg
							++vars.n;
							return true;
						}
						
					// Paramonian Nests 
						if (LEVEL_ID == 2 && C_CAM_ID == 4 && C_PATH_ID == 5 && vars.n >= 15 && vars.n <= 21) { // 15 / 06 / 2020 - Fix to prevent getting stuck if a trial doesn't split
							vars.n = 22;
							return true;
						}	
						
					// Paramonian Temple 
						if (LEVEL_ID == 8 && C_CAM_ID == 1 && C_PATH_ID == 1 && vars.n == 22) {
							vars.n = 23;
							return true;
						}	
					}		
					
					if (vars.n >= 23 && vars.n <= 25){ // Scrabania
					// Get Elum
						if (LEVEL_ID == 8 && C_CAM_ID == 1 && C_PATH_ID == 2 && vars.n == 23) {
							++vars.n;
							return true;
						}
						
					// Play with Mines
						if (LEVEL_ID == 8 && C_CAM_ID == 5 && C_PATH_ID == 8 && vars.n == 24) {
							++vars.n;
							return true;
						}
						
					// Scrabania
						if (LEVEL_ID == 9 && C_CAM_ID == 1 && C_PATH_ID == 1 && vars.n == 25) {
							++vars.n;
							return true;
						}
					}	
										
					if (vars.n >= 26 && vars.n <= 36){ // Scrabania Temple
					// Entry
						if (LEVEL_ID == 9 && C_CAM_ID == 1 && C_PATH_ID == 10 && vars.n == 26) {
							++vars.n;
							return true;
						}
					// Trial 1
						if (O_PATH_ID == 9 && C_PATH_ID == 10 && O_CAM_ID == 5) { // https://i.imgur.com/VUTQJ5R.jpg
							++vars.n;
							return true;
						}
					// Trial 2
						if (O_PATH_ID == 2 && C_PATH_ID == 10 && O_CAM_ID == 4) { // https://i.imgur.com/mtbUcdr.jpg
							++vars.n;
							return true;
						}
					// Trial 3
						if (O_PATH_ID == 3 && C_PATH_ID == 10 && O_CAM_ID == 5) { // https://i.imgur.com/09DtCCn.jpg
							++vars.n;
							return true;
						}
					// Trial 4
						if (O_PATH_ID == 5 && C_PATH_ID == 10 && O_CAM_ID == 8) { // https://i.imgur.com/qjAxMzI.jpg
							++vars.n;
							return true;
						}
					// Trial 5
						if (O_PATH_ID == 4 && C_PATH_ID == 10 && O_CAM_ID == 5) { // https://i.imgur.com/8BxoUsw.jpg
							++vars.n;
							return true;
						}
					// Trial 6
						if (O_PATH_ID == 7 && C_PATH_ID == 10 && O_CAM_ID == 1) { // https://i.imgur.com/WHeaT7j.jpg
							++vars.n;
							return true;
						}
					// Trial 7
						if (O_PATH_ID == 6 && C_PATH_ID == 10 && O_CAM_ID == 4) { // https://i.imgur.com/NkzyNWh.jpg
							++vars.n;
							return true;
						}
					// Trial 8
						if (O_PATH_ID == 8 && C_PATH_ID == 10 && O_CAM_ID == 4) { // https://i.imgur.com/lX7IQg3.jpg
							++vars.n;
							return true;
						}
					// Scrabanian Nests
						if (LEVEL_ID == 2 && C_CAM_ID == 4 && C_PATH_ID == 5 && vars.n >= 27 && vars.n <= 35) {
							vars.n = 36; // Security measure.
							return true;
						}
					// Scrabania Temple to FFZ
						if (LEVEL_ID == 6 && C_CAM_ID == 7 && C_PATH_ID == 4 && vars.n == 36) { // Entry Free Fire Zone - Change
							vars.n = 37; // Security measure.
							return true;
						}
					}		
				
				} else { // We start with Scrabania.	
				
					if (vars.ParamoniaFirst == false && LEVEL_ID == 8 && vars.n >= 23 && vars.n <= 25){ // If we restart the game and the variable is wrong, this will fix it (or SHOULD).
						vars.ParamoniaFirst = true;			
						vars.LoadTexts = true; // We make sure that the texts are updated to be Paramonia first.			
					}
					
					if (vars.n >= 9 && vars.n <= 11){ // Scrabania
					// Get Elum
						if (LEVEL_ID == 8 && C_CAM_ID == 1 && C_PATH_ID == 2 && vars.n == 9) {
							++vars.n;
							return true;
						}
						
					// Play with Mines
						if (LEVEL_ID == 8 && C_CAM_ID == 5 && C_PATH_ID == 8 && vars.n == 10) {
							++vars.n;
							return true;
						}
						
					// Scrabania
						if (LEVEL_ID == 9 && C_CAM_ID == 1 && C_PATH_ID == 1 && vars.n == 11) {
							++vars.n;
							return true;
						}
					}	
					
					if (vars.n >= 12 && vars.n <= 22){ // Scrabania Temple
					// Entry
						if (LEVEL_ID == 9 && C_CAM_ID == 1 && C_PATH_ID == 10 && vars.n == 12) {
							++vars.n;
							return true;
						}
						
					// Trial 1
						if (O_PATH_ID == 9 && C_PATH_ID == 10 && O_CAM_ID == 5) { // https://i.imgur.com/VUTQJ5R.jpg
							++vars.n;
							return true;
						}
						
					// Trial 2
						if (O_PATH_ID == 2 && C_PATH_ID == 10 && O_CAM_ID == 4) { // https://i.imgur.com/mtbUcdr.jpg
							++vars.n;
							return true;
						}
						
					// Trial 3
						if (O_PATH_ID == 3 && C_PATH_ID == 10 && O_CAM_ID == 5) { // https://i.imgur.com/09DtCCn.jpg
							++vars.n;
							return true;
						}
						
					// Trial 4
						if (O_PATH_ID == 5 && C_PATH_ID == 10 && O_CAM_ID == 8) { // https://i.imgur.com/qjAxMzI.jpg
							++vars.n;
							return true;
						}
	
					// Trial 5
						if (O_PATH_ID == 4 && C_PATH_ID == 10 && O_CAM_ID == 5) { // https://i.imgur.com/8BxoUsw.jpg
							++vars.n;
							return true;
						}
						
					// Trial 6
						if (O_PATH_ID == 7 && C_PATH_ID == 10 && O_CAM_ID == 1) { // https://i.imgur.com/WHeaT7j.jpg
							++vars.n;
							return true;
						}
						
					// Trial 7
						if (O_PATH_ID == 6 && C_PATH_ID == 10 && O_CAM_ID == 4) { // https://i.imgur.com/NkzyNWh.jpg
							++vars.n;
							return true;
						}
						
					// Trial 8
						if (O_PATH_ID == 8 && C_PATH_ID == 10 && O_CAM_ID == 4) { // https://i.imgur.com/lX7IQg3.jpg
							++vars.n;
							return true;
						}
						
					// Scrabanian Nests
						if (LEVEL_ID == 2 && C_CAM_ID == 4 && C_PATH_ID == 5 && vars.n >= 13 && vars.n <= 21) {
							vars.n = 22;
							return true;
						}
						
					// Scrabania Temple
						if (LEVEL_ID == 3 && C_CAM_ID == 1 && C_PATH_ID == 1 && vars.n == 22) { // From Scrabania to Paramonia.
							++vars.n;
							return true;
						}
					}
					
					if (vars.n >= 23 && vars.n <= 27){ // Paramonia
					// Get the Elum
						if (LEVEL_ID == 3 && C_CAM_ID == 1 && C_PATH_ID == 2 && vars.n == 23) {
							++vars.n;
							return true;
						}
						
					// Honey and Sligs
						if (LEVEL_ID == 3 && C_CAM_ID == 9 && C_PATH_ID == 5 && vars.n == 24) {
							++vars.n;
							return true;
						}
						
					// Platforms and Bees
						if (LEVEL_ID == 3 && C_CAM_ID == 1 && C_PATH_ID == 6 && vars.n == 25) {
							++vars.n;
							return true;
						}
						
					// Passwords and Sligs
						if (LEVEL_ID == 3 && C_CAM_ID == 1 && C_PATH_ID == 9 && vars.n == 26) {
							++vars.n;
							return true;
						}
						
					// Paramonia
						if (LEVEL_ID == 4 && C_CAM_ID == 1 && C_PATH_ID == 1 && vars.n == 27) {
							++vars.n;
							return true;
						}	
					}
					
					if (vars.n >= 28 && vars.n <= 36){ // Paramonian Temple
					// Entry
						if (LEVEL_ID == 4 && C_CAM_ID == 1 && C_PATH_ID == 8 && vars.n == 28) {
							++vars.n;
							return true;
						}
						
					// Trial 1
						if (C_PATH_ID == 8 && O_PATH_ID == 4 && O_CAM_ID == 6) { // https://i.imgur.com/CThhUM5.jpg
							++vars.n;
							return true;
						}
						
					// Trial 2
						if (C_PATH_ID == 8 && O_PATH_ID == 2 && O_CAM_ID == 8) { // https://i.imgur.com/C1CPF36.jpg
							++vars.n;
							return true;
						}
						
					// Trial 3
						if (C_PATH_ID == 8 && O_PATH_ID == 6 && O_CAM_ID == 7) { // https://i.imgur.com/A8IVuGp.jpg
							++vars.n;
							return true;
						}
						
					// Trial 4
						if (C_PATH_ID == 8 && O_PATH_ID == 7 && O_CAM_ID == 5) { // https://i.imgur.com/lPrWDD2.jpg
							++vars.n;
							return true;
						}
						
					// Trial 5
						if (C_PATH_ID == 8 && O_PATH_ID == 5 && O_CAM_ID == 2) { // https://i.imgur.com/ku9rf3g.jpg
							++vars.n;
							return true;
						}
						
					// Trial 6
						if (C_PATH_ID == 8 && O_PATH_ID == 3 && O_CAM_ID == 1) { // https://i.imgur.com/LtYPFNm.jpg
							++vars.n;
							return true;
						}
						
					// Paramonian Nests 
						if (LEVEL_ID == 2 && C_CAM_ID == 4 && C_PATH_ID == 5 && vars.n >= 29 && vars.n <= 35) { // 15 / 06 / 2020 - Fix to prevent getting stuck if a trial doesn't split
							vars.n = 36;
							return true;
						}	
						
					// Paramonian Temple 
						if (LEVEL_ID == 6 && C_CAM_ID == 7 && C_PATH_ID == 4 && vars.n == 36) {
							++vars.n;
							return true;
						}	
					}
				}
				
				if (vars.n == 37 || vars.n == 38){ // Zulag 1
				 // Free Fire Zone
					if (LEVEL_ID == 13 && C_CAM_ID == 3 && C_PATH_ID == 19 && vars.n == 37) {
						++vars.n;
						return true;
					}	
					
				// Zulag 1
					if (LEVEL_ID == 13 && C_CAM_ID == 4 && C_PATH_ID == 1 && vars.n == 38) {
						++vars.n;
						return true;
					}	
				}
				
				if (vars.n >= 39 && vars.n <= 43){ // Zulag 2
				// Entry
					if (LEVEL_ID == 13 && C_CAM_ID == 3 && C_PATH_ID == 1 && vars.n == 39) {
						++vars.n;
						return true;
					}	
					
				// Door 1
					if (C_PATH_ID == 2 && C_CAM_ID == 4 && vars.trialCheck[0] != true){ // Door 1 check
						vars.trialCheck[0] = true;
					}
					
					if (O_PATH_ID == 2 && C_PATH_ID == 1 && vars.trialCheck[0] == true) {
						++vars.n;
						return true;
					}	
					
				// Door 2				
					if (C_PATH_ID == 10 && C_CAM_ID == 5 && vars.trialCheck[1] != true){ // Door 2 check
						vars.trialCheck[1] = true;
					}
					
					if (O_PATH_ID == 10 && C_PATH_ID == 1 && vars.trialCheck[1] == true) {
						++vars.n;
						return true;
					}
					
				// Door 3			
					if (C_PATH_ID == 3 && C_CAM_ID == 5 && vars.trialCheck[2] != true){ // Door 3 check
						vars.trialCheck[2] = true;
					}
					
					if (O_PATH_ID == 3 && C_PATH_ID == 1 && vars.trialCheck[2] == true) {
						++vars.n;
						return true;
					}	
					
				// Zulag 2
					if (LEVEL_ID == 13 && C_CAM_ID == 5 && C_PATH_ID == 13) {
						vars.n = 44;
						return true;
					}	
				}
				
				if (vars.n >= 44 && vars.n <= 48){ // Zulag 3
				// Entry
					if (LEVEL_ID == 13 && C_CAM_ID == 4 && C_PATH_ID == 13 && vars.n == 44) {
						++vars.n;
						return true;
					}	
					
				// Door 1
					if (C_PATH_ID == 9 && C_CAM_ID == 2 && vars.trialCheck[3] != true){ // Door 2 check
						vars.trialCheck[3] = true;
					}
					
					if (O_PATH_ID == 12 && C_PATH_ID == 13 && vars.trialCheck[3] == true) {
						++vars.n;
						return true;
					}
					
					
				// Door 2	
				
					if (C_PATH_ID == 7 && C_CAM_ID == 9 && vars.trialCheck[4] != true){ // Door 2 check
						vars.trialCheck[4] = true;
					}			
					if (O_PATH_ID == 7 && C_PATH_ID == 13 && vars.trialCheck[4] == true) {
						++vars.n;
						return true;
					}	
					
					
				// Door 3
					if (C_PATH_ID == 5 && C_CAM_ID == 4 && vars.trialCheck[5] != true){ // Door 3 check
						vars.trialCheck[5] = true;
					}
					
					if (O_PATH_ID == 5 && C_PATH_ID == 13 && vars.trialCheck[5] == true) {
						++vars.n;
						return true;
					}	
					
				// Zulag 3
					if (LEVEL_ID == 13 && C_CAM_ID == 5 && C_PATH_ID == 14) {
						vars.n = 49;
						return true;
					}	
				}
				
				if (vars.n >= 49 && vars.n <= 52){ // Zulag 4
				// Enter Slog Kennels
					if (LEVEL_ID == 13 && C_CAM_ID == 1 && C_PATH_ID == 8 && vars.n == 49) {
						++vars.n;
						return true;
					}	
					
				// Leave Slog Kennels
					if (C_PATH_ID == 8 && C_CAM_ID == 5 && vars.trialCheck[6] != true){ // Slog Kennels check
						vars.trialCheck[6] = true;
					}
					
					if (LEVEL_ID == 13 && C_CAM_ID == 6 && C_PATH_ID == 4 && vars.n == 50 && vars.trialCheck[6] == true) {
						++vars.n;
						return true;
					}
					
				// Enter Second Part
					if (LEVEL_ID == 13 && C_CAM_ID == 1 && C_PATH_ID == 11 && vars.n == 51) {
						++vars.n;
						return true;
					}	
					
				// Zulag 4
					if (LEVEL_ID == 12 && C_CAM_ID == 2 && C_PATH_ID == 6 && abeY > 235 && vars.n == 52) {
						vars.n = 53;
						return true;
					}			
				}
				
				
			
			} else if (settings["Splits100%"]){
				if (vars.n < 4){ // RuptureFarms 0-3
				// Tutorials
					if (LEVEL_ID == 1 && C_CAM_ID == 1 && C_PATH_ID == 16 && vars.n == 0) {
						++vars.n;
						return true;
					}
				// Meat grinder
					if (LEVEL_ID == 1 && C_CAM_ID == 10 && C_PATH_ID == 18 && vars.n == 1) {
						++vars.n;
						return true;
					}
				// Sligs
					if (LEVEL_ID == 1 && C_CAM_ID == 1 && C_PATH_ID == 19 && vars.n == 2) {
						++vars.n;
						return true;
					}
				// RuptureFarms
					if (LEVEL_ID == 5 && C_CAM_ID == 6 && C_PATH_ID == 6 && vars.n == 3) {
						++vars.n;
						return true;
					}
				}
				
				if (vars.n >= 4 && vars.n <= 6){ // Stockyards 4-6
				// Scrab part
					if (LEVEL_ID == 5 && C_CAM_ID == 1 && C_PATH_ID == 1 && vars.n == 4) {
						++vars.n;
						return true;
					}
				// Slig Part
					if (LEVEL_ID == 5 && C_CAM_ID == 1 && C_PATH_ID == 4 && vars.n == 5) {
						++vars.n;
						return true;
					}
				// Stockyards
					if (LEVEL_ID == 2 && C_CAM_ID == 14 && C_PATH_ID == 1 && vars.n == 6) {
						++vars.n;
						return true;
					}
				}
				
				if (vars.n == 7 || vars.n == 8){ // Monsaic Lines
				// Natives
					if (LEVEL_ID == 2 && C_CAM_ID == 8 && C_PATH_ID == 2 && vars.n == 7) {
						++vars.n;
						return true;
					}
				// Monsaic Lines (to Paramonia)
					if (LEVEL_ID == 3 && C_CAM_ID == 1 && C_PATH_ID == 1 && vars.n == 8) {
						++vars.n;
						vars.ParamoniaFirst = true;
						if (!settings["NoLog"]){ 
							vars.LoadTexts = true; // We make sure that the texts are updated to be Paramonia first.
						}
						return true;
					}
					
				// Monsaic Lines (to Scrabania)
					if (LEVEL_ID == 8 && C_CAM_ID == 1 && C_PATH_ID == 1 && vars.n == 8) {
						++vars.n;			
						vars.ParamoniaFirst = false;
						if (!settings["NoLog"]){ 
							vars.LoadTexts = true; // We make sure that the texts are updated to be Scrabania first.
						}
						return true;
					}
				}
				
				if (vars.ParamoniaFirst){		
					
					if (LEVEL_ID == 3 && vars.n >= 23 && vars.n <= 27){ // If we restart the game and the variable is wrong, this will fix it (or SHOULD).
						vars.ParamoniaFirst = false;			
						if (!settings["NoLog"]){ 
							vars.LoadTexts = true; // We make sure that the texts are updated to be Paramonia first.	
						}
					}
					
					if (vars.n >= 9 && vars.n <= 13){ // Paramonia
					// Get the Elum
						if (LEVEL_ID == 3 && C_CAM_ID == 1 && C_PATH_ID == 2 && vars.n == 9) {
							++vars.n;
							return true;
						}
						
					// Honey and Sligs
						if (LEVEL_ID == 3 && C_CAM_ID == 9 && C_PATH_ID == 5 && vars.n == 10) {
							++vars.n;
							return true;
						}
						
					// Platforms and Bees
						if (LEVEL_ID == 3 && C_CAM_ID == 1 && C_PATH_ID == 6 && vars.n == 11) {
							++vars.n;
							return true;
						}
						
					// Passwords and Sligs
						if (LEVEL_ID == 3 && C_CAM_ID == 1 && C_PATH_ID == 9 && vars.n == 12) {
							++vars.n;
							return true;
						}
						
					// Paramonia
						if (LEVEL_ID == 4 && C_CAM_ID == 1 && C_PATH_ID == 1 && vars.n == 13) {
							++vars.n;
							return true;
						}	
					}
					
					if (LEVEL_ID == 4 && C_PATH_ID == 1 && vars.n <= 13) { // Split if the autosplitter gets stuck and the runner gets inside Paramonian temple (entry)
						++vars.n;
						return true;			
					} else {
						if (LEVEL_ID == 4 && C_PATH_ID > 1 && vars.n <= 14) { // Split if the autosplitter gets stuck and the runner gets inside Paramonian temple (AFTER entry)
							++vars.n;
							return true;			
						}
					}
					
					if (vars.n >= 14 && vars.n <= 22){ // Paramonian Temple
					// Entry
						if (LEVEL_ID == 4 && C_CAM_ID == 1 && C_PATH_ID == 8 && vars.n == 14) {
							++vars.n;
							return true;
						}
						
					// Trial 1
						if (C_PATH_ID == 8 && O_PATH_ID == 4 && O_CAM_ID == 6) { // https://i.imgur.com/CThhUM5.jpg
							++vars.n;
							return true;
						}
						
					// Trial 2
						if (C_PATH_ID == 8 && O_PATH_ID == 2 && O_CAM_ID == 8) { // https://i.imgur.com/C1CPF36.jpg
							++vars.n;
							return true;
						}
						
					// Trial 3
						if (C_PATH_ID == 8 && O_PATH_ID == 6 && O_CAM_ID == 7) { // https://i.imgur.com/A8IVuGp.jpg
							++vars.n;
							return true;
						}
						
					// Trial 4
						if (C_PATH_ID == 8 && O_PATH_ID == 7 && O_CAM_ID == 5) { // https://i.imgur.com/lPrWDD2.jpg
							++vars.n;
							return true;
						}
						
					// Trial 5
						if (C_PATH_ID == 8 && O_PATH_ID == 5 && O_CAM_ID == 2) { // https://i.imgur.com/ku9rf3g.jpg
							++vars.n;
							return true;
						}
						
					// Trial 6
						if (C_PATH_ID == 8 && O_PATH_ID == 3 && O_CAM_ID == 1) { // https://i.imgur.com/LtYPFNm.jpg
							++vars.n;
							return true;
						}
						
					// Paramonian Nests 
						if (LEVEL_ID == 2 && C_CAM_ID == 4 && C_PATH_ID == 5 && vars.n >= 15 && vars.n <= 21) { // 15 / 06 / 2020 - Fix to prevent getting stuck if a trial doesn't split
							vars.n = 22;
							return true;
						}	
						
					// Paramonian Temple 
						if (LEVEL_ID == 8 && C_CAM_ID == 1 && C_PATH_ID == 1 && vars.n == 22) {
							vars.n = 23;
							return true;
						}	
					}		
					
					if (vars.n >= 23 && vars.n <= 25){ // Scrabania
					// Get Elum
						if (LEVEL_ID == 8 && C_CAM_ID == 1 && C_PATH_ID == 2 && vars.n == 23) {
							++vars.n;
							return true;
						}
						
					// Play with Mines
						if (LEVEL_ID == 8 && C_CAM_ID == 5 && C_PATH_ID == 8 && vars.n == 24) {
							++vars.n;
							return true;
						}
						
					// Scrabania
						if (LEVEL_ID == 9 && C_CAM_ID == 1 && C_PATH_ID == 1 && vars.n == 25) {
							++vars.n;
							return true;
						}
					}	
					
					if (vars.n >= 26 && vars.n <= 36){ // Scrabania Temple
					// Entry
						if (LEVEL_ID == 9 && C_CAM_ID == 1 && C_PATH_ID == 10 && vars.n == 26) {
							++vars.n;
							return true;
						}
					// Trial 1
						if (O_PATH_ID == 9 && C_PATH_ID == 10 && O_CAM_ID == 5) { // https://i.imgur.com/VUTQJ5R.jpg
							++vars.n;
							return true;
						}
					// Trial 2
						if (O_PATH_ID == 2 && C_PATH_ID == 10 && O_CAM_ID == 4) { // https://i.imgur.com/mtbUcdr.jpg
							++vars.n;
							return true;
						}
					// Trial 3
						if (O_PATH_ID == 3 && C_PATH_ID == 10 && O_CAM_ID == 5) { // https://i.imgur.com/09DtCCn.jpg
							++vars.n;
							return true;
						}
					// Trial 4
						if (O_PATH_ID == 5 && C_PATH_ID == 10 && O_CAM_ID == 8) { // https://i.imgur.com/qjAxMzI.jpg
							++vars.n;
							return true;
						}
					// Trial 5
						if (O_PATH_ID == 4 && C_PATH_ID == 10 && O_CAM_ID == 5) { // https://i.imgur.com/8BxoUsw.jpg
							++vars.n;
							return true;
						}
					// Trial 6
						if (O_PATH_ID == 7 && C_PATH_ID == 10 && O_CAM_ID == 1) { // https://i.imgur.com/WHeaT7j.jpg
							++vars.n;
							return true;
						}
					// Trial 7
						if (O_PATH_ID == 6 && C_PATH_ID == 10 && O_CAM_ID == 4) { // https://i.imgur.com/NkzyNWh.jpg
							++vars.n;
							return true;
						}
					// Trial 8
						if (O_PATH_ID == 8 && C_PATH_ID == 10 && O_CAM_ID == 4) { // https://i.imgur.com/lX7IQg3.jpg
							++vars.n;
							return true;
						}
					// Scrabanian Nests
						if (LEVEL_ID == 2 && C_CAM_ID == 4 && C_PATH_ID == 5 && vars.n >= 27 && vars.n <= 35) {
							vars.n = 36; // Security measure.
							return true;
						}
					// Scrabania Temple
						if (LEVEL_ID == 6 && C_CAM_ID == 7 && C_PATH_ID == 4 && vars.n == 36) { // Entry Free Fire Zone - Change
							vars.n = 37; // Security measure.
							return true;
						}
					}		
				} else { // We start with Scrabania.	
				
					if (vars.ParamoniaFirst == false && LEVEL_ID == 8 && vars.n >= 23 && vars.n <= 25){ // If we restart the game and the variable is wrong, this will fix it (or SHOULD).
						vars.ParamoniaFirst = true;			
						vars.LoadTexts = true; // We make sure that the texts are updated to be Paramonia first.			
					}
					
					if (vars.n >= 9 && vars.n <= 11){ // Scrabania
					// Get Elum
						if (LEVEL_ID == 8 && C_CAM_ID == 1 && C_PATH_ID == 2 && vars.n == 9) {
							++vars.n;
							return true;
						}
						
					// Play with Mines
						if (LEVEL_ID == 8 && C_CAM_ID == 5 && C_PATH_ID == 8 && vars.n == 10) {
							++vars.n;
							return true;
						}
						
					// Scrabania
						if (LEVEL_ID == 9 && C_CAM_ID == 1 && C_PATH_ID == 1 && vars.n == 11) {
							++vars.n;
							return true;
						}
					}	
					
					if (vars.n >= 12 && vars.n <= 22){ // Scrabania Temple
					// Entry
						if (LEVEL_ID == 9 && C_CAM_ID == 1 && C_PATH_ID == 10 && vars.n == 12) {
							++vars.n;
							return true;
						}
					
					// Trial 1
						if (O_PATH_ID == 9 && C_PATH_ID == 10 && O_CAM_ID == 5) { // https://i.imgur.com/VUTQJ5R.jpg
							++vars.n;
							return true;
						}
					
					// Trial 2
						if (O_PATH_ID == 2 && C_PATH_ID == 10 && O_CAM_ID == 4) { // https://i.imgur.com/mtbUcdr.jpg
							++vars.n;
							return true;
						}
					
					// Trial 3
						if (O_PATH_ID == 3 && C_PATH_ID == 10 && O_CAM_ID == 5) { // https://i.imgur.com/09DtCCn.jpg
							++vars.n;
							return true;
						}
					
					// Trial 4
						if (O_PATH_ID == 5 && C_PATH_ID == 10 && O_CAM_ID == 8) { // https://i.imgur.com/qjAxMzI.jpg
							++vars.n;
							return true;
						}
						
					// Trial 5
						if (O_PATH_ID == 4 && C_PATH_ID == 10 && O_CAM_ID == 5) { // https://i.imgur.com/8BxoUsw.jpg
							++vars.n;
							return true;
						}
					
					// Trial 6
						if (O_PATH_ID == 7 && C_PATH_ID == 10 && O_CAM_ID == 1) { // https://i.imgur.com/WHeaT7j.jpg
							++vars.n;
							return true;
						}
					
					// Trial 7
						if (O_PATH_ID == 6 && C_PATH_ID == 10 && O_CAM_ID == 4) { // https://i.imgur.com/NkzyNWh.jpg
							++vars.n;
							return true;
						}
					
					// Trial 8
						if (O_PATH_ID == 8 && C_PATH_ID == 10 && O_CAM_ID == 4) { // https://i.imgur.com/lX7IQg3.jpg
							++vars.n;
							return true;
						}
					
					// Scrabanian Nests
						if (LEVEL_ID == 2 && C_CAM_ID == 4 && C_PATH_ID == 5 && vars.n >= 13 && vars.n <= 21) {
							vars.n = 22;
							return true;
						}
					
					// Scrabania Temple
						if (LEVEL_ID == 3 && C_CAM_ID == 1 && C_PATH_ID == 1 && vars.n == 22) { // Entry Free Fire Zone - Change
							++vars.n;
							return true;
						}
					}
					
					if (vars.n >= 23 && vars.n <= 27){ // Paramonia
					// Get the Elum
						if (LEVEL_ID == 3 && C_CAM_ID == 1 && C_PATH_ID == 2 && vars.n == 23) {
							++vars.n;
							return true;
						}
						
					// Honey and Sligs
						if (LEVEL_ID == 3 && C_CAM_ID == 9 && C_PATH_ID == 5 && vars.n == 24) {
							++vars.n;
							return true;
						}
						
					// Platforms and Bees
						if (LEVEL_ID == 3 && C_CAM_ID == 1 && C_PATH_ID == 6 && vars.n == 25) {
							++vars.n;
							return true;
						}
						
					// Passwords and Sligs
						if (LEVEL_ID == 3 && C_CAM_ID == 1 && C_PATH_ID == 9 && vars.n == 26) {
							++vars.n;
							return true;
						}
						
					// Paramonia
						if (LEVEL_ID == 4 && C_CAM_ID == 1 && C_PATH_ID == 1 && vars.n == 27) {
							++vars.n;
							return true;
						}	
					}
					
					
					if (vars.n >= 28 && vars.n <= 36){ // Paramonian Temple
					// Entry
						if (LEVEL_ID == 4 && C_CAM_ID == 1 && C_PATH_ID == 8 && vars.n == 28) {
							++vars.n;
							return true;
						}
						
					// Trial 1
						if (C_PATH_ID == 8 && O_PATH_ID == 4 && O_CAM_ID == 6) { // https://i.imgur.com/CThhUM5.jpg
							++vars.n;
							return true;
						}
						
					// Trial 2
						if (C_PATH_ID == 8 && O_PATH_ID == 2 && O_CAM_ID == 8) { // https://i.imgur.com/C1CPF36.jpg
							++vars.n;
							return true;
						}
						
					// Trial 3
						if (C_PATH_ID == 8 && O_PATH_ID == 6 && O_CAM_ID == 7) { // https://i.imgur.com/A8IVuGp.jpg
							++vars.n;
							return true;
						}
						
					// Trial 4
						if (C_PATH_ID == 8 && O_PATH_ID == 7 && O_CAM_ID == 5) { // https://i.imgur.com/lPrWDD2.jpg
							++vars.n;
							return true;
						}
						
					// Trial 5
						if (C_PATH_ID == 8 && O_PATH_ID == 5 && O_CAM_ID == 2) { // https://i.imgur.com/ku9rf3g.jpg
							++vars.n;
							return true;
						}
						
					// Trial 6
						if (C_PATH_ID == 8 && O_PATH_ID == 3 && O_CAM_ID == 1) { // https://i.imgur.com/LtYPFNm.jpg
							++vars.n;
							return true;
						}
						
					// Paramonian Nests 
						if (LEVEL_ID == 2 && C_CAM_ID == 4 && C_PATH_ID == 5 && vars.n >= 29 && vars.n <= 35) { // 15 / 06 / 2020 - Fix to prevent getting stuck if a trial doesn't split
							vars.n = 36;
							return true;
						}	
						
					// Paramonian Temple 
						if (LEVEL_ID == 6 && C_CAM_ID == 7 && C_PATH_ID == 4 && vars.n == 36) {
							++vars.n;
							return true;
						}	
					}
				}
		
				if (vars.n >= 37 && vars.n <= 41){ // Zulag 1			
				
				// Free Fire Zone
					if (LEVEL_ID == 13 && C_CAM_ID == 3 && C_PATH_ID == 19 && vars.n == 37) {
						++vars.n;
						return true;
					}	
					
				// Mudokon Ring
					if (LEVEL_ID == 13 && C_CAM_ID == 7 && C_PATH_ID == 16 && vars.n == 38) {
						++vars.n;
						return true;
					}	
					
				// Sligs Meat Grinder
					if (LEVEL_ID == 13 && C_CAM_ID == 8 && C_PATH_ID == 15 && vars.n == 39) {
						++vars.n;
						return true;
					}	
					
				// Tutorials 2
					if (O_PATH_ID == 15 && C_PATH_ID == 18 && vars.n == 40) {
						++vars.n;
						return true;
					}	
					
				// Zulag 1
					if (LEVEL_ID == 13 && C_CAM_ID == 4 && C_PATH_ID == 1 && vars.n == 41) {
						++vars.n;
						return true;
					}	
				}
					
				if (vars.n >= 42 && vars.n <= 46){ // Zulag 2
				// Entry
					if (LEVEL_ID == 13 && C_CAM_ID == 3 && C_PATH_ID == 1 && vars.n == 42) {
						++vars.n;
						return true;
					}	
					
				// Door 1
					if (C_PATH_ID == 2 && C_CAM_ID == 4 && vars.trialCheck[0] != true){ // Door 1 check
						vars.trialCheck[0] = true;
					}
					
					if (O_PATH_ID == 2 && C_PATH_ID == 1 && vars.trialCheck[0] == true) {
						++vars.n;
						return true;
					}	
					
				// Door 2				
					if (C_PATH_ID == 10 && C_CAM_ID == 5 && vars.trialCheck[1] != true){ // Door 2 check
						vars.trialCheck[1] = true;
					}
					
					if (O_PATH_ID == 10 && C_PATH_ID == 1 && vars.trialCheck[1] == true) {
						++vars.n;
						return true;
					}
					
				// Door 3			
					if (C_PATH_ID == 3 && C_CAM_ID == 5 && vars.trialCheck[2] != true){ // Door 3 check
						vars.trialCheck[2] = true;
					}
					
					if (O_PATH_ID == 3 && C_PATH_ID == 1 && vars.trialCheck[2] == true) {
						++vars.n;
						return true;
					}	
					
				// Zulag 2
					if (LEVEL_ID == 13 && C_CAM_ID == 5 && C_PATH_ID == 13 && vars.n == 46) {
						++vars.n;
						return true;
					}	
				}
				
				if (vars.n >= 47 && vars.n <= 51){ // Zulag 3
				// Entry
					if (LEVEL_ID == 13 && C_PATH_ID == 13 && C_CAM_ID == 4 && vars.n == 47) {
						++vars.n;
						return true;
					}	
					
				// Door 1
					if (C_PATH_ID == 9 && C_CAM_ID == 2 && vars.trialCheck[3] != true){ // Door 1 check
						vars.trialCheck[3] = true;
					}
					
					if (O_PATH_ID == 12 && C_PATH_ID == 13 && vars.trialCheck[3] == true) {
						++vars.n;
						return true;
					}	
					
				// Door 2
					if (C_PATH_ID == 7 && C_CAM_ID == 9 && vars.trialCheck[4] != true){ // Door 2 check
						vars.trialCheck[4] = true;
					}
					
					if (O_PATH_ID == 7 && C_PATH_ID == 13 && vars.trialCheck[4] == true) {
						++vars.n;
						return true;
					}
					
				// Door 3
					if (C_PATH_ID == 5 && C_CAM_ID == 4 && vars.trialCheck[5] != true){ // Door 3 check
						vars.trialCheck[5] = true;
					}
					
					if (O_PATH_ID == 5 && C_PATH_ID == 13 && vars.trialCheck[5] == true) {
						++vars.n;
						return true;
					}	
					
				// Zulag 3
					if (LEVEL_ID == 13 && C_PATH_ID == 14 && C_CAM_ID == 5 && vars.n == 51) {
						++vars.n;
						return true;
					}	
				}
							
				if (vars.n >= 52 && vars.n <= 55){ // Zulag 4
				// Enter Slog Kennels
					if (LEVEL_ID == 13 && C_CAM_ID == 1 && C_PATH_ID == 8 && vars.n == 52) {
						++vars.n;
						return true;
					}	
					
				// Leave Slog Kennels
					if (C_PATH_ID == 8 && C_CAM_ID == 5 && vars.trialCheck[6] != true){ // Slog Kennels check
						vars.trialCheck[6] = true;
					}
					
					if (LEVEL_ID == 13 && C_CAM_ID == 6 && C_PATH_ID == 4 && vars.n == 53 && vars.trialCheck[6] == true) {
						++vars.n;
						return true;
					}
					
				// Enter Second Part
					if (LEVEL_ID == 13 && C_CAM_ID == 1 && C_PATH_ID == 11 && vars.n == 54) {
						++vars.n;
						return true;
					}	
					
				// Zulag 4
					if (LEVEL_ID == 12 && C_CAM_ID == 2 && C_PATH_ID == 6 && abeY > 235 && vars.n == 55) {
						++vars.n;
						return true;
					}	
				}
			
			
			} else if (settings["SplitsGoodEnding"]){
				if (vars.n <= 3){ // RuptureFarms 0-3
				// Tutorials
					if (LEVEL_ID == 1 && C_CAM_ID == 1 && C_PATH_ID == 16 && vars.n == 0) {
						++vars.n;
						return true;
					}
				// Meat grinder
					if (LEVEL_ID == 1 && C_CAM_ID == 10 && C_PATH_ID == 18 && vars.n == 1) {
						++vars.n;
						return true;
					}
				// Sligs
					if (LEVEL_ID == 1 && C_CAM_ID == 1 && C_PATH_ID == 19 && vars.n == 2) {
						++vars.n;
						return true;
					}
				// RuptureFarms
					if (LEVEL_ID == 5 && C_CAM_ID == 6 && C_PATH_ID == 6 && vars.n == 3) {
						++vars.n;
						return true;
					}
				}
				
				if (vars.n >= 4 && vars.n <= 6){ // Stockyards 4-6
				// Scrab part
					if (LEVEL_ID == 5 && C_CAM_ID == 1 && C_PATH_ID == 1 && vars.n == 4) {
						++vars.n;
						return true;
					}
				// Slig Part
					if (LEVEL_ID == 5 && C_CAM_ID == 1 && C_PATH_ID == 4 && vars.n == 5) {
						++vars.n;
						return true;
					}
				// Stockyards
					if (LEVEL_ID == 2 && C_CAM_ID == 14 && C_PATH_ID == 1 && vars.n == 6) {
						++vars.n;
						return true;
					}
				}
				
				if (vars.n == 7 || vars.n == 8){ // Monsaic Lines
				// Natives
					if (LEVEL_ID == 2 && C_CAM_ID == 8 && C_PATH_ID == 2 && vars.n == 7) {
						++vars.n;
						return true;
					}
				// Monsaic Lines (to Paramonia)
					if (LEVEL_ID == 3 && C_CAM_ID == 1 && C_PATH_ID == 1 && vars.n == 8) {
						++vars.n;
						vars.ParamoniaFirst = true;
						if (!settings["NoLog"]){ 
							vars.LoadTexts = true; // We make sure that the texts are updated to be Paramonia first.
						}
						return true;
					}
					
				// Monsaic Lines (to Scrabania)
					if (LEVEL_ID == 8 && C_CAM_ID == 1 && C_PATH_ID == 1 && vars.n == 8) {
						++vars.n;			
						vars.ParamoniaFirst = false;
						if (!settings["NoLog"]){ 
							vars.LoadTexts = true; // We make sure that the texts are updated to be Scrabania first.
						}
						return true;
					}
				}
				
				if (vars.ParamoniaFirst){		
					
					if (LEVEL_ID == 3 && vars.n >= 23 && vars.n <= 27){ // If we restart the game and the variable is wrong, this will fix it (or SHOULD).
						vars.ParamoniaFirst = false;			
						if (!settings["NoLog"]){ 
							vars.LoadTexts = true; // We make sure that the texts are updated to be Paramonia first.	
						}
					}
					
					if (vars.n >= 9 && vars.n <= 13){ // Paramonia
					// Get the Elum
						if (LEVEL_ID == 3 && C_CAM_ID == 1 && C_PATH_ID == 2 && vars.n == 9) {
							++vars.n;
							return true;
						}
						
					// Honey and Sligs
						if (LEVEL_ID == 3 && C_CAM_ID == 9 && C_PATH_ID == 5 && vars.n == 10) {
							++vars.n;
							return true;
						}
						
					// Platforms and Bees
						if (LEVEL_ID == 3 && C_CAM_ID == 1 && C_PATH_ID == 6 && vars.n == 11) {
							++vars.n;
							return true;
						}
						
					// Passwords and Sligs
						if (LEVEL_ID == 3 && C_CAM_ID == 1 && C_PATH_ID == 9 && vars.n == 12) {
							++vars.n;
							return true;
						}
						
					// Paramonia
						if (LEVEL_ID == 4 && C_CAM_ID == 1 && C_PATH_ID == 1 && vars.n == 13) {
							++vars.n;
							return true;
						}	
					}
					
					if (LEVEL_ID == 4 && C_PATH_ID == 1 && vars.n <= 14) { // Split if the autosplitter gets stuck and the runner gets inside Paramonian temple (entry)
						++vars.n;
						return true;			
					} else {
						if (LEVEL_ID == 4 && C_PATH_ID > 1 && vars.n < 15) { // Split if the autosplitter gets stuck and the runner gets inside Paramonian temple (AFTER entry)
							++vars.n;
							return true;			
						}
					}
					
					if (vars.n >= 14 && vars.n <= 22){ // Paramonian Temple
					// Entry
						if (LEVEL_ID == 4 && C_CAM_ID == 1 && C_PATH_ID == 8 && vars.n == 14) {
							++vars.n;
							return true;
						}
						
					// Trial 1
						if (C_PATH_ID == 8 && O_PATH_ID == 4 && O_CAM_ID == 6) { // https://i.imgur.com/CThhUM5.jpg
							++vars.n;
							return true;
						}
						
					// Trial 2
						if (C_PATH_ID == 8 && O_PATH_ID == 2 && O_CAM_ID == 8) { // https://i.imgur.com/C1CPF36.jpg
							++vars.n;
							return true;
						}
						
					// Trial 3
						if (C_PATH_ID == 8 && O_PATH_ID == 6 && O_CAM_ID == 7) { // https://i.imgur.com/A8IVuGp.jpg
							++vars.n;
							return true;
						}
						
					// Trial 4
						if (C_PATH_ID == 8 && O_PATH_ID == 7 && O_CAM_ID == 5) { // https://i.imgur.com/lPrWDD2.jpg
							++vars.n;
							return true;
						}
						
					// Trial 5
						if (C_PATH_ID == 8 && O_PATH_ID == 5 && O_CAM_ID == 2) { // https://i.imgur.com/ku9rf3g.jpg
							++vars.n;
							return true;
						}
						
					// Trial 6
						if (C_PATH_ID == 8 && O_PATH_ID == 3 && O_CAM_ID == 1) { // https://i.imgur.com/LtYPFNm.jpg
							++vars.n;
							return true;
						}
						
					// Paramonian Nests 
						if (LEVEL_ID == 2 && C_CAM_ID == 4 && C_PATH_ID == 5 && vars.n >= 15 && vars.n <= 21) { // 15 / 06 / 2020 - Fix to prevent getting stuck if a trial doesn't split
							vars.n = 22;
							return true;
						}	
						
					// Paramonian Temple 
						if (LEVEL_ID == 8 && C_CAM_ID == 1 && C_PATH_ID == 1 && vars.n == 22) {
							vars.n = 23;
							return true;
						}	
					}		
					
					if (vars.n >= 23 && vars.n <= 25){ // Scrabania
					// Get Elum
						if (LEVEL_ID == 8 && C_CAM_ID == 1 && C_PATH_ID == 2 && vars.n == 23) {
							++vars.n;
							return true;
						}
						
					// Play with Mines
						if (LEVEL_ID == 8 && C_CAM_ID == 5 && C_PATH_ID == 8 && vars.n == 24) {
							++vars.n;
							return true;
						}
						
					// Scrabania
						if (LEVEL_ID == 9 && C_CAM_ID == 1 && C_PATH_ID == 1 && vars.n == 25) {
							++vars.n;
							return true;
						}
					}	
					
					
					if (vars.n >= 26 && vars.n <= 36){ // Scrabania Temple
					// Entry
						if (LEVEL_ID == 9 && C_CAM_ID == 1 && C_PATH_ID == 10 && vars.n == 26) {
							++vars.n;
							return true;
						}
					// Trial 1
						if (O_PATH_ID == 9 && C_PATH_ID == 10 && O_CAM_ID == 5) { // https://i.imgur.com/VUTQJ5R.jpg
							++vars.n;
							return true;
						}
					// Trial 2
						if (O_PATH_ID == 2 && C_PATH_ID == 10 && O_CAM_ID == 4) { // https://i.imgur.com/mtbUcdr.jpg
							++vars.n;
							return true;
						}
					// Trial 3
						if (O_PATH_ID == 3 && C_PATH_ID == 10 && O_CAM_ID == 5) { // https://i.imgur.com/09DtCCn.jpg
							++vars.n;
							return true;
						}
					// Trial 4
						if (O_PATH_ID == 5 && C_PATH_ID == 10 && O_CAM_ID == 8) { // https://i.imgur.com/qjAxMzI.jpg
							++vars.n;
							return true;
						}
					// Trial 5
						if (O_PATH_ID == 4 && C_PATH_ID == 10 && O_CAM_ID == 5) { // https://i.imgur.com/8BxoUsw.jpg
							++vars.n;
							return true;
						}
					// Trial 6
						if (O_PATH_ID == 7 && C_PATH_ID == 10 && O_CAM_ID == 1) { // https://i.imgur.com/WHeaT7j.jpg
							++vars.n;
							return true;
						}
					// Trial 7
						if (O_PATH_ID == 6 && C_PATH_ID == 10 && O_CAM_ID == 4) { // https://i.imgur.com/NkzyNWh.jpg
							++vars.n;
							return true;
						}
					// Trial 8
						if (O_PATH_ID == 8 && C_PATH_ID == 10 && O_CAM_ID == 4) { // https://i.imgur.com/lX7IQg3.jpg
							++vars.n;
							return true;
						}
					// Scrabanian Nests
						if (LEVEL_ID == 2 && C_CAM_ID == 4 && C_PATH_ID == 5 && vars.n >= 27 && vars.n <= 35) {
							vars.n = 36; // Security measure.
							return true;
						}
					// Scrabania Temple
						if (LEVEL_ID == 6 && C_CAM_ID == 7 && C_PATH_ID == 4 && vars.n == 36) { // Entry Free Fire Zone - Change
							vars.n = 37; // Security measure.
							return true;
						}
					}		
				} else { // We start with Scrabania.	
				
					if (vars.ParamoniaFirst == false && LEVEL_ID == 8 && vars.n >= 23 && vars.n <= 25){ // If we restart the game and the variable is wrong, this will fix it (or SHOULD).
						vars.ParamoniaFirst = true;			
						vars.LoadTexts = true; // We make sure that the texts are updated to be Paramonia first.			
					}
					
					if (vars.n >= 7 && vars.n <= 11){ // Scrabania
					// Get Elum
						if (LEVEL_ID == 8 && C_CAM_ID == 1 && C_PATH_ID == 2 && vars.n == 9) {
							++vars.n;
							return true;
						}
						
					// Play with Mines
						if (LEVEL_ID == 8 && C_CAM_ID == 5 && C_PATH_ID == 8 && vars.n == 10) {
							++vars.n;
							return true;
						}
						
					// Scrabania
						if (LEVEL_ID == 9 && C_CAM_ID == 1 && C_PATH_ID == 1 && vars.n == 11) {
							++vars.n;
							return true;
						}
					}	
					
					
					if (vars.n >= 12 && vars.n <= 22){ // Scrabania Temple
					// Entry
						if (LEVEL_ID == 9 && C_CAM_ID == 1 && C_PATH_ID == 10 && vars.n == 12) {
							++vars.n;
							return true;
						}
					// Trial 1
						if (O_PATH_ID == 9 && C_PATH_ID == 10 && O_CAM_ID == 5) { // https://i.imgur.com/VUTQJ5R.jpg
							++vars.n;
							return true;
						}
					// Trial 2
						if (O_PATH_ID == 2 && C_PATH_ID == 10 && O_CAM_ID == 4) { // https://i.imgur.com/mtbUcdr.jpg
							++vars.n;
							return true;
						}
					// Trial 3
						if (O_PATH_ID == 3 && C_PATH_ID == 10 && O_CAM_ID == 5) { // https://i.imgur.com/09DtCCn.jpg
							++vars.n;
							return true;
						}
					// Trial 4
						if (O_PATH_ID == 5 && C_PATH_ID == 10 && O_CAM_ID == 8) { // https://i.imgur.com/qjAxMzI.jpg
							++vars.n;
							return true;
						}
						
					// Trial 5
						if (O_PATH_ID == 4 && C_PATH_ID == 10 && O_CAM_ID == 5) { // https://i.imgur.com/8BxoUsw.jpg
							++vars.n;
							return true;
						}
					// Trial 6
						if (O_PATH_ID == 7 && C_PATH_ID == 10 && O_CAM_ID == 1) { // https://i.imgur.com/WHeaT7j.jpg
							++vars.n;
							return true;
						}
					// Trial 7
						if (O_PATH_ID == 6 && C_PATH_ID == 10 && O_CAM_ID == 4) { // https://i.imgur.com/NkzyNWh.jpg
							++vars.n;
							return true;
						}
					// Trial 8
						if (O_PATH_ID == 8 && C_PATH_ID == 10 && O_CAM_ID == 4) { // https://i.imgur.com/lX7IQg3.jpg
							++vars.n;
							return true;
						}
					// Nests
						if (LEVEL_ID == 2 && C_CAM_ID == 4 && C_PATH_ID == 5 && vars.n >= 13 && vars.n <= 21) {
							vars.n = 22;
							return true;
						}
					// Scrabania Temple
						if (LEVEL_ID == 3 && C_CAM_ID == 1 && C_PATH_ID == 1 && vars.n == 22) { // Entry Free Fire Zone - Change
							++vars.n;
							return true;
						}
					}
					
					
					if (vars.n >= 23 && vars.n <= 27){ // Paramonia
					// Get the Elum
						if (LEVEL_ID == 3 && C_CAM_ID == 1 && C_PATH_ID == 2 && vars.n == 23) {
							++vars.n;
							return true;
						}
						
					// Honey and Sligs
						if (LEVEL_ID == 3 && C_CAM_ID == 9 && C_PATH_ID == 5 && vars.n == 24) {
							++vars.n;
							return true;
						}
						
					// Platforms and Bees
						if (LEVEL_ID == 3 && C_CAM_ID == 1 && C_PATH_ID == 6 && vars.n == 25) {
							++vars.n;
							return true;
						}
						
					// Passwords and Sligs
						if (LEVEL_ID == 3 && C_CAM_ID == 1 && C_PATH_ID == 9 && vars.n == 26) {
							++vars.n;
							return true;
						}
						
					// Paramonia
						if (LEVEL_ID == 4 && C_CAM_ID == 1 && C_PATH_ID == 1 && vars.n == 27) {
							++vars.n;
							return true;
						}	
					}
					
					
					if (vars.n >= 28 && vars.n <= 36){ // Paramonian Temple
					// Entry
						if (LEVEL_ID == 4 && C_CAM_ID == 1 && C_PATH_ID == 8 && vars.n == 28) {
							++vars.n;
							return true;
						}
						
					// Trial 1
						if (C_PATH_ID == 8 && O_PATH_ID == 4 && O_CAM_ID == 6) { // https://i.imgur.com/CThhUM5.jpg
							++vars.n;
							return true;
						}
						
					// Trial 2
						if (C_PATH_ID == 8 && O_PATH_ID == 2 && O_CAM_ID == 8) { // https://i.imgur.com/C1CPF36.jpg
							++vars.n;
							return true;
						}
						
					// Trial 3
						if (C_PATH_ID == 8 && O_PATH_ID == 6 && O_CAM_ID == 7) { // https://i.imgur.com/A8IVuGp.jpg
							++vars.n;
							return true;
						}
						
					// Trial 4
						if (C_PATH_ID == 8 && O_PATH_ID == 7 && O_CAM_ID == 5) { // https://i.imgur.com/lPrWDD2.jpg
							++vars.n;
							return true;
						}
						
					// Trial 5
						if (C_PATH_ID == 8 && O_PATH_ID == 5 && O_CAM_ID == 2) { // https://i.imgur.com/ku9rf3g.jpg
							++vars.n;
							return true;
						}
						
					// Trial 6
						if (C_PATH_ID == 8 && O_PATH_ID == 3 && O_CAM_ID == 1) { // https://i.imgur.com/LtYPFNm.jpg
							++vars.n;
							return true;
						}
						
					// Paramonian Nests 
						if (LEVEL_ID == 2 && C_CAM_ID == 4 && C_PATH_ID == 5 && vars.n >= 29 && vars.n <= 35) { // 15 / 06 / 2020 - Fix to prevent getting stuck if a trial doesn't split
							vars.n = 36;
							return true;
						}	
						
					// Paramonian Temple 
						if (LEVEL_ID == 6 && C_CAM_ID == 7 && C_PATH_ID == 4 && vars.n == 36) {
							++vars.n;
							return true;
						}	
					}
				}
		
				if (vars.n >= 37 && vars.n <= 40){ // Zulag 1 - 3
				 // Free Fire Zone
					if (LEVEL_ID == 13 && C_CAM_ID == 3 && C_PATH_ID == 19 && vars.n == 37) {
						++vars.n;
						return true;
					}	
					
				// Zulag 1
					if (LEVEL_ID == 13 && C_CAM_ID == 4 && C_PATH_ID == 1 && vars.n == 38) {
						++vars.n;
						return true;
					}			
				// Zulag 2
					if (LEVEL_ID == 13 && C_CAM_ID == 5 && C_PATH_ID == 13 && vars.n == 39) {
						++vars.n;
						return true;
					}	
				// Zulag 3
					if (LEVEL_ID == 13 && C_CAM_ID == 5 && C_PATH_ID == 14 && vars.n == 40) {
						++vars.n;
						return true;
					}	
				}
								
				if (vars.n >= 41 && vars.n <= 44){ // Zulag 4
				// Enter Slog Kennels
					if (LEVEL_ID == 13 && C_CAM_ID == 1 && C_PATH_ID == 8 && vars.n == 41) {
						++vars.n;
						return true;
					}	
					
				// Leave Slog Kennels
					if (C_PATH_ID == 8 && C_CAM_ID == 5 && vars.trialCheck[6] != true){ // Slog Kennels check
						vars.trialCheck[6] = true;
					}
					
					if (LEVEL_ID == 13 && C_CAM_ID == 6 && C_PATH_ID == 4 && vars.n == 42 && vars.trialCheck[6] == true) {
						++vars.n;
						return true;
					}
					
				// Enter Second Part
					if (LEVEL_ID == 13 && C_CAM_ID == 1 && C_PATH_ID == 11 && vars.n == 43) {
						++vars.n;
						return true;
					}	
					
				// Zulag 4
					if (LEVEL_ID == 12 && C_CAM_ID == 2 && C_PATH_ID == 6 && abeY > 235 && vars.n == 44) {
						++vars.n;
						return true;
					}						
				}
			} 		
		
		} else if (settings["UsingIL"]){ // Individual levels?
		
			if (vars.ILtype == 0){ // RuptureFarms
			
			// Tutorials
				if (LEVEL_ID == 1 && C_CAM_ID == 1 && C_PATH_ID == 16 && vars.n == 0) {
					++vars.n;
					return true;
				}
			
			// Meat grinder
				if (LEVEL_ID == 1 && C_CAM_ID == 10 && C_PATH_ID == 18 && vars.n == 1) {
					++vars.n;
					return true;
				}
			
			// Sligs
				if (LEVEL_ID == 1 && C_CAM_ID == 1 && C_PATH_ID == 19 && vars.n == 2) {
					++vars.n;
					return true;
				}
			
			// RuptureFarms
				if (LEVEL_ID == 5 && C_CAM_ID == 6 && C_PATH_ID == 6 && vars.n == 3) {
					vars.REAL_TIME = System.Convert.ToString(timer.CurrentTime.RealTime).Replace("0000", "").Replace("00:", "");
					vars.LOADLESS_TIME = TimeSpan.FromMilliseconds(((gnFrame - vars.StartgnFrame) * 1000 / vars.fps) + vars.MillisecondsPaused + vars.PreviousTime).ToString(@"mm\:ss\.fff");
					vars.Log = "RuptureFarms IL is over! IGT: " + vars.LOADLESS_TIME + " | RTA: " + vars.REAL_TIME;
					return true;
				}
				
				
			} else if (vars.ILtype == 1){ // Stockyards	
			
			// Scrab part
				if (LEVEL_ID == 5 && C_CAM_ID == 1 && C_PATH_ID == 1 && vars.n == 0) {
					++vars.n;
					return true;
				}
			
			// Slig Part
				if (LEVEL_ID == 5 && C_CAM_ID == 1 && C_PATH_ID == 4 && vars.n == 1) {
					++vars.n;
					return true;
				}
			
			// Stockyards
				if (LEVEL_ID == 2 && C_CAM_ID == 14 && C_PATH_ID == 1 && vars.n == 2) {
					vars.REAL_TIME = System.Convert.ToString(timer.CurrentTime.RealTime).Replace("0000", "").Replace("00:", "");
					vars.LOADLESS_TIME = TimeSpan.FromMilliseconds(((gnFrame - vars.StartgnFrame) * 1000 / vars.fps) + vars.MillisecondsPaused + vars.PreviousTime).ToString(@"mm\:ss\.fff");
					vars.Log = "Stockyards IL is over! IGT: " + vars.LOADLESS_TIME + " | RTA: " + vars.REAL_TIME;
					return true;
				}				
				
			} else if (vars.ILtype == 2){ // Paramonia
			
			// Get the Elum
				if (LEVEL_ID == 3 && C_CAM_ID == 1 && C_PATH_ID == 2 && vars.n == 0) {
					++vars.n;
					return true;
				}				
			
			// Honey and Sligs
				if (LEVEL_ID == 3 && C_CAM_ID == 9 && C_PATH_ID == 5 && vars.n == 1) {
					++vars.n;
					return true;
				}
				
			// Platforms and Bees
				if (LEVEL_ID == 3 && C_CAM_ID == 1 && C_PATH_ID == 6 && vars.n == 2) {
					++vars.n;
					return true;
				}
				
			// Passwords and Sligs
				if (LEVEL_ID == 3 && C_CAM_ID == 1 && C_PATH_ID == 9 && vars.n == 3) {
					++vars.n;
					return true;
				}
				
			// Paramonia
				if (LEVEL_ID == 4 && C_CAM_ID == 1 && C_PATH_ID == 1 && vars.n == 4) {											
					vars.REAL_TIME = System.Convert.ToString(timer.CurrentTime.RealTime).Replace("0000", "").Replace("00:", "");
					vars.LOADLESS_TIME = TimeSpan.FromMilliseconds(((gnFrame - vars.StartgnFrame) * 1000 / vars.fps) + vars.MillisecondsPaused + vars.PreviousTime).ToString(@"mm\:ss\.fff");
					vars.Log = "Paramonia IL is over! IGT: " + vars.LOADLESS_TIME + " | RTA: " + vars.REAL_TIME;
					return true;
				}	
				
			} else if (vars.ILtype == 3){ // Scrabania + Temple
			
			// Get Elum
				if (LEVEL_ID == 8 && C_CAM_ID == 1 && C_PATH_ID == 2 && vars.n == 0) {
					++vars.n;
					return true;
				}
				
			// Play with Mines
				if (LEVEL_ID == 8 && C_CAM_ID == 5 && C_PATH_ID == 8 && vars.n == 1) {
					++vars.n;
					return true;
				}
				
			// Scrabania
				if (LEVEL_ID == 9 && C_CAM_ID == 1 && C_PATH_ID == 1 && vars.n == 2) {												
					vars.REAL_TIME = System.Convert.ToString(timer.CurrentTime.RealTime).Replace("0000", "").Replace("00:", "");
					vars.LOADLESS_TIME = TimeSpan.FromMilliseconds(((gnFrame - vars.StartgnFrame) * 1000 / vars.fps) + vars.MillisecondsPaused + vars.PreviousTime).ToString(@"mm\:ss\.fff");
					vars.Log = "Scrabania IL is over! IGT: " + vars.LOADLESS_TIME + " | RTA: " + vars.REAL_TIME;
					return true;
				}			
				
			} else if (vars.ILtype == 4){ // FFZ
			
			// FFZ
				if (LEVEL_ID == 13 && C_CAM_ID == 3 && C_PATH_ID == 19 && vars.n == 0) {
					return true;
				}	
			
			} else if (vars.ILtype == 5){ // Zulag 2
			// Entry
				if (LEVEL_ID == 13 && C_CAM_ID == 3 && C_PATH_ID == 1 && vars.n == 0) {
					++vars.n;
					return true;
				}	
				
			// Door 1
				if (C_PATH_ID == 2 && C_CAM_ID == 4 && vars.trialCheck[0] != true){ // Door 1 check
					vars.trialCheck[0] = true;
				}
				
				if (O_PATH_ID == 2 && C_PATH_ID == 1 && vars.trialCheck[0] == true) {
					++vars.n;
					return true;
				}	
				
			// Door 2				
				if (C_PATH_ID == 10 && C_CAM_ID == 5 && vars.trialCheck[1] != true){ // Door 2 check
					vars.trialCheck[1] = true;
				}
				
				if (O_PATH_ID == 10 && C_PATH_ID == 1 && vars.trialCheck[1] == true) {
					++vars.n;
					return true;
				}
				
			// Door 3			
				if (C_PATH_ID == 3 && C_CAM_ID == 5 && vars.trialCheck[2] != true){ // Door 3 check
					vars.trialCheck[2] = true;
				}
				
				if (O_PATH_ID == 3 && C_PATH_ID == 1 && vars.trialCheck[2] == true) {
					++vars.n;
					return true;
				}	
				
			// Zulag 2
				if (LEVEL_ID == 13 && C_CAM_ID == 5 && C_PATH_ID == 13) {
						vars.REAL_TIME = System.Convert.ToString(timer.CurrentTime.RealTime).Replace("0000", "").Replace("00:", "");
						vars.LOADLESS_TIME = TimeSpan.FromMilliseconds(((gnFrame - vars.StartgnFrame) * 1000 / vars.fps) + vars.MillisecondsPaused + vars.PreviousTime).ToString(@"mm\:ss\.fff");
						vars.Log = "Zulag 2 IL is over! IGT: " + vars.LOADLESS_TIME + " | RTA: " + vars.REAL_TIME;
						return true;
					}	
					
			} else if (vars.ILtype == 6){ // Zulag 3
			// Entry
				if (LEVEL_ID == 13 && C_PATH_ID == 13 && C_CAM_ID == 4 && vars.n == 0) {
					++vars.n;
					return true;
				}	
				
			// Door 1
				if (C_PATH_ID == 9 && C_CAM_ID == 2 && vars.trialCheck[3] != true){ // Door 1 check
					vars.trialCheck[3] = true;
				}
				
				if (O_PATH_ID == 12 && C_PATH_ID == 13 && vars.trialCheck[3] == true) {
					++vars.n;
					return true;
				}	
				
			// Door 2
				if (C_PATH_ID == 7 && C_CAM_ID == 9 && vars.trialCheck[4] != true){ // Door 2 check
					vars.trialCheck[4] = true;
				}
				
				if (O_PATH_ID == 7 && C_PATH_ID == 13 && vars.trialCheck[4] == true) {
					++vars.n;
					return true;
				}
				
			// Door 3
				if (C_PATH_ID == 5 && C_CAM_ID == 4 && vars.trialCheck[5] != true){ // Door 3 check
					vars.trialCheck[5] = true;
				}
				
				if (O_PATH_ID == 5 && C_PATH_ID == 13 && vars.trialCheck[5] == true) {
					++vars.n;
					return true;
				}	
				
			// Zulag 3
				if (LEVEL_ID == 13 && C_PATH_ID == 14 && C_CAM_ID == 5) {					
					vars.REAL_TIME = System.Convert.ToString(timer.CurrentTime.RealTime).Replace("0000", "").Replace("00:", "");
					vars.LOADLESS_TIME = TimeSpan.FromMilliseconds(((gnFrame - vars.StartgnFrame) * 1000 / vars.fps) + vars.MillisecondsPaused + vars.PreviousTime).ToString(@"mm\:ss\.fff");
					vars.Log = "Zulag 3 IL is over! IGT: " + vars.LOADLESS_TIME + " | RTA: " + vars.REAL_TIME;
					return true;
				}	
			
			} else if (vars.ILtype == 7){ // Zulag 4 + Boardroom
			// Enter Slog Kennels
				if (LEVEL_ID == 13 && C_CAM_ID == 1 && C_PATH_ID == 8 && vars.n == 0) {
					++vars.n;
					return true;
				}	
				
			// Leave Slog Kennels
				if (C_PATH_ID == 8 && C_CAM_ID == 5 && vars.trialCheck[6] != true){ // Slog Kennels check
					vars.trialCheck[6] = true;
				}
				
				if (LEVEL_ID == 13 && C_CAM_ID == 6 && C_PATH_ID == 4 && vars.n == 1 && vars.trialCheck[6] == true) {
					++vars.n;
					return true;
				}
				
			// Enter Second Part
				if (LEVEL_ID == 13 && C_CAM_ID == 1 && C_PATH_ID == 11 && vars.n == 2) {
					++vars.n;
					return true;
				}	
				
			// Zulag 4
				if (LEVEL_ID == 12 && C_PATH_ID == 6 && C_CAM_ID == 2 && abeY > 235 && vars.n == 3) {
					++vars.n;
					return true;
				}	
				
			// Boardroom
				if (LEVEL_ID == 12 && C_PATH_ID == 6 && C_CAM_ID == 8 && IsGameBeaten == 1) {
					vars.REAL_TIME = System.Convert.ToString(timer.CurrentTime.RealTime).Replace("0000", "").Replace("00:", "");
					vars.LOADLESS_TIME = TimeSpan.FromMilliseconds(((gnFrame - vars.StartgnFrame) * 1000 / vars.fps) + vars.MillisecondsPaused + vars.PreviousTime).ToString(@"mm\:ss\.fff");
					vars.Log = "Zulag 4 IL is over! IGT: " + vars.LOADLESS_TIME + " | RTA: " + vars.REAL_TIME;
					return true;
				}	
			
		} else if (vars.ILtype == 8){ // Monsaic Lines			
		// Monsaic Lines Slig part
			if (LEVEL_ID == 2 && C_CAM_ID == 8 && C_PATH_ID == 2 && vars.n == 0) {
				++vars.n;
				return true;
			}
		// Monsaic Lines Bees
			if (LEVEL_ID == 2 && C_CAM_ID == 1 && C_PATH_ID == 6 && vars.n == 1) {
				++vars.n;
				return true;
			}
		// Monsaic Lines to FFZ (Any%)
			if (LEVEL_ID == 6 && C_CAM_ID == 7 && C_PATH_ID == 4 && vars.n == 2) {										
				vars.REAL_TIME = System.Convert.ToString(timer.CurrentTime.RealTime).Replace("0000", "").Replace("00:", "");
				vars.LOADLESS_TIME = TimeSpan.FromMilliseconds(((gnFrame - vars.StartgnFrame) * 1000 / vars.fps) + vars.MillisecondsPaused + vars.PreviousTime).ToString(@"mm\:ss\.fff");
				vars.Log = "Monsaic Lines (Any%) IL is over! IGT: " + vars.LOADLESS_TIME + " | RTA: " + vars.REAL_TIME;
				return true;
			}
			
		// Monsaic Lines to Scrabania (OPTIMAL)
			if (LEVEL_ID == 8 && C_CAM_ID == 1 && C_PATH_ID == 1 && vars.n == 2) {
				vars.REAL_TIME = System.Convert.ToString(timer.CurrentTime.RealTime).Replace("0000", "").Replace("00:", "");
				vars.LOADLESS_TIME = TimeSpan.FromMilliseconds(((gnFrame - vars.StartgnFrame) * 1000 / vars.fps) + vars.MillisecondsPaused + vars.PreviousTime).ToString(@"mm\:ss\.fff");
				vars.Log = "Monsaic Lines (NOT Any%) IL is over! IGT: " + vars.LOADLESS_TIME + " | RTA: " + vars.REAL_TIME;
				return true;
			}					
			
		// Monsaic Lines to Paramonia (for special people)
			if (LEVEL_ID == 3 && C_CAM_ID == 1 && C_PATH_ID == 1 && vars.n == 2) {
				vars.REAL_TIME = System.Convert.ToString(timer.CurrentTime.RealTime).Replace("0000", "").Replace("00:", "");
				vars.LOADLESS_TIME = TimeSpan.FromMilliseconds(((gnFrame - vars.StartgnFrame) * 1000 / vars.fps) + vars.MillisecondsPaused + vars.PreviousTime).ToString(@"mm\:ss\.fff");
				vars.Log = "Monsaic Lines (special) IL is over! IGT: " + vars.LOADLESS_TIME + " | RTA: " + vars.REAL_TIME;
				return true;
			}					
		} else if (vars.ILtype == 9){ // Paramonian Temple
			// Entry
				if (LEVEL_ID == 4 && C_PATH_ID == 8 && C_CAM_ID == 1 && vars.n == 0) {
					++vars.n;
					return true;
				}
				
			// Trial 1
				if (C_PATH_ID == 8 && O_PATH_ID == 4 && O_CAM_ID == 6) { // https://i.imgur.com/CThhUM5.jpg
					++vars.n;
					return true;
				}
				
			// Trial 2
				if (C_PATH_ID == 8 && O_PATH_ID == 2 && O_CAM_ID == 8) { // https://i.imgur.com/C1CPF36.jpg
					++vars.n;
					return true;
				}
				
			// Trial 3
				if (C_PATH_ID == 8 && O_PATH_ID == 6 && O_CAM_ID == 7) { // https://i.imgur.com/A8IVuGp.jpg
					++vars.n;
					return true;
				}
				
			// Trial 4
				if (C_PATH_ID == 8 && O_PATH_ID == 7 && O_CAM_ID == 5) { // https://i.imgur.com/lPrWDD2.jpg
					++vars.n;
					return true;
				}
				
			// Trial 5
				if (C_PATH_ID == 8 && O_PATH_ID == 5 && O_CAM_ID == 2) { // https://i.imgur.com/ku9rf3g.jpg
					++vars.n;
					return true;
				}
				
			// Trial 6
				if (C_PATH_ID == 8 && O_PATH_ID == 3 && O_CAM_ID == 1) { // https://i.imgur.com/LtYPFNm.jpg
					++vars.n;
					return true;
				}
				
			// Paramonian Nests 
				if (LEVEL_ID == 2 && C_PATH_ID == 5 && C_CAM_ID == 4) { // 30 / 06 / 2020 - Last split for Paramonia Temple. SPAM split just in case.								
					vars.REAL_TIME = System.Convert.ToString(timer.CurrentTime.RealTime).Replace("0000", "").Replace("00:", "");
					vars.LOADLESS_TIME = TimeSpan.FromMilliseconds(((gnFrame - vars.StartgnFrame) * 1000 / vars.fps) + vars.MillisecondsPaused + vars.PreviousTime).ToString(@"mm\:ss\.fff");
					vars.Log = "Paramonia IL is over! IGT: " + vars.LOADLESS_TIME + " | RTA: " + vars.REAL_TIME;
					return true;
				}
		} else if (vars.ILtype == 10){ // Scrabanian Temple			
			// Entry
				if (LEVEL_ID == 9 && C_CAM_ID == 1 && C_PATH_ID == 10 && vars.n == 0) {
					++vars.n;
					return true;
				}
			
			// Trial 1
				if (O_PATH_ID == 9 && C_PATH_ID == 10 && O_CAM_ID == 5) { // https://i.imgur.com/VUTQJ5R.jpg
					++vars.n;
					return true;
				}
			
			// Trial 2
				if (O_PATH_ID == 2 && C_PATH_ID == 10 && O_CAM_ID == 4) { // https://i.imgur.com/mtbUcdr.jpg
					++vars.n;
					return true;
				}
			
			// Trial 3
				if (O_PATH_ID == 3 && C_PATH_ID == 10 && O_CAM_ID == 5) { // https://i.imgur.com/09DtCCn.jpg
					++vars.n;
					return true;
				}
			
			// Trial 4
				if (O_PATH_ID == 5 && C_PATH_ID == 10 && O_CAM_ID == 8) { // https://i.imgur.com/qjAxMzI.jpg
					++vars.n;
					return true;
				}
				
			// Trial 5
				if (O_PATH_ID == 4 && C_PATH_ID == 10 && O_CAM_ID == 5) { // https://i.imgur.com/8BxoUsw.jpg
					++vars.n;
					return true;
				}
			
			// Trial 6
				if (O_PATH_ID == 7 && C_PATH_ID == 10 && O_CAM_ID == 1) { // https://i.imgur.com/WHeaT7j.jpg
					++vars.n;
					return true;
				}
			
			// Trial 7
				if (O_PATH_ID == 6 && C_PATH_ID == 10 && O_CAM_ID == 4) { // https://i.imgur.com/NkzyNWh.jpg
					++vars.n;
					return true;
				}
			
			// Trial 8
				if (O_PATH_ID == 8 && C_PATH_ID == 10 && O_CAM_ID == 4) { // https://i.imgur.com/lX7IQg3.jpg
					++vars.n;
					return true;
				}
			
			// Scrabanian Nests
				if (LEVEL_ID == 2 && C_CAM_ID == 4 && C_PATH_ID == 5 && O_PATH_ID == 11) { // 25 / 06 / 2020 - Last split for Scrabanian Temple.									
					vars.REAL_TIME = System.Convert.ToString(timer.CurrentTime.RealTime).Replace("0000", "").Replace("00:", "");
					vars.LOADLESS_TIME = TimeSpan.FromMilliseconds(((gnFrame - vars.StartgnFrame) * 1000 / vars.fps) + vars.MillisecondsPaused + vars.PreviousTime).ToString(@"mm\:ss\.fff");
					vars.Log = "Scrabania Temple IL is over! IGT: " + vars.LOADLESS_TIME + " | RTA: " + vars.REAL_TIME;
					return true;
				}
				
		} else if (vars.ILtype == 11){ // Zulag 1
			// Mudokon Ring
				if (LEVEL_ID == 13 && C_CAM_ID == 7 && C_PATH_ID == 16 && vars.n == 0) {
					++vars.n;
					return true;
				}	
				
			// Sligs Meat Grinder
				if (LEVEL_ID == 13 && C_CAM_ID == 8 && C_PATH_ID == 15 && vars.n == 1) {
					++vars.n;
					return true;
				}	
				
			// Tutorials 2
				if (O_PATH_ID == 15 && C_PATH_ID == 18 && vars.n == 2) {
					++vars.n;
					return true;
				}	
				
			// Zulag 1
				if (LEVEL_ID == 13 && C_CAM_ID == 4 && C_PATH_ID == 1) {					
					vars.REAL_TIME = System.Convert.ToString(timer.CurrentTime.RealTime).Replace("0000", "").Replace("00:", "");
					vars.LOADLESS_TIME = TimeSpan.FromMilliseconds(((gnFrame - vars.StartgnFrame) * 1000 / vars.fps) + vars.MillisecondsPaused + vars.PreviousTime).ToString(@"mm\:ss\.fff");
					vars.Log = "Zulag 1 IL is over! IGT: " + vars.LOADLESS_TIME + " | RTA: " + vars.REAL_TIME;
					return true;
				}	
		} else {
			// :shrug:
		}
		// Boardroom
		if (LEVEL_ID == 12 && C_PATH_ID == 6 && C_CAM_ID == 8 && IsGameBeaten == 1) {
			++vars.n;
			vars.Log = "The run is over!\nTime: " + timer.CurrentTime.RealTime;	
			return true;
		}	
	}
		
	//##########################################################


	// Other functions not related with splits whatsoever.
		
		vars.variables = vars.LangDetected + "-> LEVEL " + LEVEL_ID + " | PATH " + C_PATH_ID + " | CAM " + C_CAM_ID + " | " + vars.GNFrame; // For programming purposes c·:
		
	} else {
		
		// ENGLISH
		if (old.EN_LEVEL_ID == 0 && old.EN_PATH_ID == 1 && old.EN_CAM_ID == 21 && current.EN_LEVEL_ID == 1 && current.EN_PATH_ID == 15 && current.EN_CAM_ID == 1) {
			vars.n = 0; // First split if you press on start game
			vars.SkippedFrames = 0;
			vars.StartgnFrame = current.EN_gnFrame;
			vars.MillisecondsPaused = 0;
			vars.StartEpochTime = (DateTime.UtcNow.Ticks - 621355968000000000) / 10000;
			vars.LangDetected = "English";	
		}
		
		// SPANISH
		if (old.ES_LEVEL_ID == 0 && old.ES_PATH_ID == 1 && old.ES_CAM_ID == 21 && current.ES_LEVEL_ID == 1 && current.ES_PATH_ID == 15 && current.ES_CAM_ID == 1) {
			vars.n = 0; // First split if you press on start game
			vars.SkippedFrames = 0;
			vars.StartgnFrame = current.ES_gnFrame;
			vars.MillisecondsPaused = 0;
			vars.StartEpochTime = (DateTime.UtcNow.Ticks - 621355968000000000) / 10000;
			vars.LangDetected = "Spanish";	
		}
		
		// FRENCH
		if (old.FR_LEVEL_ID == 0 && old.FR_PATH_ID == 1 && old.FR_CAM_ID == 21 && current.FR_LEVEL_ID == 1 && current.FR_PATH_ID == 15 && current.FR_CAM_ID == 1) {
			vars.n = 0; // First split if you press on start game
			vars.SkippedFrames = 0;
			vars.StartgnFrame = current.FR_gnFrame;
			vars.MillisecondsPaused = 0;
			vars.StartEpochTime = (DateTime.UtcNow.Ticks - 621355968000000000) / 10000;
			vars.LangDetected = "French";	
		}
		
		// JAPANESE
		if (old.JP_LEVEL_ID == 0 && old.JP_PATH_ID == 1 && old.JP_CAM_ID == 21 && current.JP_LEVEL_ID == 1 && current.JP_PATH_ID == 15 && current.JP_CAM_ID == 1) {
			vars.n = 0; // First split if you press on start game
			vars.SkippedFrames = 0;
			vars.StartgnFrame = current.JP_gnFrame;
			vars.MillisecondsPaused = 0;
			vars.StartEpochTime = (DateTime.UtcNow.Ticks - 621355968000000000) / 10000;
			vars.LangDetected = "Japanese";
		}
		
		// GERMAN
		if (old.DE_LEVEL_ID == 0 && old.DE_PATH_ID == 1 && old.DE_CAM_ID == 21 && current.DE_LEVEL_ID == 1 && current.DE_PATH_ID == 15 && current.DE_CAM_ID == 1) {
			vars.n = 0; // First split if you press on start game
			vars.SkippedFrames = 0;
			vars.StartgnFrame = current.DE_gnFrame;
			vars.MillisecondsPaused = 0;
			vars.StartEpochTime = (DateTime.UtcNow.Ticks - 621355968000000000) / 10000;
			vars.LangDetected = "German";	
		}
		
		// ITALIAN
		if (old.IT_LEVEL_ID == 0 && old.IT_PATH_ID == 1 && old.IT_CAM_ID == 21 && current.IT_LEVEL_ID == 1 && current.IT_PATH_ID == 15 && current.IT_CAM_ID == 1) {
			vars.n = 0; // First split if you press on start game
			vars.SkippedFrames = 0;
			vars.StartgnFrame = current.IT_gnFrame;
			vars.MillisecondsPaused = 0;
			vars.StartEpochTime = (DateTime.UtcNow.Ticks - 621355968000000000) / 10000;
			vars.LangDetected = "Italian";	
		}
	}
	
	if (settings["NoSplitNames"]){
		// Nothing. No Split names.
	} else if (vars.PrimeraVez == true || vars.LoadTexts == true){ // Loads all split names. JUST ONE TIME!!
		vars.PrimeraVez = false;
		vars.LoadTexts = false;
		if (settings["SplitsAny%"]){
			vars.split[0] = "RuptureFarms - Tutorials\nI feel like déjà vu!";
			vars.split[1] = "RuptureFarms - Meat Grinders\nSkipping the grinders!";
			vars.split[2] = "RuptureFarms - Sligs\nSkipping the sligs! Tomare!";
			vars.split[3] = "RuptureFarms - Exit\nI'm so outta here!";
			vars.split[4] = "Stockyards - Scrab Part\nRun to the left.";
			vars.split[5] = "Stockyards - Slig Part\nRandom acrobatics through sligs.";
			vars.split[6] = "Stockyards - Slogs\nEnough playing with slogs.";
			vars.split[7] = "Monsaic Lines - Natives\nMeet the assholes!";
			vars.split[8] = "Monsaic Lines - DDG\nChristmas DDG! 20% success rate. Alea iacta est.";
			vars.split[9] = "Monsaic Lines - Exit\nFirst autoturn.";
			vars.split[10] = "Free Fire Zone - Bomb part\nBombs? Where?";
			vars.split[11] = "Free Fire Zone - Exit\nAh, here are the bombs!";
			vars.split[12] = "RuptureFarms - Zulag 1\nSecond autoturn.";
			vars.split[13] = "RuptureFarms - Zulag 2\nThird autoturn.";
			vars.split[14] = "RuptureFarms - Zulag 3\nFourth autoturn";
			vars.split[15] = "Zulag 4 - Slog Kennels\nThis slogs ain't nothing!";
			vars.split[16] = "Zulag 4 - Return\nYeah, just leaving this.";
			vars.split[17] = "Zulag 4 - Exit\nPulling random levers and leaving.";
			vars.split[18] = "Boardroom\nGotta pull that lever and get shot 4 fun.";
			vars.split[19] = "";
			vars.split[20] = "";
		} else if (settings["SplitsAny%NMS"]){
			vars.split[0] = "RuptureFarms - Tutorials\nCan I cry now, please?";
			vars.split[1] = "RuptureFarms - Meat Grinder\nMeat doesn't kill... I HOPE.";
			vars.split[2] = "RuptureFarms - Sligs\nI hate Sligs.";
			vars.split[3] = "RuptureFarms End\nI'm so outta here!";
			
			vars.split[4] = "Stockyards - Scrab Part\nMeet the nature! And... the scrabs.";
			vars.split[5] = "Stockyards - Slig Part\nI hate sligs even more. SO I kill mudokons.";
			vars.split[6] = "Stockyards End\nEnough playing with slogs.";
			
			vars.split[7] = "Monsaic Lines - Natives\nMeet the douchebags!";
			vars.split[8] = "Monsaic Lines End\nLet's pick our choice...";
			
			if (vars.ParamoniaFirst){
				vars.split[9] = "Get the Elum (Paramonia)\nThe Elum is here!";
				vars.split[10] = "Honey and Sligs\nRocks. Convenient pocket-size power!";
				vars.split[11] = "Platforms and Bees\nLet's run very fast!";
				vars.split[12] = "Passwords and Sligs\nMissing trapdoor? Shooting sligs? Help.";
				vars.split[13] = "Paramonia\nBye Elum. We'll meet again.";
				
				vars.split[14] = "Paramonian Temple - Entry\nBad sloggies doesn't get bones.";
				vars.split[15] = "Temple - Trial 1\nMeet the rolling stone of death!";
				vars.split[16] = "Temple - Trial 2\nFood is power, too.";
				vars.split[17] = "Temple - Trial 3\nPasswords gives OP power for some reason.";
				vars.split[18] = "Temple - Trial 4\nRoll, hop twice, run + jump.";
				vars.split[19] = "Temple - Trial 5\nNo rolling is the key!";
				vars.split[20] = "Temple - Trial 6\nRun to walk, hop, crouch, roll, run + jump.";
				vars.split[21] = "Temple - Nests\nLet's run through it very fast.";
				vars.split[22] = "Temple - End\nNice tatoo. Only 13€.";
				
				vars.split[23] = "Get the Elum (Scrabania)\nThe Elum is back!";
				vars.split[24] = "Play with bombs\nFearless Abe! Let's go!";
				vars.split[25] = "Scrabania - End\nEnough riding. Let's go finally see some scrabs.";
				
				vars.split[26] = "Scrabania Temple - Entry\nScrabania, or Sligabania? Where are the scrabs?";
				vars.split[27] = "Temple - Trial 1\nI'm faster than those scrabs! And twice the dead!";
				vars.split[28] = "Temple - Trial 2\nVery normal level.";
				vars.split[29] = "Temple - Trial 3\nMeet the floating bomb of death. And random softlocks.";
				vars.split[30] = "Temple - Trial 4\nBats I guess. Where the old Max Cas DDG.";
				vars.split[31] = "Temple - Trial 5\nGoing through scrabs is fun and EASY.";
				vars.split[32] = "Temple - Trial 6\nLet's hope I don't die between screens.";
				vars.split[33] = "Temple - Trial 7\nScrabs everywhere. MOM!";
				vars.split[34] = "Temple - Trial 8\nScrabs ain't as dangerous as they say.";
				vars.split[35] = "Temple - Nests\nLet's risk a stupid death on a 3 seconds skip :)";
				vars.split[36] = "Temple - End\nI have the power of the convenience of the plot on my side!";
			} else {
				vars.split[9] = "Get the Elum (Scrabania)\nThe Elum is here!";
				vars.split[10] = "Play with bombs\nSo many bombs, WHY?!";
				vars.split[11] = "Scrabania - End\nI want scrabs, not bombs!";
				
				vars.split[12] = "Scrabania Temple - Entry\nNow mines?! WHERE ARE THE SCRABS?!";
				vars.split[13] = "Temple - Trial 1\nHow to tame your Scrab 1.0";
				vars.split[14] = "Temple - Trial 2\nVery normal level.";
				vars.split[15] = "Temple - Trial 3\nMeet the floating bomb of death.";
				vars.split[16] = "Temple - Trial 4\nThe attack of the angry bats of the DDG.";
				vars.split[17] = "Temple - Trial 5\nGoing through scrabs is fun.";
				vars.split[18] = "Temple - Trial 6\nThrowing scrabs is fun.";
				vars.split[19] = "Temple - Trial 7\nHow to tame your Scrab 2.0.";
				vars.split[20] = "Temple - Trial 8\nScrabs doesn't use elevators...";
				vars.split[21] = "Temple - Nests\nRun and use platforms.";
				vars.split[22] = "Temple - End\nNice tatoo. Only 15€.";
				
				vars.split[23] = "Get the Elum (Paramonia)\nThe Elum is back!";
				vars.split[24] = "Honey and Sligs\nFearless Elum! Annoying bees!";
				vars.split[25] = "Platforms and Bees\nLet's run!";
				vars.split[26] = "Passwords and Sligs\nI cheated! I remember the password.";
				vars.split[27] = "Paramonia\nWelp. Here we go again.";
				
				vars.split[28] = "Paramonian Temple - Entry\nBad sloggies doesn't get bones.";
				vars.split[29] = "Temple - Trial 1\nSkip the rolling stone of death!";
				vars.split[30] = "Temple - Trial 2\nFood is power, too.";
				vars.split[31] = "Temple - Trial 3\nFoodTimizer in action!";
				vars.split[32] = "Temple - Trial 4\nNeverstopping bouncing rocks.";
				vars.split[33] = "Temple - Trial 5\nMaster Baiter in action!";
				vars.split[34] = "Temple - Trial 6\nEvade the bouncing rocks of suffering!";
				vars.split[35] = "Temple - Nests\nLet's run through it very fast.";
				vars.split[36] = "Temple - End\nI got the power of god and anime on my side!";
			}
			
			vars.split[37] = "Free vire... f**k's sake\nBomb simulator.";
			vars.split[38] = "Zulag 1\nLet's go on a fun trip to Zulag 2!";
			
			vars.split[39] = "Zulag 2 - Entry\nRestart + Skippin' it like a boss.";
			vars.split[40] = "Zulag 2 - Door 1\nPull the lever and leave.";
			vars.split[41] = "Zulag 2 - Door 2\nGrenade power + Killing slogs.";
			vars.split[42] = "Zulag 2 - Door 3\nThis sligs are not getting promoted.";
			vars.split[43] = "Zulag 2 - End\nLet's enter the realm of purple!";
			
			vars.split[44] = "Zulag 3 - Entry\nSneaky, ninja power!";
			vars.split[45] = "Zulag 3 - Door 1\nMuch sligs here...";
			vars.split[46] = "Zulag 3 - Door 2\nLong level, not that long with GRENADES :D";
			vars.split[47] = "Zulag 3 - Door 3\nFloating bombs everywhere D:";
			vars.split[48] = "Zulag 3 - End\nLet's enter the realm of green!";
			
			vars.split[49] = "Zulag 4 - Enter Slog Kennels\nShooting some sligs for... you get me.";
			vars.split[50] = "Zulag 4 - Leave Slog Kennels\nLet's just skip everything. It's faster.";
			vars.split[51] = "Zulag 4 - Main Section\nLet's just leave this place.";
			vars.split[52] = "Zulag 4 End\nSkipping this part, too.";
			
			vars.split[53] = "The Boardroom\nLet's get shot!";			
			vars.split[54] = "Game finished\nI hope this was World Record :)";
			vars.split[55] = "Game finished\nI hope this was World Record :)";
			vars.split[56] = "Game finished\nI hope this was World Record :)";
			vars.split[57] = "Game finished\nI hope this was World Record :)";
			vars.split[58] = "Game finished\nI hope this was World Record :)";
			
		} else if (settings["Splits100%"]){
			vars.split[0] = "RuptureFarms - Tutorials\nCan I cry now, please?";
			vars.split[1] = "RuptureFarms - Meat Grinder\nMeat doesn't kill... I HOPE.";
			vars.split[2] = "RuptureFarms - Sligs\nI hate Sligs.";
			vars.split[3] = "RuptureFarms End\nI'm so outta here!";
			
			vars.split[4] = "Stockyards - Scrab Part\nMeet the nature! And... the scrabs.";
			vars.split[5] = "Stockyards - Slig Part\nI hate sligs even more. SO I kill mudokons.";
			vars.split[6] = "Stockyards End\nEnough playing with slogs.";
			
			vars.split[7] = "Monsaic Lines - Natives\nMeet the douchebags!";
			vars.split[8] = "Monsaic Lines End\nLet's pick our choice...";
			
			if (vars.ParamoniaFirst){
				vars.split[9] = "Get the Elum (Paramonia)\nThe Elum is here!";
				vars.split[10] = "Honey and Sligs\nRocks. Convenient pocket-size power!";
				vars.split[11] = "Platforms and Bees\nLet's run very fast!";
				vars.split[12] = "Passwords and Sligs\nMissing trapdoor? Shooting sligs? Help.";
				vars.split[13] = "Paramonia\nBye Elum. We'll meet again.";
				
				vars.split[14] = "Paramonian Temple - Entry\nBad sloggies doesn't get bones.";
				vars.split[15] = "Temple - Trial 1\nMeet the rolling stone of death!";
				vars.split[16] = "Temple - Trial 2\nFood is power, too.";
				vars.split[17] = "Temple - Trial 3\nPasswords gives OP power for some reason.";
				vars.split[18] = "Temple - Trial 4\nRoll, hop twice, run + jump.";
				vars.split[19] = "Temple - Trial 5\nNo rolling is the key!";
				vars.split[20] = "Temple - Trial 6\nRun to walk, hop, crouch, roll, run + jump.";
				vars.split[21] = "Temple - Nests\nLet's run through it very fast.";
				vars.split[22] = "Temple - End\nNice tatoo. Only 13€.";
				
				vars.split[23] = "Get the Elum (Scrabania)\nThe Elum is back!";
				vars.split[24] = "Play with bombs\nFearless Abe! Let's go!";
				vars.split[25] = "Scrabania - End\nEnough riding. Let's go finally see some scrabs.";
				
				vars.split[26] = "Scrabania Temple - Entry\nScrabania, or Sligabania? Where are the scrabs?";
				vars.split[27] = "Temple - Trial 1\nI'm faster than those scrabs! And twice the dead!";
				vars.split[28] = "Temple - Trial 2\nVery normal level.";
				vars.split[29] = "Temple - Trial 3\nMeet the floating bomb of death. And random softlocks.";
				vars.split[30] = "Temple - Trial 4\nBats I guess. Where the old Max Cas DDG.";
				vars.split[31] = "Temple - Trial 5\nGoing through scrabs is fun and EASY.";
				vars.split[32] = "Temple - Trial 6\nLet's hope I don't die between screens.";
				vars.split[33] = "Temple - Trial 7\nScrabs everywhere. MOM!";
				vars.split[34] = "Temple - Trial 8\nScrabs ain't as dangerous as they say.";
				vars.split[35] = "Temple - Nests\nLet's risk a stupid death on a 3 seconds skip :)";
				vars.split[36] = "Temple - End\nI have the power of the convenience of the plot on my side!";
			} else {
				vars.split[9] = "Get the Elum (Scrabania)\nThe Elum is here!";
				vars.split[10] = "Play with bombs\nSo many bombs, WHY?!";
				vars.split[11] = "Scrabania - End\nI want scrabs, not bombs!";
				
				vars.split[12] = "Scrabania Temple - Entry\nNow mines?! WHERE ARE THE SCRABS?!";
				vars.split[13] = "Temple - Trial 1\nI'm faster than those scrabs!";
				vars.split[14] = "Temple - Trial 2\nVery normal level.";
				vars.split[15] = "Temple - Trial 3\nMeet the floating bomb of death.";
				vars.split[16] = "Temple - Trial 4\nThe attack of the angry bats of the DDG.";
				vars.split[17] = "Temple - Trial 5\nGoing through scrabs is fun.";
				vars.split[18] = "Temple - Trial 6\nThrowing scrabs is fun.";
				vars.split[19] = "Temple - Trial 7\nScrabs everywhere.";
				vars.split[20] = "Temple - Trial 8\nScrabs doesn't use elevators...";
				vars.split[21] = "Temple - Nests\nRun and use platforms.";
				vars.split[22] = "Temple - End\nNice tatoo. Only 15€.";
				
				vars.split[23] = "Get the Elum (Paramonia)\nThe Elum is back!";
				vars.split[24] = "Honey and Sligs\nRocks are the true power.";
				vars.split[25] = "Platforms and Bees\nLet's run!";
				vars.split[26] = "Passwords and Sligs\nI cheated! I remember the password.";
				vars.split[27] = "Paramonia\nWelp. Here we go again.";
				
				vars.split[28] = "Paramonian Temple - Entry\nBad sloggies doesn't get bones.";
				vars.split[29] = "Temple - Trial 1\nMeet the rolling stone of death!";
				vars.split[30] = "Temple - Trial 2\nFood is power, too.";
				vars.split[31] = "Temple - Trial 3\nPasswords gives OP power.";
				vars.split[32] = "Temple - Trial 4\nNo paramites here...";
				vars.split[33] = "Temple - Trial 5\nNo rolling is the key!";
				vars.split[34] = "Temple - Trial 6\nEvade the bouncing rocks of suffering!";
				vars.split[35] = "Temple - Nests\nLet's run through it very fast.";
				vars.split[36] = "Temple - End\nI got the power of god and anime on my side!";
			}
			
			vars.split[37] = "Free vi... fuck's sake\nFree vire... zone?";
			vars.split[38] = "Zulag 1 - Entry Mudokon Ring\nLet's catch'em or kill'em all, mudokon version.";
			vars.split[39] = "Zulag 1 - Sligs Meat Grinders\nRed rings of death and shrykulls.";
			vars.split[40] = "Zulag 1 - Tutorials 2\nI'm back, baby!";
			vars.split[41] = "Zulag 1 - End\nLet's go on a fun trip to Zulag 2!";
			
			vars.split[42] = "Zulag 2 - Entry\nYes, hi. I want some chips and a cheeseburger.";
			vars.split[43] = "Zulag 2 - Door 1\nNot shooting at slogs this time.";
			vars.split[44] = "Zulag 2 - Door 2\nShrykull, just too OP!";
			vars.split[45] = "Zulag 2 - Door 3\nGrenade power is back.";
			vars.split[46] = "Zulag 2 - End\nLet's enter the realm of purple!";
			
			vars.split[47] = "Zulag 3 - Entry\nNothing interesting to do here.";
			vars.split[48] = "Zulag 3 - Door 1\nGrenades are life on this level.";
			vars.split[49] = "Zulag 3 - Door 2\nConvenient shrykull :)";
			vars.split[50] = "Zulag 3 - Door 3\nFloating bombs everywhere D:";
			vars.split[51] = "Zulag 3 - End\nLet's enter the realm of green!";
			
			vars.split[52] = "Zulag 4 - Enter Slog Kennels\nShooting sligs for... you get me.";
			vars.split[53] = "Zulag 4 - Leave Slog Kennels\nKilling slogs. Much slogs.";
			vars.split[54] = "Zulag 4 - Main Section\nLet's just leave this place.";
			vars.split[55] = "Zulag 4 End\nNo killing slogs this time.";
			vars.split[56] = "The Boardroom\nLast mudokon AAAND let's get shot!";
			vars.split[57] = "Game finished\nI hope this was World Record :)";
			vars.split[58] = "Game finished\nI hope this was World Record :)";
			vars.split[59] = "Game finished\nI hope this was World Record :)";
			vars.split[60] = "Game finished\nI hope this was World Record :)";
			
		} else if (settings["SplitsGoodEnding"]){
			vars.split[0] = "RuptureFarms - Tutorials\nCan I cry now, please?";
			vars.split[1] = "RuptureFarms - Meat Grinder\nMeat doesn't kill... I HOPE.";
			vars.split[2] = "RuptureFarms - Sligs\nI hate Sligs.";
			vars.split[3] = "RuptureFarms End\nI'm so outta here!";
			
			vars.split[4] = "Stockyards - Scrab Part\nMeet the nature! And... the scrabs.";
			vars.split[5] = "Stockyards - Slig Part\nI hate sligs even more. SO I kill mudokons.";
			vars.split[6] = "Stockyards End\nEnough playing with slogs.";
			
			vars.split[7] = "Monsaic Lines - Natives\nMeet the douchebags!";
			vars.split[8] = "Monsaic Lines End\nLet's pick our choice...";
			
			if (vars.ParamoniaFirst){
				vars.split[9] = "Get the Elum (Paramonia)\nThe Elum is here!";
				vars.split[10] = "Honey and Sligs\nRocks. Convenient pocket-size power!";
				vars.split[11] = "Platforms and Bees\nLet's run very fast!";
				vars.split[12] = "Passwords and Sligs\nMissing trapdoor? Shooting sligs? Help.";
				vars.split[13] = "Paramonia\nBye Elum. We'll meet again.";
				
				vars.split[14] = "Paramonian Temple - Entry\nBad sloggies doesn't get bones.";
				vars.split[15] = "Temple - Trial 1\nMeet the rolling stone of death!";
				vars.split[16] = "Temple - Trial 2\nFood is power, too.";
				vars.split[17] = "Temple - Trial 3\nPasswords gives OP power for some reason.";
				vars.split[18] = "Temple - Trial 4\nRoll, hop twice, run + jump.";
				vars.split[19] = "Temple - Trial 5\nNo rolling is the key!";
				vars.split[20] = "Temple - Trial 6\nRun to walk, hop, crouch, roll, run + jump.";
				vars.split[21] = "Temple - Nests\nLet's run through it very fast.";
				vars.split[22] = "Temple - End\nNice tatoo. Only 13€.";
				
				vars.split[23] = "Get the Elum (Scrabania)\nThe Elum is back!";
				vars.split[24] = "Play with bombs\nFearless Abe! Let's go!";
				vars.split[25] = "Scrabania - End\nEnough riding. Let's go finally see some scrabs.";
				
				vars.split[26] = "Scrabania Temple - Entry\nScrabania, or Sligabania? Where are the scrabs?";
				vars.split[27] = "Temple - Trial 1\nI'm faster than those scrabs! And twice the dead!";
				vars.split[28] = "Temple - Trial 2\nVery normal level.";
				vars.split[29] = "Temple - Trial 3\nMeet the floating bomb of death. And random softlocks.";
				vars.split[30] = "Temple - Trial 4\nBats I guess. Where the old Max Cas DDG.";
				vars.split[31] = "Temple - Trial 5\nGoing through scrabs is fun and EASY.";
				vars.split[32] = "Temple - Trial 6\nLet's hope I don't die between screens.";
				vars.split[33] = "Temple - Trial 7\nScrabs everywhere. MOM!";
				vars.split[34] = "Temple - Trial 8\nScrabs ain't as dangerous as they say.";
				vars.split[35] = "Temple - Nests\nLet's risk a stupid death on a 3 seconds skip :)";
				vars.split[36] = "Temple - End\nI have the power of the convenience of the plot on my side!";
			} else {
				vars.split[9] = "Get the Elum (Scrabania)\nThe Elum is here!";
				vars.split[10] = "Play with bombs\nSo many bombs, WHY?!";
				vars.split[11] = "Scrabania - End\nI want scrabs, not bombs!";
				
				vars.split[12] = "Scrabania Temple - Entry\nNow mines?! WHERE ARE THE SCRABS?!";
				vars.split[13] = "Temple - Trial 1\nI'm faster than those scrabs!";
				vars.split[14] = "Temple - Trial 2\nVery normal level.";
				vars.split[15] = "Temple - Trial 3\nMeet the floating bomb of death.";
				vars.split[16] = "Temple - Trial 4\nThe attack of the angry bats of the DDG.";
				vars.split[17] = "Temple - Trial 5\nGoing through scrabs is fun.";
				vars.split[18] = "Temple - Trial 6\nThrowing scrabs is fun.";
				vars.split[19] = "Temple - Trial 7\nScrabs everywhere.";
				vars.split[20] = "Temple - Trial 8\nScrabs doesn't use elevators...";
				vars.split[21] = "Temple - Nests\nRun and use platforms.";
				vars.split[22] = "Temple - End\nNice tatoo. Only 15€.";
				
				vars.split[23] = "Get the Elum (Paramonia)\nThe Elum is back!";
				vars.split[24] = "Honey and Sligs\nRocks are the true power.";
				vars.split[25] = "Platforms and Bees\nLet's run!";
				vars.split[26] = "Passwords and Sligs\nI cheated! I remember the password.";
				vars.split[27] = "Paramonia\nWelp. Here we go again.";
				
				vars.split[28] = "Paramonian Temple - Entry\nBad sloggies doesn't get bones.";
				vars.split[29] = "Temple - Trial 1\nMeet the rolling stone of death!";
				vars.split[30] = "Temple - Trial 2\nFood is power, too.";
				vars.split[31] = "Temple - Trial 3\nPasswords gives OP power.";
				vars.split[32] = "Temple - Trial 4\nNo paramites here...";
				vars.split[33] = "Temple - Trial 5\nNo rolling is the key!";
				vars.split[34] = "Temple - Trial 6\nEvade the bouncing rocks of suffering!";
				vars.split[35] = "Temple - Nests\nLet's run through it very fast.";
				vars.split[36] = "Temple - End\nI got the power of god and anime on my side!";
			}
			
		
			vars.split[37] = "FreeFire Zone\nFree vire... zone?";
			vars.split[38] = "Zulag 1\nSaving some muds and leaving this for fun!";	
			
			vars.split[39] = "Zulag 2\nBackwards jump, very convenient.";	
			
			vars.split[40] = "Zulag 3\nThis is how the game is meant to be played!";
			
			vars.split[41] = "Zulag 4 - Enter Slog Kennels\nShooting sligs. MUCH sligs.";
			vars.split[42] = "Zulag 4 - Leave Slog Kennels\nNot a good day for slogs if you ask me.";
			vars.split[43] = "Zulag 4 - Main Section\nLet's just leave this place.";
			vars.split[44] = "Zulag 4 End\nSkippin' this.";
			vars.split[45] = "The Boardroom\nLet's save the last mudokon and get shot! YES!";
			vars.split[46] = "Game finished\nI hope this was World Record :)";
			vars.split[47] = "Game finished\nI hope this was World Record :)";
			vars.split[48] = "Game finished\nI hope this was World Record :)";
			vars.split[49] = "Game finished\nI hope this was World Record :)";
			vars.split[50] = "Game finished\nI hope this was World Record :)";
			
		} else if (vars.ILtype == 0){ // RuptureFarms
			vars.split[0] = "IL - RuptureFarms - Tutorials\nCan I cry now, please?";
			vars.split[1] = "IL - RuptureFarms - Meat Grinder\nMeat doesn't kill... I HOPE.";
			vars.split[2] = "IL - RuptureFarms - Sligs\nI hate Sligs.";
			vars.split[3] = "IL - RuptureFarms - End\nI'm so outta here!";
			vars.split[4] = "IL - RuptureFarms\nOversplit. Wrong splits file?";
		} else if (vars.ILtype == 1){ // Stockyards
			vars.split[0] = "IL - Stockyards - Scrab Part\nMeet the nature! And... the scrabs.";
			vars.split[1] = "IL - Stockyards - Slig Part\nI hate sligs even more. SO I kill mudokons.";
			vars.split[2] = "IL - Stockyards - End\nEnough playing with slogs.";	
			vars.split[3] = "IL - Stockyards\nOversplit. Wrong splits file?";			
		} else if (vars.ILtype == 2){ // Paramonia + Temple + Nests
			vars.split[0] = "IL - Paramonia - Get the Elum P\nThe Elum is here!";
			vars.split[1] = "IL - Paramonia - Honey and Sligs\nFearless Elum and Annoying Bees!";
			vars.split[2] = "IL - Paramonia - Platforms and Bees\nLet's run very fast!";
			vars.split[3] = "IL - Paramonia - Passwords and Sligs\nPass the word and run!";
			vars.split[4] = "IL - Paramonia\nBye Elum. Never see you again!";
			vars.split[5] = "IL - Paramonia\nOversplit. Wrong splits file?";
		} else if (vars.ILtype == 3){ // Scrabania + Temple + Nests
			vars.split[0] = "IL - Scrabania - Get the Elum S\nThe Elum is back!";
			vars.split[1] = "IL - Scrabania - Play with bombs\nFearless Abe! Let's go!";
			vars.split[2] = "IL - Scrabania - End\nEnough riding. Let's skip some slogs, EZ!";
			vars.split[3] = "IL - Scrabania\nOversplit. Wrong splits file?";
		} else if (vars.ILtype == 4){ // FFZ + Zulag 1
			vars.split[0] = "IL - Free Fire Zone\nFree-arless Abe Zone!";
			vars.split[1] = "IL - Free Fire Zone\nOversplit. Wrong splits file?";
		} else if (vars.ILtype == 5){ // Zulag 2			
			vars.split[0] = "IL - Zulag 2 - Entry\nYes, hi. I want some chips and a cheeseburger.";
			vars.split[1] = "IL - Zulag 2 - Door 1\nMudokon dies or not?";
			vars.split[2] = "IL - Zulag 2 - Door 2\nGrenade + Slig dying.";
			vars.split[3] = "IL - Zulag 2 - Door 3\nDetonating sligs 4 fun!";
			vars.split[4] = "IL - Zulag 2 - End\nLet's enter the realm of purple!";
			vars.split[5] = "IL - Zulag 2\nOversplit. Wrong splits file?";
		} else if (vars.ILtype == 6){ // Zulag 3
			vars.split[0] = "IL - Zulag 3 - Entry\nExpress lever pull!";
			vars.split[1] = "IL - Zulag 3 - Door 1\nMeet the braindead sligs!";
			vars.split[2] = "IL - Zulag 3 - Door 2\nVery long level indeed.";
			vars.split[3] = "IL - Zulag 3 - Door 3\nFloating bombs everywhere D:";
			vars.split[4] = "IL - Zulag 3 - End\nLet's enter the realm of green!";
			vars.split[5] = "IL - Zulag 3\nOversplit. Wrong splits file?";			
		} else if (vars.ILtype == 7){ // Zulag 4 + Boardroom
			vars.split[0] = "IL - Zulag 4 - Enter Slog Kennels\nMirky grenade strat!";
			vars.split[1] = "IL - Zulag 4 - Leave Slog Kennels\nKilling slogs. Or maybe not...";
			vars.split[2] = "IL - Zulag 4 - Main Section\nLet's just leave this place.";
			vars.split[3] = "IL - Zulag 4 - End\nNo killing slogs this time.";
			vars.split[4] = "IL - The Boardroom\nLast mudokon AAAND let's get shot!";
			vars.split[5] = "IL - Zulag 4\nOversplit. Wrong splits file?";
		} else if (vars.ILtype == 8){ //Monsaic Lines
			vars.split[0] = "IL - Monsaic Lines - Natives\nSkip the dumb-dumbs!";
			vars.split[1] = "IL - Monsaic Lines - Bees\nAny%-> DDG | Other-> Just go.";
			vars.split[2] = "IL - Monsaic Lines - Exit\nAny%-> Bird portal | Other-> Well.";
			vars.split[3] = "IL - Monsaic Lines\nOversplit. Wrong splits file?";
		} else if (vars.ILtype == 9){ // Paramonian temple			
			vars.split[0] = "IL - P. Temple - Entry\nBad sloggies doesn't get bones.";
			vars.split[1] = "IL - P. Temple - Trial 1\nMeet the rolling stone of death!";
			vars.split[2] = "IL - P. Temple - Trial 2\nFood is power, too.";
			vars.split[3] = "IL - P. Temple - Trial 3\nFoodTimizer changes level order.";
			vars.split[4] = "IL - P. Temple - Trial 4\nSlogs, bats and rocks. Paramites? Nope!";
			vars.split[5] = "IL - P. Temple - Trial 5\nBehold the Master Baiter!";
			vars.split[6] = "IL - P. Temple - Trial 6\nSligs, slogs, bats, rocks... paramites?!";
			vars.split[7] = "IL - P. Temple - Nests + End\nLet's run through it very fast.";
			vars.split[8] = "IL - P. Temple\nOversplit. Wrong splits file?";
		} else if (vars.ILtype == 10){ // Scrabanian Temple			
			vars.split[0] = "IL - S. Temple - Entry\nScrabania, or Sligabania? Where are the scrabs?";
			vars.split[1] = "IL - S. Temple - Trial 1\nHow to tame your Scrab... 1.0!";
			vars.split[2] = "IL - S. Temple - Trial 2\nVery normal level.";
			vars.split[3] = "IL - S. Temple - Trial 3\nMeet the floating bomb of death. And random softlocks.";
			vars.split[4] = "IL - S. Temple - Trial 4\nBats I guess. Where the old Max Cas DDG was.";
			vars.split[5] = "IL - S. Temple - Trial 5\nGoing through scrabs is fun and EASY.";
			vars.split[6] = "IL - S. Temple - Trial 6\nElevator strat right here!";
			vars.split[7] = "IL - S. Temple - Trial 7\nHow to tame your Scrab... 2.0!";
			vars.split[8] = "IL - S. Temple - Trial 8\nScrab elevator trick.";
			vars.split[9] = "IL - S. Temple - Nests + End\nLet's risk a stupid death on a 3 seconds skip :)";
			vars.split[10] = "IL - S. Temple\nOversplit. Wrong splits file?";
		} else if (vars.ILtype == 11){ // Zulag 1		
			vars.split[0] = "IL - Zulag 1 - Mudokon Ring\nLet's catch'em or kill'em all, mudokon version.";
			vars.split[1] = "IL - Zulag 1 - Sligs Meat Grinders\nRed rings of death and shrykulls.";
			vars.split[2] = "IL - Zulag 1 - Tutorials 2\nI'm back, baby!";
			vars.split[3] = "IL - Zulag 1 - End\nLet's go on a fun trip to Zulag 2!";
			vars.split[4] = "IL - Zulag 1\nOversplit. Wrong splits file?";
		} else { // NO SPLITS WHATSOEVER
			vars.split[0] = "No category selected\nJust using loadless time feature. Check settings!";
			vars.split[1] = "No category selected\nJust using loadless time feature. Check settings!";
			vars.split[2] = "No category selected\nJust using loadless time feature. Check settings!";
			vars.split[3] = "No category selected\nJust using loadless time feature. Check settings!";			
		} 
	}

	
// LOG TOOL FOR DEBUG. 	
	if (gnFrame > 1){
		if (vars.ResetStatus == 1) {
			vars.ResetStatus = 2;
			vars.Log = "Main Menu [" + vars.n + "]\nReset performed." ;
		} else if (LEVEL_ID == 0){		
			vars.Log = "Main Menu [" + vars.n + "]\nGLOBAL AutoSplit started. Lang detected: " + vars.LangDetected + ".";
		} else {	
			if (settings["RealGameTime"]){	
				if (settings["NoSplitNames"]){
					vars.Log = "IGT: " + vars.LOADLESS_TIME + " | Split number: " + vars.n;
				} else {
					vars.Log = "IGT: " + vars.LOADLESS_TIME + " | Zone: " + vars.split[vars.n];	
				}
			} else {				
				if (settings["NoSplitNames"]){
					vars.Log = "RTA: " + vars.REAL_TIME + " | Split number: " + vars.n;
				} else {					
					vars.Log = "RTA: " + vars.REAL_TIME + " | Zone: " + vars.split[vars.n];
				}
			}
		}	
	} else {
		vars.Log = "Main Menu [" + vars.n + "]\nGLOBAL AutoSplit started. No main lang detected yet.";
	}
}
