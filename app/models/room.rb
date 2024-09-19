class Room < ApplicationRecord
    belongs_to :user
    has_many :reservations, dependent: :destroy
    has_one_attached :image
    validates :room_name, presence: true
    validates :room_introduction, presence: true
    validates :room_price, presence: true, numericality: { greater_than_or_equal_to: 1 }
    validates :room_address, presence: true
end
