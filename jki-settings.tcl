namespace eval jki {
	namespace eval settings {
		variable version "0.1d"
		variable build "090902"
		variable release "dev"
		variable debug "2"
		namespace eval gen {
			variable pubtrig "@"
			variable controller "~j"
			variable homechan "#bots"
		}
		namespace eval hunt {
			variable trigger "8"
			variable time "5"
			variable horde "yes"
			variable maxhorde "3"
			variable roast "no"
			variable startonjoin "yes"
		}
		namespace eval shop {
			variable clips "2"
			variable lvlup "5"
			variable accuracyupgrade "2"
			variable clipupgrade "10"
			variable hordetokens "35"
		}
		namespace eval flags {
			setudef flag jkic
			setudef flag jnki
		}
	}
}
putlog "JunKii ADATBRPG - settings loaded";