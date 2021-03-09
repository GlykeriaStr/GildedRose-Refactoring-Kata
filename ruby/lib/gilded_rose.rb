require 'item'

class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
  end

  def name_case
    @items.each do |item|
      case item.name
      when "Aged Brie"
        aged_brie(item)
      when "Sulfuras, Hand of Ragnaros"
        sulfuras(item)
      when "Backstage passes to a TAFKAL80ETC concert"
        backstage_passes(item)
      when "Conjured Mana Cake"
        conjured(item)
      else
        regular(item)
      end
    end
  end

  def aged_brie(item)
  end

  def sulfuras(item)
    item
  end

  def backstage_passes(item)
  end

  def conjured(item)
  end

  def regular(item)
    raise 'This item can no longer be sold' if item.quality < 0
    raise 'This item has too much quality' if item.quality > 50

    if item.sell_in < 0
      item.sell_in -= 1
      item.quality -= 2
    else
      item.sell_in -= 1
      item.quality -= 1
    end
  end

end
