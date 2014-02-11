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
	pre {
		pageQuery = page:url("query");
	}
	rule Notify {
		select when pageview ".*" setting()
		notify("Lab2 Part 1", "Pwnd" + pageQuery + "!!") with sticky = true;
	}
}