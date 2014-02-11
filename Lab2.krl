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
		pre {
			pageQuery = page:url("query");
		}
		notify("Lab2 Part 1", "Pwnd1!!") with sticky = true;
	}
}