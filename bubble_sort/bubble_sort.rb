def bubble_sort(array)
  array.size.times do
    array.each_index do |index|
      unless array[index] == array.last
        if array[index] > array[index + 1] then
          aux = array[index]
          array[index] = array[index + 1] 
          array[index + 1] = aux
        end
      end
    end
  end
  return array
end

p bubble_sort([4,3,78,2,0,2,5,6,8,9,7,45,30,1])

=begin  Otras 2 maneras de hacer bubble sort, una usando for hasta array.size-2 
y otra usando una condicion, que fue la forma mas popular en the odin project

def bubble_sort(array)
  array.size.times do
    for i in (0..(array.size-2))
      if array[i] > array[i+ 1] then
        aux = array[i]
        array[i] = array[i + 1] 
        array[i + 1] = aux
      end
    end
  end
  return array
end

def bubble_sort(array)
  swapped = true
  until swapped == false do
    array.size.times do
      swapped = false
      for i in (0..(array.size-2))
        if array[i] > array[i+ 1] then
          aux = array[i]
          array[i] = array[i + 1] 
          array[i + 1] = aux
          swapped = true
        end
      end
    end
  end
  return array
end

=end