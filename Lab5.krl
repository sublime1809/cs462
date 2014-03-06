ruleset b505258x4 {
	meta {
		use module a169x701 alias CloudRain
		use module a41x186  alias SquareTag
	}
	global {

	}
	rule startup {
		select when web cloudAppSelected
		pre {
			fs_venue = ent:venue;
			fs_city = ent:city;
			fs_shout = ent:shout;
			fs_createdAt = time:new(ent:createdAt);
			checkin_html = <<
				Foursquare App!! Woot Woot!
				<div id="checkins">
					<ul>
						<li>Venue: #{fs_venue}</li>
						<li>City: #{fs_city}</li>
						<li>Shout: #{fs_shout}</li>
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
			fs_venue = fs_checkin.pick("$.venue.name");
			fs_city = fs_checkin.pick("$.venue.location..city");
			fs_shout = fs_checkin.pick("$.shout");
			fs_createdAt = fs_checkin.pick("$.createdAt");
		}
		if not fs_venue.isnull() then noop();
		fired {
			set ent:venue fs_venue;
			set ent:city fs_city;
			set ent:shout fs_shout;
			set ent:createdAt fs_createdAt;
			raise explicit event show_checkin;
		} else {
			set ent:venue "not visited";
			raise explicit event show_checkin;
		}
	} 
	rule display_checkin {
		select when explicit show_checkin
		pre {
			checkin_html = <<
				Checking in!
			>>;
		}
		{
			replace_inner("#checkins", checkin_html);
		}
	}
}