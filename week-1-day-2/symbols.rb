
def super_print(string, options = {})

  defaults = { :times => 1, :upcase => false, :reverse => false }
  options = defaults.merge(options)

  string = string * options[:times]

  if options[:upcase]
    string.upcase!
  end

  if options[:reverse]
    string.reverse!
  end

  p string
  string
end

super_print("Hello")                                    #=> "Hello"
super_print("Hello", :times => 3)                       #=> "Hello" 3x
super_print("Hello", :upcase => true)                   #=> "HELLO"
super_print("Hello", :upcase => true, :reverse => true) #=> "OLLEH"

options = {}
super_print("hello", options)
# options shouldn't change.
