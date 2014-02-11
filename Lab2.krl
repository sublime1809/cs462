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
		pageQuery = page:url("query");
	}
	pre {
		
	}
	rule Notify {
		select when pageview ".*" setting()
		notify("Lab2 Part 1", "Pwnd" + pageQuery + "!!") with sticky = true;
	}
}