ruleset Lab3 {
	meta {
		name "Lab 3"
		description <<
			Lab3
		>>
		author "Chrys"
		logging off
	}
	dispatch {

	}
	global {
		
	}
	rule show_form {
		select when pageview ".*"
		pre {
			form = <<
				<div></div>
			>>;
		}
		replace_html("#main", form);
	}
}