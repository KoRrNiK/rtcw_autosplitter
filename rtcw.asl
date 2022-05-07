// ----------------------------------------
// GAME: Return to Castle Wolfenstein
// https://store.steampowered.com/app/9010/
// ----------------------------------------

// Patch by KoRrNiK | The bytes were found by KoRrNiK
state("WolfSP", "1.45a"){	
	string16 bsp 		: 		"WolfSP.exe", 		0x693664;
	byte cs 			: 		"WolfSP.exe", 		0xEA7B64;
	
	int client_status	: 		"WolfSP.exe", 		0x613420;
	byte ESC			:		"WolfSP.exe", 		0xCCAF24; 	// 2 == ESC | 1 == CONSOLE

	float camera_x		: 		"WolfSP.exe", 		0x7A2F9C;
	float xpos 			: 		"WolfSP.exe", 		0x77B0DC;
	float ypos 			: 		"WolfSP.exe", 		0x7A2FA4;
	float zpos 			: 		"WolfSP.exe", 		0x77B0E0;
	
	int finish			: 		"WolfSP.exe", 		0xDBC164;
	byte stuck			:		"WolfSP.exe",		0xDCB9E1;


	// LEVELS CHECKER POINTER |

	int escape2_1		: 		"qagamex86.dll", 		0x2518E4;	
	int escape2_2		: 		"qagamex86.dll", 		0x1C4664;	
	int crypt1_1		: 		"qagamex86.dll", 		0x230140;	
	int crypt1_2		: 		"qagamex86.dll", 		0x5F1604;		
	int crypt2_1		: 		"qagamex86.dll", 		0x69FF14;	
	int crypt2_2		: 		"qagamex86.dll", 		0x6A682C;	
	int church_1		: 		"qagamex86.dll", 		0x63BCC4;	
	int church_2		: 		"qagamex86.dll", 		0x212520;	
	int boss1_1			: 		"qagamex86.dll", 		0x63BCC4;
	int forest_1		: 		"qagamex86.dll", 		0x1D7054;
	int forest_2		: 		"qagamex86.dll", 		0x1C0BF8;
	int rocket_1		:		"qagamex86.dll", 		0x1F4C74;
	int rocket_2		:		"qagamex86.dll", 		0x757A74;
	int rocket_3		:		"qagamex86.dll", 		0x28D124;
	int baseout_3		:		"qagamex86.dll", 		0x63BCC4;
	int assault_1		:		"qagamex86.dll",		0x1CBA5C;
	int assault_2		:		"qagamex86.dll",		0x63DB90;

}

// Patch by Knightmare | The bytes were found by Hoyo & KoRrNiK
state("WolfSP", "1.42d"){
	string16 bsp 		: 		0x13D4, 			0x8;
	byte cs 			: 		0x26F4, 			0x0;
	
	int client_status	: 		0xB24EE0;
	byte ESC			:		"WolfSP.exe", 		0x6899D8; 	// 1 == ESC
	
	float camera_x		: 		"WolfSP.exe", 		0xDA9D3C;
	float xpos 			: 		"WolfSP.exe", 		0x5F8Da4;
	float ypos 			: 		"WolfSP.exe", 		0x5F8Da8;
	float zpos 			: 		"WolfSP.exe", 		0x5F8Dac;

	int finish			: 		"qagamex86.dll", 	0x57D7D0, 	0x42c; 
}

