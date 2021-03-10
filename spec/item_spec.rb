require 'item'

describe Item do
  subject(:item) { described_class.new(name = 'Vest', sell_in = 10, quality = 20)}

  it 'creates an object' do
    expect(item).to be_a(Item)
  end

  it 'creates a string of the arguments' do
    expect(item.to_s).to eq('Vest, 10, 20')
  end
end
