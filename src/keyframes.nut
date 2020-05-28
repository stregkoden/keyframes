//-----------------------------------------------------------------------
//------------------- Copyright (c) samisalreadytaken -------------------
//                       github.com/samisalreadytaken
//- v1.1.9 --------------------------------------------------------------
IncludeScript("vs_library");
IncludeScript("vs_library/vs_interp");

// don't overwrite
if(!("_KF_"in getroottable()))
	::_KF_ <- { _VER_ = "1.1.9" };;

// Run the script in the scope of _KF_
// when this is uncommented (along with the call in the end),
// all _KF_ mentions can be removed and replaced with 'this'.
// This does not change any functionality.
// local __init__ = function(){

class::V
{
	constructor(_x=0,_y=0,_z=0)
	{
		x = _x;
		y = _y;
		z = _z;
	}

	function V(dx=0,dy=0,dz=0)
		return::Vector(x+dx,y+dy,z+dz);

	x = 0.0;
	y = 0.0;
	z = 0.0;
}

class::Q
{
	constructor(_x=0,_y=0,_z=0,_w=0)
	{
		x = _x;
		y = _y;
		z = _z;
		w = _w;
	}

	function V(dx=0,dy=0,dz=0,dw=0)
		return::Quaternion(x+dx,y+dy,z+dz,w+dw);

	x = 0.0;
	y = 0.0;
	z = 0.0;
	w = 0.0;
}

try(IncludeScript("keyframes_data",getroottable()))
catch(e){} // file does not exist

SendToConsole("alias kf_add\"script _KF_.AddKeyframe()\";alias kf_remove\"script _KF_.RemoveKeyframe()\";alias kf_remove_undo\"script _KF_.UndoLast(1)\";alias kf_clear\"script _KF_.ClearKeyframes()\";alias kf_insert\"script _KF_.InsertKeyframe()\";alias kf_replace\"script _KF_.ReplaceKeyframe()\";alias kf_replace_undo\"script _KF_.UndoLast(0)\";alias kf_removefov\"script _KF_.RemoveFOV()\";alias kf_compile\"script _KF_.Compile()\";alias kf_play\"script _KF_.Play()\";alias kf_stop\"script _KF_.Stop()\";alias kf_save\"script _KF_.Save()\";alias kf_savekeys\"script _KF_.Save(1)\";alias kf_mode_ang\"script _KF_.SetInterpMode(0)\";alias kf_edit\"script _KF_.ToggleEditMode()\";alias kf_select\"script _KF_.SelectKeyframe()\";alias kf_see\"script _KF_.SeeKeyframe()\";alias kf_next\"script _KF_.NextKeyframe()\";alias kf_prev\"script _KF_.PrevKeyframe()\";alias kf_showkeys\"script _KF_.ShowToggle(0)\";alias kf_showpath\"script _KF_.ShowToggle(1)\";alias kf_cmd\"script _KF_.PrintCmd()\"");

// SendToConsole("alias +kf_roll_R\"script _KF_.KEY_ROLL_R(1)\";alias -kf_roll_R\"script _KF_.KEY_ROLL_R(0)\";alias +kf_roll_L\"script _KF_.KEY_ROLL_L(1)\";alias -kf_roll_L\"script _KF_.KEY_ROLL_L(0)\";alias +kf_fov_I\"script _KF_.KEY_FOV_I(1)\";alias -kf_fov_I\"script _KF_.KEY_FOV_I(0)\";alias +kf_fov_O\"script _KF_.KEY_FOV_O(1)\";alias -kf_fov_O\"script _KF_.KEY_FOV_O(0)\"");

//--------------------------------------------------------------

SendToConsole("clear;script _KF_.PostSpawn()");

VS.GetLocalPlayer();

// don't overwrite
if( !("data_pos_kf" in _KF_) )
{
	_KF_.FTIME <- 0.015625;

	_KF_.EF <-
	{
		ON  = 88, // (1<<4)|(1<<6)|(1<<3)|0
		OFF = 120 // (1<<4)|(1<<6)|(1<<3)|(1<<5)
	}

	_KF_._Compile <- delegate _KF_ :
	{
		RTIME = 0.0,
		_CLI = 0,
		_STP = 0,
		_IDX = 0,
		_CMX = 0,
		Catmull_Rom_Spline = ::VS.Catmull_Rom_Spline.bindenv(::VS),
		Catmull_Rom_SplineQ = ::VS.Catmull_Rom_SplineQ.bindenv(::VS),
		QAngleNormalize = ::VS.QAngleNormalize.bindenv(::VS),
		QuaternionAngles2 = ::VS.QuaternionAngles2.bindenv(::VS),
		VectorAngles = ::VS.VectorAngles.weakref(),
		sort = function(x,y)
		{
			if( x[0] > y[0] ) return  1;
			if( x[0] < y[0] ) return -1;
			return 0;
		}
	}

	_KF_._Save <- delegate _KF_ :
	{
		_LIM = 0,
		_STP = 0,
		_IDX = 0,
		_CMX = 0,

		VecToString = ::VecToString.weakref(),
		LOG = null,
		data_pos_save = null,
		data_ang_save = null,
	}

	_KF_.data_pos_kf <- [];
	_KF_.data_ang_kf <- [];
	_KF_.data_quat_kf <- [];
	_KF_.data_fov_kf <- [];
	_KF_.data_pos_comp <- [];
	_KF_.data_ang_comp <- [];
	_KF_.data_fov_comp <- [];
	_KF_.list_last_replace <- [];
	_KF_.list_last_remove <- [];

	_KF_.bStartedPending <- false;
	_KF_.bInterpModeAng <- true;
	_KF_.nSelectedKeyframe <- -1;
	_KF_.flInterpResolution <- 0.01;
	_KF_.nDrawResolution <- 25;
	_KF_.nCurrKeyframe <- 0;
	_KF_.bShowPath <- true;
	_KF_.bShowKeys <- true;
	_KF_.bSeeing <- false;
	_KF_.IN_ROLL_R <- false;
	_KF_.IN_ROLL_L <- false;
	_KF_.IN_FOV_I <- false;
	_KF_.IN_FOV_O <- false;
	_KF_.__STP <- floor(1.0/_KF_.flInterpResolution);
	_KF_.iFOV <- 90;
	_KF_.flTimeShow <- FrameTime()*6;
	_KF_.qKeyLast <- null;
	_KF_.VEC_MAX <- Vector(MAX_COORD_FLOAT-1,MAX_COORD_FLOAT-1,MAX_COORD_FLOAT-1);
	_KF_.Msg <- ::printl;
};;

if( !("HPlayerEye" in getroottable()) )
	::HPlayerEye <- VS.CreateMeasure(HPlayer.GetName(),null,true);;

if( !("hThinkSet" in _KF_) )
{
	// holds playback status
	_KF_.hThinkSet <- VS.Timer(true,_KF_.FTIME,null,null,false,true).weakref();

	// holds edit mode status
	_KF_.hThinkEdit <- VS.Timer(true,_KF_.flTimeShow-FrameTime(),null,null,false,true).weakref();

	_KF_.hThinkKeys <- VS.Timer(true,FrameTime()*2.5,null,null,false,true).weakref();

	_KF_.hGameText <- VS.CreateEntity("game_text",
	{
		channel = 1,
		color = Vector(255,138,0),
		holdtime = _KF_.flTimeShow,
		x = 0.475,
		y = 0.55
	},true).weakref();

	_KF_.hGameText2 <- VS.CreateEntity("game_text",
	{
		channel = 2,
		color = Vector(255,138,0),
		holdtime = _KF_.flTimeShow,
		x = 0.56,
		y = 0.485
	},true).weakref();

	_KF_.hHudHint <- VS.CreateEntity("env_hudhint",null,true).weakref();

	// holds compile status
	_KF_.hCam <- VS.CreateEntity("point_viewcontrol",{ spawnflags = 1<<3 }).weakref();

	// holds player noclip status
	_KF_.hListener <- VS.CreateEntity("game_ui",{ spawnflags = 1<<7, fieldofview = -1.0 },true).weakref();

	VS.AddOutput(_KF_.hListener, "UnpressedAttack",  null);
	VS.AddOutput(_KF_.hListener, "UnpressedAttack2", null);

	PrecacheModel("keyframes/kf_circle_orange.vmt");

	_KF_.hKeySprite <- VS.CreateEntity("env_sprite",
	{
		rendermode = 8, // only 8 works when spawned through script, don't ask why
		glowproxysize = 64.0, // MAX_GLOW_PROXY_SIZE
		effects = _KF_.EF.OFF
	},true).weakref();

	_KF_.hKeySprite.SetModel("keyframes/kf_circle_orange.vmt");

//--------------------------------------------------------

	local sc = _KF_.hThinkSet.GetScriptScope();
	sc.cam <- _KF_.hCam.weakref();
	sc.pos <- _KF_.data_pos_comp.weakref();
	sc.ang <- _KF_.data_ang_comp.weakref();
	sc.fov <- _KF_.data_fov_comp.weakref();
	sc.idx <- 0;
	sc.lim <- 0;
};;

