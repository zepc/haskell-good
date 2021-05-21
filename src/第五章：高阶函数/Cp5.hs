--haskell中的函数可以作为参数和返回值传来传去，这样的函数就被称作高阶函数。
--高阶函数可不只是某简单特性而已，它贯穿于haskell的方方面面。
--要拒绝循环与状态的改变而通过定义问题"是什么"来解决问题，高阶函数必不可少。它们是编码的得力工具。


-- 柯里函数
--本质上，haskell的所有函数都只有一个参数

max 4 5
(max 4) 5

--把空格放到两个东西之间，称作*函数调用*。它有点像个运算符，并拥有最高的优先级。 看看max函数的类型: ``max :: (Ord a) => a -> a -> a``。
--也可以写作: ``max :: (Ord a) => a -> (a -> a)``。 可以读作max取一个参数a，并返回一个函数(就是那个``->``)，这个函数取一个a类型的参数，返回一个a。
--这便是为何只用箭头来分隔参数和返回值类型。

--以不全的参数调用函数可以方便地创造新的函数
multThree :: (Num a) => a -> a -> a -> a
multThree x y z = x * y * z

--((mulThree 3) 5) 9
let multTwoWithNine = multThree 9
multTwoWithNine 2 3



cmpWithHundred :: (Num a, Ord a) => a -> Ordering
cmpWithHundred x = compare 100 x

--注意下在等号两边都有x

-- compare的类型为``(Ord a) => a -> a -> Ordering)``
-- 用100调用后，它返回的函数类型首先变为为 (Ord a) => a -> Ordering，
-- 由于100是 Num 类型类的实例，所以还得另留一个类约束，所以最终的返回类型为 (Num a, Ord a) => a -> Ordering
cmpWithHundred :: (Num a, Ord a) => a -> Ordering
cmpWithHundred = compare 100


-- 中缀函数也可以不全调用，用括号把它和一边的参数括在一起就行了
divideByTen :: (Floating a) => a -> a
divideByTen = (/10)

--divideByTen 200 就是 (/10) 200 和 200 / 20 等价

isUpperAlphanum :: Char -> Bool
isUpperAlphanum = (`elem` ['A'..'Z'])

--唯一的例外就是``-``运算符，按照前面提到的定义，``(-4)``理应返回一个并将参数减4的函数，而实际上，处于计算上的方便，``(-4)``表示负``4``。
--若你一定要弄个将参数减4的函数，就用``subtract``好了，像这样``(subtract 4)``.


--若在ghci中计算``1+1``，它会首先计算得``2``，然后调用``show 2``得到该数值的字符串表示，即"2"，再输出


-- 高阶函数

--首先注意这类型声明, 因为``(->)``是自然的右结合，不过在这里括号是必须的。
--它标明了首个参数是个参数与返回值类型都是a的函数，第二个参数与返回值的类型也都是a。
applyTwice :: (a -> a) -> a ->a
applyTwice f x = f (f x)


zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith' _ [] _ = []
zipWith' _ _ [] = []
zipWith' f (x:xs) (y:ys) = f x y : zipWith' f xs ys


flip' :: (a -> b -> c) -> (b -> a -> c)
flip' f = g
  where g x y = f y x

flip' :: (a -> b -> c) -> b -> a -> c
flip' f y x = f x y


-- map 与 filter
map' :: (a -> b) -> [a] -> [b]
map' _ [] = []
map' f (x:xs) = f x : map' f xs

filter' :: (a -> Bool) -> [a] -> [b]
filter' _ [] = []
filter' f (x:xs) =
  | f x = x : filter' f xs
  | otherwise = filter' f xs

--并没有教条规定你必须在什么情况下用``map``和``filter``还是_List Comprehension_，
--选择权归你，看谁舒服用谁就是。如果有多个限制条件，只能连着套好几个filter或用&&等逻辑函数的组合之，
--这时就不如list comprehension来得爽了。

--即便是你多次map一个list也只会遍历一遍该list

largestDivisible :: (Integral a) => a
largestDivisible = head (filter f [100000, 99999..])
  where f x = x `mod` 3829 == 0

-- 列出奇数的平方，并对小于10000的平方求和
sum (takeWhile (<10000) (filter odd (map (^2) [1..])))
