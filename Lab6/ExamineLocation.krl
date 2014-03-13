ruleset examine_location {
	meta {
		use module a169x701 alias CloudRain
		use module a41x186  alias SquareTag
		use module b505258x5 alias location_data
	}
	rule show_fs_location {
		select when web cloudAppSelected
		pre {
			last_checkin = location_data:get_location_data("fs_checkin");
			checkin_html = <<
				<div>Checkin: #{last_checkin}</div>
			>>;
		}
		if not last_checkin.isnull() then {
			SquareTag:injectStyling();
			CloudRain:createLoadPanel("Foursquare Checkins!", {}, checkin_html);
		}
	}
}