// build loading string
if( !("strLoading" in _KF_) )
{
	local i1 = -1,
		  i2 = 0,
		  d = "●",
		  b = " ",
		  a = array(64,b);

	_KF_.nIdxLoading <- 0;
	_KF_.strLoading <- [];

	for( local i = 0; i < 64; i++ )
	{
		++i1;
		++i2;
		i1 %= 64;
		i2 %= 64;

		a[i1] = b;
		a[i2] = d;

		local t = "";

		foreach(s in a) t += s;

		_KF_.strLoading.append(t);
	}
};;

// load materials
DebugDrawLine(Vector(),Vector(1,1,1),0,0,0,true,1);
DebugDrawBox(Vector(),Vector(),Vector(1,1,1),0,0,0,254,1);

//--------------------------------------------------------------

function _KF_::SetAngles(h,v) return h.SetAngles(v.x,v.y,v.z);
function _KF_::PlaySound(s) return ::HPlayer.EmitSound(s);
function _KF_::Hint(s) return ::VS.ShowHudHint(hHudHint, ::HPlayer, s);

function _KF_::Error(s)
{
	Msg(s);
	PlaySound("Bot.Stuck2");
}

function _KF_::MsgFail(s)
{
	Msg(s);
	// PlaySound("Player.WeaponSelected");
	PlaySound("UIPanorama.buymenu_failure");
}

function _KF_::MsgHint(s)
{
	Msg(s);
	Hint(s);
}

//function _KF_::DrawOverlay(i)
//{
//	if( i == 0 ) return::SendToConsole("r_screenoverlay\"\"");
//	if( i == 1 ) return::SendToConsole("r_screenoverlay\"keyframes/kf_dot_orange\"");
//	if( i == 2 ) return::SendToConsole("r_screenoverlay\"keyframes/kf_dot_red\"");
//}

// TODO: cleanup
// Process large data by splitting it into chunks, recursively process the chunkss
function _KF_::load(i)
{
	if( hCam.GetTeam() )
		return MsgFail("Cannot load file while compiling!");

	if( typeof i != "table" )
		return MsgFail("Invalid input.");

	if( !("pos" in i) || !("ang" in i) )
			return MsgFail("Invalid input.");

	Msg("\nPreparing to load...");
	PlaySound("UIPanorama.container_countdown");

	// keyframe data
	if( "anq" in i )
	{
		data_pos_load <- data_pos_kf.weakref();
		data_ang_load <- data_ang_kf.weakref();
		data_quat_load <- data_quat_kf.weakref();
		data_fov_load <- data_fov_kf.weakref();

		data_quat_load.resize(i.anq.len());
	}
	// path data
	else
	{
		data_pos_load <- data_pos_comp.weakref();
		data_ang_load <- data_ang_comp.weakref();
		data_fov_load <- data_fov_comp.weakref();
	};

	if( data_pos_load.len() != data_ang_load.len() )
		return Error("[ERROR] Corrupted data!");

	data_pos_load.resize(i.pos.len());
	data_ang_load.resize(i.ang.len());

	if( "fov" in i )
		data_fov_load.resize(i.fov.len());

	data_load_input <- i.weakref();

	_LIM <- i.pos.len();
	_STP <- 1450;
	_IDX <- 0;
	_CMX <- ::clamp(_STP, 0, _LIM);

	::print("Loading data...\n>.");

	return __load();
}

function _KF_::__load()
{
	if( "pos" in data_load_input )
	{
		// if(!(_IDX % 25))
		::print(".");

		for( local i = _IDX; i < _CMX; i++ )
			data_pos_load[i] = data_load_input["pos"][i].V();

		_IDX += _STP;
		_CMX = ::clamp(_CMX + _STP, 0, _LIM);

		if( _IDX >= _CMX )
		{
			::print("\n>.");

			delete data_pos_load;
			delete data_load_input["pos"];

			_IDX = 0;
			_CMX = ::clamp(_STP, 0, _LIM);
			return __load();
		};

		return::delay( "_KF_.__load()", FTIME );
	};

	if( "ang" in data_load_input )
	{
		::print(".");

		for( local i = _IDX; i < _CMX; i++ )
			data_ang_load[i] = data_load_input["ang"][i].V();

		_IDX += _STP;
		_CMX = ::clamp(_CMX + _STP, 0, _LIM);

		if( _IDX >= _CMX )
		{
			::print("\n>.");

			delete data_ang_load;
			delete data_load_input["ang"];

			_IDX = 0;
			_CMX = ::clamp(_STP, 0, _LIM);
			return __load();
		};

		return::delay( "_KF_.__load()", FTIME );
	};

	if( "anq" in data_load_input )
	{
		::print(".");

		for( local i = _IDX; i < _CMX; i++ )
			data_quat_load[i] = data_load_input["anq"][i].V();

		_IDX += _STP;
		_CMX = ::clamp(_CMX + _STP, 0, _LIM);

		if( _IDX >= _CMX )
		{
			::print("\n>.");

			delete data_quat_load;
			delete data_load_input["anq"];

			_IDX = 0;
			_CMX = ::clamp(_STP, 0, _LIM);
			return __load();
		};

		return::delay( "_KF_.__load()", FTIME );
	};

	if( "fov" in data_load_input )
	{
		::print(".");

		foreach( i, a in data_load_input["fov"] )
			data_fov_load[i] = clone a;

		delete data_load_input["fov"];

		return __load();
	};

	delete _LIM;
	delete _STP;
	delete _IDX;
	delete _CMX;

	PlaySound("UIPanorama.container_countdown");
	Msg("\n\nData loaded! " + ::VS.GetVarName(delete data_load_input));
}

//--------------------------------------------------------------

// see mode listen WASD
function _KF_::ListenKeys(i)
{
	if(i)
	{
		ListenMouse(0);

		::VS.AddOutput(hListener, "PressedAttack", NextKeyframe);
		::VS.AddOutput(hListener, "PressedAttack2", PrevKeyframe);

		hListener.ConnectOutput("PressedMoveRight","PressedMoveRight");
		hListener.ConnectOutput("UnpressedMoveRight","UnpressedMoveRight");
		hListener.ConnectOutput("PressedMoveLeft","PressedMoveLeft");
		hListener.ConnectOutput("UnpressedMoveLeft","UnpressedMoveLeft");
		hListener.ConnectOutput("PressedForward","PressedForward");
		hListener.ConnectOutput("UnpressedForward","UnpressedForward");
		hListener.ConnectOutput("PressedBack","PressedBack");
		hListener.ConnectOutput("UnpressedBack","UnpressedBack");

		hListener.SetTeam(::HPlayer.IsNoclipping().tointeger());

		// freeze player
		::HPlayer.__KeyValueFromInt("movetype",0);
	}
	else
	{
		hListener.DisconnectOutput("PressedAttack","PressedAttack");
		hListener.DisconnectOutput("PressedAttack2","PressedAttack2");
		hListener.DisconnectOutput("PressedMoveRight","PressedMoveRight");
		hListener.DisconnectOutput("UnpressedMoveRight","UnpressedMoveRight");
		hListener.DisconnectOutput("PressedMoveLeft","PressedMoveLeft");
		hListener.DisconnectOutput("UnpressedMoveLeft","UnpressedMoveLeft");
		hListener.DisconnectOutput("PressedForward","PressedForward");
		hListener.DisconnectOutput("UnpressedForward","UnpressedForward");
		hListener.DisconnectOutput("PressedBack","PressedBack");
		hListener.DisconnectOutput("UnpressedBack","UnpressedBack");

		// continue previous state
		// ::HPlayer.__KeyValueFromInt("movetype",hListener.GetTeam()?8:2);

		// just enable noclip
		// saving state causes problems for some reason
		// can't be bothered to find a solution
		::HPlayer.__KeyValueFromInt("movetype",8);
	};
}

