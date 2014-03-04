ruleset foursquare {
	meta {
		use module a169x701 alias CloudRain
		use module a41x186  alias SquareTag
	}
	global {

	}
	rule process_fs_checkin {
		select when foursquare checkin
		pre {

		}
		always {
			set ent:venue event:attr("");
		}
	} 
	rule display_checkin {
		select when web cloudAppSelected 
		pre {
			checkin_html = <<
				Checking in!
			>>;
		}
		{
			SquareTag:injectStyling();
			CloudRain:createLoadPanel("Foursquare Checkins!", {}, checkin_html);
		}
	}
}