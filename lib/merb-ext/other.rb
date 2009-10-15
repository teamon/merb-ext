require 'iconv'
class String
  def to_permalink
    Iconv.iconv('ascii//translit//IGNORE', 'utf-8', self).first.gsub("'", "").gsub(/[^\x00-\x7F]+/, '').gsub(/[^a-zA-Z0-9-]+/, '-').gsub(/^-/, '').gsub(/-$/, '').downcase
  end
end

class Float
  def round_to(x)
    (self * 10**x).round.to_f / 10**x
  end

  def ceil_to(x)
    (self * 10**x).ceil.to_f / 10**x
  end

  def floor_to(x)
    (self * 10**x).floor.to_f / 10**x
  end
end