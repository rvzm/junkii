# JunKii - Alcohol and Drug Abuse TBRPG
# version: 0.01delta
# by rvzm
putlog "Loading JunKii..."
if {[catch {source scripts/junkii/jki-settings.tcl} err]} {
	putlog "JunKii - Error loading settings."
}

package require sqlite3

namespace eval jki {
	namespace eval binds {
		bind pub - ${jki::settings::gen::pubtrig}junky jki::trigger::primary
		bind pub - ${jki::settings::gen::pubtrig}pack jki::weed::pack
		bind pub f ${jki::settings::gen::dealtrig}dealer jki::trigger::dealer
	}
	namespace eval trigger {
	
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
	]
	
	putlog "JunKii - Base Game $jki::settings::version -- LOADED"
}