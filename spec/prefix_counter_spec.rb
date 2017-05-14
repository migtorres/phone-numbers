
require 'spec_helper'
require_relative '../prefix_counter'

describe 'prefix_counter' do
  it 'should accept and count 3 regular numbers' do
    input = ['+351912345678', '00351961234567', '00994123456789']

    expect(PrefixCounter.results(input)).to eq({ '351' => 2, '994' => 1 })
  end

  it 'should just count numbers with 3 or between 7 and 12 digits' do
    input = ['+351', '003511234', '00351123456789', '+21', '+3523', '00353123', '+3541234567890']

    expect(PrefixCounter.results(input)).to eq({ '351' => 3 })
  end

  it 'does not count +00 as a valid number' do
    input = ['+351', '+00351911234567']

    expect(PrefixCounter.results(input)).to eq({ '351' => 1 })
  end

  it 'does not count numbers with letters' do
    input = ['+351', '00351ABCD34567']

    expect(PrefixCounter.results(input)).to eq({ '351' => 1 })
  end
end