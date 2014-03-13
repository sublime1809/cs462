ruleset location_data {
	meta {
		provides get_location_data
	}
	global {
		get_location_data = function(key) {
			ent:key_values.values(key)
		}
	}
	rule add_location_item {
		select when pds new_location_data 
		pre {
			key = event:attr("key").as("str");
			value = event:attr("value").as("str");
			key_value = {key: "#{value}"};
			merged_map = ent:key_values.put(key_value);
		}
		if not key.isnull() then noop();
		fired {
			set ent:key_values merged_map;
		}
	}
}