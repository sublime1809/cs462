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
				<div id="name_form">
					<label for="first_name">First name:</label>
					<input id="first_name" type="text" />
					<label for="last_name">Last name:</label>
					<input id="last_name" type="text" />
					<input id="name_submit" value="Submit" type="submit" />
				</div>
			>>;
		}
		{
			replace_html("#main", name_form);
			watch("#name_form", "submit");
		}
	}
	rule submit_rule {
		select when web submit "#name_form"
		pre {
			first_name = event:attr("first_name");
			last_name = event:attr("last_name");
		}
		{
			notify("Welcome", "Hello #{first_name} #{last_name}") with sticky = true;
		}
	}
}