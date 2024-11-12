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
