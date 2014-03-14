ruleset location_data {
	meta {
		provides get_location_data
	}
	global {
		get_location_data = function(key) {
			key_values = app:key_values || { "failed": "Couldn't retrieve data."};
			key_values{key}
		}
	}
	rule add_location_item {
		select when pds new_location_data 
		pre {
			key = event:param("key");
			value = event:param("value");
		}
		if not key.isnull() then noop();
		fired {
			set app:key_values key_values.put([key], value);
		}
	}
}