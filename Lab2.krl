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
		}
		if (not query.isnull()) then {
			notify("Lab2 Part 3", "Pwnd1!!") with sticky = true;
		}
		if (query.isnull()) then {
			notify("Lab2 Part 3", "Null Query") with sticky = true;
		}
	}
}


