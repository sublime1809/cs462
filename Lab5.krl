ruleset foursquare {
	rule process_fs_checkin {
		select when foursquare checkin
		pre {

		}
		always {
			set ent:venue event:attr("");
		}
	} 
	rule display_checkin {

	}
}