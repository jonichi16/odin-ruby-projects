def bubble_sort(array)
  
  k = 1
  i = 0
  while (i < array.length - 1) do
      
    sorted = array.each_with_index do |num, i|
      if i < array.length - k
        temp = 0
        if num > array[i + 1]
          temp = array[i + 1]
          array[i + 1] = num
          array[i] = temp
        end
      end
    end

    k += 1
    i +=1

  end
  
  sorted

end

p bubble_sort([4,3,78,2,0,2])
# [0, 2, 2, 3, 4, 78]