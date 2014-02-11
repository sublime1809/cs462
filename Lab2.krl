ruleset Lab2 {
	meta {
		name "Notify"
		description <<
			Lab2 part 1
		>>
		author "Chrys"
		logging off
	}
	dispatch {

	}
	global {

	}
	rule Notify {
		select when pageview ".*" setting()
		notify("Lab2 Part 1", "Pwnd!!") with sticky = true;
		notify("Lab2 Part 2", "Pwnd?") with sticky = true;
	}
}