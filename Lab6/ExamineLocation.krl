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
			fs_venue = last_checkin{"venue"};
			fs_city = last_checkin{"city"};
			fs_state = last_checkin{"state"};
			fs_shout = last_checkin{"shout"};
			fs_createdAt = last_checkin{"createdAt"};
			fs_lat = last_checkin{"lat"};
			fs_lng = last_checkin{"lng"};

			checkin_html = <<
				Your Last Checkin from location_data module:
				<div id="checkins">
					<ul>
						<li>Venue: #{fs_venue}</li>
						<li>City: #{fs_city}, #{fs_state}</li>
						<li>Shout: "#{fs_shout}"</li>
						<li>Created At: #{fs_createdAt}</li>
						<li>Latitude: #{fs_lat}</li>
						<li>Longitude: #{fs_lng}</li>
					</ul>
				</div>
			>>;
		}
		if not last_checkin.isnull() then {
			SquareTag:injectStyling();
			CloudRain:createLoadPanel("Foursquare Checkins!", {}, checkin_html);
		}
	}
}