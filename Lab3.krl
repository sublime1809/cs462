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
				<div>
					<label for="firstname">First name:</label>
					<input id="firstname" type="text" />
					<label for="lastname">Last name:</label>
					<input id="lastname" type="text" />
					<input value="Submit" type="submit" />
				</div>
			>>;
		}
		replace_html("#main", form);
	}
}