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
	rule NotifyQuery {
		select when pageview ".*" setting()
		pre {
			pageQuery = page:url("query");
		}
		notify("Lab2 Part 1", "Pwnd " + pageQuery + "!!") with sticky = true;
	}
}