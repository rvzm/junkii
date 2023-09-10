namespace eval jki {
	namespace eval settings {
		variable version "0.1d"
		variable build "091008"
		variable release "dev"
		variable debug "3"
		namespace eval gen {
			variable pubtrig "@"
			variable homechan "#bots"
		}
		namespace eval shop {
			variable nic "13"
			variable alc "15"
			variable heroin "20"
			variable coke "35"
		}
		namespace eval timers {
			variable packdefault "15"
		}
		namespace eval flags {
			setudef flag jnki
			setudef flag weed
			setudef flag sch2
			setudef flag sch1
		}
	}
}
putlog "JunKii ADATBRPG - settings loaded";