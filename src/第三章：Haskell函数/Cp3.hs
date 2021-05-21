--模式匹配
lucky :: (Integral a) => a -> String
lucky 7 = "LUCKY NUMBER SEVEN!"
lucky x = "Sorry, you're out of luck, pal!"


sayMe :: (Integral a) => a -> String
sayMe 1 = "One!"
sayMe 2 = "Two!"
sayMe 3 = "Three!"
sayMe 4 = "Four!"
sayMe 5 = "Five!"
sayMe x = "Not between 1 and 5"

-- 递归函数
factorial :: (Integral a) => a -> a
factorial 0 = 1
factorial n = n * factorial(x - 1)

-- 模式匹配也可能失败
charName :: Char -> String
charName 'a' = "Albert"
charName 'b' = "Broseph"
charName 'c' = "Cecil"

addVectors :: (Num a) => (a, a) -> (a, a) -> (a, a)
addVectors (x1, y1) (x2, y2) = (x1 + x2, y1 + y2)


first :: (a, b, c) -> a
first (x, _, _) = x

second :: (a, b, c) -> b
second (_, y, _) = y

third :: (a, b, c) -> c
third (_, _, z) = z

let xs = [(1,3), (4,3), (2,4), (5,3), (5,6), (3,1)]
[a+b | (a,b)  xs]
--x:xs这样的模式可以将list的头部绑定为x，尾部绑定为xs。如果这list只有一个元素，那么xs就是一个空list。
--如果你要把list的前三个元素都绑定到变量中，可以使用类似x:y:z:xs这样的形式。它只能匹配长度大于等于3的list。

head' :: [a] -> a
head' [] = error "Can't call head on an empty list, dummy!"
head' (x:_) = x


tell :: (Show a) => [a] -> String
tell [] = "The list is empty"
tell (x:[]) = "The list has one element: " ++ show x
tell (x:y:[]) = "The list has two elements: " ++ show x ++ " and " ++ show y
tell (x:y:_) = "This list is long. The first two elements are: " ++ show x ++ " and " ++ show y


length' :: (Num b) => [a] -> b
length' [] = 0
length' (_:xs) = 1 + length' xs

sum' :: (Num a) => [a] -> a
sum' [] = 0
sum' (x:xs) = x + sum' xs


-- as模式：将一个名字和@置于模式前，可以在按模式分割什么东西时仍保留对其整体的引用。
-- 如这个模式xs@(x:y:ys)，它会匹配出与x:y:ys对应的东西，同时你也可以方便地通过xs得到整个list，而不必在函数体中重复x:y:ys
capital :: [a] -> String
capital [] = "Empty string, whoops!"
capital all@(x:_) = "the fist letter of " ++ all ++ " is " ++ [x]
-- 使用as模式通常就是为了在较大的模式中保留对整体的引用，从而减少重复性的工作。


--注意，门卫!
--模式用来检查一个值是否合适并从中取值，而门卫（guard）则用来检查一个值的某项属性是否为真。咋一听有点像是if语句，
--实际上也正是如此。不过处理多个条件分支时门卫的可读性要高些，并且与模式匹配契合的很好。
-- 哨卫跟在竖线（|）符号的右边，一个哨卫就是一个布尔表达式，
-- 如果计算为True，就选择对应的函数体；
-- 如果为False，函数就开始对下一个哨卫求值，不断重复这一过程
bmiTell :: Double -> String
bmiTell bmi
  | bmi <= 18.5 = "You're underweight, you emo, you!"
  | bmi <= 25.0 = "You're supposedly normal. Pffft, I bet you're ugly!"
  | bmi <= 30.0 = "You're fat ! Lose some weight, fatty!"
  | otherwise = "You're a whale, congratulations!"

-- 第一个哨位之前并没有”=“号
bmiTell :: Double -> Double -> String
bmiTell weight, height
  | weight / height ^ 2 <= 18.5 = "You're underweight, you emo, you!"
  | weight / height ^ 2 <= 25.0 = "You're supposedly normal. Pffft, I bet you're ugly!"
  | weight / height ^ 2 <= 30.0 = "You're fat ! Lose some weight, fatty!"
  | otherwise = "You're a whale, congratulations!"

max' :: Ord(a) => a -> a -> a
max' a b
  | a < b = b
  | otherwise = a


-- 通过反单引号，我们不仅可以以中缀形式调用函数，也可以使用它直接按照中缀的形式定义函数
myCompare :: (Ord a) => a -> a -> Ordering
a `myCompare` b
  | a == b  = EQ
  | a <  b  = LT
  | otherwise  = GT


--Where ?!
--在编程时人们通常希望避免重复计算同一个值，而尽可能地只计算一次，保存计算的结果供反复使用。
--在命令式语言中，可以将计算的结果保存到一个变量中, 而在Haskell中使用where关键字来保存计算的中间结果，
--从而实现类似的功能

--这里将where关键字跟在了哨卫后面，随后即可定义任意数量的名字和函数了。这些名字对每个哨卫都是可见的，这一来就避免了重复
bmiTell :: Double -> Double -> String
bmiTell weight, height
  | bmi <= 18.5 = "You're underweight, you emo, you!"
  | bmi <= 25.0 = "You're supposedly normal. Pffft, I bet you're ugly!"
  | bmi <= 30.0 = "You're fat ! Lose some weight, fatty!"
  | otherwise = "You're a whale, congratulations!"
  where bmi = weight / height ^ 2


