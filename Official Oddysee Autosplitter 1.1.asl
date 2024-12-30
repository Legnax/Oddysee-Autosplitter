//	Official Autosplitter 4.0 for Abe's Oddysee for PC. Any version. Any language. Any category. Any IL. Loadless time. Frame database. DDG cats and alt glitched cats included.
//	Created by LegnaX. Relive support by Paul (paulsapps.com) and mouzedrift. Optimized by UltraStars3000.
//  DATE OF LAST EDITION-> 30-12-2024

 // Added this so the ASL Var Viewer has at least one opcode loaded by default (even if it's unused). 
	state("AbeWin") { byte use_Variables_option_instead  : 0x1C3030; }
	state("AliveExeAO") { byte use_Variables_option_instead  : 0x1C3030; }
	state("AliveExe") { byte use_Variables_option_instead  : 0x1C3030;  }
	state("relive") { byte use_Variables_option_instead  : 0x1C3030;  }

startup
{	
	// ++++++++++ GENERAL SETTINGS ++++++++++
	
	settings.Add("Version", true, "Official Version 4.0 (Dec 30th, 2024) - LegnaX#7777 - CHANGELOG");
	settings.SetToolTip("Version", "-- CHANGELOG --\n- Optimized in-game time handling, making the internal LiveSplit timer consistent with the variable one.\n- Removed the need of backup files when restarting the game during a run.\n- Added Any% to the split database feature.\n- Added new categories: Good Ending NMG, 50/50 Glitched, all glitched categories with DDG.\n- Added the new option of Split Database, and the ability to track and store the best frame time for each split for each category!\n- Optimized the code in order to prevent getting stuck on the trials.\n- Added extra refresh rate options and updated tooltip descriptions.\n- Improved some split descriptions and names.\n- Added several checks for the trials on Zulag 2 and 3. Should prevent premature splits.\n- Fixed an issue with the chrono variable not being properly reseted when manually resetting the livesplit being inside the pause menu.\n- Fixed a faulty check on Zulag 3 trial 1.\n- Added individual levels!\n- Fixed a missing split on Zulag 1 (last one) for ILs.\n- Optimized how ILs work, and as soon as the last split is done, the variable Log will output your precise RTA and IGT times.\n- Added Monsaic Lines as new IL, and split Scrabania, Paramonia and Zulag 1. Now The main level and the temple are separated, and FFZ it's a separated level from Zulag 1.\n- Created new variable: GNFrame, which can be used and displayed during runs to see the amount of frames elapsed during the actual run (useful for ILs).\n- The code was broken. It has been restructured. Sorry!\n- Adjusted the last split of Paramonia Temple IL to Spam split just in case.\n- Fixed a major glitch happening with users that didn't have the autosplitter before. The 'C:/Autosplit Backup Files/' directory wasn't getting created properly, so the autosplitter was unable to start.\n- Added 50/50 and Max Cas NMG to the categories list.\n- Fixed an issue with the language not getting saved properly.\n- The entire exit sequence was commented! So nothing was being saved upon game restart. Now it does! My bad.\n- NMS is now NMG. Updated the category name.\n- Fixed an OBVIOUS game over split issue that should have NEVER happen. My god.\n- Fixed a visual glitch with the IGT.\n- Added relive support and completely revamped the language detection system for all versions (thanks to Paul, paulsapps.com). Code should be more optimal, too\n- Adjusted how the real time shows on the autosplitter (using ASL Var Viewer). Also made Log to be selectable on the list of allowed variables.\n- Fixed a problem with the splits when selecting Scrabania first on a different category than Any% NMG.\n   It should WORK on every category now (thanks to kongy654).\n- [May 26th, 2022] Added support for relive (thanks to mouzedrift).");
	
	settings.Add("NoSplitNames", false, "LIGHT VERSION");
	settings.SetToolTip("NoSplitNames", "No split names, zones or database feature. Just loadless time and autosplitter. \nThis should make the code of the autosplitter way lighter, at least when starting the execution.");
	
	settings.Add("UseDatabase", false, "SPLIT DATABASE FEATURE (Alpha!)");
	settings.SetToolTip("UseDatabase", "Enables this feature: stores the frames for each split on text files and tracks the best time for each split!\nThe times will be stored in C:\\Autosplit Backup Files\\Database\\Oddworld Abe's Oddysee\\<category name>\\<split ID + split name>.txt \nAccurate gold times, here we go!\nNOTE: It doesn't work with LIGHT VERSION enabled!!");
	
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
	
	settings.Add("SplitsAny%", false, "Any% (Split Database AVAILABLE!)", "UsingAutosplit");
	settings.SetToolTip("SplitsAny%", "Use the Any% splits file!\nAutosplitter will split accordingly those splits.");
	
	settings.Add("SplitsAny%NMG", false, "Any% NMG | Good Ending NMG (Split Database AVAILABLE!)", "UsingAutosplit");
	settings.SetToolTip("SplitsAny%NMG", "Use the Any% NMG splits file!\nAutosplitter will split accordingly those splits.\nBoth variants are supported: Scrabania first, or Paramonia first.");
	
	settings.Add("Splits100%", false, "100% | 100% NMG | Max Cas (+DDG) | Max Cas NMG | 50/50", "UsingAutosplit");
	settings.SetToolTip("Splits100%", "Use the 100% | 100% NMG | Max Cas | Max Cas NMG | 50/50 splits file!\nAutosplitter will split accordingly those splits.\nBoth variants are supported: Scrabania first, or Paramonia first.");
	
	settings.Add("SplitsGoodEnding", false, "Good Ending (+ DDG)", "UsingAutosplit");
	settings.SetToolTip("SplitsGoodEnding", "Use the Good Ending splits file!\nAutosplitter will split accordingly those splits.\nBoth variants are supported: Scrabania first, or Paramonia first.");
	
	
	// ++++++++++ INDIVIDUAL LEVEL SETTINGS ++++++++++
	
	settings.Add("UsingIL", false, "INDIVIDUAL LEVELS - Check this to activate");
	settings.SetToolTip("UsingIL", "Leave this option unchecked to not use.\nAutosplit will priorize autosplit category over Individual Levels, so make sure you disable AUTOSPLIT GAME CATEGORY if you want to use ILs!\nYou need the splits file for the IL splits to work correctly. \nDOWNLOAD THEM AT http://tiny.cc/Splits1 !\nExcept for RuptureFarms, you need to use the Cheat Code in order for the autosplit to start.\nCHEAT CODE: Keep pressed run button and press ↓ → ← → ← → ← ↑ on the main menu.\n-> INDIVIDUAL LEVEL LIST <-\n- RuptureFarms (start a new game)\n- Stockyards\n- Monsaic Lines\n- Paramonia\n- Paramonian Temple\n- Scrabania\n- Scrabanian Temple\n- Free Fire Zone\n- Zulag 1\n- Zulag 2\n- Zulag 3\n- Zulag 4");

	// Variables initialization
	vars.You_can_show_the_following_variables_on_runs = "Ahh, I see!";
	vars.SPLIT_INFO = "Autosplitter started";
	vars.REAL_TIME_AND_LOADLESS_TIME = "Both timers\nwill be displayed here";
	vars.REAL_TIME = "Real time will be displayed here";
	vars.LOADLESS_TIME = "Loadless time will be displayed here";
	vars.DB_PREVIOUS_SPLIT = "Finished split frames info will appear here.";
	vars.DB_CURRENT_SPLIT = "Current split frames info will appear here.";
	vars.DB_LOST_FRAMES_TOTAL = 0;
	vars.DB_GOLD_FRAMES_TOTAL = 0;
	vars.____________________________________ = "Ignore this.";
	vars.You_can_NOT_show_the_following_variables_on_runs = "Only the 6 above ones can be used.";

	vars.n = 0;
	vars.PreviousTime = 0;
	vars.CurrentSplitBestFrame = 0;
}

