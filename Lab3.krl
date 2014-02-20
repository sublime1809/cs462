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
			name_form = <<
				<div id="value">
					<label for="firstname">First name:</label>
					<input id="firstname" type="text" />
					<label for="lastname">Last name:</label>
					<input id="lastname" type="text" />
					<input id="name_submit" value="Submit" type="submit" />
				</div>
			>>;
		}
		if ent:firstname.isnull() {
			replace_html("#main", name_form);
			watch("#name_submit", "click");
			notify("Last name", document.query('#lastname').value);
		}
	}

	rule submit_rule {
		select when web click "#name_submit"
		notify("You clicked", 'Watch');
	}
}