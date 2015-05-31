
def shuffle_lines
  p "enter file name"
  file_name = gets.chomp
  contents = File.readlines(file_name)
  contents.shuffle!
  File.open("#{file_name[0..-5]}--shuffle.txt","w") do |f|
    contents.each do |line|
      f.puts line
    end
  end
end

shuffle_lines
