ruleset lab7 {
	meta {
		use module a169x701 alias CloudRain
		use module a41x186  alias SquareTag
		use module b505258x5 alias location_data
	}
	/*rule nearby {
		select when location new_current
		pre {
			new_checkin = event:attr("checkin").decode();
			new_lat = new_checkin.pick("$..venue.location..lat");
			new_lng = new_checkin.pick("$..venue.location..lng");

			fs_checkin = location_data:get_location_data("fs_checkin");
			fs_lat = last_checkin{"lat"};
			fs_lng = last_checkin{"lng"};

			
			r90   = math:pi()/2;      
			rEk   = 6378;         // radius of the Earth in km
			 
			// point a
			lata  = new_lat;
			lnga  = new_lng;
			 
			// point b
			latb  = fs_lat;
			lngb  = fs_lng;
			 
			// convert co-ordinates to radians
			rlata = math:deg2rad(lata);
			rlnga = math:deg2rad(lnga);
			rlatb = math:deg2rad(latb);
			rlngb = math:deg2rad(lngb);
			 
			// distance between two co-ordinates in kilometers
			dE = math:great_circle_distance(rlnga,r90 - rlata, rlngb,r90 - rlatb, rEk);
			miles = dE*(0.621371);
		}
		if(miles < 5) then {
			noop();
		}
		fired {
			// raise explicit event location_near ;
			set ent:old_lat fs_lat;
			set ent:old_lng fs_lng;
			set ent:new_lat new_lat;
			set ent:new_lng new_lng;
			set ent:dist = miles;
		}
		else {
			// raise explicit event location_far ;
		}
	}*/
	rule show_distance {
		select when web cloudAppSelected
		pre {
			fs_lat = 10;//ent:old_lat;
			fs_lng = 5;//ent:old_lng;
			new_lat = 15;//ent:new_lat;
			new_lng = 20;//ent:new_lng;
			dist = 25;//ent:dist;

			my_html = <<
				<div id="main">
					<p>Old Lat: #{fs_lat}</p>
					<p>Old Lng: #{fs_lng}</p>
					<p>New Lat: #{new_lat}</p>
					<p>New Lng: #{new_lng}</p>
					<p>Dist: #{dist}</p>
				</div>
			>>;
		}
		{
			SquareTag:inject_styling();
			CloudRain:createLoadPanel("Distance", {}, my_html);
		}
	}
}