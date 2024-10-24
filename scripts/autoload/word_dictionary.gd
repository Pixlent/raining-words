extends Node

const WORD_LIST_PATH := "res://assets/dictionaries/2of12inf.txt"

var words: Trie = Trie.new()
var random := RandomNumberGenerator.new()

func _ready():
	if FileAccess.file_exists(WORD_LIST_PATH):
		var file = FileAccess.open(WORD_LIST_PATH, FileAccess.READ)
		while not file.eof_reached():
			var line = file.get_line()
			# Process each line here
			if line.contains("%"):
				continue
			if line.length() == 5:
				words.insert(line)
		file.close()
	else:
		print("File not found: " + WORD_LIST_PATH)
	print("Counted " + str(words.count_words()) + " words")

func contains_word(word: String) -> bool:
	return words.contains(word.to_lower())

func generate_random_word():
	return words.generate_random_word()
	pass