--注意其中的变量定义都必须对齐于同一列。如果不这样规范，Haskell就会搞不清楚它们各自位于哪个代码块了
bmiTell :: Double -> Double -> String
bmiTell weight, height
  | bmi <= skinny = "You're underweight, you emo, you!"
  | bmi <= normal = "You're supposedly normal. Pffft, I bet you're ugly!"
  | bmi <= fat = "You're fat ! Lose some weight, fatty!"
  | otherwise = "You're a whale, congratulations!"
  where bmi = weight / height ^ 2
        skinny = 18.5
        normal = 25.0
        fat = 30.0

-- where的作用域
-- 函数where部分中定义的名字只对本函数可见，
-- 如果你想在不同的函数中重复用到同一名字，就应该把它置于全局定义之中。

-- where中定义的名字不能再函数的其他模式中访问
greet :: String -> String
greet "Juan" = niceGreeting ++ " Juan!"
greet "Fernando" = niceGreeting ++ " Fernando!"
greet name = badGreeting ++ " " ++ name
  where niceGreeting = "Hello! So very nice to see you,"
        badGreeting = "Oh! Pfft. It's you."

-- 定义为全局
niceGreeting :: String
niceGreeting = "Hello! So very nice to see you,"


badGreeting :: String
badGreeting = "Oh! Pfft. It's you."

greet :: String -> String
greet "Juan" = niceGreeting ++ " Juan!"
greet "Fernando" = niceGreeting ++ " Fernando!"
greet name = badGreeting ++ " " ++ name

-- where中的模式匹配
bmiTell :: Double -> Double -> String
bmiTell weight, height
  | bmi <= skinny = "You're underweight, you emo, you!"
  | bmi <= normal = "You're supposedly normal. Pffft, I bet you're ugly!"
  | bmi <= fat = "You're fat ! Lose some weight, fatty!"
  | otherwise = "You're a whale, congratulations!"
  where bmi = weight / height ^ 2
        (skinny, normal, fat) = (18.5, 25.0, 30.0)

initials :: String -> String -> String
initials firstname lastname = [f] ++ "." ++ [l] ++ "."
  where (f:_) = firstname
        (l:_) = lastname


-- where块中函数
calcBmis :: [(Double, Double)] -> [Double]
calcBmis xs = [bmi w h | (w, h) <- xs]
  where bmi weight height = weight / height ^ 2


--let表达式
--let表达式与where绑定很相似。where允许我们在函数底部绑定变量，对包括所有哨卫在内的整个函数可见。
--let则是一个表达式，允许你在任何位置定义局部变量，且不能对其他哨卫可见

-- let表达式的格式为let <bindings> in <expressions>。
-- 在let中绑定的名字仅对于in部分可见
cylinder :: Double -> Double -> Double
cycle r h =
  let sideArea = 2 * pi * r * h
      topArea = pi * r * 2
  in sideArea + 2 * topArea

-- 几乎可以将let表达式放到代码的任何位置
4 * (let a = 9 in a + 1) + 2

-- let常见用法
-- 1. 局部作用域中定义函数
[let square x = x * x in (square 5, square 3, square 2)]

-- 2. 当需要在一行中绑定多个名字时，将这些名字排成一列显然是不行的，这时可以用分号将其分开
(let a = 100; b = 200; c = 300 in a * b * c, let foo = "Hey"; bar = "there!" in foo ++ bar)

-- 3. 当需要从一个元组中取值时，使用let表达式配合模式匹配将十分方便：
(let (a, b, c) = (1, 2, 3) in a+b+c) * 100


-- 列表推导式的每次迭代都会从源列表中的一项绑定到w和h，let表达式将w / h ^ 2的结果绑定为bmi。
-- 然后，我们将bmi作为列表推导式的输出部分。
calcBmis :: [(Double, Double)] -> [Double]
calcBmis xs = [bmi | (w, h) <- xs, let bmi = w / h * 2]

-- 其中列表推导式的 （w, h） <- xs部分被称为生成器（generator）。
-- 我们无法在生成器中引用bmi变量，因为它是在let绑定之前定义的
calcBmis :: [(Double, Double)] -> [Double]
calcBmis xs = [bmi | (w, h) <- xs, let bmi = w / h * 2, bmi > 25.0]

-- 直接在GHCi中定义函数和常量时，let的in部分也可以省略。如果省略，名字的定义将在整个会话过程中可见。





--case表达式
--函数定义中的模式匹配本质上不过就是case表达式的语法糖而已

head' :: [a] -> a
head' [] = error "No head for empty lists!"
head' (x:_) = x
-- 等价
head' :: [a] -> a
head' xs = case xs of [] -> error "No head for empty lists!"
                      (x:_) -> x


-- case expression of pattern -> result
--                    pattern -> result
--                    pattern -> result
--                    ...


--函数参数的模式匹配只能在定义函数时使用，而case表达式的模式匹配可以用在任何地方。
describeList :: [a] -> String
describeList ls = "The list is " ++ case ls of [] -> "empty."
                                               [x] -> "a singleton list."
                                               xs -> "a longer list."
-- 等价于
describeList :: [a] -> String
describeList ls = "The list is " ++ what ls
  where what [] = "empty."
        what [x] = "a singleton list."
        what xs = "a longer list."