startup {
	int m_chap = 0, i_chap = 0;

	vars.mapListChapter1 = new List<string> { "escape1", "escape2", "tram", "village1", "crypt1", "crypt2", "church", "boss1" };
	vars.mapListChapter2 = new List<string> { "forest", "rocket", "baseout", "assault" };
	vars.mapListChapter3 = new List<string> { "sfm", "factory", "trainyard", "swf"};
	vars.mapListChapter4 = new List<string> { "norway", "xlabs", "boss2" };
	vars.mapListChapter5 = new List<string> { "dam", "village2", "chateau", "dark", "dig", "castle", "end" };

	vars.chapterNames = new List<string> { "Ominous Rumors + Dark Secret", "Weapons of Vengeance", "Deadly Designs", "Deathshead's Playground", "Return Engagement + Operation Resurrection" };
	vars.individualNames1 = new List<string> { "Escape!", "Castle Keep", "Tram Ride", "Village", "Catacombs", "Crypt", "The Defiled Church", "Tomb" };
	vars.individualNames2 = new List<string> { "Forest Compound", "Rocket Base", "Radar Installation", "Air Base Assault" };
	vars.individualNames3 = new List<string> { "Kugelstadt", "The Bombed Factory", "The Trainyards", "Secret Weapons Facility" };
	vars.individualNames4 = new List<string> { "Ice Station Norway", "X-Labs", "Super Soldier" };
	vars.individualNames5 = new List<string> { "Bramburg Dam", "Paderborn Village", "Chateau Schufstaffel", "Unhallowed Ground", "The Dig", "Return to Castle Wolfenstein", "Heinrich" };

	// Full Game
	settings.Add("cat_all", 			true, 		"Full game");
	settings.Add("cat_all_new", 		true, 		"Full Game ( Segments )");

	
	// Only chapter
	settings.Add("chaptersOnly", 		false, 		"Chapters");
	foreach (var names in vars.chapterNames){
		m_chap++;
		settings.Add("cat_chap"+m_chap, false, names, "chaptersOnly");
	}

	// Individual chapter levels
	for(int i = 1; i <= 5; i++){
		settings.Add("individualLevelsC"+i, 	false, 		"Chapter "+i+" Individual Levels");
		foreach (var names in ( i == 1 ? vars.individualNames1 : i == 2 ? vars.individualNames2 : i == 3 ? vars.individualNames3 : i == 4 ? vars.individualNames4 : vars.individualNames5 )){
			i_chap++;
			settings.Add("miss"+i_chap+"_chap_"+i, false, names, "individualLevelsC"+i);
		}
		i_chap = 0;
	}

	// DEBUG MESSAGE
	Action<string> DebugOutput = (text) => {
		print("[RTCW Autosplitter] " + text);
	};
	vars.DebugOutput = DebugOutput;

	vars.checker_1 = false;
	vars.checker_2 = false;
	vars.checker_3 = false;
	vars.checker_4 = false;
	vars.checker_5 = false;
	vars.checker_6 = false;
	vars.checker_end = false;
}

init{
	// Useful for debugViewer
	// https://docs.microsoft.com/en-us/sysinternals/downloads/debugview
	
	vars.debugMessage 	= 	true;

	int idGame = modules.First().ModuleMemorySize;
	
	switch(idGame){
		case 14643200:{
			version 		= 	"1.42d";
			vars.running 	= 	true;
			break;
		}
		case 19324928:{
			version 		= 	"1.45a";
			vars.running 	=	 true;
			break;
		}
		default:{
			if(vars.debugMessage) vars.DebugOutput("Unrecognized game version. Disabling functionality.");
			version 		= 	"Unknown";
			vars.running 	= 	false;
			return false;
			break;
		}
	}

	if(vars.debugMessage){
		vars.DebugOutput("Game found | Found Patch" + version + " | Module size: "+ idGame);
	}

	vars.firstcs 		= 	true;
	vars.loadStarted 	= 	false;
	vars.bsp_list 		= 	new List<String>();
	vars.visited 		= 	new List<String>();
}

exit{
	timer.IsGameTimePaused = true;
	vars.running 		= 	false;
}

shutdown{
	timer.IsGameTimePaused = true;
	vars.running 		= 	false;
}

