extends Node

const WORD_LIST_PATH := "res://assets/dictionaries/2of12inf.txt"

var words: Trie = Trie.new()
var letter_loot_table: Dictionary = {}
var random := RandomNumberGenerator.new()

func _ready():
	if FileAccess.file_exists(WORD_LIST_PATH):
		var file = FileAccess.open(WORD_LIST_PATH, FileAccess.READ)
		while not file.eof_reached():
			var line = file.get_line()
			# Process each line here
			if line.contains("%"):
				continue
			if line.contains("!"):
				continue
			if line.length() == 5:
				words.insert(line)
				for letter_pos in 5:
					var letter = line[letter_pos]
					weigh_letter(letter)
		file.close()
	else:
		print("File not found: " + WORD_LIST_PATH)
	print("Counted " + str(words.count_words()) + " words")
	letter_loot_table = Sorter.sort_dict_by_value(letter_loot_table)
	print(letter_loot_table)

func contains_word(word: String) -> bool:
	return words.contains(word.to_lower())

func generate_random_word():
	return words.generate_random_word()
	pass

func weigh_letter(letter: String):
	if !letter_loot_table.has(letter):
		letter_loot_table.merge({letter:0})
	
	var number = letter_loot_table.get(letter)
	
	letter_loot_table.erase(letter)
	letter_loot_table.merge({letter:number+1})
	pass

func roll_random_letter() -> String:
	var weighted_sum = 0

	for key in letter_loot_table:
		var value = letter_loot_table.get(key)
		weighted_sum += value
	
	var num = random.randi_range(0, weighted_sum)
	
	for key in letter_loot_table:
		var value = letter_loot_table.get(key)
		
		if num <= value:
			return key
		num -= value
	return "?"

func iterate_words(callback: Callable, node = words.root, prefix = ""):
	if node.has('*'):
		callback.call(prefix)
	
	for letter in node.keys():
		if letter != '*':
			iterate_words(callback, node[letter], prefix + letter)

func can_make_word(word: String, letters: Array[String]) -> bool:
	for letter in word:
		if letters.has(letter):
			letters.remove_at(letters.find(letter))
		else:
			return false
	return true

func find_words(available_letters: Array[String]) -> Array[String]:
	var letter_count = {}
	for letter in available_letters:
		letter_count[letter] = letter_count.get(letter, 0) + 1
	
	return _recursive_word_search(letter_count)

func _recursive_word_search(letter_count: Dictionary, node = words.root, prefix = "") -> Array[String]:
	var found_words: Array[String] = []
	
	if node.has('*'):
		found_words.append(prefix)
	
	for letter in node.keys():
		if letter != '*' and letter in letter_count and letter_count[letter] > 0:
			letter_count[letter] -= 1
			found_words.append_array(_recursive_word_search(letter_count, node[letter], prefix + letter))
			letter_count[letter] += 1
	
	return found_words
