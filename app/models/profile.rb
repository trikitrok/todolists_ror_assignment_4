class Profile < ActiveRecord::Base
  belongs_to :user

  validate :first_name_or_last_name_presence

  validates :gender, inclusion: { in: ["male", "female"] }

  validate :boy_not_named_sue

  def first_name_or_last_name_presence
    if (first_name.nil? && last_name.nil?)
      errors.add(:first_name, "must be present") if first_name.nil?
      errors.add(:last_name, "must be present") if last_name.nil?
    end
  end

  def boy_not_named_sue
    errors.add(:first_name, "can't be Sue") if first_name == "Sue"
  end

  def self.get_all_profiles min_year, max_year
    self.where(
      "birth_year BETWEEN :min_year AND :max_year", 
      min_year: min_year, 
      max_year: max_year
    ).order(:birth_year)
  end
end
