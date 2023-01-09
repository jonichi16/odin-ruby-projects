def merge_sort(arr)
  return arr if arr.length < 2

  left = merge_sort(arr[0..(arr.length - 1)/2])
  right = merge_sort(arr[arr.length/2..-1])

  sorted = []
  until left.length.zero? || right.length.zero?
    left[0] <= right[0] ? sorted << left.shift : sorted << right.shift
  end

  sorted + left + right
end

p merge_sort([2,4,1,5,3,6])