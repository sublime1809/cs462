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
			name_form_html = <<
				<form id="name_form" onsubmit="return false">
					<label for="first_name">First name:</label>
					<input name="first_name" type="text" />
					<label for="last_name">Last name:</label>
					<input name="last_name" type="text" />
					<input value="Submit" type="submit" />
				</form>
			>>;
		}
		{
			replace_html("#main", name_form_html);
			watch("#name_form", "submit");
		}
	}
	rule catch_submit {
		select when web submit "#name_form"
		pre {
			first_name = event:attr("first_name");
			last_name = event:attr("last_name");
		}
		notify("Button Clicked", "HI #{first_name} #{last_name}") with sticky = true;
		fired 
		{
			set ent:first_name event:attr("first_name");
			set ent:last_name event:attr("last_name");
		}
	}
}