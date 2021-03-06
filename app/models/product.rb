class Product < ActiveRecord::Base
  belongs_to :category
  has_many :order_items
  has_many :orders, through: :order_items
  belongs_to :store
  # before_validation :set_default_image
  validates :name, :description, :price, :category_id, presence: true
  validates :price, numericality: { greater_than: 0 }
  mount_uploader :image_url, ProductPictureUploader
  enum status: %w(active inactive)

  scope :active, -> { where(status: 0) }
  scope :inactive, -> { where(status: 1) }
end
