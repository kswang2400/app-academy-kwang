
def remix(drinks_array)
  output = []
  alcohol =[]
  mixer = []

  drinks_array.each do |sub_array|
    alcohol << sub_array[0]
    mixer << sub_array[1]
  end

  p alcohol
  p mixer

  count = drinks_array.count
  mutating_count = count
  (1..count).each do |n|
    removed_alcohol = alcohol.delete_at(rand(mutating_count))
    removed_mixer = mixer.delete_at(rand(mutating_count))
    output << [removed_alcohol, removed_mixer]
    mutating_count -= 1
  end

  output
end

p remix([
  ["rum", "coke"],
  ["gin", "tonic"],
  ["scotch", "soda"]
])
