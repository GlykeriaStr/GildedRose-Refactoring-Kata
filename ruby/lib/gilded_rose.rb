require 'item'

class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    name_case
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
    quality_check(item)
    increase_quality_by = item.sell_in < 0 ? 2 : 1
    item.sell_in -= 1
    item.quality += increase_quality_by
  end

  def sulfuras(item)
    item
  end

  def backstage_passes(item)
    quality_check(item)
    item.sell_in -= 1
    item.quality += 1
  end

  def conjured(item)
    quality_check(item)
    item.sell_in -= 1
    item.quality -= 2
  end

  def regular(item)
    quality_check(item)
    decrease_quality_by = item.sell_in < 0 ? 2 : 1
    item.sell_in -= 1
    item.quality -= decrease_quality_by
  end

  def quality_check(item)
    raise 'This item can no longer be sold' if item.quality < 0
    raise 'This item has too much quality' if item.quality > 50
  end
end
