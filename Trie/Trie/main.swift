
import Foundation


let trie = Trie<String>()

trie.insert("car")
print(" 1. car 라는 단어가 포함되어 있어? \(trie.contains("car"))") 
trie.insert("card")
trie.insert("care")
trie.insert("cared")
trie.insert("banana")
trie.insert("bananonaa")
print(" 2. card 삭제할거야, 삭제 전에 card 확인 : \(trie.contains("card"))")
trie.remove("card")
print(" 2. card 삭제 후 card 확인 : \(trie.contains("card"))")
print(" 3. ca 로 시작하는 단어들은 \n \(trie.collections(startingWith: "ca"))")
print(" 3. care 로 시작하는 단어들은 \n \(trie.collections(startingWith: "care"))")
print(" 3. ba 로 시작하는 단어들은 \n \(trie.collections(startingWith: "ba"))")


