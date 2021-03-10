# frozen_string_literal: true

require './lib/gilded_rose'
require './lib/item'
require 'rspec'

describe GildedRose do
  describe '#update_quality' do
    before(:each) do
      @items = [
        Item.new(name = 'Vest', sell_in = 10, quality = 20),
        Item.new(name = 'Aged Brie', sell_in = 2, quality = 0),
        Item.new(name = 'Sulfuras, Hand of Ragnaros', sell_in = 0, quality = 80),
        Item.new(name = 'Sulfuras, Hand of Ragnaros', sell_in = -1, quality = 80),
        Item.new(name = 'Backstage passes to a TAFKAL80ETC concert', sell_in = 15, quality = 20),
        Item.new(name = 'Backstage passes to a TAFKAL80ETC concert', sell_in = 10, quality = 45),
        Item.new(name = 'Backstage passes to a TAFKAL80ETC concert', sell_in = 5, quality = 49),
        Item.new(name = 'Conjured Mana Cake', sell_in = 3, quality = 6)
      ]
      @shop = GildedRose.new(@items)
      @shop.update_quality
    end

    it 'does not change the name' do
      expect(@items[0].name).to eq('Vest')
    end

    it 'decreases the days and quality of a regular item every day by 1' do
      expect(@items[0].sell_in).to eq(9)
      expect(@items[0].quality).to eq(19)
    end

    it 'aged brie increases in quality the older it gets' do
      expect(@items[1].quality).to eq(1)
    end

    it 'returns sulfuras as they were' do
      expect(@items[2].sell_in).to eq(0)
      expect(@items[2].quality).to eq(80)
      expect(@items[3].sell_in).to eq(-1)
      expect(@items[3].quality).to eq(80)
    end

    it 'increases the quality of backstage_passes when sell by date is approaching' do
      expect(@items[4].sell_in).to eq(14)
      expect(@items[4].quality).to eq(21)
    end

    it 'increase the quality of backstage_passes by 2 when there are 10 days or less' do
      expect(@items[5].sell_in).to eq(9)
      expect(@items[5].quality).to eq(47)
    end

    it 'increase the quality of backstage_passes by 3 when there are 10 days or less' do
      expect(@items[6].sell_in).to eq(4)
      expect { @shop.update_quality }.to raise_error('This item has too much quality')
    end

    it 'decreases the quality of a conjured item twice as fast as regular items' do
      expect(@items[7].sell_in).to eq(2)
      expect(@items[7].quality).to eq(4)
    end
  end

  describe '#regular' do
    it 'decreases quality twice as fast when sell by date has passed' do
      vest = Item.new(name = 'Vest', sell_in = -1, quality = 10)
      shop = GildedRose.new(vest)
      shop.regular(vest)
      expect(vest.sell_in).to eq(-2)
      expect(vest.quality).to eq(8)
    end
  end

  describe '#aged_brie' do
    it 'increases by 2 when sell by date has passed' do
      @brie = Item.new(name = 'Aged Brie', sell_in = -1, quality = 0)
      @shop = GildedRose.new(@brie)
      @shop.aged_brie(@brie)
      expect(@brie.quality).to eq(2)
    end
  end

  describe '#backstage_passes' do
    it 'drop quality to 0 after the concert' do
      ticket = Item.new(name = 'Backstage passes to a TAFKAL80ETC concert', sell_in = -1, quality = 20)
      shop = GildedRose.new(ticket)
      shop.backstage_passes(ticket)
      expect(ticket.quality).to eq(0)
    end
  end

  describe '#quality_check' do
    it 'raises an error if the quality is more than 50' do
      vest = Item.new(name = 'Vest', sell_in = 10, quality = 60)
      shop = GildedRose.new(vest)
      expect { shop.quality_check(vest) }.to raise_error('This item has too much quality')
    end

    it 'raises an error if the quality is less than  0' do
      vest = Item.new(name = 'Vest', sell_in = 10, quality = -2)
      shop = GildedRose.new(vest)
      expect { shop.quality_check(vest) }.to raise_error('This item can no longer be sold')
    end
  end
end
