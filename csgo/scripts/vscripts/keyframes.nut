//-----------------------------------------------------------------------
//------------------- Copyright (c) samisalreadytaken -------------------
//                       github.com/samisalreadytaken
//- v1.0.1 --------------------------------------------------------------
const _VER_="1.0.1";;IncludeScript("vs_library");class V{constructor(_x=0,_y=0,_z=0){x=_x;y=_y;z=_z}function V(dx=0,dy=0,dz=0)return::Vector(x+dx,y+dy,z+dz);x=0.0;y=0.0;z=0.0}class Q{constructor(_x=0,_y=0,_z=0,_w=0){x=_x;y=_y;z=_z;w=_w}function V(dx=0,dy=0,dz=0,dw=0)return::Quaternion(x+dx,y+dy,z+dz,w+dw);x=0.0;y=0.0;z=0.0;w=0.0}try(IncludeScript("keyframes_data"))catch(e){}if(!("__R"in::getroottable()))::__R<-false;;if(::__R)delete::__R;else{local _=function(){};::__R=true;return::DoIncludeScript(_.getinfos().src,this)};;const FTIME=0.015625;;enum EF{ON=16392,OFF=16424}SendToConsole("alias kf_add\"script _kf82b3BZ1bBA()\";alias kf_remove\"script _kf82b38Z1bbA()\";alias kf_remove_undo\"script _kf8Zb3B2lbBA(1)\";alias kf_clear\"script _kf82b3BZ1Bb4()\";alias kf_insert\"script _kf82b3821bB4()\";alias kf_replace\"script _kf82b3821bBA()\";alias kf_replace_undo\"script _kf8Zb3B2lbBA(0)\";alias kf_removefov\"script _kf82b3BZ1bbA()\";alias kf_compile\"script _kfb28382lB64()\";alias kf_play\"script _kfB283B2lbBA()\";alias kf_stop\"script _kfB283B2lBbA()\";alias kf_save\"script _kf82b3B2lBb4()\";alias kf_savekeys\"script _kf82b3B2lBb4(1)\";alias kf_mode\"script _kfb2838Z1Bba()\";alias kf_edit\"script _kfB2b3821bb4()\";alias kf_select\"script _kf82b3821bb4()\";alias kf_see\"script _kf82bE82lbBA()\";alias kf_next\"script _kfb283821bBx()\";alias kf_prev\"script _kfb283821bBp()\";alias kf_showkeys\"script _kfB283B21bBA(0)\";alias kf_showpath\"script _kfB283B21bBA(1)\";alias kf_cmd\"script _kfB2bEB21bba()\"");SendToConsole("alias +kf_roll_R \"script _kf_roll_R(1)\";alias -kf_roll_R \"script _kf_roll_R(0)\";alias +kf_roll_L \"script _kf_roll_L(1)\";alias -kf_roll_L \"script _kf_roll_L(0)\";alias +kf_fov_U \"script _kf_fov_U(1)\";alias -kf_fov_U \"script _kf_fov_U(0)\";alias +kf_fov_D \"script _kf_fov_D(1)\";alias -kf_fov_D \"script _kf_fov_D(0)\"");SendToConsole("clear;script OnPostSpawn()");VS.GetLocalPlayer();if(!("_kfb28382lb6a"in this))_kfb28382lb6a<-false;;if(!("_kfb283821b6a"in this))_kfb283821b6a<-false;;if(!("_kfb283821B6a"in this))_kfb283821B6a<-true;;if(!("_kfb283821Bba"in this))_kfb283821Bba<-false;;if(!("_kfb283821bBa"in this))_kfb283821bBa<--1;;if(!("_kfb283821bB4"in this))_kfb283821bB4<-0.01;;if(!("_kfb2B3821bB4"in this))_kfb2B3821bB4<-25;;if(!("_kfb283821BB4"in this))_kfb283821BB4<-0;;if(!("_kfb283B21bB4"in this))_kfb283B21bB4<-true;;if(!("_kfb283B21bBa"in this))_kfb283B21bBa<-true;;if(!("_kf82bE821bBA"in this))_kf82bE821bBA<-false;;if(!("_kf82bEB2lbBA"in this))_kf82bEB2lbBA<-[];;if(!("_kf8ZbEB2lbBA"in this))_kf8ZbEB2lbBA<-[];;_db36Slt4ATef<-floor(1.0/_kfb283821bB4);__roll_R<-false;__roll_L<-false;__fov_U<-false;__fov_D<-false;_kf82b38Z1BB4<-90;if(Msg!=printl)Msg<-printl;;_kfb283B21b8a<-FrameTime()*18;local _=function(){if(!("_kfb283BZ1b8a"in this)){_kfb283BZ1b8a<-VS.Timer(1,FTIME,_kfb283BZlb8a);VS.MakePermanent(_kfb283BZ1b8a)};if(!("_kfb283B2lbBa"in this)){_kfb283B2lbBa<-VS.Timer(1,_kfb283B21b8a-FrameTime(),_kfB283B21bBa);VS.MakePermanent(_kfb283B2lbBa)};if(!("_kfb283B2tbBa"in this)){_kfb283B2tbBa<-VS.Timer(1,FrameTime()*2.5,"dummy");VS.MakePermanent(_kfb283B2tbBa)};if(!("_kfB2B38Z1bBa"in this)){_kfB2B38Z1bBa<-VS.CreateGameText(null,{channel=1,color=Vector(255,138,0),holdtime=_kfb283B21b8a,x=0.475,y=0.55});_kfB2B38Z1bB4<-VS.CreateGameText(null,{channel=2,color=Vector(255,138,0),holdtime=_kfb283B21b8a,x=0.56,y=0.485});VS.MakePermanent(_kfB2B38Z1bBa);VS.MakePermanent(_kfB2B38Z1bB4)};if(!("_kfB2B38ZlbB4"in this)){_kfB2B38ZlbB4<-VS.CreateHudHint();VS.MakePermanent(_kfB2B38ZlbB4)};if(!("HPlayerEye"in this)||!Ent("vs_ref_*"))HPlayerEye<-VS.CreateMeasure(HPlayer.GetName(),null,true);if(!("_kfB2B382lbB4"in this))_kfB2B382lbB4<-VS.CreateEntity("point_viewcontrol",null,{spawnflags=1<<3});if(!("_kfB2bEB2lbB4"in this)||!Ent("kf_helper")){PrecacheModel("models/tools/rotate_widget.mdl");_kfB2bEB2lbB4<-CreateProp("prop_dynamic_override",Vector(),"models/tools/rotate_widget.mdl",0);VS.SetName(_kfB2bEB2lbB4,"kf_helper");VS.SetKeyFloat(_kfB2bEB2lbB4,"modelscale",2.0);VS.SetKeyInt(_kfB2bEB2lbB4,"effects",EF.OFF)};if(!("_kf82b3821bbA"in this))local _=function(){local i1=-1,i2=0,d="●",b=" ",a=array(64,b);_kfbZ83B21b8a<-0;_kf82b3821bbA<-[];for(local i=0;i<64;i++){++i1;++i2;i1%=64;i2%=64;a[i1]=b;a[i2]=d;local t="";foreach(s in a)t+=s;_kf82b3821bbA.append(t)}}();DebugDrawLine(Vector(),Vector(),0,0,0,true,0)}function OnPostSpawn(){if(HPlayer.GetTeam()!=2&&HPlayer.GetTeam()!=3)HPlayer.SetTeam(2);HPlayer.SetHealth(1337);PlaySound("Player.DrownStart");ClearChat();Chat(txt.blue+" -------------------------------- ");Chat(txt.orange+"> "+txt.lightgreen+"Loaded keyframe smoothing script");Chat(txt.orange+"> Use the console commands to control the script.");Chat(txt.orange+"> '"+txt.white+"kf_cmd"+txt.orange+"' to print all commands.");Chat(txt.blue+" -------------------------------- ");if(GetDeveloperLevel()>0)delay("SendToConsole(\"clear;script _kfB2bEB2lbba()\")",0.75);else _kfB2bEB2lbba()}function _kfB2bEB2lbba(){Msg("\n\n\n   [v"+_VER_+"]     github.com/samisalreadytaken/keyframes\n\nkf_add                : Add new keyframe\nkf_remove             : Remove the selected key\nkf_remove_undo        : Undo last remove action\nkf_clear              : Remove all keyframes\nkf_insert             : Insert new keyframe after the selected key\nkf_replace            : Replace the selected key\nkf_replace_undo       : Undo last replace action\n                      :\nscript fovs(time)     : Modify the time of the FOV key of the selected key\nscript fov(val,time)  : Add new FOV data to the selected key\n                      :\nkf_removefov          : Remove the FOV data from the selected key\n                      :\nkf_compile            : Compile the keyframe data\nkf_play               : Play the compiled data\nkf_stop               : Stop playback\nkf_save               : Save the compiled data\nkf_savekeys           : Save the keyframe data\n                      :\nkf_mode               : Toggle stabilised angles algorithm\n                      :\nkf_edit               : Toggle edit mode\nkf_select             : In edit mode, hold the current selection\nkf_see                : In edit mode, see the current selection\nkf_next               : While holding a key, select the next one\nkf_prev               : While holding a key, select the previous one\nkf_showkeys           : In edit mode, toggle showing keyframes\nkf_showpath           : In edit mode, toggle showing the path\n                      :\nscript load(input)    : Load new data from file\n                      :\nkf_cmd                : List all commands\n\n--- --- --- --- --- ---\n\nRIGHTARROW / LEFTARROW: Set camera roll\nUPARROW / DOWNARROW   : Set camera FOV, 0s. Use `script fovs()` to modify time\n");local T=VS.GetTickrate();if(!VS.IsInteger(128.0/T)){Msg("[!] Invalid tickrate ( "+T+" )! Only 128 and 64 ticks are supported.");Chat(txt.red+"[!] "+txt.white+"Invalid tickrate ( "+txt.yellow+T+txt.white+" )! Only 128 and 64 ticks are supported.")}}function _kfB2bEB21bba(){Msg("\n[i] See README.md for details.\n\n   [v"+_VER_+"]     github.com/samisalreadytaken/keyframes\n\nkf_add                : Add new keyframe\nkf_remove             : Remove the selected key\nkf_remove_undo        : Undo last remove action\nkf_clear              : Remove all keyframes\nkf_insert             : Insert new keyframe after the selected key\nkf_replace            : Replace the selected key\nkf_replace_undo       : Undo last replace action\n                      :\nscript fovs(time)     : Modify the time of the FOV key of the selected key\nscript fov(val,time)  : Add new FOV data to the selected key\n                      :\nkf_removefov          : Remove the FOV data from the selected key\n                      :\nkf_compile            : Compile the keyframe data\nkf_play               : Play the compiled data\nkf_stop               : Stop playback\nkf_save               : Save the compiled data\nkf_savekeys           : Save the keyframe data\n                      :\nkf_mode               : Toggle stabilised angles algorithm\n                      :\nkf_edit               : Toggle edit mode\nkf_select             : In edit mode, hold the current selection\nkf_see                : In edit mode, see the current selection\nkf_next               : While holding a key, select the next one\nkf_prev               : While holding a key, select the previous one\nkf_showkeys           : In edit mode, toggle showing keyframes\nkf_showpath           : In edit mode, toggle showing the path\n                      :\nscript load(input)    : Load new data from file\n                      :\nkf_cmd                : List all commands\n\n--- --- --- --- --- ---\n\nRIGHTARROW / LEFTARROW: Set camera roll\nUPARROW / DOWNARROW   : Set camera FOV, 0s. Use `script fovs()` to modify time\n")}function PlaySound(s){HPlayer.EmitSound(s)}function Hint(s){VS.ShowHudHint(_kfB2B38ZlbB4,HPlayer,s)}function Error(s){Msg(s);PlaySound("Bot.Stuck2")}function MsgFail(s){Msg(s);PlaySound("UIPanorama.buymenu_failure")}function MsgHint(s){Msg(s);Hint(s)}function DrawOverlay(i){if(i==0)return SendToConsole("r_screenoverlay \"\"");if(i==1)return SendToConsole("r_screenoverlay \"keyframes/kf_orange\"");if(i==2)return SendToConsole("r_screenoverlay \"keyframes/kf_red\"")}function load(i){if(_kfb283821Bba)return MsgFail("Cannot load file while compiling!");if(typeof i!="table")return MsgFail("Invalid input.");if(!("pos"in i)||!("ang"in i))return MsgFail("Invalid input.");Msg("\nPreparing to load...");PlaySound("UIPanorama.container_countdown");if("anq"in i){if(!("__lp_c"in this)||!("__la_c"in this)){::__lp_c<-[];::__la_c<-[];::__la_q<-[];::__la_f<-[]};::__lp_o<-__lp_c;::__la_o<-__la_c;::__lq_o<-__la_q;::__lf_o<-__la_f;__lq_o.resize(i.anq.len())}else{if(!("__lp_k"in this)||!("__la_k"in this)||!("__la_v"in this)){::__lp_k<-[];::__la_k<-[];::__la_v<-[]};::__lp_o<-__lp_k;::__la_o<-__la_k;::__lf_o<-__la_v};if(__lp_o.len()!=__la_o.len())return Error("[ERROR] Corrupted data!");__lp_o.resize(i.pos.len());__la_o.resize(i.ang.len());if("fov"in i)__lf_o.resize(i.fov.len());::__ll_o<-i;::_dBebSlTa4T3F<-i.pos.len();::_dBebSlTa4t3F<-1450;::_dBebSlTa4tef<-0;::_dBebSlTa4teF<-clamp(_dBebSlTa4t3F,0,_dBebSlTa4T3F);print("Loading data...\n>.");_kfB2bEB21bb4()}function _kfB2bEB21bb4(){if("pos"in __ll_o){if(_dBebSlTa4tef>=_dBebSlTa4teF){print("\n>.");delete::__lp_o;delete::__ll_o["pos"];_dBebSlTa4tef=0;_dBebSlTa4teF=clamp(_dBebSlTa4t3F,0,_dBebSlTa4T3F);return _kfB2bEB21bb4()};print(".");for(local i=_dBebSlTa4tef;i<_dBebSlTa4teF;i++)__lp_o[i]=__ll_o["pos"][i].V();_dBebSlTa4tef+=_dBebSlTa4t3F;_dBebSlTa4teF=clamp(_dBebSlTa4teF+_dBebSlTa4t3F,0,_dBebSlTa4T3F);return delay("_kfB2bEB21bb4()",FTIME)};if("ang"in __ll_o){if(_dBebSlTa4tef>=_dBebSlTa4teF){print("\n>.");delete::__la_o;delete::__ll_o["ang"];_dBebSlTa4tef=0;_dBebSlTa4teF=clamp(_dBebSlTa4t3F,0,_dBebSlTa4T3F);return _kfB2bEB21bb4()};print(".");for(local i=_dBebSlTa4tef;i<_dBebSlTa4teF;i++)__la_o[i]=__ll_o["ang"][i].V();_dBebSlTa4tef+=_dBebSlTa4t3F;_dBebSlTa4teF=clamp(_dBebSlTa4teF+_dBebSlTa4t3F,0,_dBebSlTa4T3F);return delay("_kfB2bEB21bb4()",FTIME)};if("anq"in __ll_o){if(_dBebSlTa4tef>=_dBebSlTa4teF){print("\n>.");delete::__lq_o;delete::__ll_o["anq"];_dBebSlTa4tef=0;_dBebSlTa4teF=clamp(_dBebSlTa4t3F,0,_dBebSlTa4T3F);return _kfB2bEB21bb4()};print(".");for(local i=_dBebSlTa4tef;i<_dBebSlTa4teF;i++)__lq_o[i]=__ll_o["anq"][i].V();_dBebSlTa4tef+=_dBebSlTa4t3F;_dBebSlTa4teF=clamp(_dBebSlTa4teF+_dBebSlTa4t3F,0,_dBebSlTa4T3F);return delay("_kfB2bEB21bb4()",FTIME)};if("fov"in __ll_o){print(".");foreach(i,a in __ll_o["fov"])__lf_o[i]=clone a;delete::__ll_o["fov"];return _kfB2bEB21bb4()};PlaySound("UIPanorama.container_countdown");return Msg("\n\nData loaded! "+VS.GetVarName(delete::__ll_o))}function _kf82bE8Z1BBA(){if(__roll_R){_kf82bE8Z1BB4.z=clamp(floor(_kf82bE8Z1BB4.z)+4,-180,180);VS.SetAngles(_kfB2B382lbB4,_kf82bE8Z1BB4);Hint("Roll "+_kf82bE8Z1BB4.z)}else if(__roll_L){_kf82bE8Z1BB4.z=clamp(floor(_kf82bE8Z1BB4.z)-4,-180,180);VS.SetAngles(_kfB2B382lbB4,_kf82bE8Z1BB4);Hint("Roll "+_kf82bE8Z1BB4.z)};;PlaySound("UIPanorama.store_item_rollover")}function _kf82bE8Z1bBA(){local f=FrameTime()*6;if(__fov_U){_kf82b38Z1BB4=clamp(_kf82b38Z1BB4-2,1,179);Hint("FOV "+_kf82b38Z1BB4);_kfB2B382lbB4.SetFov(_kf82b38Z1BB4,f)}else if(__fov_D){_kf82b38Z1BB4=clamp(_kf82b38Z1BB4+2,1,179);Hint("FOV "+_kf82b38Z1BB4);_kfB2B382lbB4.SetFov(_kf82b38Z1BB4,f)};;PlaySound("UIPanorama.store_item_rollover")}function _kf_roll_R(i){if(i){if(!_kf82bE821bBA)return MsgFail("You need to be in see mode to use the key controls.");VS.OnTimer(_kfb283B2tbBa,_kf82bE8Z1BBA);_kf82bE8Z1BB4<-VS.QuaternionAngles2(__la_q[_kfb283821BB4],Vector());__roll_R=true;EntFireByHandle(_kfb283B2tbBa,"enable")}else{if(!_kf82bE821bBA)return;__roll_R=false;EntFireByHandle(_kfb283B2tbBa,"disable");__la_q[_kfb283821BB4]=VS.AngleQuaternion(_kf82bE8Z1BB4,Quaternion())}}function _kf_roll_L(i){if(i){if(!_kf82bE821bBA)return MsgFail("You need to be in see mode to use the key controls.");VS.OnTimer(_kfb283B2tbBa,_kf82bE8Z1BBA);_kf82bE8Z1BB4<-VS.QuaternionAngles2(__la_q[_kfb283821BB4],Vector());__roll_L=true;EntFireByHandle(_kfb283B2tbBa,"enable")}else{if(!_kf82bE821bBA)return;__roll_L=false;EntFireByHandle(_kfb283B2tbBa,"disable");__la_q[_kfb283821BB4]=VS.AngleQuaternion(_kf82bE8Z1BB4,Quaternion())}}function _kf_fov_U(i){if(i){if(!_kf82bE821bBA)return MsgFail("You need to be in see mode to use the key controls.");VS.OnTimer(_kfb283B2tbBa,_kf82bE8Z1bBA);_kf82b38Z1BB4=90;__fov_U=true;EntFireByHandle(_kfb283B2tbBa,"enable");foreach(i,v in __la_f)if(v[0]==_kfb283821BB4){_kf82b38Z1BB4=v[1]?v[1]:90;return};__la_f.append([_kfb283821BB4,0,0])}else{if(!_kf82bE821bBA)return;__fov_U=false;EntFireByHandle(_kfb283B2tbBa,"disable");foreach(i,v in __la_f)if(v[0]==_kfb283821BB4)v[1]=_kf82b38Z1BB4}}function _kf_fov_D(i){if(i){if(!_kf82bE821bBA)return MsgFail("You need to be in see mode to use the key controls.");VS.OnTimer(_kfb283B2tbBa,_kf82bE8Z1bBA);_kf82b38Z1BB4=90;__fov_D=true;EntFireByHandle(_kfb283B2tbBa,"enable");foreach(i,v in __la_f)if(v[0]==_kfb283821BB4){_kf82b38Z1BB4=v[1];return};__la_f.append([_kfb283821BB4,0,0])}else{if(!_kf82bE821bBA)return;__fov_D=false;EntFireByHandle(_kfb283B2tbBa,"disable");foreach(i,v in __la_f)if(v[0]==_kfb283821BB4)v[1]=_kf82b38Z1BB4}}function _kfB283B21bBA(t){if(t){_kfb283B21bB4=!_kfb283B21bB4;Msg(_kfb283B21bB4?"Showing path":"Hiding path")}else{_kfb283B21bBa=!_kfb283B21bBa;Msg(_kfb283B21bBa?"Showing keyframes":"Hiding keyframes")};SendToConsole("clear_debug_overlays");PlaySound("UIPanorama.container_countdown")}function _kfB2b3821bb4(){if(_kfb283821Bba)return MsgFail("Cannot "+(_kfb283B2lbBa.GetTeam()?"disable":"enable")+" edit mode while compiling!");local a,b;if(!("__lp_c"in this)||!("__la_c"in this)||!__lp_c.len()){a=true;Msg("No keyframes found.");__lp_c<-[];__la_c<-[]};if(!("__lp_k"in this)||!("__la_k"in this)||!__lp_k.len()){Msg("No path data found.");b=true;__lp_k<-[];__la_k<-[]};if(a&&b)return MsgFail("Cannot enable the edit mode!");_kfb283B2lbBa.SetTeam((!_kfb283B2lbBa.GetTeam()).tointeger());if(_kfb283B2lbBa.GetTeam()){if(developer()>1){Msg("Setting developer level to 1");SendToConsole("developer 1")};DrawOverlay(1);SendToConsole("cl_drawhud 1");VS.SetKeyInt(_kfB2bEB2lbB4,"effects",EF.ON);EntFireByHandle(_kfb283B2lbBa,"enable");Msg("Edit mode enabled.")}else{if(_kf82bE821bBA)_kf82bE82lbBA(1);DrawOverlay(0);VS.SetKeyInt(_kfB2bEB2lbB4,"effects",EF.OFF);EntFireByHandle(_kfb283B2lbBa,"disable");EntFireByHandle(_kfB2B38Z1bB4,"settext","",0,HPlayer);Msg("Edit mode disabled.")};SendToConsole("clear_debug_overlays");PlaySound("UIPanorama.container_countdown")}function _kf82b3821bb4(){if(!_kfb283B2lbBa.GetTeam())return MsgFail("You need to be in edit mode to select.");if(_kfb283821bBa==-1){_kfb283821bBa=_kfb283821BB4;MsgHint("Selected key #"+_kfb283821bBa)}else{MsgHint("Unselected key #"+_kfb283821bBa);if(_kf82bE821bBA)_kf82bE82lbBA(1);_kfb283821bBa=-1};PlaySound("UIPanorama.container_countdown")}function _kfb283821bBx(){if(_kfb283821bBa==-1)return MsgFail("You need to have a key selected to use kf_next.");local t=clamp(_kfb283821bBa+1,0,__lp_c.len()-1),b=_kf82bE821bBA;if(b)_kf82bE82lbBA(1);_kfb283821bBa=t;_kfb283821BB4=t;if(b)_kf82bE82lbBA()}function _kfb283821bBp(){if(_kfb283821bBa==-1)return MsgFail("You need to have a key selected to use kf_next.");local t=clamp(_kfb283821bBa-1,0,__lp_c.len()-1),b=_kf82bE821bBA;if(b)_kf82bE82lbBA(1);_kfb283821bBa=t;_kfb283821BB4=t;if(b)_kf82bE82lbBA()}function _kf82bE82lbBA(i=0){if(i){_kf82bE821bBA=false;if(_kfb283821bBa!=-1)_kf82b3821bb4();VS.SetKeyInt(_kfB2bEB2lbB4,"effects",EF.ON);_kfB2B382lbB4.SetFov(0,0.1);EntFireByHandle(_kfB2B382lbB4,"disable","",0,HPlayer);return};if(_kfb28382lb6a||_kfb283821b6a)return MsgFail("Cannot use see while in playback!");if(!_kfb283B2lbBa.GetTeam())return MsgFail("You need to be in edit mode to use see.");_kf82bE821bBA=!_kf82bE821bBA;if(_kf82bE821bBA){if(_kfb283821bBa==-1)_kf82b3821bb4();VS.SetKeyInt(_kfB2bEB2lbB4,"effects",EF.OFF);foreach(v in __la_f)if(v[0]==_kfb283821bBa)_kfB2B382lbB4.SetFov(v[1],0.25);_kfB2B382lbB4.SetAbsOrigin(__lp_c[_kfb283821bBa]);VS.SetAngles(_kfB2B382lbB4,VS.QuaternionAngles2(__la_q[_kfb283821bBa]));EntFireByHandle(_kfB2B382lbB4,"enable","",0,HPlayer);MsgHint("Seeing key #"+_kfb283821bBa)}else{if(_kfb283821bBa!=-1)_kf82b3821bb4();VS.SetKeyInt(_kfB2bEB2lbB4,"effects",EF.ON);_kfB2B382lbB4.SetFov(0,0.1);EntFireByHandle(_kfB2B382lbB4,"disable","",0,HPlayer);MsgHint("Stopped seeing.")};PlaySound("UIPanorama.container_countdown")}function roll(v){if(_kfb283821Bba)return MsgFail("Cannot modify keyframes while compiling!");if(!_kfb283B2lbBa.GetTeam())return MsgFail("You need to be in edit mode to use roll.");v=VS.AngleNormalize(v.tofloat());local a=VS.QuaternionAngles2(__la_q[_kfb283821BB4]);a.z=v;__la_q[_kfb283821BB4]=VS.AngleQuaternion(a,Quaternion());if(_kf82bE821bBA){if(_kfb283821bBa==-1)return Error("[ERROR] Assertion failed. Seeing while no key is selected.");VS.SetAngles(_kfB2B382lbB4,VS.QuaternionAngles2(__la_q[_kfb283821bBa]))};MsgHint("Set key #"+_kfb283821BB4+" roll to "+v);PlaySound("UIPanorama.container_countdown")}function _kfB283B21bBa(){local l=::__lp_c;if(l.len()){local h="";if(_kfb283821bBa==-1){local k=l.len()-1,b=0.9;foreach(i,v in l){local d=v-::HPlayer.EyePosition();d.Norm();local d=::HPlayerEye.GetForwardVector().Dot(d);if(d>b){k=i;b=d};if(::_kfb283B21bBa)::DebugDrawBox(v,::Vector(-8,-8,-8),::Vector(8,8,8),255,0,0,0,::_kfb283B21b8a)}_kfb283821BB4=k}else if(_kfb283B21bBa){h=" (HOLD)";foreach(i,v in l)::DebugDrawBox(v,::Vector(-8,-8,-8),::Vector(8,8,8),255,0,0,0,::_kfb283B21b8a)};;foreach(v in __la_f)if(v[0]==_kfb283821BB4)VS.SetKeyString(_kfB2B38Z1bB4,"message","FOV: "+v[1]+", "+v[2]+"s");VS.SetKeyString(_kfB2B38Z1bBa,"message","KEY: "+_kfb283821BB4+h);EntFireByHandle(_kfB2B38Z1bBa,"display","",0,HPlayer);EntFireByHandle(_kfB2B38Z1bB4,"display","",0,HPlayer);EntFireByHandle(_kfB2B38Z1bB4,"settext","",0,HPlayer);DebugDrawBox(l[_kfb283821BB4],Vector(-8,-8,-8),Vector(8,8,8),255,138,0,255,_kfb283B21b8a);_kfB2bEB2lbB4.SetOrigin(l[_kfb283821BB4])};if(_kfb283B21bB4){local a=VS.AngleVectors;for(local i=0;i<::__lp_k.len()-::_kfb2B3821bB4;i+=::_kfb2B3821bB4){local p=::__lp_k[i];::DebugDrawLine(p,p+a(::__la_k[i])*16,255,128,255,true,::_kfb283B21b8a);::DebugDrawLine(p,::__lp_k[i+::_kfb2B3821bB4],138,255,0,true,::_kfb283B21b8a)}}}function _kf82b3821bBA(){if(_kfb283821Bba)return MsgFail("Cannot modify keyframes while compiling!");if(!("__lp_c"in this)||!("__la_c"in this)||!__lp_c.len())return MsgFail("No keyframes found.");if(!_kfb283B2lbBa.GetTeam())return MsgFail("You need to be in edit mode to insert keyframes.");if(_kf82bE821bBA)return MsgFail("Cannot replace while seeing!");_kf82bEB2lbBA=[_kfb283821BB4,__lp_c[_kfb283821BB4],__la_c[_kfb283821BB4],__la_q[_kfb283821BB4]];local pos=HPlayer.EyePosition(),dir=HPlayerEye.GetForwardVector();__lp_c[_kfb283821BB4]=pos;__la_c[_kfb283821BB4]=dir;__la_q[_kfb283821BB4]=VS.AngleQuaternion(HPlayerEye.GetAngles(),Quaternion());DebugDrawLine(pos,pos+dir*64,138,255,0,true,7);DebugDrawBox(pos,Vector(-4,-4,-4),Vector(4,4,4),138,255,0,127,7);MsgHint("Replaced keyframe #"+_kfb283821BB4);PlaySound("UIPanorama.container_countdown")}function _kf82b3821bB4(){if(_kfb283821Bba)return MsgFail("Cannot modify keyframes while compiling!");if(!("__lp_c"in this)||!("__la_c"in this)||!__lp_c.len())return MsgFail("No keyframes found.");if(!_kfb283B2lbBa.GetTeam())return MsgFail("You need to be in edit mode to insert keyframes.");if(_kf82bE821bBA)return MsgFail("Cannot insert while seeing!");local pos=HPlayer.EyePosition(),dir=HPlayerEye.GetForwardVector();local i=_kfb283821BB4+1;__lp_c.insert(i,pos);__la_c.insert(i,dir);__la_q.insert(i,VS.AngleQuaternion(HPlayerEye.GetAngles(),Quaternion()));DebugDrawLine(pos,pos+dir*64,138,255,0,true,7);DebugDrawBox(pos,Vector(-4,-4,-4),Vector(4,4,4),138,255,0,127,7);MsgHint("Inserted keyframe #"+i);PlaySound("UIPanorama.container_countdown")}function _kf82b38Z1bbA(){if(_kfb283821Bba)return MsgFail("Cannot modify keyframes while compiling!");if(!("__lp_c"in this)||!("__la_c"in this)||!__lp_c.len())return MsgFail("No keyframes found.");if(!_kfb283B2lbBa.GetTeam())return MsgFail("You need to be in edit mode to remove keyframes.");if(_kf82bE821bBA)_kf82bE82lbBA(1);_kf8ZbEB2lbBA=[_kfb283821BB4,__lp_c.remove(_kfb283821BB4),__la_c.remove(_kfb283821BB4),__la_q.remove(_kfb283821BB4)];foreach(i,v in __la_f)if(v[0]==_kfb283821BB4){_kf8ZbEB2lbBA.append(__la_f.remove(i));_kfB2B3821bB4()};if(!__lp_c.len()){MsgHint("Removed all keyframes.");_kfb283821BB4=0;_kfb283821bBa=-1}else{MsgHint("Removed keyframe #"+_kfb283821BB4);if(!(_kfb283821BB4 in __lp_c)){_kfb283821BB4=0;_kfb283821bBa=-1}};PlaySound("UIPanorama.container_countdown")}function _kf8Zb3B2lbBA(t){if(_kfb283821Bba)return MsgFail("Cannot modify keyframes while compiling!");if(t){if(!("_kf8ZbEB2lbBA"in this)||!_kf8ZbEB2lbBA.len())return MsgFail("No removed key found.");local i=_kf8ZbEB2lbBA[0];__lp_c.insert(i,_kf8ZbEB2lbBA[1]);__la_c.insert(i,_kf8ZbEB2lbBA[2]);__la_q.insert(i,_kf8ZbEB2lbBA[3]);if(_kf8ZbEB2lbBA.len()>4)__la_f.append(_kf8ZbEB2lbBA[4]);if(_kf8ZbEB2lbBA.len()>5)Msg("[ERROR] Assertion failed. Duplicated FOV data.");_kf8ZbEB2lbBA.clear();MsgHint("Undone remove #"+i)}else{if(!("_kf82bEB2lbBA"in this)||!_kf82bEB2lbBA.len())return MsgFail("No replaced key found.");local i=_kf82bEB2lbBA[0];__lp_c[i]=_kf82bEB2lbBA[1];__la_c[i]=_kf82bEB2lbBA[2];__la_q[i]=_kf82bEB2lbBA[3];_kf82bEB2lbBA.clear();MsgHint("Undone replace #"+i)};PlaySound("UIPanorama.container_countdown")}function _kf82b3BZ1bbA(){if(_kfb283821Bba)return MsgFail("Cannot modify keyframes while compiling!");if(!("__lp_c"in this)||!("__la_c"in this)||!__lp_c.len())return MsgFail("No keyframes found.");if(!_kfb283B2lbBa.GetTeam())return MsgFail("You need to be in edit mode to remove FOV data.");if(_kf82bE821bBA)_kfB2B382lbB4.SetFov(0,0.1);foreach(i,v in __la_f)if(v[0]==_kfb283821BB4)__la_f.remove(i);_kfB2B3821bB4();MsgHint("Removed FOV data at key #"+_kfb283821BB4);PlaySound("UIPanorama.container_countdown")}function fov(x,t=0){if(_kfb283821Bba)return MsgFail("Cannot modify keyframes while compiling!");if(!("__lp_c"in this)||!("__la_c"in this)||!__lp_c.len())return MsgFail("No keyframes found.");if(!_kfb283B2lbBa.GetTeam())return MsgFail("You need to be in edit mode to add new FOV data.");x=x.tofloat();t=t.tofloat();if(_kf82bE821bBA)_kfB2B382lbB4.SetFov(x,0.25);local q=[_kfb283821BB4,x,t];foreach(i,v in __la_f)if(v[0]==_kfb283821BB4){__la_f[i]=q;_kfB2B3821bB4();MsgHint("Set key #"+_kfb283821BB4+" FOV to "+x+", "+t+"s");return};__la_f.append(q);_kfB2B3821bB4();MsgHint("Set key #"+_kfb283821BB4+" FOV to "+x+", "+t+"s");PlaySound("UIPanorama.container_countdown")}function fovs(t){if(_kfb283821Bba)return MsgFail("Cannot modify keyframes while compiling!");if(!("__lp_c"in this)||!("__la_c"in this)||!__lp_c.len())return MsgFail("No keyframes found.");if(!_kfb283B2lbBa.GetTeam())return MsgFail("You need to be in edit mode to modify FOV data.");foreach(i,v in __la_f)if(v[0]==_kfb283821BB4){v[2]=t.tofloat();_kfB2B3821bB4();MsgHint("Set key #"+_kfb283821BB4+" FOV to "+v[1]+", "+t.tofloat()+"s");PlaySound("UIPanorama.container_countdown");return};return MsgFail("\tUnexpected error!")}function _kf82b3BZ1bBA(){if(_kfb283821Bba)return MsgFail("Cannot modify keyframes while compiling!");if(_kf82bE821bBA)return MsgFail("Cannot add new keyframe while seeing!");if(!("__lp_c"in this)||!("__la_c"in this)||!("__la_q"in this)||!("__la_f"in this)){__lp_c<-[];__la_c<-[];__la_q<-[];__la_f<-[]};local pos=HPlayer.EyePosition(),dir=HPlayerEye.GetForwardVector();__lp_c.append(pos);__la_c.append(dir);__la_q.append(VS.AngleQuaternion(HPlayerEye.GetAngles(),Quaternion()));DebugDrawLine(pos,pos+dir*64,138,255,0,true,7);DebugDrawBox(pos,Vector(-4,-4,-4),Vector(4,4,4),138,255,0,127,7);MsgHint("Added keyframe #"+(__lp_c.len()-1));PlaySound("UIPanorama.container_countdown")}function _kf82b3BZ1Bb4(){if(_kfb283821Bba)return MsgFail("Cannot modify keyframes while compiling!");if(!("__lp_c"in this)||!("__la_c"in this)||!__lp_c.len())return MsgFail("No keyframes found.");if(_kf82bE821bBA)_kf82bE82lbBA(1);_kfb283821bBa=-1;_kfb283821BB4=0;MsgHint("Cleared "+__lp_c.len()+" keyframes.");__lp_c.clear();__la_c.clear();__la_q.clear();__la_f.clear();_kf82bEB2lbBA.clear();_kf8ZbEB2lbBA.clear();PlaySound("UIPanorama.container_countdown")}function res(f){if(_kfb283821Bba)return MsgFail("Cannot change resolution while compiling!");if(f<0.001||f>0.5)return MsgFail("Invalid resolution range. [0.001, 0.5]");_kfb283821bB4=f.tofloat();_db36Slt4ATef=floor(1.0/_kfb283821bB4);Msg("Interpolation resolution set to: "+_kfb283821bB4);Msg("Time between 2 keyframes: "+(FTIME/_kfb283821bB4)+" second(s)");PlaySound("UIPanorama.container_countdown")}function _kfb2838Z1Bba(){if(_kfb283821Bba)return MsgFail("Cannot change algorithm while compiling!");_kfb283821B6a=!_kfb283821B6a;Msg("\nNow using the "+(_kfb283821B6a?"default":"stabilised")+" algorithm.");PlaySound("UIPanorama.container_countdown")}function _kfb28382lB64(){if(_kfb283821Bba)return MsgFail("Compilation in progress...");if(_kfb28382lb6a||_kfb283821b6a)return MsgFail("Cannot compile while in playback!");if(!("__lp_c"in this)||!("__la_c"in this)||!__lp_c.len())return MsgFail("No keyframes found.");if(__lp_c.len()<4)return MsgFail("Not enough keyframes to compile. (Required minimum amount: 4)");if(__lp_c.len()!=__la_c.len()||__la_c.len()!=__la_q.len())return Error("[ERROR]\nAssertion failed: Corrupted keyframe data! [p"+__lp_c.len()+",a"+__la_c.len()+",q"+__la_q.len()+"]");_kfb283821Bba=true;_kf82bE82lbBA(1);EntFireByHandle(_kfb283B2lbBa,"disable");SendToConsole("clear_debug_overlays");DrawOverlay(2);Msg("\nPreparing..."+"\nResolution          : "+_kfb283821bB4+"\nTime between 2 keys : "+(FTIME/_kfb283821bB4)+"s\nAlgorithm           : "+(_kfb283821B6a?"default":"stabilised")+"\n");PlaySound("UIPanorama.container_countdown");return delay("__kfb28382lB64()",_kfb283B21b8a+FrameTime())}function __kfb28382lB64(){::__lp_k<-array(__lp_c.len());::__la_k<-array(__la_c.len());::RTIME<-FrameTime()*1.5;::_db36SltAaTef<-10;if(_kfb283821bB4<=0.025){::_db36SltAaTef<-2;RTIME*=2};::_db36Slt4aTef<-0;::_db36Slt4ATef=floor(1.0/_kfb283821bB4);::_db36SltA4T3f<-0;::_db36SltA473f<-clamp(_db36SltAaTef,0,_db36Slt4ATef);_kfb2B3821bB4=_db36Slt4ATef.tointeger()/10;print("Compiling (1/3) ");return delay("_kfb28EB21bB4()",RTIME)}function _kfb28EB21bB4(){if(_db36SltA4T3f>=_db36SltA473f){print("\n");__lp_k.pop();__lp_k.pop();__lp_k.remove(0);_db36SltA4T3f=0;_db36SltA473f=clamp(_db36SltAaTef,0,_db36Slt4ATef);print("Compiling (2/3) ");return _kfb28EB2lbBA()};if(!(_db36SltA4T3f%25))print(".");_kfbZ83B21b8a%=63;Hint(_kf82b3821bbA[++_kfbZ83B21b8a]);local s=VS.Catmull_Rom_Spline.bindenv(VS),c=__lp_c,k=__lp_k,v=Vector;for(local j=_db36SltA4T3f,f=_kfb283821bB4*_db36SltA4T3f;j<_db36SltA473f;j++,f+=_kfb283821bB4)for(local i=0;i<c.len()-3;i++)k.insert((j+2)+(i*(j+2)),s(c[i],c[i+1],c[i+2],c[i+3],f,v()));_db36SltA4T3f+=_db36SltAaTef;_db36SltA473f=clamp(_db36SltA473f+_db36SltAaTef,0,_db36Slt4ATef);return delay("_kfb28EB21bB4()",RTIME)}function _kfb28EB2lbBA(){if(_db36SltA4T3f>=_db36SltA473f){print("\n");__la_k.pop();__la_k.pop();__la_k.remove(0);_db36SltA4T3f=0;_db36SltA473f=clamp(_db36SltAaTef,0,_db36Slt4ATef);print("Compiling (3/3) ");return _kfb28EbZlbBA()};if(!(_db36SltA4T3f%25))print(".");_kfbZ83B21b8a%=63;Hint(_kf82b3821bbA[++_kfbZ83B21b8a]);if(_kfb283821B6a){local a=VS.QAngleNormalize.bindenv(VS),b=VS.QuaternionAngles2.bindenv(VS),c=VS.Catmull_Rom_SplineQ.bindenv(VS),q=__la_q,k=__la_k,v=Vector,t=Quaternion;for(local j=_db36SltA4T3f,f=_kfb283821bB4*_db36SltA4T3f;j<_db36SltA473f;j++,f+=_kfb283821bB4)for(local i=0;i<q.len()-3;i++)k.insert((j+2)+(i*(j+2)),a(b(c(q[i],q[i+1],q[i+2],q[i+3],f,t()),v())))}else{local a=VS.QAngleNormalize.bindenv(VS),b=VS.VectorAngles,c=VS.Catmull_Rom_Spline.bindenv(VS),e=__la_c,k=__la_k,v=Vector;for(local j=_db36SltA4T3f,f=_kfb283821bB4*_db36SltA4T3f;j<_db36SltA473f;j++,f+=_kfb283821bB4)for(local i=0;i<e.len()-3;i++)k.insert((j+2)+(i*(j+2)),a(b(c(e[i],e[i+1],e[i+2],e[i+3],f,v()))))};_db36SltA4T3f+=_db36SltAaTef;_db36SltA473f=clamp(_db36SltA473f+_db36SltAaTef,0,_db36Slt4ATef);return delay("_kfb28EB2lbBA()",RTIME)}function _kfb28EbZlbBA(){if(!(_db36Slt4aTef%175))print(".");if(!(_db36Slt4aTef%50)){_kfbZ83B21b8a%=63;Hint(_kf82b3821bbA[++_kfbZ83B21b8a])};for(local i=_db36Slt4aTef;i<__lp_k.len();i++)if(__lp_k[i]==null){__lp_k.remove(i);__la_k.remove(i);_db36Slt4aTef=i;return delay("_kfb28EbZlbBA()",RTIME)};_kfB2B3821bB4();_kfb283821Bba=false;EntFireByHandle(_kfb283B2lbBa,_kfb283B2lbBa.GetTeam()?"enable":"disable");DrawOverlay(_kfb283B2lbBa.GetTeam()?1:0);Msg("\n\nCompiled keyframes: "+__lp_k.len()*FTIME+" seconds\n\n* Play the compiled data                kf_play\n* Toggle edit mode                      kf_edit\n* Save the compiled data                kf_save\n* Save the keyframes                    kf_savekeys\n\n* List all commands                     kf_cmd\n");Hint("Compilation complete!");PlaySound("UIPanorama.container_countdown")}function _kfB2B3821bB4(){::__la_v<-array(__la_f.len());foreach(i,v in __la_f)__la_v[i]=[(v[0]-1)*_db36Slt4ATef,v[1],v[2]]}function _kf82b3B2lBb4(i=0){if(_kfb283821Bba)return MsgFail("Cannot save while compiling!");if(!i){if(!("__lp_k"in this)||!__lp_k.len())return MsgFail("No compiled keyframes found.")}else{if(!("__lp_c"in this)||!__lp_c.len())return MsgFail("No keyframes found.")};DrawOverlay(2);_kf82b3b2lBb4<-VS.Log.L;VS.Log.Clear();VS.Log.filePrefix="kf_data";VS.Log.condition=true;VS.Log.export=true;VS.Log.filter="L ";_kf82b3b2lBb4.append("l_"+(i?"keys_":"")+split(GetMapName(),"/").pop()+" <-{pos=[");__lp_s<-i?__lp_c:__lp_k;__la_s<-i?__la_c:__la_k;_dBebSlTa4T3F<-__lp_s.len();_dBebSlTa4t3F<-1450;_dBebSlTa4tef<-0;_dBebSlTa4teF<-clamp(_dBebSlTa4t3F,0,_dBebSlTa4T3F);return _kf82b3B2lBb2(i)}function _kf82b3B2lBb8(i){local file=VS.Log.Run();Msg("\n* "+(i?"Keyframe":"Path")+" data is exported: /csgo/"+file+".log\n");PrecacheScriptSound("Survival.TabletUpgradeSuccess");PlaySound("Survival.TabletUpgradeSuccess");DrawOverlay(_kfb283B2lbBa.GetTeam()?1:0)}function _kf82b3B2lBb2(i){if(_dBebSlTa4tef>=_dBebSlTa4teF){_kf82b3b2lBb4.append("]ang=[");_dBebSlTa4tef=0;_dBebSlTa4teF=clamp(_dBebSlTa4t3F,0,_dBebSlTa4T3F);return _kf82b3B2lBb3(i)};for(local i=_dBebSlTa4tef;i<_dBebSlTa4teF;i++)_kf82b3b2lBb4.append(VecToString(__lp_s[i],"V("));_dBebSlTa4tef+=_dBebSlTa4t3F;_dBebSlTa4teF=clamp(_dBebSlTa4teF+_dBebSlTa4t3F,0,_dBebSlTa4T3F);return delay("_kf82b3B2lBb2("+i+")",FTIME)}function _kf82b3B2lBb3(i){if(_dBebSlTa4tef>=_dBebSlTa4teF){_kf82b3b2lBb4.pop();_kf82b3b2lBb4.append(VecToString(__la_s[__la_s.len()-1],"V(")+"]");local kf;if(i){_kf82b3b2lBb4.append("anq=[");for(local i=0;i<__la_q.len();i++){local q=__la_q[i];_kf82b3b2lBb4.append("Q("+q.x+","+q.y+","+q.z+","+q.w+")")}_kf82b3b2lBb4.append("]");kf=__la_f}else kf=__la_v;if(kf.len()){_kf82b3b2lBb4.append("fov=[");foreach(a in kf){_kf82b3b2lBb4.append("[");foreach(v in a){_kf82b3b2lBb4.append(v);_kf82b3b2lBb4.append(",")}_kf82b3b2lBb4.pop();_kf82b3b2lBb4.append("]");_kf82b3b2lBb4.append(",")}_kf82b3b2lBb4.pop();_kf82b3b2lBb4.append("]")};_kf82b3b2lBb4.append("}\n");return _kf82b3B2lBb8(i)};for(local i=_dBebSlTa4tef;i<_dBebSlTa4teF;i++)_kf82b3b2lBb4.append(VecToString(__la_s[i],"V("));_dBebSlTa4tef+=_dBebSlTa4t3F;_dBebSlTa4teF=clamp(_dBebSlTa4teF+_dBebSlTa4t3F,0,_dBebSlTa4T3F);return delay("_kf82b3B2lBb3("+i+")",FTIME)}function _kfb283BZlb8a(){_kfB2B382lbB4.SetAbsOrigin(__lp_p[_kfB283B2lbB4]);VS.SetAngles(_kfB2B382lbB4,__la_p[_kfB283B2lbB4]);foreach(x in __la_v)if(x[0]==_kfB283B2lbB4){_kfB2B382lbB4.SetFov(x[1],x[2]);break};if(++_kfB283B2lbB4>=_kfB283B2lb84)_kfB283B2lBbA()}function _kfB283B2lbBA(){if(_kfb283821Bba)return MsgFail("Cannot start playback while compiling!");if(_kfb283821b6a)return MsgFail("Playback has not started yet!");if(_kfb28382lb6a)return MsgFail("Playback is already running.");if(_kf82bE821bBA)_kf82bE82lbBA(1);if(!("__lp_k"in this)||!("__la_k"in this)||!__lp_k.len())return MsgFail("No compiled data found.");if(__lp_k.len()!=__la_k.len())return Error("Corrupted data! ["+__lp_k.len()+","+__la_k.len()+"]");if(developer()>1){Msg("Setting developer level to 1");SendToConsole("developer 1")};__lp_p<-__lp_k;__la_p<-__la_k;_kfB283B2lb84<-__lp_p.len();_kfB283B2lbB4<-0;foreach(x in __la_v)if(x[0]==-100){_kfB2B382lbB4.SetFov(x[1],0);break};_kfB2B382lbB4.SetAbsOrigin(__lp_p[0]);VS.SetAngles(_kfB2B382lbB4,__la_p[0]);EntFireByHandle(_kfB2B382lbB4,"enable","",0,HPlayer);EntFireByHandle(_kfb283BZ1b8a,"disable");delay("MsgHint(\"Starting in 3...\");PlaySound(\"UI.CounterBeep\")",0.0);delay("MsgHint(\"Starting in 2...\");PlaySound(\"UI.CounterBeep\")",1.0);delay("MsgHint(\"Starting in 1...\");PlaySound(\"UI.CounterBeep\")",2.0);HPlayer.SetHealth(1337);VS.HideHudHint(_kfB2B38ZlbB4,HPlayer,3.0-FrameTime());_kfb283821b6a=true;delay("_kfb283821b6a=false;_kfb28382lb6a=true;Msg(\"Playback has started...\\n\");EntFireByHandle(_kfb283BZ1b8a,\"enable\")",3.0)}function _kfB283B2lBbA(){if(!_kfb28382lb6a)return MsgFail("Playback is not running.");_kfb28382lb6a=false;EntFireByHandle(_kfB2B382lbB4,"disable","",0,HPlayer);EntFireByHandle(_kfb283BZ1b8a,"disable");_kfB2B382lbB4.SetFov(0,0);Msg("Playback has ended.");PlaySound("UI.RankDown")}_();