// default listen MOUSE1, MOUSE2
function _KF_::ListenMouse(i)
{
	if(i)
	{
		ListenKeys(0);

		::VS.AddOutput(hListener, "PressedAttack",  AddKeyframe);
		::VS.AddOutput(hListener, "PressedAttack2", RemoveKeyframe);
	}
	else
	{
		hListener.DisconnectOutput("PressedAttack","PressedAttack");
		hListener.DisconnectOutput("PressedAttack2","PressedAttack2");
	};
}

VS.AddOutput(_KF_.hListener, "PressedMoveRight",  "_KF_.KEY_ROLL_R(1)");
VS.AddOutput(_KF_.hListener, "UnpressedMoveRight","_KF_.KEY_ROLL_R(0)");
VS.AddOutput(_KF_.hListener, "PressedMoveLeft",   "_KF_.KEY_ROLL_L(1)");
VS.AddOutput(_KF_.hListener, "UnpressedMoveLeft", "_KF_.KEY_ROLL_L(0)");
VS.AddOutput(_KF_.hListener, "PressedForward",    "_KF_.KEY_FOV_I(1)");
VS.AddOutput(_KF_.hListener, "UnpressedForward",  "_KF_.KEY_FOV_I(0)");
VS.AddOutput(_KF_.hListener, "PressedBack",       "_KF_.KEY_FOV_O(1)");
VS.AddOutput(_KF_.hListener, "UnpressedBack",     "_KF_.KEY_FOV_O(0)");

// +use to see
VS.AddOutput(_KF_.hListener, "PlayerOff", function()
{
	SeeKeyframe();

	::EntFireByHandle(hThinkKeys,"disable");
	IN_FOV_I = false;
	IN_FOV_O = false;
	IN_ROLL_R = false;
	IN_ROLL_L = false;

	::EntFireByHandle(hListener,"activate","",0,::HPlayer)
},_KF_);

//--------------------------------------------------------------

// Think keys roll
function _KF_::KEY_ThinkRoll()
{
	if( IN_ROLL_R )
	{
		qKeyLast.z = ::clamp(::floor(qKeyLast.z)+4, -180, 180);
		SetAngles(hCam, qKeyLast);
		Hint("Roll "+qKeyLast.z);
	}
	else if( IN_ROLL_L )
	{
		qKeyLast.z = ::clamp(::floor(qKeyLast.z)-4, -180, 180);
		SetAngles(hCam, qKeyLast);
		Hint("Roll "+qKeyLast.z);
	};;

	PlaySound("UIPanorama.store_item_rollover");
}

// Think keys fov
function _KF_::KEY_ThinkFOV()
{
	local f = FrameTime()*6;

	if( IN_FOV_I )
	{
		iFOV = ::clamp(iFOV-2,1,179);
		Hint("FOV "+iFOV);
		hCam.SetFov(iFOV,f);
	}
	else if( IN_FOV_O )
	{
		iFOV = ::clamp(iFOV+2,1,179);
		Hint("FOV "+iFOV);
		hCam.SetFov(iFOV,f);
	};;

	PlaySound("UIPanorama.store_item_rollover");
}

// roll clockwise
function _KF_::KEY_ROLL_R(i)
{
	if(i)
	{
		if( !bSeeing )
			return MsgFail("You need to be in see mode to use the key controls.");

		::VS.OnTimer(hThinkKeys,KEY_ThinkRoll);
		qKeyLast = ::VS.QuaternionAngles2(data_quat_kf[nCurrKeyframe],::Vector());

		IN_ROLL_R = true;
		::EntFireByHandle(hThinkKeys, "enable");
	}
	else
	{
		if( !bSeeing ) return;

		IN_ROLL_R = false;
		::EntFireByHandle(hThinkKeys, "disable");

		// save last set data
		data_quat_kf[nCurrKeyframe] = ::VS.AngleQuaternion(qKeyLast,::Quaternion());
	};
}

// roll counter-clockwise
function _KF_::KEY_ROLL_L(i)
{
	if(i)
	{
		if( !bSeeing )
			return MsgFail("You need to be in see mode to use the key controls.");

		::VS.OnTimer(hThinkKeys,KEY_ThinkRoll);
		qKeyLast = ::VS.QuaternionAngles2(data_quat_kf[nCurrKeyframe],::Vector());

		IN_ROLL_L = true;
		::EntFireByHandle(hThinkKeys, "enable");
	}
	else
	{
		if( !bSeeing ) return;

		IN_ROLL_L = false;
		::EntFireByHandle(hThinkKeys, "disable");

		// save last set data
		data_quat_kf[nCurrKeyframe] = ::VS.AngleQuaternion(qKeyLast,::Quaternion());
	};
}

// fov in
function _KF_::KEY_FOV_I(i)
{
	if(i)
	{
		if( !bSeeing )
			return MsgFail("You need to be in see mode to use the key controls.");

		::VS.OnTimer(hThinkKeys,KEY_ThinkFOV);
		iFOV = 90;
		IN_FOV_I = true;
		::EntFireByHandle(hThinkKeys, "enable");

		// get current fov value
		foreach( i,v in data_fov_kf ) if( v[0] == nCurrKeyframe )
		{
			iFOV = v[1] ? v[1] : 90;
			return;
		};

		// if the key doesnt have any fov data, create one
		data_fov_kf.append([nCurrKeyframe,0,0]);
	}
	else
	{
		if( !bSeeing ) return;

		IN_FOV_I = false;
		::EntFireByHandle(hThinkKeys, "disable");

		foreach( i,v in data_fov_kf ) if( v[0] == nCurrKeyframe )
			v[1] = iFOV;
	};
}

// fov out
function _KF_::KEY_FOV_O(i)
{
	if(i)
	{
		if( !bSeeing )
			return MsgFail("You need to be in see mode to use the key controls.");

		::VS.OnTimer(hThinkKeys,KEY_ThinkFOV);
		iFOV = 90;
		IN_FOV_O = true;
		::EntFireByHandle(hThinkKeys, "enable");

		// get current fov value
		foreach( i,v in data_fov_kf ) if( v[0] == nCurrKeyframe )
		{
			iFOV = v[1] ? v[1] : 90;
			return;
		};

		// if the key doesnt have any fov data, create one
		data_fov_kf.append([nCurrKeyframe,0,0]); // -1
	}
	else
	{
		if( !bSeeing ) return;

		IN_FOV_O = false;
		::EntFireByHandle(hThinkKeys, "disable");

		foreach( i,v in data_fov_kf ) if( v[0] == nCurrKeyframe )
			v[1] = iFOV;
	};
}

//--------------------------------------------------------------

function _KF_::ShowToggle(t)
{
	// kf_showpath
	if(t)
	{
		bShowPath = !bShowPath;
		Msg(bShowPath?"Showing path":"Hiding path");
	}
	// kf_showkeys
	else
	{
		bShowKeys = !bShowKeys;
		Msg(bShowKeys?"Showing keyframes":"Hiding keyframes");
	};

	::SendToConsole("clear_debug_overlays");
	PlaySound("UIPanorama.container_countdown");
}

// kf_edit
function _KF_::ToggleEditMode()
{
	if( hCam.GetTeam() )
		return MsgFail("Cannot "+(hThinkEdit.GetTeam()?"disable":"enable")+" edit mode while compiling!");

	local a,b;

	if( !data_pos_kf.len() )
	{
		a = true;
		data_pos_kf.clear();
		data_ang_kf.clear();
		Msg("No keyframes found.");
	};

	if( !data_pos_comp.len() )
	{
		b = true;
		data_pos_comp.clear();
		data_ang_comp.clear();
		Msg("No path data found.");
	};

	if( a&&b )
		return MsgFail("Cannot enable the edit mode!");

	// toggle
	hThinkEdit.SetTeam((!hThinkEdit.GetTeam()).tointeger());

	// on
	if( hThinkEdit.GetTeam() )
	{
		if( ::developer() > 1 )
		{
			Msg("Setting developer level to 1");
			::SendToConsole("developer 1");
		};

		// DrawOverlay(1);
		::SendToConsole("cl_drawhud 1");
		hKeySprite.__KeyValueFromInt("effects", EF.ON);
		::EntFireByHandle(hThinkEdit, "enable");

		Msg("Edit mode enabled.");
	}
	// off
	else
	{
		// unsee
		if( bSeeing )
			SeeKeyframe(1);

		// DrawOverlay(0);
		hKeySprite.__KeyValueFromInt("effects", EF.OFF);
		::EntFireByHandle(hThinkEdit, "disable");
		::EntFireByHandle(hGameText2, "settext", "", 0, ::HPlayer);

		Msg("Edit mode disabled.");
	};

	::SendToConsole("clear_debug_overlays");
	PlaySound("UIPanorama.container_countdown");
}

