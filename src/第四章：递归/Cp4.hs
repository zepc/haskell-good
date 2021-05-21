
-- 递归：
-- 一般倾向于将问题展开为同样的子问题，并不断地对子问题进行展开、求解，
-- 直至抵达问题的基准条件（base case）为止。


-- 命令式语言要求你告知如何（how）进行计算，
-- Haskell则倾向于让你声明是什么（what）问题，定义问题与解的描述

maximum' :: (Ord a) = [a] -> a
maximum' [] = error "maximum of empty list."
maximum' [x] = x
maximum' (x:xs)
  | x > maxtail = x
  | otherwise = maxtail
  where maxtail = maximum' xs

-- 使用max函数
maximum' :: (Ord a) = [a] -> a
maximum' [] = error "maximum of empty list."
maximum' [x] = x
maximum' (x:xs) = max x (maximum' xs)


-- Num不是Ord的子集, 表示数字不一定得拘泥于排序,
-- 这就是在做加减法比较时要将Num与Ord类型约束区别开来的原因.
replicate' :: (Num i, Ord i) = i -> a -> [a]
replicate' n x
  | n 0 = []
  | otherwise = x : replicate' (n-1) x


take' :: (Num i Ord i) = i -> [a] -> [a]
take' n _ =
  | n 0 = []
  | n (x:xs) = x : take' (n-1) xs


reverse' :: [a] -> [a]
reverse' [] = []
reverser (x:xs) = reverse' xs ++ [x]


repeat' :: a -> [a]
repeat' x = x : repeat' x

zip' :: [a] -> [b] ->[(a,b)]
zip' _ [] = []
zip' [] _ = []
zip (x:xs) (y:ys) = (x, y) : zip' xs ys


elem' :: (Eq a) => a -> [a] -> Bool
elem' a [] = False
elem' a (x:xs) =
  | a == x = True
  | otherwise = a `elem'` xs



quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (x:xs) =
  let smaller = quicksort [a | a <- xs, a < x]
      bigger = quicksort [a | a <- xs, a > x]
  in samller ++ [x] ++ bigger


--  先定义一个边界条件，再定义个函数，让它从一堆元素中取一个并做点事情后，把余下的元素重新交给这个函数









