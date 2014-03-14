ruleset b505258x4 {
	meta {
		use module a169x701 alias CloudRain
		use module a41x186  alias SquareTag
		use module b505258x5 alias location_data
	}
	global {

	}
	rule startup {
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
	rule process_fs_checkin is active {
		select when foursquare checkin
		pre {
			fs_checkin = event:attr("checkin").decode();
			fs_venue = fs_checkin.pick("$..venue.name");
			fs_city = fs_checkin.pick("$..venue.location..city");
			fs_state = fs_checkin.pick("$..venue.location..state");
			fs_shout = fs_checkin.pick("$..shout");
			fs_createdAt = fs_checkin.pick("$..createdAt");
			fs_map = {
				"venue" : fs_venue,
				"city": fs_city,
				"state": fs_state,
				"shout": fs_shout,
				"createdAt": fs_createdAt
			};
		}
		if not fs_venue.isnull() then noop();
		fired {
			set ent:venue fs_venue;
			set ent:city fs_city;
			set ent:state fs_state;
			set ent:shout fs_shout;
			set ent:createdAt fs_createdAt;
			raise pds event new_location_data for location_data with key = "fs_checkin" and value = fs_map;
		}
	} 
}