// kf_select
function _KF_::SelectKeyframe()
{
	if( !hThinkEdit.GetTeam() )
		return MsgFail("You need to be in edit mode to select.");

	// ( nSelectedKeyframe != nCurrKeyframe )
	if( nSelectedKeyframe == -1 )
	{
		nSelectedKeyframe = nCurrKeyframe;

		MsgHint("Selected key #" + nSelectedKeyframe);
	}
	else
	{
		MsgHint("Unselected key #" + nSelectedKeyframe);

		// unsee silently
		if( bSeeing )
			SeeKeyframe(1);

		nSelectedKeyframe = -1;
	};

	PlaySound("UIPanorama.container_countdown");
}

// kf_next
function _KF_::NextKeyframe()
{
	if( nSelectedKeyframe == -1 )
		return MsgFail("You need to have a key selected to use kf_next.");

	local t = (nSelectedKeyframe+1) % data_pos_kf.len(),
	      b = bSeeing;		// hold current value

	// unsee silently
	if(b) SeeKeyframe(1);

	nSelectedKeyframe = t;
	nCurrKeyframe = t;

	// then see again
	if(b) SeeKeyframe();
}

// kf_prev
function _KF_::PrevKeyframe()
{
	if( nSelectedKeyframe == -1 )
		return MsgFail("You need to have a key selected to use kf_prev.");

	// local t = clamp(nSelectedKeyframe-1,0,data_pos_kf.len()-1),

	local n = nSelectedKeyframe-1;

	if( n < 0 )
		n += data_pos_kf.len();

	local t = n % data_pos_kf.len(),
	      b = bSeeing;

	// unsee silently
	if(b) SeeKeyframe(1);

	nSelectedKeyframe = t;
	nCurrKeyframe = t;

	// then see again
	if(b) SeeKeyframe();
}

// kf_see
// if i == true, unsee. NO error and safety checks
// TODO: a better method?
function _KF_::SeeKeyframe(i=0)
{
	if(i)
	{
		__CompileFOV();
		bSeeing = false;
		if( nSelectedKeyframe != -1 ) SelectKeyframe();
		hKeySprite.__KeyValueFromInt("effects", EF.ON);
		hCam.SetFov(0,0.1);
		::EntFireByHandle(hCam, "disable", "", 0, ::HPlayer);
		ListenMouse(1);
		return;
	};

	if( hCam.GetTeam() )
		return MsgFail("Cannot modify keyframes while compiling!");

	if( hThinkSet.GetTeam() || bStartedPending )
		return MsgFail("Cannot use see while in playback!");

	if( !hThinkEdit.GetTeam() )
		return MsgFail("You need to be in edit mode to use see.");

	if( !data_pos_kf.len() )
		return MsgFail("No keyframes found.");

	bSeeing = !bSeeing;

	if( bSeeing )
	{
		// if not selected, select
		if( nSelectedKeyframe == -1 )
			SelectKeyframe();

		// hide the helper
		hKeySprite.__KeyValueFromInt("effects", EF.OFF);

		// set fov and pos to selected
		foreach( v in data_fov_kf ) if( v[0] == nSelectedKeyframe )
			hCam.SetFov(v[1],0.25);

		hCam.SetOrigin(data_pos_kf[nSelectedKeyframe]);
		SetAngles(hCam, VS.QuaternionAngles2(data_quat_kf[nSelectedKeyframe]));
		::EntFireByHandle(hCam, "enable", "", 0, HPlayer);

		ListenKeys(1);

		MsgHint("Seeing key #"+nSelectedKeyframe);
	}
	else
	{
		__CompileFOV();

		// if selected, unselect
		if( nSelectedKeyframe != -1 )
			SelectKeyframe();

		hKeySprite.__KeyValueFromInt("effects", EF.ON);
		hCam.SetFov(0,0.1);
		::EntFireByHandle(hCam, "disable", "", 0, ::HPlayer);
		// ListenKeys(0);

		ListenMouse(1);

		MsgHint("Stopped seeing.");
	};

	PlaySound("UIPanorama.container_countdown");
}

// constant values that are called very often - in loops
local vi = Vector(-8,-8,-8),
      vx = Vector(8,8,8),
      DrawBox = DebugDrawBox;

// Think UI
VS.OnTimer(_KF_.hThinkEdit,function():(vi,vx,DrawBox)
{
	local keys = data_pos_kf,
	      time = flTimeShow;

	if(keys.len())
	{
		local h = "";

		// not selected any key
		if( nSelectedKeyframe == -1 )
		{
			local k = keys.len()-1,
			      b = 0.9, // threshold
			      E = ::HPlayer.EyePosition(),
			      D = ::HPlayerEye.GetForwardVector();

			// VS.FindEntityNearestFacing
			foreach( i, v in keys )
			{
				local d = v - E;
				d.Norm();
				local d = D.Dot(d);

				if( d > b )
				{
					k = i;
					b = d;
				};

				if( bShowKeys )
					DrawBox(v, vi, vx, 255, 0, 0, 0, time);
			}

			nCurrKeyframe = k;
		}
		else if( bShowKeys )
		{
			h = " (HOLD)";

			foreach( i, v in keys )
				DrawBox(v, vi, vx, 255, 0, 0, 0, time);
		};;

		// show fov
		foreach( v in data_fov_kf ) if( v[0] == nCurrKeyframe )
			hGameText2.__KeyValueFromString("message", "FOV: " + v[1]);

		hGameText.__KeyValueFromString("message", "KEY: " + nCurrKeyframe + h);
		::EntFireByHandle(hGameText, "display", "", 0, ::HPlayer);
		::EntFireByHandle(hGameText2, "display", "", 0, ::HPlayer);
		::EntFireByHandle(hGameText2, "settext", "", 0, ::HPlayer);

		local k = keys[nCurrKeyframe];

		// selected key
		DrawBox(k, vi, vx, 255, 138, 0, 255, time);
		hKeySprite.SetOrigin(k);

//		if( bMoveMode )
//		{
//			hKeySprite.SetOrigin(Vector());
//			hHelperTranslate.SetOrigin(k);
//
//			local ORIG = HPlayer.EyePosition();
//			local tr = VS.TraceDir(ORIG, HPlayerEye.GetForwardVector()).Ray();
//
//			local origX = k; //+ Vector(32,0,0);
//			local minsX = Vector(-54,-3,-3);
//			local maxsX = Vector(54,3,3);
//
//			if( VS.IsBoxIntersectingRay(origX, minsX, maxsX, tr, 0.5) )
//			{
//				Hint("X")
//
//				DebugDrawLine(k, k - Vector(-128,0,0), 255, 255, 255, true, time);
//				DebugDrawBox(origX, minsX, maxsX, 255, 0, 0, 154, time);
//			}
//			else
//			{
//				local origY = k; //+ Vector(0,32,0);
//				local minsY = Vector(-3,-54,-3);
//				local maxsY = Vector(3,54,3);
//
//				if( VS.IsBoxIntersectingRay(origY, minsY, maxsY, tr, 0.5) )
//				{
//					Hint("Y")
//
//					DebugDrawLine(k, k - Vector(0,-128,0), 255, 255, 255, true, time);
//					DebugDrawBox(origY, minsY, maxsY, 0, 255, 0, 154, time);
//				}
//				else
//				{
//					local origZ = k; //+ Vector(0,0,32);
//					local minsZ = Vector(-3,-3,-54);
//					local maxsZ = Vector(3,3,54);
//
//					if( VS.IsBoxIntersectingRay(origZ, minsZ, maxsZ, tr, 0.5) )
//					{
//						Hint("Z")
//
//						DebugDrawLine(k, k + Vector(0,0,128),  255, 255, 255, true, time);
//						DebugDrawBox(origZ, minsZ, maxsZ, 0, 0, 255, 127, time);
//					};
//				};
//			};
//		};
	};

	if( bShowPath )
	{
		local Y = nDrawResolution,
		      k = data_pos_comp,
		      a = data_ang_comp,
		      L = ::DebugDrawLine,
		      A = ::VS.AngleVectors,
		      n = data_pos_comp.len()-Y;

		for( local i = 0; i < n; i+=Y )
		{
			local p = k[i];
			L(p, p + A(a[i]) * 16, 255, 128, 255, true, time);
			L(p, k[i+Y], 138, 255, 0, true, time);
		}
	};
},_KF_);

