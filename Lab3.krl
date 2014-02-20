ruleset Lab3 {
	meta {
		name "Lab 3"
		description <<
			Lab3
		>>
		author "Chrys"
		logging off
	}
	rule clear_name {
		select when pageview ".*"
		pre {
			query = page:url("query");
			clearParam = query.extract(re/(?:&|^)clear=(1)(?:[^&]*)/);
		}
		always {
			clear ent:first_name if not clearParam[0].isnull();
			clear ent:last_name if not clearParam[0].isnull();
		}
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
			replace_inner("#main", name_form_html);
			watch("#name_form", "submit");
		}
	}
	rule form_submit {
		select when web submit "#name_form"
		pre {
			first_name = event:attr("first_name");
			last_name = event:attr("last_name");
		}
		notify("Welcome", "Welcome #{first_name} #{last_name}") with sticky = true;
		always 
		{
			set ent:first_name event:attr("first_name");
			set ent:last_name event:attr("last_name");
		}
	}
	rule display_name {
		select when pageview ".*"
		pre {
			name_p_html = <<
				<p>#{ent:first_name} #{ent:last_name}</p>
			>>;
		}
		if(not ent:first_name eq "" && not ent:last_name eq "") then {
			append("#main", name_p_html);
		}
	}
}