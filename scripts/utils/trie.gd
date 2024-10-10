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

func contains(word: String):
	var node = root
	for letter in word:
		if not node.has(letter):
			return false
		node = node[letter]
	return node.has('*')

func starts_with(prefix: String):
	var node = root
	for letter in prefix:
		if not node.has(letter):
			return false
		node = node[letter]
	return true
