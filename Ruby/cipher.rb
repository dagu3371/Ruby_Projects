def cipher(string, integer)
  alphabet = ("a".."z").to_a
  numbers = (1..26).to_a
  test = Hash[alphabet.zip(numbers)]
  test2 = Hash[numbers.zip(alphabet)]
  string.scan(/./).each do |i|
    variable=test[i]-integer
    if variable ==0
      variable = 26
    elsif variable<0
      variable = variable+26
    else 
      variable = variable.abs
    end
    puts test2[variable]
  end
end

cipher("hellodavid", 15)