//--------------------------------------------------------------

// kf_replace
function _KF_::ReplaceKeyframe()
{
	if( hCam.GetTeam() )
		return MsgFail("Cannot modify keyframes while compiling!");

	if( !data_pos_kf.len() )
		return MsgFail("No keyframes found.");

	if( !hThinkEdit.GetTeam() )
		return MsgFail("You need to be in edit mode to insert keyframes.");

	if( bSeeing )
		return MsgFail("Cannot replace while seeing!");

	// undolast_replace
	list_last_replace = [nCurrKeyframe,
	                     data_pos_kf[nCurrKeyframe],
	                     data_ang_kf[nCurrKeyframe],
	                     data_quat_kf[nCurrKeyframe]];

	local pos = ::HPlayer.EyePosition(),
	      dir = ::HPlayerEye.GetForwardVector();

	data_pos_kf[nCurrKeyframe] = pos;
	data_ang_kf[nCurrKeyframe] = dir;
	data_quat_kf[nCurrKeyframe] = ::VS.AngleQuaternion(::HPlayerEye.GetAngles(), ::Quaternion());

	::DebugDrawLine(pos, pos + dir * 64, 138, 255, 0, true, 7);
	::DebugDrawBox(pos, ::Vector(-4,-4,-4), ::Vector(4,4,4), 138, 255, 0, 127, 7);

	MsgHint("Replaced keyframe #" + nCurrKeyframe);
	PlaySound("UIPanorama.container_countdown");
}

// kf_insert
function _KF_::InsertKeyframe()
{
	if( hCam.GetTeam() )
		return MsgFail("Cannot modify keyframes while compiling!");

	if( !data_pos_kf.len() )
		return MsgFail("No keyframes found.");

	if( !hThinkEdit.GetTeam() )
		return MsgFail("You need to be in edit mode to insert keyframes.");

	if( bSeeing )
		return MsgFail("Cannot insert while seeing!");

	local pos = ::HPlayer.EyePosition(),
	      dir = ::HPlayerEye.GetForwardVector();

	local i = nCurrKeyframe+1;

	data_pos_kf.insert(i, pos);
	data_ang_kf.insert(i, dir);
	data_quat_kf.insert(i, ::VS.AngleQuaternion(::HPlayerEye.GetAngles(), ::Quaternion()));

	::DebugDrawLine(pos, pos + dir * 64, 138, 255, 0, true, 7);
	::DebugDrawBox(pos, ::Vector(-4,-4,-4), ::Vector(4,4,4), 138, 255, 0, 127, 7);

	MsgHint("Inserted keyframe #" + i);
	PlaySound("UIPanorama.container_countdown");
}

// kf_remove
function _KF_::RemoveKeyframe()
{
	if( hCam.GetTeam() )
		return MsgFail("Cannot modify keyframes while compiling!");

	if( !data_pos_kf.len() )
		return MsgFail("No keyframes found.");

	if( !hThinkEdit.GetTeam() )
		return MsgFail("You need to be in edit mode to remove keyframes.");

	// unsee
	if( bSeeing )
		SeeKeyframe(1);

	// undolast_remove
	list_last_remove = [nCurrKeyframe,
	                    data_pos_kf.remove(nCurrKeyframe),
	                    data_ang_kf.remove(nCurrKeyframe),
	                    data_quat_kf.remove(nCurrKeyframe)];

	foreach( i,v in data_fov_kf ) if( v[0] == nCurrKeyframe )
	{
		list_last_remove.append(data_fov_kf.remove(i));

		__CompileFOV();
	};

	if( !data_pos_kf.len() )
	{
		MsgHint("Removed all keyframes.");

		// current
		nCurrKeyframe = 0;

		// unselect
		nSelectedKeyframe = -1;

		// cheap way to hide the sprite
		hKeySprite.SetOrigin(VEC_MAX);
	}
	else
	{
		MsgHint("Removed keyframe #" + nCurrKeyframe);

		// if out of bounds, reset
		if( !(nCurrKeyframe in data_pos_kf) )
		{
			nCurrKeyframe = 0;
			nSelectedKeyframe = -1;
		};
	};

	PlaySound("UIPanorama.container_countdown");
}

// undolast
function _KF_::UndoLast(t)
{
	if( hCam.GetTeam() )
		return MsgFail("Cannot modify keyframes while compiling!");

	// remove undo
	if(t)
	{
		if( !list_last_remove.len() )
			return MsgFail("No removed key found.");

		local i = list_last_remove[0];

		data_pos_kf.insert(i,list_last_remove[1]);
		data_ang_kf.insert(i,list_last_remove[2]);
		data_quat_kf.insert(i,list_last_remove[3]);

		if( list_last_remove.len() > 4 )
			data_fov_kf.append(list_last_remove[4]);

		if( list_last_remove.len() > 5 )
			Error("[ERROR] Assertion failed. Duplicated FOV data.");

		list_last_remove.clear();

		MsgHint("Undone remove #" + i);
	}
	// replace undo
	else
	{
		if( !list_last_replace.len() )
			return MsgFail("No replaced key found.");

		local i = list_last_replace[0];

		data_pos_kf[i] = list_last_replace[1];
		data_ang_kf[i] = list_last_replace[2];
		data_quat_kf[i] = list_last_replace[3];

		list_last_replace.clear();

		MsgHint("Undone replace #" + i);
	};

	PlaySound("UIPanorama.container_countdown");
}

// kf_removefov
function _KF_::RemoveFOV()
{
	if( hCam.GetTeam() )
		return MsgFail("Cannot modify keyframes while compiling!");

	if( !data_pos_kf.len() )
		return MsgFail("No keyframes found.");

	if( !hThinkEdit.GetTeam() )
		return MsgFail("You need to be in edit mode to remove FOV data.");

	// refresh
	if( bSeeing )
		hCam.SetFov(0,0.1);

	foreach( i,v in data_fov_kf ) if( v[0] == nCurrKeyframe )
		data_fov_kf.remove(i);

	__CompileFOV();

	MsgHint("Removed FOV data at key #" + nCurrKeyframe);
	PlaySound("UIPanorama.container_countdown");
}

// kf_add
function _KF_::AddKeyframe()
{
	if( hCam.GetTeam() )
		return MsgFail("Cannot modify keyframes while compiling!");

	if( bSeeing )
		return MsgFail("Cannot add new keyframe while seeing!");

	local pos = ::HPlayer.EyePosition(),
	      dir = ::HPlayerEye.GetForwardVector();

	data_pos_kf.append(pos);
	data_ang_kf.append(dir);
	data_quat_kf.append(::VS.AngleQuaternion(::HPlayerEye.GetAngles(), ::Quaternion()));

	::DebugDrawLine(pos, pos + dir * 64, 138, 255, 0, true, 7);
	::DebugDrawBox(pos, Vector(-4,-4,-4), Vector(4,4,4), 138, 255, 0, 127, 7);

	MsgHint("Added keyframe #" + (data_pos_kf.len()-1));
	PlaySound("UIPanorama.container_countdown");
}

// kf_clear
function _KF_::ClearKeyframes()
{
	if( hCam.GetTeam() )
		return MsgFail("Cannot modify keyframes while compiling!");

	if( !data_pos_kf.len() )
		return MsgFail("No keyframes found.");

	// unsee
	if( bSeeing )
		SeeKeyframe(1);

	// unselect
	nSelectedKeyframe = -1;

	// current
	nCurrKeyframe = 0;

	MsgHint("Cleared "+data_pos_kf.len()+" keyframes.");

	data_pos_kf.clear();
	data_ang_kf.clear();
	data_quat_kf.clear();
	data_fov_kf.clear();

	// undolast
	list_last_replace.clear();
	list_last_remove.clear();

	// cheap way to hide the sprite
	hKeySprite.SetOrigin(VEC_MAX);

	PlaySound("UIPanorama.container_countdown");
}

