require 'spec_helper'
require_relative '../prefix_counter'

describe 'prefix_counter' do
  it 'should accept and count 3 regular numbers' do
    input = ['+351912345678', '003519612345678', '00994123456789']

    expect(PrefixCounter.results(input)).to eq({ '351' => 2, '994' => 1 })
  end
end