init
{		
// ################## PAUL'S BLACK MAGIC STARTS HERE UNTIL LINE 265 ##################

	print("+init");

	// Detect which version/language of the game we are running, load the entire code section to an array
	print("Reading " +  modules.First().ModuleMemorySize.ToString() + " bytes from the first module base address");
 	var moduleMemory = memory.ReadBytes(modules.First().BaseAddress, modules.First().ModuleMemorySize);
	string converted = Encoding.UTF8.GetString(moduleMemory, 0, moduleMemory.Length);
	print("Read code section as a string");

	vars.version = "";

	vars.SigScan = (Func<Process, int, string, IntPtr>)((proc, offset, signature) => {
        var target = new SigScanTarget(offset, signature);
        IntPtr result = IntPtr.Zero;
        foreach (var page in proc.MemoryPages(true)) {
            var scanner = new SignatureScanner(proc, page.BaseAddress, (int)page.RegionSize);
            if ((result = scanner.Scan(target)) != IntPtr.Zero) {
                break;
            }
        }

        return result;
    });

	for (;;)
	{	
		// First check if this is relive
		int pos = converted.IndexOf("{1D2E2B5A-19EE-4776-A0EE-98F49F781370}");
		if (pos != -1)
		{
			print("Relive Buffer match: " + converted.Substring(pos, 50));

			// Find the guid again via signature scanning to get the RVA offset
			IntPtr scan = vars.SigScan(game, 0, "7B 31 44 32 45 32 42 35 41 2D 31 39 45 45 2D 34 37 37 36 2D 41 30 45 45 2D 39 38 46 34 39 46 37 38 31 33 37 30 7D 00");
			if (scan != IntPtr.Zero)
			{
				print("Scan = " + scan.ToString());

				// Point to data after the guid in the AEGameInfo structure
				scan += 40;

				vars.version = "Relive";				
				vars.SPLIT_INFO = "Autosplitter started. Game version detected-> " + vars.version;
				
				// If this guid exists its a 64bit version of relive
				bool is64Bit = converted.IndexOf("{069DDB51-609D-49AB-B69D-5CC6D13E73EE}") != -1;
				int gamePointerSize = is64Bit ? 8 : 4;

				print("Pointer size = " + gamePointerSize.ToString());

				vars.watchers = new MemoryWatcherList
				{
					new MemoryWatcher<byte>(new DeepPointer(memory.ReadPointer(scan + (1*gamePointerSize)))) { Name = "LEVEL_ID" },
					new MemoryWatcher<byte>(new DeepPointer(memory.ReadPointer(scan + (2*gamePointerSize)))) { Name = "PATH_ID" },
					new MemoryWatcher<byte>(new DeepPointer(memory.ReadPointer(scan + (3*gamePointerSize)))) { Name = "CAM_ID" },
					new MemoryWatcher<int>(new DeepPointer(memory.ReadPointer(scan + (4*gamePointerSize)))) { Name = "gnFrame" },
					new MemoryWatcher<short>(new DeepPointer(memory.ReadPointer(scan + (5*gamePointerSize)), new int[] {memory.ReadValue<int>(scan + (6*gamePointerSize))})) { Name = "abeY" },
					new MemoryWatcher<byte>(new DeepPointer(memory.ReadPointer(scan + (7*gamePointerSize)))) { Name = "IsGameRunning" },
					new MemoryWatcher<byte>(new DeepPointer(memory.ReadPointer(scan + (8*gamePointerSize)))) { Name = "IsGameBeaten" },
				};
			}
			break;
		}

		// Then look in the array for the quit strings which are localised to figure out which language this is (for the original game)
		pos = converted.IndexOf("Do you really want to quit ?");
		if (pos != -1)
		{
			print("English Buffer match: " + converted.Substring(pos, 50));
			vars.version = "English";
			vars.SPLIT_INFO = "Autosplitter started. Game version detected-> " + vars.version;
			vars.watchers = new MemoryWatcherList
			{
				new MemoryWatcher<byte>(new DeepPointer(0x107BA8)) { Name = "LEVEL_ID" },
				new MemoryWatcher<byte>(new DeepPointer(0x107BAA)) { Name = "PATH_ID" },
				new MemoryWatcher<byte>(new DeepPointer(0x107BAC)) { Name = "CAM_ID" },
				new MemoryWatcher<int>(new DeepPointer(0x107670)) { Name = "gnFrame" }, // Ingame frame counter.
				new MemoryWatcher<short>(new DeepPointer(0x107678, new int[] {0xAE})) { Name = "abeY" }, // Needed for the Zulag 4 split.
				new MemoryWatcher<byte>(new DeepPointer(0x1080E4)) { Name = "IsGameRunning" }, // Paused game = 1
				new MemoryWatcher<byte>(new DeepPointer(0x1055AE)) { Name = "IsGameBeaten" }, // When variable 70 is true on the Boardroom. Game beaten = 1.
			};
			break;
		}

		pos = converted.IndexOf("Seguro que quieres salir?"); // Only check the ascii chars
		if (pos != -1) 
		{
			print("Buffer match: " + converted.Substring(pos, 50));
			vars.version = "Spanish";
			vars.SPLIT_INFO = "Autosplitter started. Game version detected-> " + vars.version;
			vars.watchers = new MemoryWatcherList
			{
				new MemoryWatcher<byte>(new DeepPointer(0x108332)) { Name = "LEVEL_ID" },
				new MemoryWatcher<byte>(new DeepPointer(0x108334)) { Name = "PATH_ID" },
				new MemoryWatcher<byte>(new DeepPointer(0x108336)) { Name = "CAM_ID" },
				new MemoryWatcher<int>(new DeepPointer(0x107DF0)) { Name = "gnFrame" },
				new MemoryWatcher<short>(new DeepPointer(0x107DF8, new int[] {0xAE})) { Name = "abeY" },
				new MemoryWatcher<byte>(new DeepPointer(0x108864)) { Name = "IsGameRunning" },
				new MemoryWatcher<byte>(new DeepPointer(0x105D2E)) { Name = "IsGameBeaten" },
			};
			break;
		}
		
		pos = converted.IndexOf("de vouloi quitter?"); // Only check the ascii chars
		if (pos != -1) 
		{
			print("French Buffer match: " + converted.Substring(pos, 50));
			vars.version = "French";
			vars.SPLIT_INFO = "Autosplitter started. Game version detected-> " + vars.version;
			vars.watchers = new MemoryWatcherList
			{
				new MemoryWatcher<byte>(new DeepPointer(0x108382)) { Name = "LEVEL_ID" },
				new MemoryWatcher<byte>(new DeepPointer(0x108384)) { Name = "PATH_ID" },
				new MemoryWatcher<byte>(new DeepPointer(0x108386)) { Name = "CAM_ID" },
				new MemoryWatcher<int>(new DeepPointer(0x107E40)) { Name = "gnFrame" },
				new MemoryWatcher<short>(new DeepPointer(0x107E48, new int[] {0xAE})) { Name = "abeY" },
				new MemoryWatcher<byte>(new DeepPointer(0x1088B4)) { Name = "IsGameRunning" },
				new MemoryWatcher<byte>(new DeepPointer(0x105D7E)) { Name = "IsGameBeaten" },
			};
			break;
		}
		
		pos = converted.IndexOf("Willst Du wirklich aufh"); // Only check the ascii chars
		if (pos != -1)
		{
			print("German Buffer match: " + converted.Substring(pos, 50));
			vars.version = "German";
			vars.SPLIT_INFO = "Autosplitter started. Game version detected-> " + vars.version;
			vars.watchers = new MemoryWatcherList
			{
				new MemoryWatcher<byte>(new DeepPointer(0x108342)) { Name = "LEVEL_ID" },
				new MemoryWatcher<byte>(new DeepPointer(0x108344)) { Name = "PATH_ID" },
				new MemoryWatcher<byte>(new DeepPointer(0x108346)) { Name = "CAM_ID" },
				new MemoryWatcher<int>(new DeepPointer(0x107E00)) { Name = "gnFrame" },
				new MemoryWatcher<short>(new DeepPointer(0x107E0C, new int[] {0xAE})) { Name = "abeY" },
				new MemoryWatcher<byte>(new DeepPointer(0x108874)) { Name = "IsGameRunning" },
				new MemoryWatcher<byte>(new DeepPointer(0x105D3E)) { Name = "IsGameBeaten" },
			};
			break;
		}
		
		pos = converted.IndexOf("Desideri realmente uscire?");
		if (pos != -1)
		{
			print("Italian Buffer match: " + converted.Substring(pos, 50));
			vars.version = "Italian";
			vars.SPLIT_INFO = "Autosplitter started. Game version detected-> " + vars.version;
			vars.watchers = new MemoryWatcherList
			{
				new MemoryWatcher<byte>(new DeepPointer(0x108222)) { Name = "LEVEL_ID" },
				new MemoryWatcher<byte>(new DeepPointer(0x108224)) { Name = "PATH_ID" },
				new MemoryWatcher<byte>(new DeepPointer(0x108226)) { Name = "CAM_ID" },
				new MemoryWatcher<int>(new DeepPointer(0x107CE0)) { Name = "gnFrame" },
				new MemoryWatcher<short>(new DeepPointer(0x107CE8, new int[] {0xAE})) { Name = "abeY" },
				new MemoryWatcher<byte>(new DeepPointer(0x108754)) { Name = "IsGameRunning" },
				new MemoryWatcher<byte>(new DeepPointer(0x105C1E)) { Name = "IsGameBeaten" },
			};
			break;
		}

		pos = converted.IndexOf("Abe Agogo"); // A unique English/ascii string rather than its encoded quit message
		if (pos != -1)
		{
			print("Japanese Buffer match: " + converted.Substring(pos, 50));
			vars.version = "Japanese";
			vars.SPLIT_INFO = "Autosplitter started. Game version detected-> " + vars.version;
			vars.watchers = new MemoryWatcherList
			{
				new MemoryWatcher<byte>(new DeepPointer(0x108B32)) { Name = "LEVEL_ID" },
				new MemoryWatcher<byte>(new DeepPointer(0x108B34)) { Name = "PATH_ID" },
				new MemoryWatcher<byte>(new DeepPointer(0x108B36)) { Name = "CAM_ID" },
				new MemoryWatcher<int>(new DeepPointer(0x1085F0)) { Name = "gnFrame" },
				new MemoryWatcher<short>(new DeepPointer(0x1085F8, new int[] {0xAE})) { Name = "abeY" },
				new MemoryWatcher<byte>(new DeepPointer(0x109084)) { Name = "IsGameRunning" },
				new MemoryWatcher<byte>(new DeepPointer(0x10652E)) { Name = "IsGameBeaten" },
			};
			break;
		}
		else
		{
			// Unknown
			print("Unknown game");
			break;
		}
	}
	
// ############ PAUL'S BLACK MAGIC ENDS HERE (STARTED AT LINE 78) ##################
	
	
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
	vars.split = new string[70]; // Split names.
	bool[] trialCheckk = new bool[7]; // 0 = 2-1. 1 = 2-2. 2 = 2-3. 3 = 3-1. 4 = 3-2. 5 = 3-3. 6 = 4-1.
	vars.trialCheck = trialCheckk; // Used to check the trials in order to verify if the screen with the lever that flags the level as completed was visited.
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
	vars.splitName = "";

	vars.isLevelSelect = false;
	
	vars.FramesUpToPreviousFrame = 0;
	vars.DatabaseName = new string[70]; // Database names for storing splits
	vars.DBSplit = false;
	
	// vars.Database_Current_Split = "";
		
	print("-init");
}


// MORE OF PAUL'S BLACK MAGIC

