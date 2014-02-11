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
		pageQuery = page:url("query");
		select when pageview ".*" setting()
		notify("Lab2 Part 1", "Pwnd1!!") with sticky = true;
	}
}