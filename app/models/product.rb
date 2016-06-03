class Product <ActiveRecord::Base
  has_many :reviews

  def slug
    self.name.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    self.all.find do |product|
      product.slug == slug
    end
  end

end
