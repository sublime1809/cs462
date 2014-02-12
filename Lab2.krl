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
			nameValue = (name[0].isnull()) => "Monkey" | name[0];
		}
		notify("Lab2 Part 3", "Hello " + nameValue + ".") with sticky = true;
	}
	rule Count {
		select when pageview ".*"
		pre {
			query = page:url("query");
			clearParam = query.extract(re/(?:&|^)clear=([^&]*)/);
			visits = ent:visits;
		}
		if ent:visits < 500 then {
			notify("Lab2 Part 5", "Count: " + visits) with sticky = true;
		}
		always {
			ent:visits += 1 from 1;
			clear ent:visits if not clearParam[0].isnull();
		}
	}
}