start{	
	int listChapters = 0;
	bool firstLevelChapter = false;

	for(int i = 1; i <= 5; i ++){
		foreach (var maps in ( i == 1 ? vars.mapListChapter1 : i == 2 ? vars.mapListChapter2 : i == 3 ? vars.mapListChapter3 : i == 4 ? vars.mapListChapter4 : vars.mapListChapter5 )) {
			if(settings["miss" + (listChapters+1) + "_chap_"+ i ]) vars.bsp_list.Add("/" + maps + ".bsp");
			if(settings["cat_all"] || settings["cat_all_new"] || settings["cat_chap"+ i ]) vars.bsp_list.Add("/" + maps + ".bsp");
			listChapters++;
		}
		listChapters = 0;
	}
	

	if ((settings["cat_all"] || (settings["cat_all_new"] && version == "1.45a") ) && current.bsp == "/cutscene1.bsp" && current.cs == 1 && old.cs == 0) {
		if(vars.debugMessage) vars.DebugOutput("Timer started");
		vars.firstcs = true;

		if(settings["cat_all_new"] && version == "1.45a"){
			vars.checker_1 = false;
			vars.checker_2 = false;
			vars.checker_3 = false;
			vars.checker_4 = false;
			vars.checker_5 = false;
			vars.checker_6 = false;
			vars.checker_end = false;
		}

		vars.visited.Clear();
		vars.visited.Add("/cutscene1.bsp");
		vars.visited.Add("/escape1.bsp");
		return true;
	}

	for(int i = 1; i <= 5; i ++){
		foreach (var maps in ( i == 1 ? vars.mapListChapter1 : i == 2 ? vars.mapListChapter2 : i == 3 ? vars.mapListChapter3 : i == 4 ? vars.mapListChapter4 : vars.mapListChapter5 )) {
			if(listChapters == 0){
				firstLevelChapter = true;
			} else firstLevelChapter = false;
			listChapters++;
			if((settings["cat_chap"+i] && firstLevelChapter) || settings["miss" + (listChapters) + "_chap_"+i]){
				if (current.bsp == "/" + maps + ".bsp" && old.bsp != "/" + maps + ".bsp") {
					if(vars.debugMessage) vars.DebugOutput("Timer started");
					vars.firstcs = true;
					vars.visited.Clear();
					vars.visited.Add("/" + maps + ".bsp");
					return true;
				}
			}
		}
		listChapters = 0;
	}
}

