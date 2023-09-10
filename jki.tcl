# JunKii - Alcohol and Drug Abuse TBRPG
# version: 0.01delta
# by rvzm
putlog "Loading JunKii..."
if {[catch {source scripts/junkii/jki-settings.tcl} err]} {
	putlog "JunKii - Error loading settings."
}

package require sqlite3
sqlite3 zdb "scripts/junkii/jki.sqlite" -create true -readonly false

namespace eval jki {
	namespace eval binds {
		bind pub - ${jki::settings::gen::pubtrig}junky jki::trigger::primary
		bind pub - ${jki::settings::gen::pubtrig}pack jki::weed::pack
		bind pub f ${jki::settings::gen::dealtrig}dealer jki::trigger::dealer
	}
	namespace eval trigger {
		proc primary {nick uhost hand chan text} {
			if {${jki::settings::debug} >= "1"} { jki::util::jdbg "main command sent| $nick $chan - $text"; }
			set v1 [lindex [split $text] 0]
			set v2 [lindex [split $text] 1]
			set v3 [lindex [split $text] 2]
			if {$v1 == ""} {
				if {${jki::settings::debug} == "2"} { jki::util::jdbg "(level2) main command recieved no input, informing chan and halting"; }
				putserv "PRIVMSG $chan :\037ERROR\037: Incorrect Parameters. \037SYNTAX\037: ${jki::settings::gen::pubtrig}junky help"; return
			}
			if {$v1 == "buy"} {
				if {$v2 == "alc"} {
					jki::util::sql::changedrug
			}
		}
		proc dealer {nick uhand hand chan text} {
		
		}
	}
	namespace eval weed {
		proc pack {nick uhost hand chan text} {
				global wchan
				set wchan $chan
				if {[lindex [split $text] 0] != ""} {
					if {[scan $text "%d%1s" count type] != 2} {
						putserv "PRIVMSG $chan :\[JunKii\]error - '$text' is not a valid time delcaration."
						return
					}
					switch -- $type {
						"s" { set delay $count }
						"m" { set delay [expr {$count * 60}] }
						"h" { set delay [expr {$count * 60 * 60}] }
						default {
							return
						}
					}
				} else { set delay $jki::settings::timers::packdefault }
				putserv "PRIVMSG $chan \00303Pack your \00309bowls\00303! Gring it, Load it, Heat it, Roll it!! Chan-wide \00315\002Toke\002\00306-\00315\002out\002\00303 in\00311 $delay \00303seconds!\003"
				utimer $delay jki::weed::pack:go
			}
		proc pack:go {} {
			global wchan
			utimer 1 "putserv \"PRIVMSG $wchan :\00315::\00304PREPARE\00315/ TO \002SMOKE\002!!!\00303\"";
			utimer 2 "putserv \"PRIVMSG $wchan :\00315::\00304/\00303////\003155\00315/\00315:\"";
			utimer 3 "putserv \"PRIVMSG $wchan :\00315::\00303/\00302///\003144\00315/\00315:\"";
			utimer 4 "putserv \"PRIVMSG $wchan :\00315::\00302/\00314//\003113\00315/\00315:\"";
			utimer 5 "putserv \"PRIVMSG $wchan :\00315::\00314/\00315/\003092\00315/\00315:\"";
			utimer 6 "putserv \"PRIVMSG $wchan :\00315::\00315/\003031\00315/\00315:\"";
			utimer 8 "putserv \"PRIVMSG $wchan :\00315::\00314\002_\00315/\00302SYNCRONIZED! \00304Fire Away!\002\00307!\00308\002!\"";
			return
		}
	}
	namespace eval util {
		proc jcmd {text} { putcmdlog "JunKii// $text"; }
		proc jdbg {lv tx}
			if {$lv == "1"} { putcmdlog "]JunKii:debug[ \[level 1\] $tx"; }
			if {$lv == "2"} { putcmdlog "]JunKii:debug[ !Level 2! $tx"; }
			if {$lv == "3"} { putcmdlog "]JunKii:debug[ \[CRITICAL DEBUG\] $tx"; }
		}
		proc getVersion {} {
			global jki::settings::version
			return $jki::settings::version
		}
		proc getBuild {} {
			global jki::settings::build
			return $jki::settings::build
		}
		proc getRelease {} {
			global jki::settings::release
			return $jki::settings::release
		}
		namespace eval sql {
			proc dbmake {user} {
				set zdbc "[zdb eval {SELECT * FROM users WHERE user=$user}]"
				if {${zboe::settings::debug} >= "2"} { zboe::util::zboedbg "(level2) dbmake: $user | $zdbc"; }
				set zdbc [lindex [split $zdbc] 0]
                if {$zdbc == $user} {
                    putcmdlog "***zboe|debug-sql|Error! Cannot create users row, it already exists."
                    return 
                } else {
                    putcmdlog "***zboe|debug-sql| Creating user $user row"
                    zdb eval {INSERT INTO users VALUES($user, 0, 1, 0, 55, "no", 6, 3, 6, 3, 0)} -parameters [list user $user]
					putcmdlog "***zboe|debug-sql| User row $user Created"
                }
            }

            proc initdb {} {
				if {${jki::settings::debug} >= "2"} { jki::util::jdbg "*** initializing sql"; }
                zdb eval {CREATE TABLE settings(drug TEXT, dealer TEXT, uses INTEGER, cost INTEGER)}
                zdb eval {INSERT INTO settings VALUES('no', 0, 'no', 0)}
				#                               0              1                2              3               4                      5                 6                7                8                    9                 10              
				zdb eval {CREATE TABLE users(user TEXT, weed_use INTEGER, alc_use INTEGER, nic_use INTEGER, heroin_use INTEGER, coke_use INTEGER, alc_od INTEGER, heroin_od INTEGER, coke_od INTEGER, drug_level INTEGER)}
				if {${jki::settings::debug} >= "2"} { jki::util::jdbg "*** SQL Database initialized"; }
            }
			proc checkdrug_use {user drug} {
                set jdbrt "[jkisql eval {SELECT * FROM users WHERE user=$user}]"
                if {$drug == "weed"} { return [lindex [split $jdbrt] 1] }
				if {$drug == "alc"} { return [lindex [split $jdbrt] 2] }
				if {$drug == "nic"} { return [lindex [split $jdbrt] 3] }
				if {$drug == "heroin"} { return [lindex [split $jdbrt] 4] }
				if {$drug == "coke"} { return [lindex [split $jdbrt] 5] }
            }
			proc checkdrug_od {user drug} {
			
			}
            proc changedrug_use {user d v} {
				if {$d == "alc"} { jkisql eval "UPDATE users SET alc_use = ('$v') WHERE user = '$user'" }
            }
			proc changedrug_od {user d v} {
				if {$d == "alc"} { jkisql eval "UPDATE users SET alc_od = ('$v') WHERE user = '$user'" }
			}
		}
	]
	
	putlog "JunKii - Base Game $jki::settings::version -- LOADED"
}