update
{
    vars.watchers.UpdateAll(game);

	/*
	print("GnFrame = " + vars.watchers["gnFrame"].Current.ToString());
	print("LEVEL_ID = " + vars.watchers["LEVEL_ID"].Current.ToString());
	print("PATH_ID = " + vars.watchers["PATH_ID"].Current.ToString());
	print("CAM_ID = " + vars.watchers["CAM_ID"].Current.ToString());
	print("abeY = " + vars.watchers["abeY"].Current.ToString());
	print("IsGameRunning = " + vars.watchers["IsGameRunning"].Current.ToString());
	print("IsGameBeaten = " + vars.watchers["IsGameBeaten"].Current.ToString());
	*/

	if (vars.watchers["LEVEL_ID"].Current == 0){ // MAIN SCREEN
		if (vars.gnBeforeMainMenu == 0){
			vars.gnBeforeMainMenu = vars.watchers["gnFrame"].Current;
		}
	} else {
		vars.gnBeforeMainMenu = 0;
	}

	// WE JUST RESTARTED THE GAME AND LOADED!!
	if (vars.watchers["LEVEL_ID"].Current > 0 && vars.PreviousTime > 0 && vars.StartgnFrame == 0) {
		vars.StartgnFrame = vars.watchers["gnFrame"].Current; 
	}

	// Pause time handle
	if (vars.watchers["IsGameRunning"].Current == 1){ // if the game is paused...
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

}

// #############################

// ############## THIS PART HAS BEEN ADAPTED FROM WATCHERS FROM PAUL'S NEW CODE ##############

start
{	
	// Checking for the Level Select screen
	if(vars.watchers["LEVEL_ID"].Current == 0 && vars.watchers["CAM_ID"].Current == 31) {
		vars.isLevelSelect = true;
	}
	// Once back in the Main screen
	if(vars.watchers["LEVEL_ID"].Current == 0 && vars.watchers["CAM_ID"].Current == 1) {
		vars.isLevelSelect = false;
	}
	vars.StartgnFrame = 0;

	// On exiting the main menu level
	if(vars.watchers["LEVEL_ID"].Old == 0 && vars.watchers["LEVEL_ID"].Current != 0) {
		if (settings["UsingIL"] && vars.isLevelSelect){
			vars.StartgnFrame = vars.watchers["gnFrame"].Current;

			// The reason we check each level individually is because:
			// - The ILtype variable doesn't match the game level select index
			// - A dynamic pointer offset is needed to retrieve the game level select index

			// Stockyards
			if(vars.watchers["LEVEL_ID"].Current == 5) {
				vars.ILtype = 1;
			}
			// Paramonia
			if(vars.watchers["LEVEL_ID"].Current == 3) {
				vars.ILtype = 2;
			}
			// Scrabania
			if(vars.watchers["LEVEL_ID"].Current == 8) {
				vars.ILtype = 2;
			}
			// Free Fire Zone
			if(vars.watchers["LEVEL_ID"].Current == 6) {
				vars.ILtype = 4;
			}
			// Zulag 2
			if(vars.watchers["LEVEL_ID"].Current == 13 && vars.watchers["PATH_ID"].Current == 1) {
				vars.ILtype = 5;
			}
			// Zulag 3
			if(vars.watchers["LEVEL_ID"].Current == 13 && vars.watchers["PATH_ID"].Current == 13) {
				vars.ILtype = 6;
			}
			// Zulag 4
			if(vars.watchers["LEVEL_ID"].Current == 13 && vars.watchers["PATH_ID"].Current == 14) {
				vars.ILtype = 7;
			}
			// Monsaic Lines
			if(vars.watchers["LEVEL_ID"].Current == 2) {
				vars.ILtype = 8;
			}
			// Paramonian Temple
			if(vars.watchers["LEVEL_ID"].Current == 4) {
				vars.ILtype = 9;
			}
			// Scrabanian Temple
			if(vars.watchers["LEVEL_ID"].Current == 9) {
				vars.ILtype = 10;
			}
			// Zulag 1
			if(vars.watchers["LEVEL_ID"].Current == 13 && vars.watchers["PATH_ID"].Current == 19) {
				vars.ILtype = 11;
			}
		}

		// RuptureFarms (for both IL and full runs)
		if(vars.watchers["LEVEL_ID"].Current == 1 && vars.watchers["PATH_ID"].Current == 15 && vars.watchers["CAM_ID"].Current == 1) {
			vars.StartgnFrame = vars.watchers["gnFrame"].Current;
			if(settings["UsingIL"]) {
				vars.ILtype = 0;
			}
		}
	}
	
	if (vars.StartgnFrame > 10){ // This should ONLY happen when the autosplitter binds to the game when you start a new game, not when you are restarting the game. 
		vars.n = 0; // SET TO 0. First split if you press on start game
		vars.PauseStartTime = -1;
		vars.MillisecondsPaused = 0;
		vars.PreviousTime = 0;
		vars.StartEpochTime = (DateTime.UtcNow.Ticks - 621355968000000000) / 10000;		
		bool[] trialCheckk = new bool[7]; // 0 = 2-1. 1 = 2-2. 2 = 2-3. 3 = 3-1. 4 = 3-2. 5 = 3-3. 6 = 4-1.
		vars.trialCheck = trialCheckk;
		if (vars.ILtype > -1) {			
			vars.LoadTexts = true;
		}
		
		if (settings["UseDatabase"] && !settings["NoSplitNames"]){
			// WE CREATE ALL NECESSARY DIRECTORIES!
			
			var dir = @"C:\Autosplit Backup Files\Database\Oddworld Abe's Oddysee\";  // folder location
			if (!Directory.Exists(dir)){  // if it doesn't exist, create
				Directory.CreateDirectory(dir);
			}	

			if (settings["SplitsAny%"]){
				dir = @"C:\Autosplit Backup Files\Database\Oddworld Abe's Oddysee\Any%\ID\";  // folder location
				if (!Directory.Exists(dir)){  // if it doesn't exist, create
					Directory.CreateDirectory(dir);
				}		
			
				if (File.Exists(@"C:\Autosplit Backup Files\Database\Oddworld Abe's Oddysee\Any%\ID\" + vars.n + ".txt")) {// AÑADIR EN TODAS LAS OTRAS CATEGORÍAS
					vars.CurrentSplitBestFrame = Int32.Parse(File.ReadAllText(@"C:\Autosplit Backup Files\Database\Oddworld Abe's Oddysee\Any%\ID\" + vars.n + ".txt"));
				} else {
					vars.CurrentSplitBestFrame = 0;
				}					
			}
			
			if (settings["SplitsAny%NMG"]){
				dir = @"C:\Autosplit Backup Files\Database\Oddworld Abe's Oddysee\Any% NMG\ID\";  // folder location
				if (!Directory.Exists(dir)){  // if it doesn't exist, create
					Directory.CreateDirectory(dir);
				}	
			
				if (File.Exists(@"C:\Autosplit Backup Files\Database\Oddworld Abe's Oddysee\Any% NMG\ID\" + vars.n + ".txt")) {// AÑADIR EN TODAS LAS OTRAS CATEGORÍAS
					vars.CurrentSplitBestFrame = Int32.Parse(File.ReadAllText(@"C:\Autosplit Backup Files\Database\Oddworld Abe's Oddysee\Any% NMG\ID\" + vars.n + ".txt"));
				} else {
					vars.CurrentSplitBestFrame = 0;
				}				
			}
			
			if (settings["Splits100%"]){
				dir = @"C:\Autosplit Backup Files\Database\Oddworld Abe's Oddysee\100%\ID\";  // folder location
				if (!Directory.Exists(dir)){  // if it doesn't exist, create
					Directory.CreateDirectory(dir);
				}		
			}
			
			if (settings["SplitsGoodEnding"]){
				dir = @"C:\Autosplit Backup Files\Database\Oddworld Abe's Oddysee\Good Ending\ID\";  // folder location
				if (!Directory.Exists(dir)){  // if it doesn't exist, create
					Directory.CreateDirectory(dir);
				}		
			}
			
			if (settings["UsingIL"]){
				dir = @"C:\Autosplit Backup Files\Database\Oddworld Abe's Oddysee\Individual Levels\ID\";  // folder location
				if (!Directory.Exists(dir)){  // if it doesn't exist, create
					Directory.CreateDirectory(dir);
				}		
			}
			vars.FramesUpToPreviousFrame = 0;			
			vars.DB_LOST_FRAMES_TOTAL = 0;
			vars.DB_GOLD_FRAMES_TOTAL = 0;
		} else {			
			vars.DB_CURRENT_SPLIT = "SPLIT DATABASE FEATURE is off! :(";
			vars.DB_PREVIOUS_SPLIT = "SPLIT DATABASE FEATURE is off! :'(";		
			vars.DB_LOST_FRAMES_TOTAL = "SPLIT DATABASE FEATURE is off! :[";
			vars.DB_GOLD_FRAMES_TOTAL = "SPLIT DATABASE FEATURE is off! :c";
		}
		return true;		
	}	
}

// ##########################################

exit
{	
	if (vars.gnBeforeMainMenu > 0) { // Did we go back to the main menu? :/
		vars.PreviousTime = ((vars.gnBeforeMainMenu - vars.StartgnFrame) * 1000 / vars.fps) + vars.MillisecondsPaused + vars.PreviousTime; // Backup for keeping the previous time in Oddysee incase of a game crash.
	} else { // If we just closed the game.
		vars.PreviousTime = ((vars.gnFrameCurrent - vars.StartgnFrame) * 1000 / vars.fps) + vars.MillisecondsPaused + vars.PreviousTime; // Backup for keeping the previous time in Oddysee incase of a game crash.
	}	
	vars.StartgnFrame = 0;
	vars.SPLIT_INFO = "Game has closed.";
}

reset
{
	if (vars.watchers["LEVEL_ID"].Current == 0 && vars.watchers["CAM_ID"].Old == 1 && (vars.watchers["CAM_ID"].Current == 21 || vars.watchers["CAM_ID"].Current == 31)){
		vars.StartgnFrame = 0;
		vars.PauseStartTime = -1;
		return true;
	}
}

gameTime
{
	TimeSpan gameTimeTimeSpan;

	if (vars.watchers["gnFrame"].Current > 0) {
		vars.REAL_TIME = TimeSpan.Parse(System.Convert.ToString(timer.CurrentTime.RealTime)).ToString(@"h\:mm\:ss\.fff");
		if (vars.StartgnFrame == 0) { // So the IGT doesn't look like it decrements upon loading a save after restarting the game
			vars.GNFrame = 0;
		} else if (vars.watchers["LEVEL_ID"].Current == 0){ // So the IGT doesn't increment while on main menu
			vars.GNFrame = vars.gnBeforeMainMenu - vars.StartgnFrame;
		} else {
			vars.GNFrame = vars.watchers["gnFrame"].Current - vars.StartgnFrame;
		}
		
		if (settings["UseDatabase"] && !settings["NoSplitNames"]){
			if (vars.CurrentSplitBestFrame > 0) {
				vars.DB_CURRENT_SPLIT = (vars.GNFrame - vars.FramesUpToPreviousFrame) + " / " + vars.CurrentSplitBestFrame;
			} else {
				vars.DB_CURRENT_SPLIT = (vars.GNFrame - vars.FramesUpToPreviousFrame) + " / ????";
			}
		} 
		
		if (vars.watchers["IsGameRunning"].Current == 1){ // if the game is paused...
			gameTimeTimeSpan = TimeSpan.FromMilliseconds(((vars.GNFrame) * 1000 / vars.fps) + vars.MillisecondsPaused + (vars.Epoch - vars.PauseStartTime) + vars.PreviousTime);
		} else {
			gameTimeTimeSpan = TimeSpan.FromMilliseconds(((vars.GNFrame) * 1000 / vars.fps) + vars.MillisecondsPaused + vars.PreviousTime);
		}

		vars.LOADLESS_TIME = gameTimeTimeSpan.ToString(@"h\:mm\:ss\.fff");
		vars.REAL_TIME_AND_LOADLESS_TIME = "Real time = " + vars.REAL_TIME + " \nLoadless time = " + vars.LOADLESS_TIME;
		return gameTimeTimeSpan;
	}
}

isLoading
{				
	return true;
}

split
{		
	int LEVEL_ID = -1;
	int O_PATH_ID = -1;
	int C_PATH_ID = -1;
	int O_CAM_ID = -1;
	int C_CAM_ID = -1;
	int abeY = -1;
	long gnFrame = -1;
	int IsGameBeaten = -1;	
	vars.DBSplit = false;
	
	LEVEL_ID = vars.watchers["LEVEL_ID"].Current;
	O_PATH_ID = vars.watchers["PATH_ID"].Old;
	C_PATH_ID = vars.watchers["PATH_ID"].Current;
	O_CAM_ID = vars.watchers["CAM_ID"].Old;
	C_CAM_ID = vars.watchers["CAM_ID"].Current;
	abeY = vars.watchers["abeY"].Current;
	gnFrame = vars.watchers["gnFrame"].Current;
	IsGameBeaten = vars.watchers["IsGameBeaten"].Current;

	if (gnFrame >= 0){		
	
		vars.gnFrameCurrent = gnFrame;
				
		if (LEVEL_ID == 8 && vars.n > 8 && vars.n < 15 && vars.ParamoniaFirst){
			vars.ParamoniaFirst = false;
			vars.LoadTexts = true;
		}

		if (settings["UsingAutosplit"]){
			if (settings["SplitsAny%"]){
				if (vars.n <= 3){ // RuptureFarms 0-3
				// RF First part
					if (LEVEL_ID == 1 && C_CAM_ID == 1 && C_PATH_ID == 16 && vars.n == 0) {
						if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[vars.n]						
							vars.splitName = vars.DatabaseName[vars.n];
							vars.DBSplit = true;
						} else {
							++vars.n;
							return true;
						}
					}
				// RF Second part
					if (LEVEL_ID == 1 && C_CAM_ID == 10 && C_PATH_ID == 18 && vars.n == 1) {
						if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[vars.n]						
							vars.splitName = vars.DatabaseName[vars.n];
							vars.DBSplit = true;
						} else {
							++vars.n;
							return true;
						}
					}
				// RF Third part
					if (LEVEL_ID == 1 && C_CAM_ID == 1 && C_PATH_ID == 19 && vars.n == 2) {
						if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[vars.n]						
							vars.splitName = vars.DatabaseName[vars.n];
							vars.DBSplit = true;
						} else {
							++vars.n;
							return true;
						}
					}
				// RuptureFarms
					if (LEVEL_ID == 5 && C_CAM_ID == 6 && C_PATH_ID == 6 && vars.n == 3) {
						if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[vars.n]						
							vars.splitName = vars.DatabaseName[vars.n];
							vars.DBSplit = true;
						} else {
							++vars.n;
							return true;
						}
					}
				}

				if (vars.n >= 4 && vars.n <= 6){ // Stockyards 4-6
				// S Scrab part
					if (LEVEL_ID == 5 && C_CAM_ID == 1 && C_PATH_ID == 1 && vars.n == 4) {
						if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[vars.n]						
							vars.splitName = vars.DatabaseName[vars.n];
							vars.DBSplit = true;
						} else {
							++vars.n;
							return true;
						}
					}
				// S Slig Part
					if (LEVEL_ID == 5 && C_CAM_ID == 1 && C_PATH_ID == 4 && vars.n == 5) {
						if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[vars.n]						
							vars.splitName = vars.DatabaseName[vars.n];
							vars.DBSplit = true;
						} else {
							++vars.n;
							return true;
						}
					}
				// Stockyards
					if (LEVEL_ID == 2 && C_CAM_ID == 14 && C_PATH_ID == 1 && vars.n == 6) {
						if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[vars.n]						
							vars.splitName = vars.DatabaseName[vars.n];
							vars.DBSplit = true;
						} else {
							++vars.n;
							return true;
						}
					}
				}
				
				if (vars.n >= 7 && vars.n <= 9){ // Monsaic Lines
				// ML Slig part
					if (LEVEL_ID == 2 && C_CAM_ID == 8 && C_PATH_ID == 2 && vars.n == 7) {
						if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[vars.n]						
							vars.splitName = vars.DatabaseName[vars.n];
							vars.DBSplit = true;
						} else {
							++vars.n;
							return true;
						}
					}
				// ML DDG Bees
					if (LEVEL_ID == 2 && C_CAM_ID == 1 && C_PATH_ID == 6 && vars.n == 8) {
						if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[vars.n]						
							vars.splitName = vars.DatabaseName[vars.n];
							vars.DBSplit = true;
						} else {
							++vars.n;
							return true;
						}
					}
				// Monsaic Lines
					if (LEVEL_ID == 6 && C_CAM_ID == 7 && C_PATH_ID == 4 && vars.n == 9) {
						if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[vars.n]						
							vars.splitName = vars.DatabaseName[vars.n];
							vars.DBSplit = true;
						} else {
							++vars.n;
							return true;
						}
					}
				}
				
				if (vars.n == 10 || vars.n == 11){ // Return to RuptureFarms
				// RtR First Part
					if (LEVEL_ID == 6 && C_CAM_ID == 4 && C_PATH_ID == 2 && vars.n == 10) {
						if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[vars.n]						
							vars.splitName = vars.DatabaseName[vars.n];
							vars.DBSplit = true;
						} else {
							++vars.n;
							return true;
						}
					}
				// Return to Rupturefarms
					if (LEVEL_ID == 13 && C_CAM_ID == 3 && C_PATH_ID == 19 && vars.n == 11) {
						if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[vars.n]						
							vars.splitName = vars.DatabaseName[vars.n];
							vars.DBSplit = true;
						} else {
							++vars.n;
							return true;
						}
					}
				}	
				
				if (vars.n >= 12 && vars.n <= 17){ // Zulags
				// Zulag I
					if (LEVEL_ID == 13 && C_CAM_ID == 4 && C_PATH_ID == 1 && vars.n == 12) {
						if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[vars.n]						
							vars.splitName = vars.DatabaseName[vars.n];
							vars.DBSplit = true;
						} else {
							++vars.n;
							return true;
						}
					}
				// Zulag II
					if (LEVEL_ID == 13 && C_CAM_ID == 5 && C_PATH_ID == 13 && vars.n == 13) {
						if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[vars.n]						
							vars.splitName = vars.DatabaseName[vars.n];
							vars.DBSplit = true;
						} else {
							++vars.n;
							return true;
						}
					}
					
				// Zulag III
					if (LEVEL_ID == 13 && C_CAM_ID == 5 && C_PATH_ID == 14 && vars.n == 14) {
						if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[vars.n]						
							vars.splitName = vars.DatabaseName[vars.n];
							vars.DBSplit = true;
						} else {
							++vars.n;
							return true;
						}
					}
					
				// Slog Kennels
					if (LEVEL_ID == 13 && C_CAM_ID == 6 && C_PATH_ID == 4 && O_PATH_ID == 8 && vars.n == 15) {
						if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[vars.n]						
							vars.splitName = vars.DatabaseName[vars.n];
							vars.DBSplit = true;
						} else {
							++vars.n;
							return true;
						}
					}
					
				// Main Section
					if (LEVEL_ID == 13 && C_CAM_ID == 1 && C_PATH_ID == 11 && vars.n == 16) {
						if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[vars.n]						
							vars.splitName = vars.DatabaseName[vars.n];
							vars.DBSplit = true;
						} else {
							++vars.n;
							return true;
						}
					}
					
				// Zulag IV
					if (LEVEL_ID == 12 && C_CAM_ID == 2 && C_PATH_ID == 6 && abeY > 235 && vars.n == 17) {
						if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[vars.n]						
							vars.splitName = vars.DatabaseName[vars.n];
							vars.DBSplit = true;
						} else {
							++vars.n;
							return true;
						}
					}					
				}
			
			
			} else if (settings["SplitsAny%NMG"]){
				if (vars.n <= 3){ // RuptureFarms 0-3
				// Tutorials
					if (LEVEL_ID == 1 && C_CAM_ID == 1 && C_PATH_ID == 16 && vars.n == 0) {
						if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[0]						
							vars.splitName = vars.DatabaseName[vars.n];
							vars.DBSplit = true;
						} else {
							++vars.n;
							return true;
						}
					}
				// Meat grinder
					if (LEVEL_ID == 1 && C_CAM_ID == 10 && C_PATH_ID == 18 && vars.n == 1) {
						if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[1]						
							vars.splitName = vars.DatabaseName[vars.n];
							vars.DBSplit = true;
						} else {
							++vars.n;
							return true;
						}
					}
				// Sligs
					if (LEVEL_ID == 1 && C_CAM_ID == 1 && C_PATH_ID == 19 && vars.n == 2) {
						if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[2]									
							vars.splitName = vars.DatabaseName[2];
							vars.DBSplit = true;
						} else {
							++vars.n;
							return true;
						}
					}
				// RuptureFarms
					if (LEVEL_ID == 5 && C_CAM_ID == 6 && C_PATH_ID == 6 && vars.n == 3) {
						if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[3]					
							vars.splitName = vars.DatabaseName[3];
							vars.DBSplit = true;
						} else {
							++vars.n;
							return true;
						}
					}
				}
				
				if (vars.n >= 4 && vars.n <= 6){ // Stockyards 4-6
				// Scrab part
					if (LEVEL_ID == 5 && C_CAM_ID == 1 && C_PATH_ID == 1 && vars.n == 4) {
						if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[4]								
							vars.splitName = vars.DatabaseName[4];
							vars.DBSplit = true;
						} else {
							++vars.n;
							return true;
						}
					}
				// Slig Part
					if (LEVEL_ID == 5 && C_CAM_ID == 1 && C_PATH_ID == 4 && vars.n == 5) {
						if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[5]								
							vars.splitName = vars.DatabaseName[5];
							vars.DBSplit = true;
						} else {
							++vars.n;
							return true;
						}
					}
				// Stockyards
					if (LEVEL_ID == 2 && C_CAM_ID == 14 && C_PATH_ID == 1 && vars.n == 6) {
						if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[6]							
							vars.splitName = vars.DatabaseName[6];
							vars.DBSplit = true;
						} else {
							++vars.n;
							return true;
						}
					}
				}
				
				if (vars.n == 7 || vars.n == 8){ // Monsaic Lines
				// Natives
					if (LEVEL_ID == 2 && C_CAM_ID == 8 && C_PATH_ID == 2 && vars.n == 7) {
						if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[7]								
							vars.splitName = vars.DatabaseName[7];
							vars.DBSplit = true;
						} else {
							++vars.n;
							return true;
						}
					}
				// Monsaic Lines (to Paramonia)
					if (LEVEL_ID == 3 && C_CAM_ID == 1 && C_PATH_ID == 1 && vars.n == 8) {
						vars.ParamoniaFirst = true;
						if (!settings["NoLog"]){ 
							vars.LoadTexts = true; // We make sure that the texts are updated to be Paramonia first.
						}
						if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[8]								
							vars.splitName = vars.DatabaseName[8];
							vars.DBSplit = true;
						} else {
							++vars.n;
							return true;
						}
					}
					
				// Monsaic Lines (to Scrabania)
					if (LEVEL_ID == 8 && C_CAM_ID == 1 && C_PATH_ID == 1 && vars.n == 8) {								
						vars.ParamoniaFirst = false;
						if (!settings["NoLog"]){ 
							vars.LoadTexts = true; // We make sure that the texts are updated to be Scrabania first.
						}
						if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[9]							
							vars.splitName = vars.DatabaseName[9];
							vars.DBSplit = true;
						} else {
							++vars.n;
							return true;
						}
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
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[10]							
								vars.splitName = vars.DatabaseName[10];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}
						}
						
					// Honey and Sligs
						if (LEVEL_ID == 3 && C_CAM_ID == 9 && C_PATH_ID == 5 && vars.n == 10) {
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[11]								
								vars.splitName = vars.DatabaseName[11];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}
						}
						
					// Platforms and Bees
						if (LEVEL_ID == 3 && C_CAM_ID == 1 && C_PATH_ID == 6 && vars.n == 11) {
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[12]								
								vars.splitName = vars.DatabaseName[12];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}
						}
						
					// Passwords and Sligs
						if (LEVEL_ID == 3 && C_CAM_ID == 1 && C_PATH_ID == 9 && vars.n == 12) {
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[13]								
								vars.splitName = vars.DatabaseName[13];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}
						}
						
					// Paramonia
						if (LEVEL_ID == 4 && C_CAM_ID == 1 && C_PATH_ID == 1 && vars.n == 13) {
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[14]								
								vars.splitName = vars.DatabaseName[14];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}
						}	
					
					
					if (LEVEL_ID == 4 && C_PATH_ID == 1 && vars.n <= 13) { // Split if the autosplitter gets stuck and the runner gets inside Paramonian temple (entry)
						if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[14]								
							vars.splitName = vars.DatabaseName[14];
							vars.DBSplit = true;
						} else {
							++vars.n;
							return true;
						}	
					} else {
						if (LEVEL_ID == 4 && C_PATH_ID > 1 && vars.n < 15) { // Split if the autosplitter gets stuck and the runner gets inside Paramonian temple (AFTER entry)
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[14]								
								vars.splitName = vars.DatabaseName[14];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}
						}
					}
				}
					
					if (vars.n >= 14 && vars.n <= 22){ // Paramonian Temple
					// Entry
						if (LEVEL_ID == 4 && C_CAM_ID == 1 && C_PATH_ID == 8 && vars.n == 14) {
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[15]							
								vars.splitName = vars.DatabaseName[15];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}	
						}
						
					// Trial 1
						if (C_PATH_ID == 8 && O_PATH_ID == 4 && O_CAM_ID == 6) { // https://i.imgur.com/CThhUM5.jpg
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[16]							
								vars.splitName = vars.DatabaseName[16];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}	
						}
						
					// Trial 2
						if (C_PATH_ID == 8 && O_PATH_ID == 2 && O_CAM_ID == 8) { // https://i.imgur.com/C1CPF36.jpg
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[17]							
								vars.splitName = vars.DatabaseName[17];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}	
						}
						
					// Trial 3 (now it's 5)
						if (C_PATH_ID == 8 && O_PATH_ID == 6 && O_CAM_ID == 7) { // https://i.imgur.com/A8IVuGp.jpg
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[20]							
								vars.splitName = vars.DatabaseName[20];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}	
						}
						
					// Trial 4 (now it's 6)
						if (C_PATH_ID == 8 && O_PATH_ID == 7 && O_CAM_ID == 5) { // https://i.imgur.com/lPrWDD2.jpg
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[21]							
								vars.splitName = vars.DatabaseName[21];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}	
						}
						
					// Trial 5  (now it's 3)
						if (C_PATH_ID == 8 && O_PATH_ID == 5 && O_CAM_ID == 2) { // https://i.imgur.com/ku9rf3g.jpg
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[18]							
								vars.splitName = vars.DatabaseName[18];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}	
						}
						
					// Trial 6 (now it's 4)
						if (C_PATH_ID == 8 && O_PATH_ID == 3 && O_CAM_ID == 1) { // https://i.imgur.com/LtYPFNm.jpg
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[19]							
								vars.splitName = vars.DatabaseName[19];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}	
						}
						
					// Paramonian Nests 
						if (LEVEL_ID == 2 && C_CAM_ID == 4 && C_PATH_ID == 5 && vars.n >= 15 && vars.n <= 21) { // 15 / 06 / 2020 - Fix to prevent getting stuck if a trial doesn't split
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[22]							
								vars.splitName = vars.DatabaseName[22];
								vars.DBSplit = true;
								vars.n = 21; // The fix itself
							} else {
								++vars.n;
								return true;
							}	
						}
						
					// Paramonian Temple 
						if (LEVEL_ID == 8 && C_CAM_ID == 1 && C_PATH_ID == 1 && vars.n == 22) {
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[23]							
								vars.splitName = vars.DatabaseName[23];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}	
						}
					}		
					
					if (vars.n >= 23 && vars.n <= 25){ // Scrabania
					// Get Elum
						if (LEVEL_ID == 8 && C_CAM_ID == 1 && C_PATH_ID == 2 && vars.n == 23) {
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[24]							
								vars.splitName = vars.DatabaseName[24];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}	
						}
						
					// Play with Mines
						if (LEVEL_ID == 8 && C_CAM_ID == 5 && C_PATH_ID == 8 && vars.n == 24) {
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[25]							
								vars.splitName = vars.DatabaseName[25];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}	
						}
						
					// Scrabania
						if (LEVEL_ID == 9 && C_CAM_ID == 1 && C_PATH_ID == 1 && vars.n == 25) {
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[26]							
								vars.splitName = vars.DatabaseName[26];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}	
						}
					}	
										
					if (vars.n >= 26 && vars.n <= 36){ // Scrabania Temple
					// Entry
						if (LEVEL_ID == 9 && C_CAM_ID == 1 && C_PATH_ID == 10 && vars.n == 26) {
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[27]							
								vars.splitName = vars.DatabaseName[27];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}	
						}
					// Trial 1
						if (O_PATH_ID == 9 && C_PATH_ID == 10 && O_CAM_ID == 5) { // https://i.imgur.com/VUTQJ5R.jpg
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[28]							
								vars.splitName = vars.DatabaseName[28];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}	
						}
					// Trial 2
						if (O_PATH_ID == 2 && C_PATH_ID == 10 && O_CAM_ID == 4) { // https://i.imgur.com/mtbUcdr.jpg
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[29]							
								vars.splitName = vars.DatabaseName[29];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}	
						}
					// Trial 3
						if (O_PATH_ID == 3 && C_PATH_ID == 10 && O_CAM_ID == 5) { // https://i.imgur.com/09DtCCn.jpg
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[30]							
								vars.splitName = vars.DatabaseName[30];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}	
						}
					// Trial 4
						if (O_PATH_ID == 5 && C_PATH_ID == 10 && O_CAM_ID == 8) { // https://i.imgur.com/qjAxMzI.jpg
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[31]							
								vars.splitName = vars.DatabaseName[31];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}	
						}
					// Trial 5
						if (O_PATH_ID == 4 && C_PATH_ID == 10 && O_CAM_ID == 5) { // https://i.imgur.com/8BxoUsw.jpg
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[33]							
								vars.splitName = vars.DatabaseName[33];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}	
						}
					// Trial 6
						if (O_PATH_ID == 7 && C_PATH_ID == 10 && O_CAM_ID == 1) { // https://i.imgur.com/WHeaT7j.jpg
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[32]							
								vars.splitName = vars.DatabaseName[32];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}	
						}
					// Trial 7
						if (O_PATH_ID == 6 && C_PATH_ID == 10 && O_CAM_ID == 4) { // https://i.imgur.com/NkzyNWh.jpg
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[34]							
								vars.splitName = vars.DatabaseName[34];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}	
						}
					// Trial 8
						if (O_PATH_ID == 8 && C_PATH_ID == 10 && O_CAM_ID == 4) { // https://i.imgur.com/lX7IQg3.jpg
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[35]							
								vars.splitName = vars.DatabaseName[35];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}	
						}
					// Scrabanian Nests
						if (LEVEL_ID == 2 && C_CAM_ID == 4 && C_PATH_ID == 5 && vars.n >= 27 && vars.n <= 35) {
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[36]							
								vars.splitName = vars.DatabaseName[36];
								vars.DBSplit = true;
								vars.n = 35; // Security Measure
							} else {
								++vars.n;
								return true;
							}	
						}
					// Scrabania Temple to FFZ
						if (LEVEL_ID == 6 && C_CAM_ID == 7 && C_PATH_ID == 4 && vars.n == 36) { // Entry Free Fire Zone - Change
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[37]							
								vars.splitName = vars.DatabaseName[37];
								vars.DBSplit = true;
								vars.n = 36; // Security Measure
							} else {
								++vars.n;
								return true;
							}	
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
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[24]							
								vars.splitName = vars.DatabaseName[24];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}	
						}
						
					// Play with Mines
						if (LEVEL_ID == 8 && C_CAM_ID == 5 && C_PATH_ID == 8 && vars.n == 10) {
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[25]							
								vars.splitName = vars.DatabaseName[25];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}	
						}
						
					// Scrabania
						if (LEVEL_ID == 9 && C_CAM_ID == 1 && C_PATH_ID == 1 && vars.n == 11) {
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[26]							
								vars.splitName = vars.DatabaseName[26];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}	
						}
					}	
					
					if (vars.n >= 12 && vars.n <= 22){ // Scrabania Temple
					// Entry
						if (LEVEL_ID == 9 && C_CAM_ID == 1 && C_PATH_ID == 10 && vars.n == 12) {
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[27]							
								vars.splitName = vars.DatabaseName[27];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}	
						}
						
					// Trial 1
						if (O_PATH_ID == 9 && C_PATH_ID == 10 && O_CAM_ID == 5) { // https://i.imgur.com/VUTQJ5R.jpg
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[28]							
								vars.splitName = vars.DatabaseName[28];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}	
						}
						
					// Trial 2
						if (O_PATH_ID == 2 && C_PATH_ID == 10 && O_CAM_ID == 4) { // https://i.imgur.com/mtbUcdr.jpg
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[29]							
								vars.splitName = vars.DatabaseName[29];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}	
						}
						
					// Trial 3
						if (O_PATH_ID == 3 && C_PATH_ID == 10 && O_CAM_ID == 5) { // https://i.imgur.com/09DtCCn.jpg
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[30]							
								vars.splitName = vars.DatabaseName[30];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}	
						}
						
					// Trial 4
						if (O_PATH_ID == 5 && C_PATH_ID == 10 && O_CAM_ID == 8) { // https://i.imgur.com/qjAxMzI.jpg
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[31]							
								vars.splitName = vars.DatabaseName[31];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}	
						}
	
					// Trial 5
						if (O_PATH_ID == 4 && C_PATH_ID == 10 && O_CAM_ID == 5) { // https://i.imgur.com/8BxoUsw.jpg
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[33]							
								vars.splitName = vars.DatabaseName[33];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}	
						}
						
					// Trial 6
						if (O_PATH_ID == 7 && C_PATH_ID == 10 && O_CAM_ID == 1) { // https://i.imgur.com/WHeaT7j.jpg
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[32]							
								vars.splitName = vars.DatabaseName[32];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}	
						}
						
					// Trial 7
						if (O_PATH_ID == 6 && C_PATH_ID == 10 && O_CAM_ID == 4) { // https://i.imgur.com/NkzyNWh.jpg
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[34]							
								vars.splitName = vars.DatabaseName[34];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}	
						}
						
					// Trial 8
						if (O_PATH_ID == 8 && C_PATH_ID == 10 && O_CAM_ID == 4) { // https://i.imgur.com/lX7IQg3.jpg
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[35]							
								vars.splitName = vars.DatabaseName[35];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}	
						}
						
					// Scrabanian Nests
						if (LEVEL_ID == 2 && C_CAM_ID == 4 && C_PATH_ID == 5 && vars.n >= 13 && vars.n <= 21) {
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[36]							
								vars.splitName = vars.DatabaseName[36];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}	
						}
						
					// Scrabania Temple
						if (LEVEL_ID == 3 && C_CAM_ID == 1 && C_PATH_ID == 1 && vars.n == 22) { // From Scrabania to Paramonia.
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[38]							
								vars.splitName = vars.DatabaseName[38];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}	
						}
					}
					
					if (vars.n >= 23 && vars.n <= 27){ // Paramonia
					// Get the Elum
						if (LEVEL_ID == 3 && C_CAM_ID == 1 && C_PATH_ID == 2 && vars.n == 23) {
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[10]							
								vars.splitName = vars.DatabaseName[10];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}	
						}
						
					// Honey and Sligs
						if (LEVEL_ID == 3 && C_CAM_ID == 9 && C_PATH_ID == 5 && vars.n == 24) {
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[11]							
								vars.splitName = vars.DatabaseName[11];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}	
						}
						
					// Platforms and Bees
						if (LEVEL_ID == 3 && C_CAM_ID == 1 && C_PATH_ID == 6 && vars.n == 25) {
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[12]							
								vars.splitName = vars.DatabaseName[12];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}	
						}
						
					// Passwords and Sligs
						if (LEVEL_ID == 3 && C_CAM_ID == 1 && C_PATH_ID == 9 && vars.n == 26) {
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[13]							
								vars.splitName = vars.DatabaseName[13];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}	
						}
						
					// Paramonia
						if (LEVEL_ID == 4 && C_CAM_ID == 1 && C_PATH_ID == 1 && vars.n == 27) {
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[14]							
								vars.splitName = vars.DatabaseName[14];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}	
						}
					}
					
					if (vars.n >= 28 && vars.n <= 36){ // Paramonian Temple
					// Entry
						if (LEVEL_ID == 4 && C_CAM_ID == 1 && C_PATH_ID == 8 && vars.n == 28) {
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[15]							
								vars.splitName = vars.DatabaseName[15];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}	
						}
						
					// Trial 1
						if (C_PATH_ID == 8 && O_PATH_ID == 4 && O_CAM_ID == 6) { // https://i.imgur.com/CThhUM5.jpg
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[16]							
								vars.splitName = vars.DatabaseName[16];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}	
						}
						
					// Trial 2
						if (C_PATH_ID == 8 && O_PATH_ID == 2 && O_CAM_ID == 8) { // https://i.imgur.com/C1CPF36.jpg
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[17]							
								vars.splitName = vars.DatabaseName[17];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}	
						}
						
					// Trial 3
						if (C_PATH_ID == 8 && O_PATH_ID == 6 && O_CAM_ID == 7) { // https://i.imgur.com/A8IVuGp.jpg
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[20]							
								vars.splitName = vars.DatabaseName[20];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}	
						}
						
					// Trial 4
						if (C_PATH_ID == 8 && O_PATH_ID == 7 && O_CAM_ID == 5) { // https://i.imgur.com/lPrWDD2.jpg
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[21]							
								vars.splitName = vars.DatabaseName[21];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}	
						}
						
					// Trial 5
						if (C_PATH_ID == 8 && O_PATH_ID == 5 && O_CAM_ID == 2) { // https://i.imgur.com/ku9rf3g.jpg
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[18]							
								vars.splitName = vars.DatabaseName[18];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}	
						}
						
					// Trial 6
						if (C_PATH_ID == 8 && O_PATH_ID == 3 && O_CAM_ID == 1) { // https://i.imgur.com/LtYPFNm.jpg
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[19]							
								vars.splitName = vars.DatabaseName[19];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}	
						}
						
					// Paramonian Nests 
						if (LEVEL_ID == 2 && C_CAM_ID == 4 && C_PATH_ID == 5 && vars.n >= 29 && vars.n <= 35) { // 15 / 06 / 2020 - Fix to prevent getting stuck if a trial doesn't split
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[22]							
								vars.splitName = vars.DatabaseName[22];
								vars.DBSplit = true;
								vars.n = 35;
							} else {
								++vars.n;
								return true;
							}	
						}
						
					// Paramonian Temple to FFZ
						if (LEVEL_ID == 6 && C_CAM_ID == 7 && C_PATH_ID == 4 && vars.n == 36) {
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[39]							
								vars.splitName = vars.DatabaseName[39];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}	
						}
					}
				}
				
				if (vars.n == 37 || vars.n == 38){ // Zulag 1
				 // Free Fire Zone
					if (LEVEL_ID == 13 && C_CAM_ID == 3 && C_PATH_ID == 19 && vars.n == 37) {
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[40]							
								vars.splitName = vars.DatabaseName[40];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}	
						}
					
				// Zulag 1
					if (LEVEL_ID == 13 && C_CAM_ID == 4 && C_PATH_ID == 1 && vars.n == 38) {
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[41]							
								vars.splitName = vars.DatabaseName[41];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}	
						}
				}
				
				if (vars.n >= 39 && vars.n <= 43){ // Zulag 2
				// Entry
					if (LEVEL_ID == 13 && C_CAM_ID == 3 && C_PATH_ID == 1 && vars.n == 39) {
						if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[42]							
							vars.splitName = vars.DatabaseName[42];
							vars.DBSplit = true;
						} else {
							++vars.n;
							return true;
						}	
					}
					
				// Door 1 (now is trial 3)
					if (C_PATH_ID == 2 && C_CAM_ID == 4 && vars.trialCheck[0] != true){ // Door 1 check
						vars.trialCheck[0] = true;
					}
					
					if (O_PATH_ID == 2 && C_PATH_ID == 1 && vars.trialCheck[0] == true) {
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[45]							
								vars.splitName = vars.DatabaseName[45];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}	
						}
					
				// Door 2		
					if (C_PATH_ID == 10 && C_CAM_ID == 5 && vars.trialCheck[1] != true){ // Door 2 check
						vars.trialCheck[1] = true;
					}
					
					if (O_PATH_ID == 10 && C_PATH_ID == 1 && vars.trialCheck[1] == true) {
						if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[44]							
							vars.splitName = vars.DatabaseName[44];
							vars.DBSplit = true;
						} else {
							++vars.n;
							return true;
						}	
					}
					
				// Door 3 (now is trial 1)		
					if (C_PATH_ID == 3 && C_CAM_ID == 5 && vars.trialCheck[2] != true){ // Door 3 check
						vars.trialCheck[2] = true;
					}
					
					if (O_PATH_ID == 3 && C_PATH_ID == 1 && vars.trialCheck[2] == true) {
						if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[43]							
							vars.splitName = vars.DatabaseName[43];
							vars.DBSplit = true;
						} else {
							++vars.n;
							return true;
						}	
					}
					
				// Zulag 2
					if (LEVEL_ID == 13 && C_CAM_ID == 5 && C_PATH_ID == 13) {
						if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[46]							
							vars.splitName = vars.DatabaseName[46];
							vars.DBSplit = true;
							vars.n = 43;
						} else {
							++vars.n;
							return true;
						}	
					}
				}
				
				if (vars.n >= 44 && vars.n <= 48){ // Zulag 3
				// Entry
					if (LEVEL_ID == 13 && C_CAM_ID == 4 && C_PATH_ID == 13 && vars.n == 44) {
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[47]							
								vars.splitName = vars.DatabaseName[47];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}	
						}
					
				// Door 1
					if (C_PATH_ID == 9 && C_CAM_ID == 2 && vars.trialCheck[3] != true){ // Door 1 check
						vars.trialCheck[3] = true;
					}
					
					if (O_PATH_ID == 12 && C_PATH_ID == 13 && vars.trialCheck[3] == true) {
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[48]							
								vars.splitName = vars.DatabaseName[48];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}	
						}
					
					
				// Door 2	
				
					if (C_PATH_ID == 7 && C_CAM_ID == 9 && vars.trialCheck[4] != true){ // Door 2 check
						vars.trialCheck[4] = true;
					}			
					if (O_PATH_ID == 7 && C_PATH_ID == 13 && vars.trialCheck[4] == true) {
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[49]							
								vars.splitName = vars.DatabaseName[49];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}	
						}
					
					
				// Door 3
					if (C_PATH_ID == 5 && C_CAM_ID == 4 && vars.trialCheck[5] != true){ // Door 3 check
						vars.trialCheck[5] = true;
					}
					
					if (O_PATH_ID == 5 && C_PATH_ID == 13 && vars.trialCheck[5] == true) {
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[50]							
								vars.splitName = vars.DatabaseName[50];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}	
						}
					
				// Zulag 3
					if (LEVEL_ID == 13 && C_CAM_ID == 5 && C_PATH_ID == 14) {
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[51]							
								vars.splitName = vars.DatabaseName[51];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}	
						}
				}
				
				if (vars.n >= 49 && vars.n <= 52){ // Zulag 4
				// Enter Slog Kennels
					if (LEVEL_ID == 13 && C_CAM_ID == 1 && C_PATH_ID == 8 && vars.n == 49) {
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[52]							
								vars.splitName = vars.DatabaseName[52];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}	
						}
					
				// Leave Slog Kennels
					if (C_PATH_ID == 8 && C_CAM_ID == 5 && vars.trialCheck[6] != true){ // Slog Kennels check
						vars.trialCheck[6] = true;
					}
					
					if (LEVEL_ID == 13 && C_CAM_ID == 6 && C_PATH_ID == 4 && vars.n == 50 && vars.trialCheck[6] == true) {
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[53]							
								vars.splitName = vars.DatabaseName[53];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}	
						}
					
				// Enter Second Part
					if (LEVEL_ID == 13 && C_CAM_ID == 1 && C_PATH_ID == 11 && vars.n == 51) {
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[54]							
								vars.splitName = vars.DatabaseName[54];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}	
						}
					
				// Zulag 4
					if (LEVEL_ID == 12 && C_CAM_ID == 2 && C_PATH_ID == 6 && abeY > 235 && vars.n == 52) {
							if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[55]							
								vars.splitName = vars.DatabaseName[55];
								vars.DBSplit = true;
							} else {
								++vars.n;
								return true;
							}	
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
					
					// Scrabania Temple to paramonia
						if (LEVEL_ID == 3 && C_CAM_ID == 1 && C_PATH_ID == 1 && vars.n == 22) { // Entry Paramonia
							++vars.n;
							return true;
						}
						
					// Scrabania Temple to FFZ (DDG WAY)
						if (LEVEL_ID == 6 && C_CAM_ID == 7 && C_PATH_ID == 4 && vars.n == 22) {
							vars.n = 37;
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
					
				// Monsaic Lines (to FFZ, DDG WAY BABY!!)
					if (LEVEL_ID == 6 && C_CAM_ID == 7 && C_PATH_ID == 4 && vars.n == 8) {
						vars.n = 37;		
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
					vars.REAL_TIME = TimeSpan.Parse(System.Convert.ToString(timer.CurrentTime.RealTime)).ToString(@"h\:mm\:ss\.fff");
					vars.LOADLESS_TIME = TimeSpan.FromMilliseconds(((gnFrame - vars.StartgnFrame) * 1000 / vars.fps) + vars.MillisecondsPaused + vars.PreviousTime).ToString(@"h\:mm\:ss\.fff");
					vars.SPLIT_INFO = "RuptureFarms IL is over! IGT: " + vars.LOADLESS_TIME + " | RTA: " + vars.REAL_TIME;
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
					vars.REAL_TIME = TimeSpan.Parse(System.Convert.ToString(timer.CurrentTime.RealTime)).ToString(@"h\:mm\:ss\.fff");
					vars.LOADLESS_TIME = TimeSpan.FromMilliseconds(((gnFrame - vars.StartgnFrame) * 1000 / vars.fps) + vars.MillisecondsPaused + vars.PreviousTime).ToString(@"h\:mm\:ss\.fff");
					vars.SPLIT_INFO = "Stockyards IL is over! IGT: " + vars.LOADLESS_TIME + " | RTA: " + vars.REAL_TIME;
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
					vars.REAL_TIME = TimeSpan.Parse(System.Convert.ToString(timer.CurrentTime.RealTime)).ToString(@"h\:mm\:ss\.fff");
					vars.LOADLESS_TIME = TimeSpan.FromMilliseconds(((gnFrame - vars.StartgnFrame) * 1000 / vars.fps) + vars.MillisecondsPaused + vars.PreviousTime).ToString(@"h\:mm\:ss\.fff");
					vars.SPLIT_INFO = "Paramonia IL is over! IGT: " + vars.LOADLESS_TIME + " | RTA: " + vars.REAL_TIME;
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
					vars.REAL_TIME = TimeSpan.Parse(System.Convert.ToString(timer.CurrentTime.RealTime)).ToString(@"h\:mm\:ss\.fff");
					vars.LOADLESS_TIME = TimeSpan.FromMilliseconds(((gnFrame - vars.StartgnFrame) * 1000 / vars.fps) + vars.MillisecondsPaused + vars.PreviousTime).ToString(@"h\:mm\:ss\.fff");
					vars.SPLIT_INFO = "Scrabania IL is over! IGT: " + vars.LOADLESS_TIME + " | RTA: " + vars.REAL_TIME;
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
						vars.REAL_TIME = TimeSpan.Parse(System.Convert.ToString(timer.CurrentTime.RealTime)).ToString(@"h\:mm\:ss\.fff");
						vars.LOADLESS_TIME = TimeSpan.FromMilliseconds(((gnFrame - vars.StartgnFrame) * 1000 / vars.fps) + vars.MillisecondsPaused + vars.PreviousTime).ToString(@"h\:mm\:ss\.fff");
						vars.SPLIT_INFO = "Zulag 2 IL is over! IGT: " + vars.LOADLESS_TIME + " | RTA: " + vars.REAL_TIME;
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
					vars.REAL_TIME = TimeSpan.Parse(System.Convert.ToString(timer.CurrentTime.RealTime)).ToString(@"h\:mm\:ss\.fff");
					vars.LOADLESS_TIME = TimeSpan.FromMilliseconds(((gnFrame - vars.StartgnFrame) * 1000 / vars.fps) + vars.MillisecondsPaused + vars.PreviousTime).ToString(@"h\:mm\:ss\.fff");
					vars.SPLIT_INFO = "Zulag 3 IL is over! IGT: " + vars.LOADLESS_TIME + " | RTA: " + vars.REAL_TIME;
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
					vars.REAL_TIME = TimeSpan.Parse(System.Convert.ToString(timer.CurrentTime.RealTime)).ToString(@"h\:mm\:ss\.fff");
					vars.LOADLESS_TIME = TimeSpan.FromMilliseconds(((gnFrame - vars.StartgnFrame) * 1000 / vars.fps) + vars.MillisecondsPaused + vars.PreviousTime).ToString(@"h\:mm\:ss\.fff");
					vars.SPLIT_INFO = "Zulag 4 IL is over! IGT: " + vars.LOADLESS_TIME + " | RTA: " + vars.REAL_TIME;
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
				vars.REAL_TIME = TimeSpan.Parse(System.Convert.ToString(timer.CurrentTime.RealTime)).ToString(@"h\:mm\:ss\.fff");
				vars.LOADLESS_TIME = TimeSpan.FromMilliseconds(((gnFrame - vars.StartgnFrame) * 1000 / vars.fps) + vars.MillisecondsPaused + vars.PreviousTime).ToString(@"h\:mm\:ss\.fff");
				vars.SPLIT_INFO = "Monsaic Lines (Any%) IL is over! IGT: " + vars.LOADLESS_TIME + " | RTA: " + vars.REAL_TIME;
				return true;
			}
			
		// Monsaic Lines to Scrabania (OPTIMAL)
			if (LEVEL_ID == 8 && C_CAM_ID == 1 && C_PATH_ID == 1 && vars.n == 2) {
				vars.REAL_TIME = TimeSpan.Parse(System.Convert.ToString(timer.CurrentTime.RealTime)).ToString(@"h\:mm\:ss\.fff");
				vars.LOADLESS_TIME = TimeSpan.FromMilliseconds(((gnFrame - vars.StartgnFrame) * 1000 / vars.fps) + vars.MillisecondsPaused + vars.PreviousTime).ToString(@"h\:mm\:ss\.fff");
				vars.SPLIT_INFO = "Monsaic Lines (NOT Any%) IL is over! IGT: " + vars.LOADLESS_TIME + " | RTA: " + vars.REAL_TIME;
				return true;
			}					
			
		// Monsaic Lines to Paramonia (for special people)
			if (LEVEL_ID == 3 && C_CAM_ID == 1 && C_PATH_ID == 1 && vars.n == 2) {
				vars.REAL_TIME = TimeSpan.Parse(System.Convert.ToString(timer.CurrentTime.RealTime)).ToString(@"h\:mm\:ss\.fff");
				vars.LOADLESS_TIME = TimeSpan.FromMilliseconds(((gnFrame - vars.StartgnFrame) * 1000 / vars.fps) + vars.MillisecondsPaused + vars.PreviousTime).ToString(@"h\:mm\:ss\.fff");
				vars.SPLIT_INFO = "Monsaic Lines (special) IL is over! IGT: " + vars.LOADLESS_TIME + " | RTA: " + vars.REAL_TIME;
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
					vars.REAL_TIME = TimeSpan.Parse(System.Convert.ToString(timer.CurrentTime.RealTime)).ToString(@"h\:mm\:ss\.fff");
					vars.LOADLESS_TIME = TimeSpan.FromMilliseconds(((gnFrame - vars.StartgnFrame) * 1000 / vars.fps) + vars.MillisecondsPaused + vars.PreviousTime).ToString(@"h\:mm\:ss\.fff");
					vars.SPLIT_INFO = "Paramonia IL is over! IGT: " + vars.LOADLESS_TIME + " | RTA: " + vars.REAL_TIME;
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
					vars.REAL_TIME = TimeSpan.Parse(System.Convert.ToString(timer.CurrentTime.RealTime)).ToString(@"h\:mm\:ss\.fff");
					vars.LOADLESS_TIME = TimeSpan.FromMilliseconds(((gnFrame - vars.StartgnFrame) * 1000 / vars.fps) + vars.MillisecondsPaused + vars.PreviousTime).ToString(@"h\:mm\:ss\.fff");
					vars.SPLIT_INFO = "Scrabania Temple IL is over! IGT: " + vars.LOADLESS_TIME + " | RTA: " + vars.REAL_TIME;
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
					vars.REAL_TIME = TimeSpan.Parse(System.Convert.ToString(timer.CurrentTime.RealTime)).ToString(@"h\:mm\:ss\.fff");
					vars.LOADLESS_TIME = TimeSpan.FromMilliseconds(((gnFrame - vars.StartgnFrame) * 1000 / vars.fps) + vars.MillisecondsPaused + vars.PreviousTime).ToString(@"h\:mm\:ss\.fff");
					vars.SPLIT_INFO = "Zulag 1 IL is over! IGT: " + vars.LOADLESS_TIME + " | RTA: " + vars.REAL_TIME;
					return true;
				}	
		} else {
			// :shrug:
		}
		}
	
		// Boardroom
		if (LEVEL_ID == 12 && C_PATH_ID == 6 && C_CAM_ID == 8 && IsGameBeaten == 1) {
			if (settings["UseDatabase"] && !settings["NoSplitNames"]){ // vars.DatabaseName[vars.n]							
				vars.splitName = vars.DatabaseName[vars.n];
				vars.DBSplit = true;
			} else {
				++vars.n;
				vars.SPLIT_INFO = "The run is over!\nTime: " + timer.CurrentTime.RealTime;	
				return true;
			}			
		}
	}
		
	//##########################################################


	// Other functions not related with splits whatsoever.
		
		vars.variables = vars.version + "-> LEVEL " + LEVEL_ID + " | PATH " + C_PATH_ID + " | CAM " + C_CAM_ID + " | " + vars.GNFrame; // For programming purposes c·:
		
	} else {
		
		// ENGLISH
		if (vars.watchers["LEVEL_ID"].Old == 0 && vars.watchers["PATH_ID"].Old == 1 && vars.watchers["CAM_ID"].Old == 21 && vars.watchers["LEVEL_ID"].Current == 1 && vars.watchers["PATH_ID"].Current == 15 && vars.watchers["CAM_ID"].Current == 1) {
			vars.n = 0; // First split if you press on start game
			vars.SkippedFrames = 0;
			vars.StartgnFrame = vars.watchers["gnFrame"].Current;
			vars.MillisecondsPaused = 0;
			vars.StartEpochTime = (DateTime.UtcNow.Ticks - 621355968000000000) / 10000;			
			if (settings["UseDatabase"] && !settings["NoSplitNames"]){
				if (File.Exists(@"C:\Autosplit Backup Files\Database\Oddworld Abe's Oddysee\Any% NMG\ID\" + vars.n + ".txt")) {
					vars.CurrentSplitBestFrame = Int32.Parse(File.ReadAllText(@"C:\Autosplit Backup Files\Database\Oddworld Abe's Oddysee\Any% NMG\ID\" + vars.n + ".txt"));
				}
			}
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
		} else if (settings["SplitsAny%NMG"]){
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

	if (settings["UseDatabase"] && !settings["NoSplitNames"]){
		
		if (settings["SplitsAny%"]){	
		
			vars.DatabaseName[0] = "RuptureFarms - Tutorials";
			vars.DatabaseName[1] = "RuptureFarms - Meat Grinders";
			vars.DatabaseName[2] = "RuptureFarms - Sligs";
			vars.DatabaseName[3] = "RuptureFarms - Exit";
			
			vars.DatabaseName[4] = "Stockyards - Scrab Part";
			vars.DatabaseName[5] = "Stockyards - Slig Part";
			vars.DatabaseName[6] = "Stockyards - Slogs";
			
			vars.DatabaseName[7] = "Monsaic Lines - Natives";
			vars.DatabaseName[8] = "Monsaic Lines - DDG";
			vars.DatabaseName[9] = "Monsaic Lines - Exit";
			
			vars.DatabaseName[10] = "Free Fire Zone - Bomb part";
			vars.DatabaseName[11] = "Free Fire Zone - Exit";
			
			vars.DatabaseName[12] = "RuptureFarms - Zulag 1";
			vars.DatabaseName[13] = "RuptureFarms - Zulag 2";
			vars.DatabaseName[14] = "RuptureFarms - Zulag 3";
			
			vars.DatabaseName[15] = "Zulag 4 - Slog Kennels";
			vars.DatabaseName[16] = "Zulag 4 - Return";
			vars.DatabaseName[17] = "Zulag 4 - Exit";
			
			vars.DatabaseName[18] = "Boardroom";
			
			vars.DatabaseName[19] = "Weird extra split 1";
			vars.DatabaseName[20] = "Weird extra split 2";
			
		} else if (settings["SplitsAny%NMG"]){	
		
			vars.DatabaseName[0] = "RuptureFarms - Tutorials" ;
			vars.DatabaseName[1] = "RuptureFarms - Meat Grinders" ;
			vars.DatabaseName[2] = "RuptureFarms - Sligs" ;
			vars.DatabaseName[3] = "RuptureFarms - Exit" ;
			
			vars.DatabaseName[4] = "Stockyards - Scrab part" ;
			vars.DatabaseName[5] = "Stockyards - Slig Part" ;
			vars.DatabaseName[6] = "Stockyards - Exit" ;
			
			vars.DatabaseName[7] = "Monsaic Lines - Natives" ;
			vars.DatabaseName[8] = "Monsaic Lines - Enter Paramonia" ;
			vars.DatabaseName[9] = "Monsaic Lines - Enter Scrabania" ;
			
			vars.DatabaseName[10] = "Paramonia - Get the Elum" ;
			vars.DatabaseName[11] = "Paramonia - Honey and Sligs" ;
			vars.DatabaseName[12] = "Paramonia - Platforms and Bees" ;
			vars.DatabaseName[13] = "Paramonia - Passwords and Sligs" ;
			vars.DatabaseName[14] = "Paramonia - Exit" ;
			
			vars.DatabaseName[15] = "Paramonia Temple - Entry" ;
			vars.DatabaseName[16] = "Paramonia Temple - Trial Down Right" ;
			vars.DatabaseName[17] = "Paramonia Temple - Trial Down Left" ;
			vars.DatabaseName[18] = "Paramonia Temple - Trial Middle Right" ;
			vars.DatabaseName[19] = "Paramonia Temple - Trial Middle Right+" ;
			vars.DatabaseName[20] = "Paramonia Temple - Trial Middle Left+" ;
			vars.DatabaseName[21] = "Paramonia Temple - Trial Middle Left" ;
			vars.DatabaseName[22] = "Paramonia Temple - Nests" ;
			vars.DatabaseName[23] = "Paramonia Temple - Enter Scrabania" ;
			vars.DatabaseName[39] = "Paramonia Temple - Enter FFZ" ;
			
			vars.DatabaseName[24] = "Scrabania - Get the Elum" ;	
			vars.DatabaseName[25] = "Scrabania - Play with Mines" ;	
			vars.DatabaseName[26] = "Scrabania - Exit" ;	

			vars.DatabaseName[27] = "Scrabania Temple - Entry" ;	
			vars.DatabaseName[28] = "Scrabania Temple - Trial Middle Left" ;	
			vars.DatabaseName[29] = "Scrabania Temple - Trial Middle Left+" ;	
			vars.DatabaseName[30] = "Scrabania Temple - Trial Bottom Left" ;
			vars.DatabaseName[31] = "Scrabania Temple - Trial Top" ;
			vars.DatabaseName[32] = "Scrabania Temple - Trial Middle Right" ;
			vars.DatabaseName[33] = "Scrabania Temple - Trial Middle Right+" ;
			vars.DatabaseName[34] = "Scrabania Temple - Trial Bottom Right" ;
			vars.DatabaseName[35] = "Scrabania Temple - Trial Bottom Right+" ;
			vars.DatabaseName[36] = "Scrabania Temple - Nests" ;
			vars.DatabaseName[37] = "Scrabania Temple - Enter FFZ" ;	
			vars.DatabaseName[38] = "Scrabania Temple - Enter Paramonia" ;			
			
			vars.DatabaseName[40] = "Zulag 1 - Free Fire Zone" ;	
			vars.DatabaseName[41] = "Zulag 1 - Exit" ;	
			
			vars.DatabaseName[42] = "Zulag 2 - Entry" ;	
			vars.DatabaseName[43] = "Zulag 2 - Trial Right" ;	
			vars.DatabaseName[44] = "Zulag 2 - Trial Middle" ;	
			vars.DatabaseName[45] = "Zulag 2 - Trial Left" ;	
			vars.DatabaseName[46] = "Zulag 2 - Exit" ;	
			
			vars.DatabaseName[47] = "Zulag 3 - Entry" ;	
			vars.DatabaseName[48] = "Zulag 3 - Trial Bottom" ;	
			vars.DatabaseName[49] = "Zulag 3 - Trial Left" ;	
			vars.DatabaseName[50] = "Zulag 3 - Trial Right" ;	
			vars.DatabaseName[51] = "Zulag 3 - Exit" ;	
			
			vars.DatabaseName[52] = "Zulag 4 - Enter Slog Kennels" ;	
			vars.DatabaseName[53] = "Zulag 4 - Leave Slog Kennels" ;	
			vars.DatabaseName[54] = "Zulag 4 - Second Part" ;	
			vars.DatabaseName[55] = "Zulag 4 - Exit" ;
			
			vars.DatabaseName[56] = "Boardroom" ;	
		}
		
		
	}
	
// LOG TOOL FOR DEBUG. 	
	if (gnFrame > 1){
		if (LEVEL_ID == 0){		
			vars.SPLIT_INFO = "Main Menu [" + vars.n + "]\nGLOBAL AutoSplit started. Lang detected: " + vars.version + ".";
		} else {	
			if (settings["RealGameTime"]){	
				if (settings["NoSplitNames"]){
					vars.SPLIT_INFO = "IGT: " + vars.LOADLESS_TIME + " | Split number: " + vars.n;
				} else {
					vars.SPLIT_INFO = "IGT: " + vars.LOADLESS_TIME + " | Zone: " + vars.split[vars.n];	
				}
			} else {				
				if (settings["NoSplitNames"]){
					vars.SPLIT_INFO = "RTA: " + vars.REAL_TIME + " | Split number: " + vars.n;
				} else {					
					vars.SPLIT_INFO = "RTA: " + vars.REAL_TIME + " | Zone: " + vars.split[vars.n];
				}
			}
		}	
	} else {
		vars.SPLIT_INFO = "Main Menu [" + vars.n + "]\nGLOBAL AutoSplit started. No main lang detected yet.";
	}
	
	if (vars.DBSplit){ // We perform the DB actions for the previous split.
		string CatName = "";
		if (settings["SplitsAny%"]){
			CatName = "Any%";
		} else if (settings["SplitsAny%NMG"]){
			CatName = "Any% NMG";
		}
		// THE CAT NAME SHOULD WORK TO DETERMINE THE CATEGORY AND THEN SPECIFY THE CORRECT FOLDER
		if (File.Exists(@"C:\Autosplit Backup Files\Database\Oddworld Abe's Oddysee\" + CatName + "\\ID\\" + (vars.n) + ".txt") && File.Exists(@"C:\Autosplit Backup Files\Database\Oddworld Abe's Oddysee\\" + CatName + "\\[" + (vars.n) + "] " + vars.splitName + ".txt")) { // The split file exists.
			if ((vars.GNFrame - vars.FramesUpToPreviousFrame) < vars.CurrentSplitBestFrame){ // We beaten our best time.
				if ((vars.GNFrame - vars.FramesUpToPreviousFrame) > 150) { // More than 5 seconds in this split.
					vars.DB_PREVIOUS_SPLIT = "## BEATEN BY " + (vars.CurrentSplitBestFrame - (vars.GNFrame - vars.FramesUpToPreviousFrame)) + " FRAMES! New best: " + (vars.GNFrame - vars.FramesUpToPreviousFrame);		
					File.WriteAllText(@"C:\Autosplit Backup Files\Database\Oddworld Abe's Oddysee\\" + CatName + "\\ID\\" + (vars.n) + ".txt", "" + (vars.GNFrame - vars.FramesUpToPreviousFrame)); // We save the best on the ID text file.
					File.WriteAllText(@"C:\Autosplit Backup Files\Database\Oddworld Abe's Oddysee\\" + CatName + "\\[" + (vars.n) + "] " + vars.splitName + ".txt", "" + (vars.GNFrame - vars.FramesUpToPreviousFrame)); // We save the best on the split text file.	
					vars.DB_GOLD_FRAMES_TOTAL = vars.DB_GOLD_FRAMES_TOTAL + (vars.CurrentSplitBestFrame - (vars.GNFrame - vars.FramesUpToPreviousFrame));
				} else {
					vars.DB_PREVIOUS_SPLIT = "Frame amount is " + (vars.GNFrame - vars.FramesUpToPreviousFrame) + ". Error?";
				}
			} else if ((vars.GNFrame - vars.FramesUpToPreviousFrame) == vars.CurrentSplitBestFrame) { // We got the same time.
				vars.DB_PREVIOUS_SPLIT = "# Same frames as your best! Frames: " + (vars.GNFrame - vars.FramesUpToPreviousFrame);	
			} else { // We got worse time.
				vars.DB_PREVIOUS_SPLIT = "Lost " + -(vars.CurrentSplitBestFrame - (vars.GNFrame - vars.FramesUpToPreviousFrame)) + " frames vs best (" + vars.CurrentSplitBestFrame + "). Frames: " + (vars.GNFrame - vars.FramesUpToPreviousFrame);
				vars.DB_LOST_FRAMES_TOTAL = 	vars.DB_LOST_FRAMES_TOTAL + (-(vars.CurrentSplitBestFrame - (vars.GNFrame - vars.FramesUpToPreviousFrame)));
			}
		} else { // Split file doesn't exist / we save the time.
			vars.DB_PREVIOUS_SPLIT = "# CREATED SPLIT TIME: " + (vars.GNFrame - vars.FramesUpToPreviousFrame) + " frames.";		
			File.WriteAllText(@"C:\Autosplit Backup Files\Database\Oddworld Abe's Oddysee\\" + CatName + "\\ID\\" + (vars.n) + ".txt", "" + (vars.GNFrame - vars.FramesUpToPreviousFrame)); // We save the best on the ID text file.
			File.WriteAllText(@"C:\Autosplit Backup Files\Database\Oddworld Abe's Oddysee\\" + CatName + "\\[" + (vars.n) + "] " + vars.splitName + ".txt", "" + (vars.GNFrame - vars.FramesUpToPreviousFrame)); // We save the best on the split text file.									
		}							
		vars.FramesUpToPreviousFrame = vars.GNFrame; // We store the current GNFrame as FramesUpToPreviousFrame.
		if (IsGameBeaten == 1) {
			vars.SPLIT_INFO = "The run is over!\nTime: " + timer.CurrentTime.RealTime;
			vars.CurrentSplitBestFrame = 0;	
		} else if (File.Exists(@"C:\Autosplit Backup Files\Database\Oddworld Abe's Oddysee\\" + CatName + "\\ID\\" + (vars.n + 1) + ".txt")) {
			vars.CurrentSplitBestFrame = Int32.Parse(File.ReadAllText(@"C:\Autosplit Backup Files\Database\Oddworld Abe's Oddysee\\" + CatName + "\\ID\\" + (vars.n + 1) + ".txt")); // We get the frame count for the next split.
		} else {
			vars.CurrentSplitBestFrame = 0;
		}		
		++vars.n;
		return true;
	}
}
