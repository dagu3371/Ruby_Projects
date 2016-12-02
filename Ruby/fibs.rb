def fibs(iterations)
	array = Array.new(iterations,1)
	array.each_index { |i| array[i]=array[i-1]+array[i-2] if i>1}	
	print array
end
fibs(10)