def fibs(num)
  array = []
  num.times do |i|
    if i < 2
      array.push(i)
    else
      array.push(array[i - 1] + array[i - 2])
    end
  end
  array
end

def fibs_rec(num)
  return [0] if num.zero?
  return [0, 1] if num == 1

  arr = fibs_rec(num - 1)
  arr.push(arr[-2] + arr[-1])
end

p fibs(8)
p fibs_rec(8)
