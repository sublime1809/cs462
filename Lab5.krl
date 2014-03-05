ruleset foursquare {
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
			checkin_html = <<
				Foursquare App!! Woot Woot!
				<div id="checkins"></div>
			>>;
		}
		{
			SquareTag:injectStyling();
			CloudRain:createLoadPanel("Foursquare Checkins!", {}, checkin_html);
		}
	}
	rule process_fs_checkin {
		select when foursquare checkin
		pre {
			checkin_html = <<
				Checking in!
			>>;
		}
		{
			replace_inner("#checkins", checkin_html);
		}
	} 
	rule display_checkin {
		select when explicit show_checkin
		pre {
			fs_venue = event:attr("fs_venue");
			checkin_html = <<
				Checking in! #{fs_venue}
			>>;
		}
		{
			replace_inner("#checkins", checkin_html);
		}
	}
}