// kf_mode_ang
function _KF_::SetInterpMode(i)
{
	if( hCam.GetTeam() )
		return MsgFail("Cannot change algorithm while compiling!");

	switch(i)
	{
		case 0:
			bInterpModeAng = !bInterpModeAng;
			Msg("Now using the "+(bInterpModeAng?"default":"stabilised")+" angle algorithm.");
			break;
	}

	PlaySound("UIPanorama.container_countdown");
}

//--------------------------------------------------------------

// kf_compile
function _KF_::Compile()
{
	if( hCam.GetTeam() )
		return MsgFail("Compilation in progress...");

	if( hThinkSet.GetTeam() || bStartedPending )
		return MsgFail("Cannot compile while in playback!");

	if( !data_pos_kf.len() )
		return MsgFail("No keyframes found.");

	if( data_pos_kf.len() < 4 )
		return MsgFail("Not enough keyframes to compile. (Required minimum amount: 4)");

	if( data_pos_kf.len() != data_ang_kf.len() || data_ang_kf.len() != data_quat_kf.len() )
		return Error("[ERROR]\nAssertion failed: Corrupted keyframe data! [p" + data_pos_kf.len() + ",a" + data_ang_kf.len() + ",q" + data_quat_kf.len() + "]");

	// compiling
	hCam.SetTeam(1);

	// stop seeing
	SeeKeyframe(1);

	// temporarily disable edit mode
	::EntFireByHandle(hThinkEdit, "disable");
	::SendToConsole("clear_debug_overlays");
	// DrawOverlay(2);
	hKeySprite.SetOrigin(VEC_MAX);

	Msg("\nPreparing..." + "\nResolution          : " + flInterpResolution + "\nTime between 2 keys : "+(FTIME/flInterpResolution)+"s\nAngle algorithm     : "+(bInterpModeAng?"default":"stabilised")+"\n");
	PlaySound("UIPanorama.container_countdown");

	return::delay( "_KF_._Compile.__Compile()", flTimeShow+::FrameTime() );
}

// TODO: Implement consistent speed
function _KF_::_Compile::__Compile()
{
	// an alternative to inserting would be calculating the future length of
	// the compiled data, and creating that sized empty arrays, and accessing those indices
	// but I'm fine with inserting
	// data_pos_comp = ::array(data_pos_kf.len());
	// data_ang_comp = ::array(data_ang_kf.len());
	data_pos_comp.clear();
	data_ang_comp.clear();
	data_pos_comp.resize(data_pos_kf.len());
	data_ang_comp.resize(data_ang_kf.len());

	RTIME = FTIME; // FrameTime()*1.5;
	_STP = 10;
	if( flInterpResolution <= 0.025 )
	{
		_STP = 2;
		RTIME *= 2;
	};
	_CLI = 0;
	__STP = ::floor(1.0/flInterpResolution);
	_IDX = 0;
	_CMX = ::clamp(_STP, 0, __STP);

	nDrawResolution = __STP.tointeger() / 10;

	::print("Compiling (1/3) ");
	return::delay( "_KF_._Compile.__SplineOrigin()", RTIME );
}

function _KF_::_Compile::__SplineOrigin()
{
	if(!(_IDX % 25)) ::print(".");

	// if(!(_IDX % 10))
	nIdxLoading %= 63;
	Hint(strLoading[++nIdxLoading]);

	local s = Catmull_Rom_Spline,
	      c = data_pos_kf,
	      l = c.len()-3,
	      k = data_pos_comp,
	      v = ::Vector;

	for( local i,j = _IDX, f = flInterpResolution * _IDX; j < _CMX; ++j, f += flInterpResolution )
		for( i = 0; i < l; ++i )
			k.insert((j+2)+(i*(j+2)),s(c[i],c[i+1],c[i+2],c[i+3],f,v()));

	_IDX += _STP;
	_CMX = ::clamp(_CMX + _STP, 0, __STP);

	// complete
	if( _IDX >= _CMX )
	{
		::print("\n");
		data_pos_comp.pop();
		data_pos_comp.pop();
		data_pos_comp.remove(0);

		// next process
		_IDX = 0;
		_CMX = ::clamp(_STP, 0, __STP);

		::print("Compiling (2/3) ");
		return __SplineAngles();
	};

	return::delay( "_KF_._Compile.__SplineOrigin()", RTIME );
}

function _KF_::_Compile::__SplineAngles()
{
	if(!(_IDX % 25)) ::print(".");

	// if(!(_IDX % 10))
	nIdxLoading %= 63;
	Hint(strLoading[++nIdxLoading]);

	if( bInterpModeAng )
	{
		local a = QAngleNormalize,
		      b = QuaternionAngles2,
		      c = Catmull_Rom_SplineQ,
		      q = data_quat_kf,
		      l = q.len()-3,
		      k = data_ang_comp,
		      v = ::Vector,
		      t = ::Quaternion;

		for( local i,j = _IDX, f = flInterpResolution * _IDX; j < _CMX; ++j, f += flInterpResolution )
			for( i = 0; i < l; ++i )
				k.insert((j+2)+(i*(j+2)),a(b(c(q[i],q[i+1],q[i+2],q[i+3],f,t()),v())));
	}
	else
	{
		local a = QAngleNormalize,
		      b = VectorAngles,
		      c = Catmull_Rom_Spline,
		      e = data_ang_kf,
		      l = e.len()-3,
		      k = data_ang_comp,
		      v = ::Vector;

		for( local i,j = _IDX, f = flInterpResolution * _IDX; j < _CMX; ++j, f += flInterpResolution )
			for( i = 0; i < l; ++i )
				k.insert((j+2)+(i*(j+2)),a(b(c(e[i],e[i+1],e[i+2],e[i+3],f,v()))));
	};

	_IDX += _STP;
	_CMX = ::clamp(_CMX + _STP, 0, __STP);

	// complete
	if( _IDX >= _CMX )
	{
		::print("\n");
		data_ang_comp.pop();
		data_ang_comp.pop();
		data_ang_comp.remove(0);

		// next process
		_IDX = 0;
		_CMX = ::clamp(_STP, 0, __STP);

		::print("Compiling (3/3) ");
		return __Clear();
	};

	return::delay( "_KF_._Compile.__SplineAngles()", RTIME );
}

function _KF_::_Compile::__Clear()
{
	if(!(_CLI % 175)) ::print(".");

	if(!(_CLI % 50))
	{
		nIdxLoading %= 63;
		Hint(strLoading[++nIdxLoading]);
	};

	// don't do this because a large data may cause issues. delay recursion instead
	// for( local i = data_pos_comp.len(); i >= _CLI; --i )
	for( local i = _CLI; i < data_pos_comp.len(); ++i )
		if( data_pos_comp[i] == null )
		{
			data_pos_comp.remove(i);
			data_ang_comp.remove(i);
			_CLI = i;

			return::delay( "_KF_._Compile.__Clear()", RTIME );
		};

	::delay( "print(\".\");_KF_._Compile.__CompileFOV();delay(\"_KF_._Compile.__Finish()\",_KF_._Compile.RTIME)", RTIME );
}

function _KF_::_Compile::__Finish()
{
	RTIME = null;
	_CLI = null;
	_STP = null;
	_IDX = null;
	_CMX = null;

	// complete
	hCam.SetTeam(0);
	::EntFireByHandle(hThinkEdit, hThinkEdit.GetTeam()?"enable":"disable");
	// DrawOverlay(hThinkEdit.GetTeam()?1:0);
	Msg("\n\nCompiled keyframes: "+data_pos_comp.len() * FTIME+" seconds\n\n* Play the compiled data      kf_play\n* Toggle edit mode            kf_edit\n* Save the compiled data      kf_save\n* Save the keyframes          kf_savekeys\n\n* List all commands           kf_cmd\n");
	Hint("Compilation complete!");
	PlaySound("UIPanorama.container_countdown");
}

function _KF_::_Compile::__CompileFOV()
{
	local _f = data_fov_kf;

	if( !_f.len() )
	{
		data_fov_comp.clear();
		return;
	};

	_f.sort(sort);

	// FOV data at key 0 is invalid
	if( _f[0][0] == 0 ) _f.remove(0);

	if( !_f.len() ) return;

	// if key 1 doesn't have an FOV value, set to 90
	if( _f[0][0] != 1 ) _f.insert(0,[1,90,0]);

	// data_fov_comp = ::array(_f.len()-1);
	data_fov_comp.clear();
	data_fov_comp.resize(_f.len()-1);

	local i  = -1,
	      t  = FTIME/flInterpResolution,
	      _v = data_fov_comp,
	      l  = _f.len()-1;

	while( l>++i )
	{
		local v = _f[i],
		      c = _f[i+1];

		local d = (c[0]-v[0]) * t;

		_v[i] = [ (v[0]-1)*__STP, c[1], d ];
	}

	// key 1
	if( _f[0][0] == 1 )
		_v.insert(0,[-__STP,_f[0][1],0]);

	// to be safe
	// this shouldn't be necessary
	_v.sort(sort);
}