split{
	if(!vars.running) return;

	bool isOld = (version == "1.42d" && current.finish != 0) ? true : false;
	bool isNew = (version == "1.45a" && current.finish == 4 && current.cs == 0 && current.stuck != 3) ? true : false;
	bool isFS = (current.finish == 4 && current.stuck == 0) ? true : false;

	bool cordVillage1 = (current.zpos > 4500.0 && current.zpos < 4580.0 && current.xpos > -460.0 && current.xpos < -300.0 ) ? true : false;
	bool cordTram = (current.xpos < -3850.0 && current.ypos > -1300.0) ? true : false;
	bool cordBoss2 = (current.xpos >= 1454.0 && old.xpos < 1454.0 && current.xpos <= 1500.0 && old.xpos > 1300.0) ? true : false;
	bool cordDark = (current.xpos > 3100.0 && current.xpos < 3360.0 && current.zpos < 3230.0 && current.zpos > 2970.0) ? true : false;
	bool cordxlabs = (current.zpos < -2500.0 && current.ypos < 0.0 && current.xpos > -749.0 && current.xpos < -530.0) ? true : false;

	int listChapters = 0;
	bool stoppedTimer = false;
	bool stoppedCutscene = false;
	
	bool checker_yes = false;

	if(settings["cat_all_new"] && version == "1.45a"){

		if(current.bsp != old.bsp) {
			if(vars.bsp_list.Contains(current.bsp) && !vars.visited.Contains(current.bsp) && vars.checker_end){
				if(vars.debugMessage) vars.DebugOutput("Map changed to " + current.bsp);
				vars.checker_end = false;
				vars.checker_1 = false;
				vars.checker_2 = false;
				vars.checker_3 = false;
				vars.checker_4 = false;
				vars.checker_5 = false;
				vars.checker_6 = false;
				vars.visited.Add(current.bsp);
				checker_yes = true;
				vars.firstcs = true;
				if(vars.debugMessage) vars.DebugOutput("Map change valid.");
			} else if(vars.debugMessage) vars.DebugOutput("Map change ignored.");
		}
		
		if(current.bsp == "/cutscene1.bsp" || current.bsp == "/escape1.bsp"){
			
			if(!vars.checker_end){
				bool __cordEscape1_jail = (current.xpos < -330.0 && current.zpos >= 716.0 && current.zpos <= 787.0) ? true : false;
				bool __cordEscape1_tower = (current.xpos > -1000.0 && current.xpos < -990.0 && current.zpos >= 1330.0 && current.zpos <= 1357.0 && current.ypos > 200.0 && current.ypos < 300.0) ? true : false;
				bool __cordEscape1_floor = (current.xpos < -1615.0 && current.xpos > -1815.0 && current.ypos < 350.0 && current.ypos > 300.0 && current.zpos > 240.0 && current.zpos < 480.0) ? true : false;
				
				if(__cordEscape1_jail && !vars.checker_1){
					vars.checker_1 = true;
					checker_yes = true;
				} else if(__cordEscape1_tower && !vars.checker_2 && vars.checker_1){
					vars.checker_2 = true;
					checker_yes = true;
				} else if(__cordEscape1_floor && !vars.checker_3 && vars.checker_2 && vars.checker_1){
					vars.checker_3 = true;
					vars.checker_end = true;
					checker_yes = true;
				}
				
			}
		} else if(current.bsp == "/escape2.bsp" ){

			if(!vars.checker_end){
				
				bool __cordEscape2_gate = (current.xpos >= 735.0 && current.ypos >= 165.0 && current.ypos <= 250.0 && current.zpos <= 861.0 && current.zpos >= 802.0 ) ? true : false;
				
				if(current.escape2_1 == 1 && !vars.checker_1){
					vars.checker_1 = true;
					checker_yes = true;
				} else if(current.escape2_2 == 1 && !vars.checker_2 && vars.checker_1){
					vars.checker_2 = true;
					checker_yes = true;
				} else if(__cordEscape2_gate && !vars.checker_3 && vars.checker_2 && vars.checker_1){
					vars.checker_3 = true;
					vars.checker_end = true;
					checker_yes = true;
				} 
				
			}
		} else if(current.bsp == "/tram.bsp"){

			if(!vars.checker_end){

				bool __cordTram_door = (current.xpos >= 3712.0 && current.zpos >= 146.0 && current.zpos <= 173.0 && current.ypos <= 1050.0 && current.ypos >= 1000.0) ? true : false;
				bool __cordTram_tunel = (current.xpos <= -3058.0 && current.xpos >= -3085.0 && current.zpos <= -320.0 && current.ypos >= -400.0 && current.ypos <= -255.0) ? true : false;
				
				if(__cordTram_door && !vars.checker_1){
					vars.checker_1 = true;
					checker_yes = true;
				} else if(__cordTram_tunel && !vars.checker_2 && vars.checker_1){
					vars.checker_2 = true;
					vars.checker_end = true;
					checker_yes = true;
				}
			}

		} else if(current.bsp == "/village1.bsp"){

			if(!vars.checker_end){

				bool __cordVillage1_hatch = (current.zpos <= -1150.0 && current.zpos >= -1264.0 && current.xpos >= -2677.0 && current.xpos <= 2602.0 && current.ypos <= -314.0 && current.ypos >= -315.0) ? true : false;
				bool __cordVillage1_door = (current.zpos >= 1780.0 && current.zpos <= 1790.0 && current.xpos >= -1037.0 && current.xpos <= 1010.0 && current.ypos <= 50.0 && current.ypos >= -40.0) ? true : false;

				if(__cordVillage1_hatch && !vars.checker_1){
					vars.checker_1 = true;
					checker_yes = true;
				} else if(__cordVillage1_door && !vars.checker_2 && vars.checker_1){
					vars.checker_2 = true;
					vars.checker_end = true;
					checker_yes = true;
				}
				
			}

		} else if(current.bsp == "/crypt1.bsp"){

			if(!vars.checker_end){

				if(current.crypt1_1 == 1 && !vars.checker_1){
					vars.checker_1 = true;
					checker_yes = true;
				} else if(current.crypt1_2 == 1 && !vars.checker_2 && vars.checker_1){
					vars.checker_2 = true;
					vars.checker_end = true;
					checker_yes = true;
				}
			}

		} else if(current.bsp == "/crypt2.bsp"){

			if(!vars.checker_end){

				if(current.crypt2_1 == 1 && !vars.checker_1){
					vars.checker_1 = true;
					checker_yes = true;
				} else if(current.crypt2_2 > 0 && !vars.checker_2 && vars.checker_1){
					vars.checker_2 = true;
					vars.checker_end = true;
					checker_yes = true;
				} 
				
			}

		} else if(current.bsp == "/church.bsp"){

			if(!vars.checker_end){

				bool __cordChurch_gate = (current.xpos >= 700.0 && current.xpos <= 710.0 && current.zpos <= 733.0 && current.zpos >= 674.0 && current.ypos >= 600.0 && current.ypos <= 700.0) ? true : false;

				if(current.church_1 == 1 && !vars.checker_1){
					vars.checker_1 = true;
					checker_yes = true;
				} else if(current.church_2 == 1 && !vars.checker_2 && vars.checker_1){
					vars.checker_2 = true;
					checker_yes = true;
				} else if(__cordChurch_gate && !vars.checker_3 && vars.checker_2 && vars.checker_1){
					vars.checker_3 = true;
					vars.checker_end = true;
					checker_yes = true;
				} 
				
			}

		} else if(current.bsp == "/boss1.bsp"){

			if(!vars.checker_end){
				if(current.boss1_1 == 1 && !vars.checker_1){
					vars.checker_1 = true;
					vars.checker_end = true;
					checker_yes = true;
				}
			}

		} else if(current.bsp == "/forest.bsp"){

			if(!vars.checker_end){
				if(current.forest_1 == 1 && !vars.checker_1){
					vars.checker_1 = true;
					checker_yes = true;
				} else if(current.forest_2 == 1 && !vars.checker_2 && vars.checker_1){
					vars.checker_2 = true;
					vars.checker_end = true;
					checker_yes = true;
				}
			}
			
		} else if(current.bsp == "/rocket.bsp"){

			bool __cordRocket_elevator = (current.xpos >= 1410.0 && current.ypos <= -250.0 && current.ypos >= -350.0 && current.zpos >= 125.0 && current.zpos <= 240.0) ? true : false;

			if(__cordRocket_elevator && !vars.checker_1){
				vars.checker_1 = true;
				checker_yes = true;
			} else if(current.rocket_1 > 0 && !vars.checker_2 && vars.checker_1){
				vars.checker_2 = true;
				checker_yes = true;
			} else if(current.rocket_2 == 1 && !vars.checker_3 && vars.checker_2 && vars.checker_1){
				vars.checker_3 = true;
				checker_yes = true;
			} else if(current.rocket_3 == 1 && !vars.checker_4 && vars.checker_3 && vars.checker_2 && vars.checker_1){
				vars.checker_4 = true;
				vars.checker_end = true;
				checker_yes = true;
			}
			
		} else if(current.bsp == "/baseout.bsp"){

			bool __cordBaseout_stairs = (current.xpos < 850.0 && current.xpos >= 400.0 && current.zpos <= 845.0 && current.zpos >= 466.0) ? true : false;

			if(!vars.checker_end){
				if(__cordBaseout_stairs && !vars.checker_1){
					vars.checker_1 = true;
					checker_yes = true;
				} else if(current.baseout_3 == 1 && !vars.checker_2 && vars.checker_1){
					vars.checker_2 = true;
					vars.checker_end = true;
					checker_yes = true;
				}
			}
		} else if(current.bsp == "/assault.bsp"){

			bool __cordAssault_glassdoor = (current.xpos <= -4466.0 && current.xpos >= -4493.0 && current.zpos >= 4600.0 && current.ypos >= 640.0 && current.ypos <= 720.0) ? true : false;

			if(current.assault_1 == 1 && !vars.checker_1){
				vars.checker_1 = true;
				checker_yes = true;
			} else if(current.assault_2 == 1 && !vars.checker_2 && vars.checker_1){
				vars.checker_2 = true;
				checker_yes = true;
			} else if(__cordAssault_glassdoor && !vars.checker_3 && vars.checker_2 && vars.checker_1){
				vars.checker_3 = true;
				vars.checker_end = true;
				checker_yes = true;
			} 
			
		}
		
		if(checker_yes){
			checker_yes = false;
			return true;
		}

	} else {
		if(current.bsp != old.bsp) {
			if(vars.debugMessage) vars.DebugOutput("Map changed to " + current.bsp);
			if(vars.bsp_list.Contains(current.bsp) && !vars.visited.Contains(current.bsp)){
				if(vars.debugMessage) vars.DebugOutput("Map change valid.");
				vars.visited.Add(current.bsp);
				vars.firstcs = true;
				return true;
			}
			else if(vars.debugMessage) vars.DebugOutput("Map change ignored.");
		}
	}

	for(int i = 1; i <= 5; i ++){
		if(i == 1 && current.bsp == "/boss1.bsp" && ( settings["cat_chap"+i] || settings["miss8_chap_"+i] )) stoppedCutscene = true;
		if(settings["cat_chap"+i]){
			if((i == 2 && current.bsp == "/assault.bsp") || (i == 3 && current.bsp == "/swf.bsp")) stoppedCutscene = true;
		}
		if(i == 5 && current.bsp == "/end.bsp") stoppedCutscene = true;
		if (stoppedCutscene && current.cs == 1 && old.cs == 0) {
			if(vars.firstcs == false) {
				if(vars.debugMessage) vars.DebugOutput("Second cutscene.");
				return true;
			}
			if(vars.firstcs == true) {
				vars.firstcs = false;
				if(vars.debugMessage) vars.DebugOutput("First cutscene.");
			}
		}
		stoppedCutscene = false;
	}

	if((settings["cat_chap4"] || settings["miss3_chap_4"]) && current.bsp == "/boss2.bsp" && cordBoss2){
		if(vars.debugMessage) vars.DebugOutput("The timer has stopped (BOSS2)");
		return true;
	}

	for(int i = 1; i <= 5; i ++){
		foreach (var maps in ( i == 1 ? vars.mapListChapter1 : i == 2 ? vars.mapListChapter2 : i == 3 ? vars.mapListChapter3 : i == 4 ? vars.mapListChapter4 : vars.mapListChapter5 )) {
			listChapters++;
			
			if(i == 1 && maps == "boss1") continue;
			if(i == 4 && maps == "boss2") continue;
			if(i == 5 && maps == "end") continue;

			if(settings["miss" + listChapters + "_chap_"+i] && current.bsp == "/" + maps + ".bsp"){

				if(i == 1){
					if(maps == "village1" && version == "1.45a"){
						if(isFS && cordVillage1) stoppedTimer = true;
					} else if(isOld || isNew || (isNew && maps == "tram" && cordTram)) stoppedTimer = true;
				}
				if(i == 2 && ((maps == "forest" && current.cs == 1 && old.cs == 0 && vars.firstcs == true) || isOld || isNew)) stoppedTimer = true;
				if(i == 3 && (isOld || isNew)) stoppedTimer = true;
				if(i == 4){
					if(maps == "xlabs" && version == "1.45a"){
						if(isFS && cordxlabs) stoppedTimer = true;
					} else if(isOld || isNew) stoppedTimer = true;
				}
				if(i == 5){
					if((maps == "dam" || (maps == "dark" && cordDark)) && version == "1.45a"){
						if(isFS && isNew) stoppedTimer = true;
					} else if(isOld || isNew) stoppedTimer = true;
				}

				if(stoppedTimer){
					if(vars.debugMessage) vars.DebugOutput("The timer has stopped (" + maps +")");
					return true;
				}
			}
		}
		listChapters = 0;
	}
}

update{
	if(!vars.running) return;
	
	switch(version){
		case "1.45a": {
			if((current.client_status == 0) || current.ESC == 2) vars.loadStarted = true;
			else{	
				if(current.camera_x != 0) vars.loadStarted = false;
			}
			break;
		}
		case "1.42d":{
			if((current.client_status != 8 && current.client_status != 1) || current.ESC == 1) vars.loadStarted = true;
			else{	
				if(current.camera_x != 0) vars.loadStarted = false;
			}
			break;
		}
		case "Unknown":{ 
			return;
			break;
		}
	}

	if(vars.debugMessage){
		vars.DebugOutput("POSS: X " + current.xpos + " Y " + current.ypos + " Z " + current.zpos + " CS " + current.cs + " F " + current.finish + " CLS " + current.client_status + " S " + current.stuck );
	}

}

isLoading{	 
	return vars.loadStarted;
}