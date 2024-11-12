class_name Sorter

static func sort_dict_by_value(dict: Dictionary) -> Dictionary:
	var pairs = dict.keys().map(func(key): return [key, dict[key]])
	pairs.sort_custom(func(a, b): return a[1] > b[1])
	
	var sorted_dict = {}
	for pair in pairs:
		sorted_dict[pair[0]] = pair[1]
	
	return sorted_dict