//--------------------------------------------------------------

// (0)kf_save, (1)kf_savekeys
function _KF_::Save( i = 0 )
{
	if( hCam.GetTeam() )
		return MsgFail("Cannot save while compiling!");

	if( !i )
	{
		if( !data_pos_comp.len() )
			return MsgFail("No compiled keyframes found.");
	}
	else
	{
		if( !data_pos_kf.len() )
			return MsgFail("No keyframes found.");
	};

	// DrawOverlay(2);

	_Save.LOG = ::VS.Log.L.weakref();

	::VS.Log.Clear();
	::VS.Log.filePrefix = "scripts/vscripts/kf_data";
	::VS.Log.condition = true;
	::VS.Log.export = true;
	::VS.Log.filter = "L ";

	_Save.LOG.append("l_" + (i?"keys_":"") + ::split(::GetMapName(),"/").top() + " <-{pos=[");

	_Save.data_pos_save = i ? data_pos_kf.weakref() : data_pos_comp.weakref();
	_Save.data_ang_save = i ? data_ang_kf.weakref() : data_ang_comp.weakref();

	_Save._LIM = _Save.data_pos_save.len();
	_Save._STP = 1450;
	_Save._IDX = 0;
	_Save._CMX = ::clamp(_Save._STP, 0, _Save._LIM);

	return _Save.__pos(i);
}

// save run
function _KF_::_Save::__Finish(i)
{
	local file = ::VS.Log.Run();
	Msg("\n* "+(i?"Keyframe":"Path")+" data is exported: /csgo/"+file+".log\n");

	LOG = null;
	data_pos_save = null;
	data_ang_save = null;
	_LIM = null;
	_STP = null;
	_IDX = null;
	_CMX = null;

	::PrecacheScriptSound("Survival.TabletUpgradeSuccess");
	PlaySound("Survival.TabletUpgradeSuccess");

	// DrawOverlay(hThinkEdit.GetTeam()?1:0);
}

// save pos
function _KF_::_Save::__pos(i)
{
	for( local i = _IDX; i < _CMX; i++ )
		LOG.append(VecToString(data_pos_save[i],"V("));

	_IDX += _STP;
	_CMX = ::clamp(_CMX + _STP, 0, _LIM);

	if( _IDX >= _CMX )
	{
		LOG.append("]ang=[");
		_IDX = 0;
		_CMX = ::clamp(_STP, 0, _LIM );
		return __ang(i);
	};

	return::delay( "_KF_._Save.__pos("+i+")", FTIME );
}

// save ang, quat, fov
function _KF_::_Save::__ang(i)
{
	for( local i = _IDX; i < _CMX; i++ )
		LOG.append(VecToString(data_ang_save[i],"V("));

	_IDX += _STP;
	_CMX = ::clamp(_CMX + _STP, 0, _LIM);

	if( _IDX >= _CMX )
	{
		LOG.pop();
		LOG.append(VecToString(data_ang_save[data_ang_save.len()-1],"V(") + "]");

		local kf;

		// saving keys?
		if(i)
		{
			local l = data_quat_kf.len();

			LOG.append("anq=[");

			for( local i = 0; i < l; i++ )
			{
				local q = data_quat_kf[i];
				LOG.append("Q(" + q.x + ","+ q.y + "," + q.z + "," + q.w + ")");
			}

			LOG.append("]");

			kf = data_fov_kf;
		}
		else kf = data_fov_comp;

		// save fov
		if(kf.len())
		{
			LOG.append("fov=[");

			foreach( a in kf )
			{
				LOG.append("[");

				foreach( v in a )
				{
					LOG.append(v);
					LOG.append(",");
				}

				LOG.pop();
				LOG.append("]");
				LOG.append(",");
			}

			LOG.pop();
			LOG.append("]");
		};

		LOG.append("}\n");

		return __Finish(i);
	};

	return::delay( "_KF_._Save.__ang("+i+")", FTIME );
}

VS.OnTimer(_KF_.hThinkSet, function()
{
	cam.SetOrigin(pos[idx]);
	local a = ang[idx];
	cam.SetAngles(a.x,a.y,a.z);

	foreach( x in fov ) if( x[0] == idx )
	{
		cam.SetFov(x[1],x[2]);
		break;
	};

	if( ++idx >= lim )
		::_KF_.Stop();
},null,true);

// kf_play
function _KF_::Play()
{
	if( hCam.GetTeam() )
		return MsgFail("Cannot start playback while compiling!");

	if( bStartedPending )
		return MsgFail("Playback has not started yet!");

	if( hThinkSet.GetTeam() )
		return MsgFail("Playback is already running.");

	// unsee
	if( bSeeing )
		SeeKeyframe(1);

	if( !data_pos_comp.len() )
		return MsgFail("No compiled data found.");

	if( data_pos_comp.len() != data_ang_comp.len() )
		return Error("Corrupted data! [" + data_pos_comp.len() + "," + data_ang_comp.len() + "]");

	if( ::developer() > 1 )
	{
		Msg("Setting developer level to 1");
		::SendToConsole("developer 1");
	};

	local s = hThinkSet.GetScriptScope();
	s.lim = s.pos.len();
	s.idx = 0;

	// initiate cam
	if( s.fov.len() )
		if( s.fov[0][0] == -__STP )
			hCam.SetFov(s.fov[0][1],0);;

	hCam.SetOrigin(s.pos[0]);
	SetAngles(hCam,s.ang[0]);
	::EntFireByHandle(hCam, "enable", "", 0, ::HPlayer);
	::EntFireByHandle(hThinkSet, "disable");

	MsgHint("Starting in 3...");PlaySound("UI.CounterBeep");
	::delay( "_KF_.MsgHint(\"Starting in 2...\");_KF_.PlaySound(\"UI.CounterBeep\")", 1.0 );
	::delay( "_KF_.MsgHint(\"Starting in 1...\");_KF_.PlaySound(\"UI.CounterBeep\")", 2.0 );

	::HPlayer.SetHealth(1337);
	::VS.HideHudHint(hHudHint, ::HPlayer, 3.0-::FrameTime());

	bStartedPending = true;
	::delay( "_KF_.bStartedPending=false;_KF_.hThinkSet.SetTeam(1);_KF_.Msg(\"Playback has started...\\n\");EntFireByHandle(_KF_.hThinkSet,\"enable\")", 3.0 );
}

// kf_stop
function _KF_::Stop()
{
	if( !hThinkSet.GetTeam() )
		return MsgFail("Playback is not running.");

	hThinkSet.SetTeam(0);

	::EntFireByHandle(hCam, "disable", "", 0, ::HPlayer);
	::EntFireByHandle(hThinkSet, "disable");

	hCam.SetFov(0,0);

	Msg("Playback has ended.");
	PlaySound("UI.RankDown");
}

//--------------------------------------------------------------

// interp resolution
function _KF_::res(f)
{
	if( hCam.GetTeam() )
		return MsgFail("Cannot change resolution while compiling!");

	if( f < 0.001 || f > 0.5 )
		return MsgFail("Invalid resolution range. [0.001, 0.5]");

	flInterpResolution = f.tofloat();
	__STP = floor(1.0/flInterpResolution);
	Msg("Interpolation resolution set to: " + flInterpResolution);
	Msg("Time between 2 keyframes: " + (FTIME/flInterpResolution) + " second(s)");
	PlaySound("UIPanorama.container_countdown");
}

function _KF_::fov(x)
{
	if( hCam.GetTeam() )
		return MsgFail("Cannot modify keyframes while compiling!");

	if( !data_pos_kf.len() )
		return MsgFail("No keyframes found.");

	if( !hThinkEdit.GetTeam() )
		return MsgFail("You need to be in edit mode to add new FOV data.");

	PlaySound("UIPanorama.container_countdown");

	x = x.tofloat();

	// refresh
	if( bSeeing )
		hCam.SetFov(x,0.25);

	local q = [nCurrKeyframe,x,0];

	foreach( i,v in data_fov_kf ) if( v[0] == nCurrKeyframe )
	{
		data_fov_kf[i] = q;
		__CompileFOV();

		MsgHint("Set key #" + nCurrKeyframe + " FOV to " + x);
		// MsgHint("Replaced previous FOV key.");
		return;
	};

	__CompileFOV();

	MsgHint("Set key #" + nCurrKeyframe + " FOV to " + x);
}

