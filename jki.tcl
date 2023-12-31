# JunKii - Alcohol and Drug Abuse TRPG
# version: 0.01delta
# by rvzm
putlog "Loading JunKii..."
if {[catch {source scripts/junkii/jki-settings.tcl} err]} {
	putlog "JunKii - Error loading settings."
}

package require sqlite3
sqlite3 jdb "scripts/junkii/jki.sqlite" -create true -readonly false

namespace eval jki {
	namespace eval binds {
		bind pub - ${jki::settings::gen::pubtrig}junky jki::trigger::primary
		bind pub - ${jki::settings::gen::pubtrig}register jki::trigger::register
		bind pub - ${jki::settings::gen::pubtrig}pack jki::weed::pack
		bind pub - ${jki::settings::gen::pubtrig}weed jki::weed::weed
		bind pub - ${jki::settings::gen::pubtrig}pass jki::weed::pass
		bind pub - ${jki::settings::gen::pubtrig}bong jki::weed::bong
		bind pub - ${jki::settings::gen::pubtrig}joint jki::weed::joint
		bind pub - ${jki::settings::gen::pubtrig}version jki::base::version
		bind pub - ${jki::settings::gen::pubtrig}dealer jki::trigger::dealer
		# time binds
		bind time - "20 04*" jki::weed::synctime 
		bind time - "20 16*" jki::weed::synctime 
		# dcc reset
		bind dcc - junkii jki::dcc::command
	}
	namespace eval trigger {
		proc primary {nick uhost hand chan text} {
			if {${jki::settings::debug} >= "1"} { jki::util::jdbg "1" "Junky command sent| $nick $chan - $text"; }
			if {![channel get $chan jnki]} { putserv "PRIVMSG $chan :\[JunKii\] Error - This channel does not have junkii permission. y'all got jeezus"; return }
			#jki::util::sql::dbmake "$nick";
			set v1 [lindex [split $text] 0]
			set v2 [lindex [split $text] 1]
			set v3 [lindex [split $text] 2]
			if {$v1 == ""} {
				if {${jki::settings::debug} == "2"} { jki::util::jdbg "2" "junky command recieved no input, informing chan and halting"; }
				putserv "PRIVMSG $chan :\037ERROR\037: Incorrect Parameters. \037SYNTAX\037: ${jki::settings::gen::pubtrig}junky stock"
				return
			}
			if {$v1 == "help"} { 
				putserv "PRIVMSG $chan :JunKii - use '${jki::settings::gen::pubtrig}junky stock' to see current stock or '${jki::settings::gen::pubtrig}junky commands' for commands."
				return
			}
			if {$v1 == "commands"} {
				putserv "PRIVMSG $chan :JunKii 'junky' commands via '${jki::settings::gen::pubtrig}junky stock' or use '${jki::settings::gen::pubtrig}weed help' for weed commands"
			}
			if {$v1 == "stock"} {
				putserv "PRIVMSG $chan :JunKii - Available Alcohol stock: alcohol, scotch, whiskey, gin, vodka, congac, tequila, beer, cooler"
				putserv "PRIVMSG $chan :JunKii - Available Drugs stock: heroin, coke, shrooms"
				putserv "PRIVMSG $chan :JunKii - Available Kratom stocks: kpops (pills), kpow (powder), kshot (liquid)"
				return
			}
			if {$v1 == "menu"} {
				set jsc "[jki::util::sql::checkbrand scotch]"
				set jwh "[jki::util::sql::checkbrand whiskey]"
				set jji "[jki::util::sql::checkbrand gin]"
				set jvk "[jki::util::sql::checkbrand vodka]"
				set jcg "[jki::util::sql::checkbrand congac]"
				set jtq "[jki::util::sql::checkbrand tequila]"
				set jbr "[jki::util::sql::checkbrand beer]"
				set jcl "[jki::util::sql::checkbrand cooler]"
				putserv "PRIVMSG $chan :JunKii Menu - scotch $jsc | whiskey $jwh | gin $jji | vodka $jvk | congac $cg | tequila $tq | beer $jbr | cooler $jcl"
			}
			if {$v1 == "alcohol"} {
				putserv "PRIVMSG $chan :hey junkiis, lets all get drunk on $nick's dime!!"
				return
			}
			if {$v1 == "scotch"} {
				if {$v2 != ""} { set jkip $v2; } else { set jkip $nick; }
				jki::util::act $chan "pours $jkip a [jki::util::sql::checkbrand scotch] scotch over rocks, then slides it down the bar to them"
				putserv "PRIVMSG $chan :Enjoy your scotch, $jkip!"
				return
			}
			if {$v1 == "whiskey"} {
				if {$v2 != ""} { set jkip $v2; } else { set jkip $nick; }
				jki::util::act $chan "pours $jkip a glass of [jki::util::sql::checkbrand whiskey] whiskey over rocks, then slides it down the bar to them"
				putserv "PRIVMSG $chan :Enjoy your whiskey, $jkip!"
				return
			}
			if {$v1 == "gin"} {
				if {$v2 != ""} { set jkip $v2; } else { set jkip $nick; }
				jki::util::act $chan "pours $jkip a glass of [jki::util::sql::checkbrand gin] gin on ice, then slides it down the bar to them"
				putserv "PRIVMSG $chan :Enjoy your gin, $jkip!"
				return
			}
			if {$v1 == "tequila"} {
				if {$v2 != ""} { set jkip $v2; } else { set jkip $nick; }
				jki::util::act $chan "pours $jkip a shot of [jki::util::sql::checkbrand tequila], then slides it down the bar to them"
				putserv "PRIVMSG $chan :Enjoy your tequila, $jkip!"
				return
			}
			if {$v1 == "vodka"} {
				if {$v2 != ""} { set jkip $v2; } else { set jkip $nick; }
				jki::util::act $chan "pours $jkip a glass of [jki::util::sql::checkbrand vodka] vodka, then slides it down the bar to them"
				putserv "PRIVMSG $chan :Enjoy your vodka and sadness, $jkip!"
				return
			}
			if {$v1 == "congac"} {
				if {$v2 != ""} { set jkip $v2; } else { set jkip $nick; }
				jki::util::act $chan "pours $jkip a glass of [jki::util::sql::checkbrand congac] on ice, then slides it down the bar to them"
				putserv "PRIVMSG $chan :Enjoy your fancy people alcohol, $jkip!"
				return
			}
			if {$v1 == "beer"} {
				if {$v2 != ""} { set jkip $v2; } else { set jkip $nick; }
				jki::util::act $chan "pours $jkip a stein of [jki::util::sql::checkbrand beer] on tap, then slides it down the bar to them"
				putserv "PRIVMSG $chan :Enjoy your beer, $jkip!"
				return
			}
			if {$v1 == "cooler"} {
				if {$v2 != ""} { set jkip $v2; } else { set jkip $nick; }
				jki::util::act $chan "grabs $jkip a can of [jki::util::sql::checkbrand cooler], then slides it down the bar to them"
				putserv "PRIVMSG $chan :Enjoy your cooler, $jkip!"
				return
			}
			if {$v1 == "whiskey"} {
				if {$v2 != ""} { set jkip $v2; } else { set jkip $nick; }
				jki::util::act $chan "grabs $jkip a cooler of [jki::util::sql::checkbrand cooler], then hands it to them"
				putserv "PRIVMSG $chan :Enjoy your cooler, $jkip!"
				return
			}
			if {$v1 == "heroin"} {
				if {![channel get $chan sch1]} { putserv "PRIVMSG $chan :\[JunKii\] Error - This channel does not have junkii permission for that level of drugs"; return }
				putserv "PRIVMSG $chan :hey junkiis, fresh batch of needles and black tar. lets boil that shit and shoot up, $nick's payin!!"
				return
			}
			if {$v1 == "coke"} {
				if {![channel get $chan sch2]} { putserv "PRIVMSG $chan :\[JunKii\] Error - This channel does not have junkii permission for that level of drugs"; return }
				putserv "PRIVMSG $chan :hey junkiis, we just got some pure columbian cocaine from $nick! who wants to hoover some schneef?!"
				return
			}
			if {$v1 == "shrooms"} {
				if {![channel get $chan sch2]} { putserv "PRIVMSG $chan :\[JunKii\] Error - This channel does not have junkii permission for that level of drugs"; return }
				putserv "PRIVMSG $chan :hey junkiis, we just got some fresh grown Golden Teacher shrooms from $nick! who wants to trip on some sonic chronic?!?!"
				return
			}
			if {$v1 == "kpops"} {
				if {![channel get $chan sch3]} { putserv "PRIVMSG $chan :\[JunKii\] Error - This channel does not have junkii permission for that level of drugs"; return }
				putserv "PRIVMSG $chan :hey junkiis, we just got some Meang Da pills from $nick! who wants to take some kratom?"
				return
			}
			if {$v1 == "kpow"} {
				if {![channel get $chan sch3]} { putserv "PRIVMSG $chan :\[JunKii\] Error - This channel does not have junkii permission for that level of drugs"; return }
				putserv "PRIVMSG $chan :hey junkiis, we just got some fresh Green Dragon powder from $nick! who wants to take some kratom?"
				return
			}
			if {$v1 == "kshot"} {
				if {![channel get $chan sch3]} { putserv "PRIVMSG $chan :\[JunKii\] Error - This channel does not have junkii permission for that level of drugs"; return }
				putserv "PRIVMSG $chan :hey junkiis, we just got some wonderful MIT45 Gold shots from $nick! who wants to take some kratom?"
				return
			}
			return
		}
		proc dealer {nick uhand hand chan text} {
			if {${jki::settings::debug} >= "1"} { jki::util::jdbg "1" "Dealer command sent| $nick $chan - $text"; }
			if {![channel get $chan jnki]} { putserv "PRIVMSG $chan :\[JunKii\] Error - This channel does not have junkii permission. y'all got jeezus"; return }
			set v1 [lindex [split $text] 0]
			set v2 [lindex [split $text] 1]
			set v3 [lindex [split $text] 2]
			if {$v1 == ""} {
				if {${jki::settings::debug} == "2"} { jki::util::jdbg "2" "dealer command recieved no input, informing chan and halting"; }
				putserv "PRIVMSG $chan :\037ERROR\037: Incorrect Parameters. \037SYNTAX\037: ${jki::settings::gen::pubtrig}dealer help"
				return
			}
			if {$v1 == "buy"} {
				if {$v2 == "alc"} {
					putserv "PRIVMSG $chan :Err, system in progress";
					return
				}
			}
			if {$v1 == "420"} { jki::weed::synctime }
		}
		proc register {nick uhost hand chan text} {
			if {![channel get $chan jnki]} { jki::util::jcmd "command from $chan blocked - missing flag"; return }
			if {[validuser $hand] == "1"} { putserv "PRIVMSG $chan :Sorry $nick, but you're already registered. :)"; return }
			if {[adduser $hand $uhost] == "1"} {
				putserv "PRIVMSG [zboe::util::homechan] :*** Introduced user - $nick / $uhost"
				putlog "*** Introduced to user - $nick / $uhost"
				putserv "PRIVMSG $chan :Congradulations, $nick! you are now in my system! yay :)"
				} else { putserv "PRIVMSG $chan :Addition failed." }
			return
		}
	}
	namespace eval weed {
		proc weed {nick uhost hand chan text} {
			if {![channel get $chan jnki]} { jki::util::jcmd "command from $chan blocked - missing flag"; return }
			if {${jki::settings::debug} >= "1"} { jki::util::jdbg "1" "weed command sent| $nick $chan - $text"; }
			if {![channel get $chan weed]} { putserv "PRIVMSG $chan :\[JunKii\] Error - This channel does not have weed permission. y'all got jeezus"; return }
			#jki::util::sql::dbmake "$nick";
			set v1 [lindex [split $text] 0]
			set v2 [lindex [split $text] 1]
			set v3 [lindex [split $text] 2]
			if {$v1 == ""} { putserv "PRIVMSG $chan :weed devices: bong pipe joint dab"; return }
			if {$v1 == "help"} {
				putserv "PRIVMSG $chan :use '${jki::settings::gen::pubtrig}weed \[device\] \[user (optional)\]' to smoke (or pass) something within the channel"
				return
			}
			if {$v1 == "strains"} {
				set jbg "[jki::util::sql::checkstrain bong]"
				set jhk "[jki::util::sql::checkstrain hookah]"
				set jbl "[jki::util::sql::checkstrain blunt]"
				set jjt "[jki::util::sql::checkstrain joint]"
				set jda "[jki::util::sql::checkstrain dab]"
				set jch "[jki::util::sql::checkstrain chillum]"
				set jsr "[jki::util::sql::checkstrain steamroller]"
				set jpp "[jki::util::sql::checkstrain pipe]"
				putserv "PRIVMSG $chan :\[JunKii\] Strains: dab $jda | bong $jbg | hookah $jhk | pipe $jpp | chillum $jch | joint $jjt | blunt $jbl"
			}
			if {$v2 == ""} { set jkiwp $nick; set jpas "no"; } else { set jkiwp $v2; set jpas "yes"; }
			if {$v1 == "bong"} {
				jki::util::act $chan "loads a bong with some [jki::util::sql::checkstrain bong] and passes to $jkiwp";
				if {$jpas == "yes"} { putserv "PRIVMSG $chan :Clear that shit and pass it around"; return }
			}
			if {$v1 == "pipe"} {
				jki::util::act $chan "loads a pipe with some [jki::util::sql::checkstrain pipe] and passes to $jkiwp";
				if {$jpas == "yes"} { putserv "PRIVMSG $chan :Hit that shit and pass it around"; return }
			}
			if {$v1 == "joint"} {
				jki::util::act $chan "rolls a joint with some [jki::util::sql::checkstrain joint] and passes to $jkiwp";
				if {$jpas == "yes"} { putserv "PRIVMSG $chan :Hit that shit and pass it around"; return }
			}
			if {$v1 == "dab"} {
				jki::util::act $chan "grabs a jar of some [jki::util::sql::checkstrain dab] budder and a eNail and hands it to $jkiwp";
				if {$jpas == "yes"} { putserv "PRIVMSG $chan :Hit that shit and pass it around"; return }
			}
		}
		proc pass {nick uhost hand chan text} {
			if {![channel get $chan jnki]} { jki::util::jcmd "command from $chan  'pass' blocked - missing flag"; return }
			putserv "PRIVMSG $chan :Err, system in progress";
		}
		proc bong {nick uhost hand chan text} {
			if {![channel get $chan jnki]} { jki::util::jcmd "command from $chan blocked - missing flag"; return }
			putserv "PRIVMSG $chan :Err, system in progress";
		}
		proc joint {nick uhost hand chan text} {
			if {![channel get $chan jnki]} { jki::util::jcmd "command from $chan blocked - missing flag"; return }
			putserv "PRIVMSG $chan :Err, system in progress";
		}
		proc pack {nick uhost hand chan text} {
			if {![channel get $chan jnki]} { jki::util::jcmd "command from $chan blocked - missing flag"; return }
			if {${jki::settings::debug} >= "1"} { jki::util::jdbg "1" "Pack command sent| $nick $chan - $text"; }
			if {![channel get $chan weed]} { putserv "PRIVMSG $chan :\[JunKii\] Error - This channel does not have weed permission. y'all got jeezus"; return }
			if {${jki::settings::debug} >= "3"} { jki::util::jdbg "3" "Initiating pack command"; }
			global wchan
			set wchan $chan
			if {[lindex [split $text] 0] != ""} {
				if {${jki::settings::debug} >= "2"} { jki::util::jdbg "3" "Checking pack time declaration"; }
				if {[scan $text "%d%1s" count type] != 2} {
					putserv "PRIVMSG $chan :\[JunKii\]error - '$text' is not a valid time delcaration."
					if {${jki::settings::debug} >= "2"} { jki::util::jdbg "2" "Pack Gommand given invalid time declaration"; }
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
			if {${jki::settings::debug} >= "3"} { jki::util::jdbg "3" "Pack delay set: $delay"; }
			putserv "PRIVMSG $chan \00303Pack your \00309bowls\00303! Grind it, Load it, Heat it, Roll it!! Chan-wide \00315\002Toke\002\00306-\00315\002out\002\00303 in\00311 $delay \00303seconds!\003"
			utimer $delay jki::weed::pack:go
		}
		proc pack:go {} {
			global wchan
			if {${jki::settings::debug} >= "3"} { jki::util::jdbg "3" "Pack trigger time passed, initiating countdown"; }
			utimer 1 "putserv \"PRIVMSG $wchan :\00315::\00304PREPARE\00315/ TO \002SMOKE\002!!!\00303\"";
			utimer 2 "putserv \"PRIVMSG $wchan :\00315::\00304/\00303////\003155\00315/\00315:\"";
			utimer 3 "putserv \"PRIVMSG $wchan :\00315::\00303/\00302///\003144\00315/\00315:\"";
			utimer 4 "putserv \"PRIVMSG $wchan :\00315::\00302/\00314//\003113\00315/\00315:\"";
			utimer 5 "putserv \"PRIVMSG $wchan :\00315::\00314/\00315/\003092\00315/\00315:\"";
			utimer 6 "putserv \"PRIVMSG $wchan :\00315::\00315/\003031\00315/\00315:\"";
			utimer 8 "putserv \"PRIVMSG $wchan :\00315::\00314\002_\00315/\00302SYNCRONIZED! \00304Fire Away!\002\00307!\00308\002!\"";
			return
		}
		proc synctime {m h d n y} {
			if {${jki::settings::debug} >= "1"} { jki::util::jdbg "1" "synctime"; }
			if {${jki::settings::gen::syncpack} == "no"} { return }
			putserv "PRIVMSG ${jki::settings::gen::homechan} :\00315::\00304/\00303////\00315/\00315:\00303/\00302/// \0039It's 4:20 Somewhere!! Spark it up and get faded g \00302/\00314//\00311\00315/\00315:\00315/\00303\00315/\00315:" 
		}
	}
	namespace eval base {
		proc version {nick uhost hand chan text} {
			if {![channel get $chan jnki]} { jki::util::jcmd "command from $chan blocked - missing flag"; return }
			putserv "PRIVMSG $chan :JunKii Alcohol and Drug Abuse TRPG"
			putserv "PRIVMSG $chan :JunKii -> version-[jki::util::getVersion] [jki::util::getBuild] r:[jki::util::getRelease]"
			return
		}
	}
	namespace eval dcc {
		proc command {hand idx text} {
			set v1 [lindex [split $text] 0]
			if {$v1 == "reset"} {
				file delete "scripts/junkii/jki.sqlite"
				jki::util::jcmd "Database removed"
				jki::util::sql::initdb
				jki::util::jcmd "Database initialized"
				return
			}
			if {$v1 == "init"} { jki::util::sql::initdb; }
			if {$v1 == "flush"} {
				jdb cache flush;
			}
		}
	}
	namespace eval util {
		proc jcmd {text} { putcmdlog "JunKii// $text"; }
		proc jdbg {lv tx} {
			if {$lv == "1"} { putcmdlog "\]JunKii:debug\[ \[level 1\] $tx"; }
			if {$lv == "2"} { putcmdlog "\]JunKii:debug\[ \[Level 2\] $tx"; }
			if {$lv == "3"} { putcmdlog "\]JunKii:debug\[ \[CRITICAL DEBUG\] $tx"; }
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
		proc act {chan text} { putserv "PRIVMSG $chan \01ACTION $text\01"; }
		namespace eval sql {
			proc dbmake {user} {
				jki::util::sql::initdb;
				set jdbc "[jdb eval {SELECT * FROM users WHERE user=$user}]"
				if {${jki::settings::debug} >= "2"} { jki::util::jdbg "2" "(dbmake: $user | $jdbc"; }
				set jdbc [lindex [split $jdbc] 0]
                if {$jdbc == $user} {
                    if {${jki::settings::debug} >= "1"} { jki::util::jdbg "1" "sql|Error! Cannot create users row, it already exists." }
                    return 
                } else {
                    if {${jki::settings::debug} >= "1"} { jki::util::jdbg "1" "sql| Creating user $user row" }
                    jdb eval {INSERT INTO users VALUES($user, 0, 1, 0, 55, "no", 6, 3, 6, 3, 0)} -parameters [list user $user]
					if {${jki::settings::debug} >= "1"} { jki::util::jdbg "1" "sql| User row $user Created" }
                }
            }

            proc initdb {} {
				if {${jki::settings::debug} >= "2"} { jki::util::jdbg "2" "*** initializing sql"; }
				jdb eval {CREATE TABLE dealers(drug TEXT, dealer TEXT, uses INTEGER)}
				jdb eval {CREATE TABLE strains(dab TEXT, joint TEXT, blunt TEXT, bong TEXT, hookah TEXT, steamroller TEXT, pipe TEXT, chillum TEXT)}
				jdb eval {CREATE TABLE brands(scotch TEXT, whiskey TEXT, congac TEXT, vodka TEXT, tequila TEXT, gin TEXT, beer TEXT, cooler TEXT)}
				jdb eval {INSERT INTO dealers VALUES('weed', 'system', 0)}
				jdb eval {INSERT INTO strains VALUES('Gastro Cough', 'GMO', 'Green Crack', 'Cupcake', 'Super Sour Diesel', 'Animal', 'Matanuska ThunderFuk', 'Runtz')}
				jdb eval {INSERT INTO brands VALUES('Single Malt Islay', 'Jameson', 'hennessy', 'Smirnoff', 'Patron', 'New Hamsterdam', 'Pisswasser', 'Beast Unleashed')}
				#                               0              1           2          3           4               5               6                7                8                    9                 10              
				jdb eval {CREATE TABLE users(user TEXT, weed INTEGER, alc INTEGER, nic INTEGER, heroin INTEGER, coke INTEGER, scotch INTEGER, whiskey INTEGER, rum INTEGER,  INTEGER)}
				if {${jki::settings::debug} >= "2"} { jki::util::jdbg "2" "*** SQL Database initialized"; }
            }
			proc checkdrug_use {user drug} {
                set jdbrt "[jdb eval {SELECT * FROM users WHERE user=$user}]"
                if {$drug == "weed"} { return [lindex [split $jdbrt] 1] }
				if {$drug == "alc"} { return [lindex [split $jdbrt] 2] }
				if {$drug == "nic"} { return [lindex [split $jdbrt] 3] }
				if {$drug == "heroin"} { return [lindex [split $jdbrt] 4] }
				if {$drug == "coke"} { return [lindex [split $jdbrt] 5] }
            }
			proc checkstrain {drug} {
				set jdbrt [jdb eval "SELECT $drug FROM strains"]
				if {${jki::settings::debug} >= "2"} { jki::util::jdbg "2" "checkstrain - $jdbrt"; }
				return $jdbrt;
			}
			proc checkbrand {alc} {
				set jdbrt [jdb eval "SELECT $alc FROM brands"]
				if {${jki::settings::debug} >= "2"} { jki::util::jdbg "2" "checkbrand - $jdbrt"; }
				return $jdbrt;
			}
            proc changedrug {user d v} {
				jdb eval "UPDATE users SET '$d' = ('$v') WHERE user = '$user'"
            }
		}
	}
	putlog "JunKii - Base Game $jki::settings::version -- LOADED"
}