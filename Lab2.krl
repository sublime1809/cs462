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
		select when pageview ".*" setting() {
			notify("Lab2 Part 1", "Pwnd1!!") with sticky = true;	
			notify("Lab2 Part 2", "Pwnd2!!") with sticky = true;
		}
	}
	rule Query {
		select when pageview ".*"
		pre {
			query = page:url("query");
			name = query.extract(re/(?:&|^)name=([^&]*)/);
		}
		if (name[0]) then {
			name[0].isnull() => notify("Lab2 Part 3", "Hello Monkey.") |
				notify("Lab2 Part 3", "Pwnd " + name[0] + "!!") with sticky = true;
		}
	}
}