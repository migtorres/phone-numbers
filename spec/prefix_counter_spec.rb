
require 'spec_helper'
require_relative '../prefix_counter'

describe 'prefix_counter' do
  prefix_list = %w(351 994 21 352 353 354)
  it 'should accept and count 3 regular numbers' do
    input = ['+351912345678', '00351961234567', '00994123456789']

    expect(PrefixCounter.results(input, prefix_list)).to eq({ '351' => 2,
                                                              '994' => 1 })
  end

  it 'should just count numbers with 3 or between 7 and 12 digits' do
    input = ['+351', '003511234', '00351123456789',
             '+21', '+3523', '00353123', '+3541234567890']

    expect(PrefixCounter.results(input, prefix_list)).to eq('351' => 3)
  end

  it 'does not count +00 as a valid number' do
    input = ['+351', '+00351911234567']

    expect(PrefixCounter.results(input, prefix_list)).to eq('351' => 1)
  end

  it 'does not count numbers with letters or special characters' do
    input = ['+351', '00351ABCD34567', '00351$%+#34567']

    expect(PrefixCounter.results(input, prefix_list)).to eq('351' => 1)
  end

  it 'does not count spaces between + and other numbers' do
    input = ['+351', '+ 351123456']

    expect(PrefixCounter.results(input, prefix_list)).to eq('351' => 1)
  end

  it 'accepts spaces between numbers' do
    input = ['+351', '+351 123456789']

    expect(PrefixCounter.results(input, prefix_list)).to eq('351' => 2)
  end

  it 'accepts numbers without + or 00 sign' do
    input = ['+351', '351123456789']

    expect(PrefixCounter.results(input, prefix_list)).to eq('351' => 2)
  end

  it 'only accepts numbers within prefix list' do
    input = ['+351', '359123456']

    expect(PrefixCounter.results(input, prefix_list)).to eq('351' => 1)
  end
end
