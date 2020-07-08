def merge_sort(array)
  result = array
  unless array.size <= 1
    left,right = array.each_slice((array.size/2.0).round).to_a
    merge_sort(left)
    merge_sort(right)
    result = (left+right).sort
  end
  result
end

array_example = [4,8,3,7,2,6,1,9,5,10,5,25,130,92,1,100]
print merge_sort(array_example)