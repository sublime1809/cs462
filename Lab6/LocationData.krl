ruleset location_data {
	meta {
		provides get_location_data
	}
	global {
		get_location_data = function(key) {
			key_values = ent:key_values || { "fs_checkin": "Couldn't retrieve data."};
			key_values{key}
		}
	}
	rule add_location_item {
		select when pds new_location_data 
		pre {
			key = event:attr("key");
			value = event:attr("value");
			key_values = ent:key_values || {};
		}
		if not key.isnull() then {
			send_directive(key) with key = "location" and value = value;
		}
		fired {
			set ent:key_values key_values.put([key], value);
		}
	}
}