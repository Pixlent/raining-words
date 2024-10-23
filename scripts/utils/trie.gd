class_name Trie

var root = {}
var word_count = 0

func insert(word):
	var node = root
	for letter in word:
		if not node.has(letter):
			node[letter] = {}
		node = node[letter]
	if not node.has('*'):
		node['*'] = true
		word_count += 1

func count_words():
	return word_count

func contains(word: String) -> bool:
	var node = root
	for letter in word:
		if not node.has(letter):
			return false
		node = node[letter]
	return node.has('*')

func starts_with(prefix: String) -> bool:
	var node = root
	for letter in prefix:
		if not node.has(letter):
			return false
		node = node[letter]
	return true

func generate_random_word() -> String:
	var word = ""
	var node = root

	while true:
		# Get all possible next letters (including end-of-word marker '*')
		var choices = node.keys()
		
		# If we've reached a dead end (shouldn't happen in a proper trie)
		if choices.is_empty():
			return word if word else "ERROR: Empty trie"
		
		# Randomly choose the next letter or end the word
		var choice = choices[randi() % choices.size()]
		
		# If we've reached the end of a word, return it
		if choice == '*':
			return word
		
		# Otherwise, add the letter to our word and continue
		word += choice
		node = node[choice]
	
	# This line should never be reached
	return "ERROR: Unexpected end of trie"
