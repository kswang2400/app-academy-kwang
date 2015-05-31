
def super_print(string, options = {})

  default = { :times => 1, :upcase => false, :reverse => false }
  new_options = default.merge(options)

  new_string = new_options[:reverse] ? string.reverse : string
  if new_options[:upcase]
    new_string.upcase!
  end


  p output = "#{new_string*new_options[:times]}"

end

super_print("Hello")                                    #=> "Hello"
super_print("Hello", :times => 3)                       #=> "Hello" 3x
super_print("Hello", :upcase => true)                   #=> "HELLO"
super_print("Hello", :upcase => true, :reverse => true) #=> "OLLEH"

options = {}
super_print("hello", options)
# options shouldn't change.
