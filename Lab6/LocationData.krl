ruleset location_data {
	global {
		get_location_data = function(key) {
			ent:#{key}
		}
	}
	rule add_location_item {
		select when pds new_location_data 
		pre {
			key = event:attr("key");
			value = event:attr("value");
		}
		if not key.isnull() then noop();
		fired {
			set ent:#{key} value;
		}
	}
}