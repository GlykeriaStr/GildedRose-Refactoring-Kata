# frozen_string_literal: true

class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    name_case
  end

  def name_case
    @items.each do |item|
      case item.name
      when 'Aged Brie'
        aged_brie(item)
      when 'Sulfuras, Hand of Ragnaros'
        sulfuras(item)
      when 'Backstage passes to a TAFKAL80ETC concert'
        backstage_passes(item)
      when 'Conjured Mana Cake'
        conjured(item)
      else
        regular(item)
      end
    end
  end

  def aged_brie(item)
    quality_check(item)
    increase_quality_by = sell_by_date_passed?(item) ? 2 : 1
    item.sell_in -= 1
    item.quality += increase_quality_by
  end

  def sulfuras(item)
    item
  end

  def backstage_passes(item)
    quality_check(item)

    return item.quality = 0 if sell_by_date_passed?(item)

    concert_days(item)
  end

  def conjured(item)
    quality_check(item)
    item.sell_in -= 1
    item.quality -= 2
  end

  def regular(item)
    quality_check(item)
    decrease_quality_by = sell_by_date_passed?(item) ? 2 : 1
    item.sell_in -= 1
    item.quality -= decrease_quality_by
  end

  def quality_check(item)
    raise 'This item can no longer be sold' if item.quality.negative?
    raise 'This item has too much quality' if item.quality > 50
  end

  def concert_days(item)
    item.quality += if item.sell_in <= 5
                      3
                    elsif item.sell_in <= 10
                      2
                    else
                      1
                    end
    item.sell_in -= 1
  end

  def sell_by_date_passed?(item)
    item.sell_in.negative?
  end
end
