class Topic < ActiveRecord::Base
  validates :content, presence: true
  #validates :image, presence: true
  belongs_to :user
  has_many :comments, dependent: :destroy
  mount_uploader :image, ImageUploader
end
