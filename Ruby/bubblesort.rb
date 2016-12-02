def bubblesort(array)
  loop do
    (array.length-1).times do |i|
      if array[i]>array[i+1]
        array[i], array[i+1] = array[i+1], array[i]
      end
    end
    break if array[0]<array[1]
  end
  return array
end

bubblesort([5,4,3,9,4,5,6,10])