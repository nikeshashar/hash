require 'rspec'
require 'hash'

describe 'monkey patching' do 

  specify 'symbolized keys should be' do
    h = symbolized_keys({ 'a' => { 'b' => 'Hello', 'c' => { 'd' => { 'e' => 'Nesting' }, 'f' => { 'g' => [1, 2, 3] }, 'h' => 'Very silly hash' }, 'i' => 15 } }
)
    expect(h).to eq({:a=>{:b=>"Hello", :c=>{:d=>{:e=>"Nesting"}, :f=>{:g=>[1, 2, 3]}, :h=>"Very silly hash"}, :i=>15}})
  end
end
