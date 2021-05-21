-- List
-- let 定义一个常量
let lostNumbers = [4, 8, 15, 16, 23, 48]

-- ++ : haskell会遍历左边的list
[1,2,3,4] ++ [9, 10, 11, 12]
"hello" ++ " " ++ "world"

-- :, 连接一个元素到一个List或者字符串之中
'A' : " SMALL CAT"
-- [1, 2, 3]实际上是1:2:3:[]的语法糖
-- [] 空list
5: [1,2,3,4,5]

-- !!: 获取指定索引的元素
"Steve Buscemi" !! 6

-- 使用 > 和 >= 可以比较List的大小，它会先比较第一个元素，若值相等，则比较下一个
[3,2,1] > [2,1,0]

head [5,4,3,2,1]
tail [5,4,3,2,1]
last [5,4,3,2,1]
init [5,4,3,2,1]

length [5,4,3,2,1]
-- null 检查一个List是否为空
null [1,2,3]

reverse [5,4,3,2,1]
take 1 [5,4,3,2,1]

minimum [5,4,3,2,1]
maximum [5,4,3,2,1]

sum [5,4,3,2,1]
-- 所有元素的积
product [5,4,3,2,1]

-- elem 判断List是否包含
4 `elem` [3,4,5,5]



-- Range
[1,2,3,4,5]
[1 .. 5]

-- 2为步长
[2,4..20]

-- 不能使用[20..1]生成20到1的List
-- 必须是[20,19..1]才能生成
[20,19..1]

-- 24个13的倍数
[13, 26..24*13]
-- 更好的方法是从无限List中take
take 24 [13,26..]

-- 由于 Haskell 是惰性的，它不会对无限长度的 List 求值，否则会没完没了的。
-- 它会等着，看你会从它那儿取多少。

-- 无限List生成函数
-- cycle 接收一个List
take 10 (cycle [1,2,3])
-- repeat 接收一个值
take 10 (repeat 5)

-- 其实，你若只是想得到包含相同元素的 List ，使用 replicate 会更简单 
replicate 3 10 -- [10,10,10]

-- List递推式
[x * 2 | x <- [1..10]]
[x * 2 | x <- [1..10], x * 2 > 12]

booBang xs = [if x < 10 then "BOOM" else "BANG" | x <- xs, odd x]

[x | x <- [10..20], x /= 13, x /= 15, x /= 19]

[x * y | x <- [1,2,3], y <- [4,5,6]]

let nouns = ["hobo","frog","pope"]   
let adjectives = ["lazy","grouchy","scheming"]   
[adjective ++ " " ++ noun | adjective <- adjectives, noun <- nouns]

length' xs = sum [1 | _ <- xs]
removeNonUppercase st = [ c | c <- st, c `elem` ['A'..'Z']]  

let xxs = [[1,3,5,2,3,1,2,4,5],[1,2,3,4,5,6,7,8,9],[1,2,4,2,1,6,3,1,3,2,3,6]]   
[ [ x | x <- xs, even x ] | xs  xxs]  


-- tuple
-- fst: 返回序列的首项
fst (8, 10)
-- snd 返回序对的尾项
snd (8,11)

zip [1,2,3,4,5] [5,5,5,5,5] 
zip [1..] ["apple", "orange", "cherry", "mango"]

let triangles = [(x,y,z) | z<-[1..10], y<-[1..z], x <- [1..y] , x^2 + y^2 == z^2, x + y + z == 24]
