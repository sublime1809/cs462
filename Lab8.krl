ruleset Lab8 {
	meta {
		use module a169x701 alias CloudRain
		use module a41x186  alias SquareTag
	}
	rule location_catch {
		select when location notification
		pre {
			fs_venue = event:attr("venue");
			fs_city = event:attr("city");
			fs_state = event:attr("state");
			fs_shout = event:attr("shout");
			fs_createdAt = event:attr("createdAt");
		}
		if not fs_venue.isnull() then { noop(); }
		fired {
			set ent:venue fs_venue;
			set ent:city fs_city;
			set ent:state fs_state;
			set ent:shout fs_shout;
			set ent:createdAt fs_createdAt;
		}
	}
	rule location_show {
		select when web cloudAppSelected
		pre {
			fs_venue = ent:venue;
			fs_city = ent:city;
			fs_state = ent:state;
			fs_shout = ent:shout;
			fs_createdAt = ent:createdAt;
			checkin_html = <<
				Your Last Checkin:
				<div id="checkins">
					<ul>
						<li>Venue: #{fs_venue}</li>
						<li>City: #{fs_city}, #{fs_state}</li>
						<li>Shout: "#{fs_shout}"</li>
						<li>Created At: #{fs_createdAt}</li>
					</ul>
				</div>
			>>;
		}
		{
			SquareTag:injectStyling();
			CloudRain:createLoadPanel("Foursquare Checkins!", {}, checkin_html);
		}
	}
}