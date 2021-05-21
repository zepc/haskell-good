-- :t命令处理一个表达式的输出结果为表达式后跟::及其类型，::读作“它的类型为”
:t True  -- True :: Bool  
-- 编写函数时，给它一个明确的类型声明是个好习惯，比较短的函数就不用多此一举了
removeNonUppercase :: [Char] -> [Char]
-- [Char] 等价于 String
removeNonUppercase :: String -> String

-- 参数之间由->分隔，而与返回值之间并无特殊差异。返回值是最后一项，参数就是前三项
addThree :: Int -> Int -> Int -> Int

-- Integral，可以存放非常的大的整数，相率不如int


-- 类型类
-- ：=>符号。它左边的部分叫做类型约束。我们可以这样阅读这段类型声明：
-- “相等函数取两个相同类型的值作为参数并返回一个布尔值，
-- 而这两个参数的类型同在Eq类之中（即类型约束）”
:t (==)   
(==) :: (Eq a) => a -> a -> Bool
-- Eq这一类型类提供了判断相等性的接口，凡是可比较相等性的类型必属于Eq类。
-- Ord包含可比较大小的类型
"Abra" `compare` "Zebra" -- "LT"
5 >= 2 -- "True"

-- 类型转换
-- Show的成员为可用字符串表示的类型
show 3 -- "3"
show 5.334
show True -- "True"

-- Read是与Show相反的类型类。read函数可以将一个字符串转为Read的某成员类型。
read "True" || False -- True
read "8.2" + 3.8

read "5" :: Int
read "5" :: Float
(read "5" :: Float) * 4
read "[1,2,3,4]" :: [Int]
read "(3, 'a')" :: (Int, Char)

-- Enum的成员都是连续的类型，也就是可枚举。
-- Enum类存在的主要好处就在于我们可以在Range中用到它的成员类型：每个值都有后继子(successer)和前置子(predecesor)，
--  分别可以通过succ函数和pred函数得到


--Bounded的成员都有一个上限和下限。
minBound :: Int
maxBound :: Char
maxBound :: Bool
minBound :: Bool
--如果其中的项都属于Bounded类型类，那么该Tuple也属于Bounded
maxBound :: (Bool, Int, Char)

--Num是表示数字的类型类，它的成员类型都具有数字的特征。
--看样子所有的数字都是多态常量，它可以作为所有Num类型类中的成员类型

--Integral 整数类型，包括Int和Integer
--Floating 浮点类型：包括Float和Double

--fromIntegral 将 Integer 转换为 Num