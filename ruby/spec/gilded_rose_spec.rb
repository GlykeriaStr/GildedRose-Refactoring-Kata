require './lib/gilded_rose'
require './lib/item'
require 'rspec'

describe GildedRose do
  # let(:regular) { double(Item, name: 'bread', sell_in: 10, quality: 20)}

  # describe "#update_quality" do
  #   it "does not change the name" do
  #     items = [Item.new("foo", 0, 0)]
  #     GildedRose.new(items).update_quality()
  #     expect(items[0].name).to eq "foo"
  #   end
  # end

  describe '#regular' do
    it 'raises an error if the quality is less than  0' do
      vest = Item.new(name="Vest", sell_in=10, quality=-2)
      shop = GildedRose.new(vest)
      expect{ shop.regular(vest) }.to raise_error('This item can no longer be sold')
    end
  end

end
