# frozen_string_literal: true

def masking(num)
  num_string = num.to_s

  return num_string if num_string.length < 5

  ('#' * (num_string.length - 4)) + num_string[-4..]
end
