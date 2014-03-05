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
			fs_venue = event:attr("fs_venue");
			visited = ent:venue;
			checkin_html = <<
				Foursquare App!! Woot Woot!
				<div id="checkins">#{visited}</div>
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
			fs_city = fs_checkin.pick("$..city");
		}
		if not fs_venue.isnull() then noop();
		fired {
			raise explicit event show_checkin with ev_venue = fs_venue;
			set ent:venue fs_venue;
		} else {
			set ent:venue "not visited";
		}
	} 
	rule display_checkin {
		select when explicit show_checkin
		pre {
			fs_venue = event:attr("ev_venue");
			checkin_html = <<
				Checking in! #{fs_venue}
			>>;
		}
		{
			replace_inner("#checkins", checkin_html);
		}
	}
}