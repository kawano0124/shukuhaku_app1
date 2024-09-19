class Reservation < ApplicationRecord
  belongs_to :room
  belongs_to :user

  validates :check_in_date, :check_out_date, presence: true
  validates :number_of_people, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validate  :check_in_date_cannot_be_in_the_past
  validate  :check_out_after_check_in

  def check_in_date_cannot_be_in_the_past
    return if check_in_date.blank?

    if check_in_date < Date.today
      errors.add(:check_in_date, "は本日以降の日付を選んでください")
    end
  end

  def check_out_after_check_in
    return if check_in_date.blank? || check_out_date.blank?

    if check_out_date <= check_in_date
      errors.add(:check_out_date, "はチェックイン日より後の日付を選んでください")
    end
  end

  def total_price
    return 0 unless valid_for_pricing?

    room.room_price * stay_duration * number_of_people
  end

  def stay_duration
    return 0 if check_in_date.nil? || check_out_date.nil?

    (check_out_date - check_in_date).to_i
  end

  def valid_for_pricing?
    room.present? && room.room_price.present? && stay_duration > 0 && number_of_people.present?
  end
end