function _KF_::roll(v)
{
	if( hCam.GetTeam() )
		return MsgFail("Cannot modify keyframes while compiling!");

	if( !hThinkEdit.GetTeam() )
		return MsgFail("You need to be in edit mode to use camera roll.");

	v = ::VS.AngleNormalize(v.tofloat());

	local a = ::VS.QuaternionAngles2(data_quat_kf[nCurrKeyframe]);

	a.z = v;

	data_quat_kf[nCurrKeyframe] = ::VS.AngleQuaternion(a,::Quaternion());

	// refresh
	if( bSeeing )
	{
		if( nSelectedKeyframe == -1 )
			return Error("[ERROR] Assertion failed. Seeing while no key is selected.");

		SetAngles(hCam, ::VS.QuaternionAngles2(data_quat_kf[nSelectedKeyframe]));
	};

	MsgHint("Set key #" + nCurrKeyframe + " roll to " + v);
	PlaySound("UIPanorama.container_countdown");
}

_KF_.__CompileFOV <- _KF_._Compile.__CompileFOV.bindenv(_KF_._Compile);

// global bindings for easy use with 'script XX()'
::roll <- _KF_.roll.bindenv(_KF_);
::fov <- _KF_.fov.bindenv(_KF_);
::res <- _KF_.res.bindenv(_KF_);
::load <- _KF_.load.bindenv(_KF_);

//--------------------------------------------------------------

function _KF_::PostSpawn()
{
	if( ::HPlayer.GetTeam() != 2 && ::HPlayer.GetTeam() != 3 )
		::HPlayer.SetTeam(2);

	PlaySound("Player.DrownStart");
	::HPlayer.SetHealth(1337);

	// key listener
	::EntFireByHandle(hListener, "activate", "", 0, ::HPlayer);

	ListenMouse(1);

	::ClearChat();
	::ClearChat();
	::Chat(::txt.blue+" --------------------------------");
	::Chat("");
	::Chat(::txt.lightgreen + "[Keyframes Script v"+_VER_+"]");
	::Chat(::txt.orange+"'"+::txt.white+"kf_cmd" + ::txt.orange + "': Print all commands");
	::Chat("");
	::Chat(::txt.blue+" --------------------------------");

	// print after Steamworks Msg
	if( ::GetDeveloperLevel() > 0 )
		::delay("SendToConsole(\"clear;script _KF_.WelcomeMsg()\")", 0.75);
	else WelcomeMsg();

	delete PostSpawn;
}

function _KF_::WelcomeMsg()
{
	Msg("\n\n\n   [v"+_VER_+"]     github.com/samisalreadytaken/keyframes\n\nkf_add                : Add new keyframe\nkf_remove             : Remove the selected key\nkf_remove_undo        : Undo last remove action\nkf_removefov          : Remove the FOV data from the selected key\nkf_clear              : Remove all keyframes\nkf_insert             : Insert new keyframe after the selected key\nkf_replace            : Replace the selected key\nkf_replace_undo       : Undo last replace action\n                      :\nkf_compile            : Compile the keyframe data\nkf_play               : Play the compiled data\nkf_stop               : Stop playback\nkf_save               : Save the compiled data\nkf_savekeys           : Save the keyframe data\n                      :\nkf_mode_ang           : Toggle stabilised angles algorithm\n                      :\nkf_edit               : Toggle edit mode\nkf_select             : In edit mode, hold the current selection\nkf_see                : In edit mode, see the current selection\nkf_next               : While holding a key, select the next one\nkf_prev               : While holding a key, select the previous one\nkf_showkeys           : In edit mode, toggle showing keyframes\nkf_showpath           : In edit mode, toggle showing the path\n                      :\nscript fov(val)       : Set FOV data on the selected key\nscript roll(val)      : Set camera roll on the selected key\n                      :\nscript load(input)    : Load new data from file\n                      :\nkf_cmd                : List all commands\n\n--- --- --- --- --- ---\n\nMOUSE1                : kf_add\nMOUSE2                : kf_remove\nE                     : kf_see\nA / D                 : (In see mode) Set camera roll\nW / S                 : (In see mode) Set camera FOV\nMOUSE1                : (In see mode) kf_next\nMOUSE2                : (In see mode) kf_prev\n");

	local T = ::VS.GetTickrate();

	if( !::VS.IsInteger(128.0/T) )
	{
		Msg("[!] Invalid tickrate ( " + T + " )! Only 128 and 64 ticks are supported.");
		::Chat(txt.red+"[!] "+txt.white+"Invalid tickrate ( " +txt.yellow+ T +txt.white+" )! Only 128 and 64 ticks are supported.");
	};

	delete WelcomeMsg;
}

// kf_cmd
function _KF_::PrintCmd()
{
//	Msg(@"
//
//   [v1.0.0]     github.com/samisalreadytaken/keyframes
//
//kf_add                : Add new keyframe
//kf_remove             : Remove the selected key
//kf_remove_undo        : Undo last remove action
//kf_removefov          : Remove the FOV data from the selected key
//kf_clear              : Remove all keyframes
//kf_insert             : Insert new keyframe after the selected key
//kf_replace            : Replace the selected key
//kf_replace_undo       : Undo last replace action
//                      :
//kf_compile            : Compile the keyframe data
//kf_play               : Play the compiled data
//kf_stop               : Stop playback
//kf_save               : Save the compiled data
//kf_savekeys           : Save the keyframe data
//                      :
//kf_mode_ang           : Toggle stabilised angles algorithm
//                      :
//kf_edit               : Toggle edit mode
//kf_select             : In edit mode, hold the current selection
//kf_see                : In edit mode, see the current selection
//kf_next               : While holding a key, select the next one
//kf_prev               : While holding a key, select the previous one
//kf_showkeys           : In edit mode, toggle showing keyframes
//kf_showpath           : In edit mode, toggle showing the path
//                      :
//script fov(val)       : Set FOV data on the selected key
//script roll(val)      : Set camera roll on the selected key
//                      :
//script load(input)    : Load new data from file
//                      :
//kf_cmd                : List all commands
//
//--- --- --- --- --- ---
//
//MOUSE1                : kf_add
//MOUSE2                : kf_remove
//E                     : kf_see
//A / D                 : (In see mode) Set camera roll
//W / S                 : (In see mode) Set camera FOV
//MOUSE1                : (In see mode) kf_next
//MOUSE2                : (In see mode) kf_prev
//");

	Msg("\n   [v"+_VER_+"]     github.com/samisalreadytaken/keyframes\n\nkf_add                : Add new keyframe\nkf_remove             : Remove the selected key\nkf_remove_undo        : Undo last remove action\nkf_removefov          : Remove the FOV data from the selected key\nkf_clear              : Remove all keyframes\nkf_insert             : Insert new keyframe after the selected key\nkf_replace            : Replace the selected key\nkf_replace_undo       : Undo last replace action\n                      :\nkf_compile            : Compile the keyframe data\nkf_play               : Play the compiled data\nkf_stop               : Stop playback\nkf_save               : Save the compiled data\nkf_savekeys           : Save the keyframe data\n                      :\nkf_mode_ang           : Toggle stabilised angles algorithm\n                      :\nkf_edit               : Toggle edit mode\nkf_select             : In edit mode, hold the current selection\nkf_see                : In edit mode, see the current selection\nkf_next               : While holding a key, select the next one\nkf_prev               : While holding a key, select the previous one\nkf_showkeys           : In edit mode, toggle showing keyframes\nkf_showpath           : In edit mode, toggle showing the path\n                      :\nscript fov(val)       : Set FOV data on the selected key\nscript roll(val)      : Set camera roll on the selected key\n                      :\nscript load(input)    : Load new data from file\n                      :\nkf_cmd                : List all commands\n\n--- --- --- --- --- ---\n\nMOUSE1                : kf_add\nMOUSE2                : kf_remove\nE                     : kf_see\nA / D                 : (In see mode) Set camera roll\nW / S                 : (In see mode) Set camera FOV\nMOUSE1                : (In see mode) kf_next\nMOUSE2                : (In see mode) kf_prev\n");
}

// }.call(_KF_);