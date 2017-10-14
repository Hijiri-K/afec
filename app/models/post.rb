class Post < ApplicationRecord
  validates :content, {presence: true, length: {maximum: 140}}
  validates :currency_have, {presence: true}
  validates :currency_want, {presence: true}
  validates :currency_have_amount, {presence: true}
  validates :currency_want_amount, {presence: true}
  validates :lat, {presence: true}
  validates :lng, {presence: true}

  
  #geokit-rails test
  acts_as_mappable(:default_units => :kms,
                   :default_formula => :sphere,
                   :distance_field_name => :distance,
                   :lat_column_name => :lat,
                   :lng_column_name => :lng)
end
