
def bubble_sort(arr)
  (1..arr.length).each do
    (0...arr.length - 1).each do |i|
      if arr[i] > arr[i + 1]
        p "i = #{i}"
        p "arr[i] = #{arr[i]}, arr[i+1} = #{arr[i+1]}"
        temp = arr[i]
        arr[i] = arr[i + 1]
        arr[i + 1] = temp
        p arr
      end
    end
  end

  arr
end

p bubble_sort([1, 3, 2, 4, 6, 7, 1, 10, 30, 20, 24, 32, 22])
