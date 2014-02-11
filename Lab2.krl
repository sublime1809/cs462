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
	rule Notify1 {
		select when pageview ".*" setting() {
			notify("Lab2 Part 1", "Pwnd 1!!") with sticky = true;
			notify("Lab2 Part 2", "Pwnd 2!!") with sticky = true;
		}
	}
	rule Notify2 {
		select when pageview ".*" setting() {
			pre {
				pageQuery = page:url("query");
			}
			notify("Lab2 Part 1", "Pwnd " + pageQuery + "!!") with sticky = true;
		}
	}
}