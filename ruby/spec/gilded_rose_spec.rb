require './lib/gilded_rose'
require './lib/item'
require 'rspec'

describe GildedRose do
  let(:regular) { double(Item, name: 'bread', sell_in: 10, quality: 20)}

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end
  end

  describe '#regular' do
    it 'decreases in days and quality every day by 1' do
      vest = Item.new(name="Vest", sell_in=10, quality=2)
      shop = GildedRose.new(vest)
      shop.regular(vest)
      expect(vest.sell_in).to eq(9)
      expect(vest.quality).to eq(1)
    end

    it 'decreases quality twice as fast when sell by date has passed' do
      vest = Item.new(name="Vest", sell_in=-1, quality=10)
      shop = GildedRose.new(vest)
      shop.regular(vest)
      expect(vest.sell_in).to eq(-2)
      expect(vest.quality).to eq(8)
    end
  end

  describe '#quality_check' do
    it 'raises an error if the quality is more than 50' do
      vest = Item.new(name="Vest", sell_in=10, quality=60)
      shop = GildedRose.new(vest)
      expect{ shop.quality_check(vest) }.to raise_error('This item has too much quality')
    end

    it 'raises an error if the quality is less than  0' do
      vest = Item.new(name="Vest", sell_in=10, quality=-2)
      shop = GildedRose.new(vest)
      expect{ shop.quality_check(vest) }.to raise_error('This item can no longer be sold')
    end
  end

  describe '#conjured' do
    it 'decreases in quality twice as fast as regular items' do
      cake = Item.new(name="Conjured Mana Cake", sell_in=3, quality=6)
      shop = GildedRose.new(cake)
      shop.conjured(cake)
      expect(cake.quality).to eq(4)
    end
  end

  describe '#aged_brie' do
    before(:each) do
      @brie = Item.new(name="Aged Brie", sell_in=0, quality=0)
      @shop = GildedRose.new(@brie)
      @shop.aged_brie(@brie)
    end

    it 'increases in quality the older it gets' do
      expect(@brie.quality).to eq(1)
    end

    it 'increases by 2 when sell by date has passed' do
      @shop.aged_brie(@brie)
      expect(@brie.quality).to eq(3)
    end
  end

  describe '#backstage_passes' do
    it 'increases in quality when sell by date is approaching' do
      ticket = Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=15, quality=20)
      shop = GildedRose.new(ticket)
      shop.backstage_passes(ticket)
      expect(ticket.quality).to eq(21)
    end

    it 'increases in quality by 2 when there are 10 days or less' do
      ticket = Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=10, quality=20)
      shop = GildedRose.new(ticket)
      shop.backstage_passes(ticket)
      expect(ticket.quality).to eq(22)
    end
  end
end
