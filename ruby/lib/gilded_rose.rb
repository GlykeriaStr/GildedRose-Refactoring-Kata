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
        aged_brie
      when "Sulfuras, Hand of Ragnaros"
        sulfuras
      when "Backstage passes to a TAFKAL80ETC concert"
        backstage_passes
      when "Conjured Mana Cake"
        conjured
      else
        regular
      end
    end
  end

  def aged_brie
  end

  def sulfuras
  end

  def backstage_passes
  end

  def conjured
  end

  def regular
  end
end
