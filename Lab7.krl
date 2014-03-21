ruleset lab7 {
	meta {
		use module a169x701 alias CloudRain
		use module a41x186  alias SquareTag
		use module b505258x5 alias location_data
	}
	rule nearby is active {
		select when location new_current
		pre {
			new_lat = event:attr("lat");
			new_lng = event:attr("lng");

			last_checkin = location_data:get_location_data("fs_checkin");
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
		if (miles < 5) then {
			noop();
		}
		fired {	
			set ent:old_lat fs_lat;
			set ent:old_lng fs_lng;
			set ent:new_lat new_lat;
			set ent:new_lng new_lng;
			set ent:dist miles;
			set ent:state "near";

			raise explicit event location_nearby for b505258x8 with dist = miles;
		}
		else {
			set ent:old_lat fs_lat;
			set ent:old_lng fs_lng;
			set ent:new_lat new_lat;
			set ent:new_lng new_lng;
			set ent:dist miles;
			set ent:state "far";

			raise explicit event location_far for b505258x8 with dist = miles;
		}
	}
	rule show_distance {
		select when web cloudAppSelected
		pre {
			fs_lat = ent:old_lat;
			fs_lng = ent:old_lng;
			new_lat = ent:new_lat;
			new_lng = ent:new_lng;
			dist = ent:dist;
			state = ent:state;

			my_html = <<
				<div id="main">
					<p>Old Lat: #{fs_lat}</p>
					<p>Old Lng: #{fs_lng}</p>
					<p>New Lat: #{new_lat}</p>
					<p>New Lng: #{new_lng}</p>
					<p>Dist: #{dist}</p>
					<p>State: #{state}</p>
				</div>
			>>;
		}
		{
			SquareTag:inject_styling();
			CloudRain:createLoadPanel("Distance", {}, my_html);
		}
	}
}