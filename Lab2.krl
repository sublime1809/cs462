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
		notify("Hello World", "This is a sample rule.") with sticky = true;
	}
}