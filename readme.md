Monkey Patch the Hash class to add the following methods -

A "#symbolize_keys" method that transforms all keys in any arbitrarily complex nested hash from strings to symbols
An "#extract_nested_keys" method for extracting all keys from an arbitrarily complex nested hash
A "#fetch_nested(arg)" method for finding the value of a key from an arbitrarily complex nested hash

The arbitrarily complex nested hash:
```
{ 'a' => { 'b' => 'Hello', 'c' => { 'd' => { 'e' => 'Nesting' }, 'f' => { 'g' => [1, 2, 3] }, 'h' => 'Very silly hash' }, 'i' => 15 } }
```
The result of #symbolize_keys should be this: 
```
{:a=>{:b=>"Hello", :c=>{:d=>{:e=>"Nesting"}, :f=>{:g=>[1, 2, 3]}, :h=>"Very silly hash"}, :i=>15}}
```
The result of #extract_nested_keys should be this: 
```
["a", "b", "c", "d", "e", "f", "g", "h", "i"]
```

The result of passing in any key that exists in the hash to the #fetch_nested method should return that value, 
i.e. passing it 'e' will return 'Nesting', pass it a key that doesn't exist in any depth of the nested hash returns nil.


Answer 1: 

```
def symbolize_keys(hash)
  hash.inject({}){|result, (key, value)|
    new_key = case key
              when String then key.to_sym
              else key
              end
    new_value = case value
                when Hash then symbolize_keys(value)
                else value
                end
    result[new_key] = new_value
    result
  }
end
```
Answer 2:

```
class Hash
  def find_all_values_for(key)
    result = []
    result << self[key]
    self.values.each do |hash_value|
      values = [hash_value] unless hash_value.is_a? Array
      values.each do |value|
        result += value.find_all_values_for(key) if value.is_a? Hash
      end
    end
    result.compact
  end
end
```

To do: 

 + Finish testing with RSpec
 + Research and understand how to pass keys into nested hashes to extract the corresponding values
 + Fully test the results
 