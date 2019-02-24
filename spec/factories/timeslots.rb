# frozen_string_literal: true
# == Schema Information
#
# Table name: timeslots
#
#  id              :integer          not null, primary key
#  default_user_id :integer
#  time_range_id   :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  day             :integer
#
# Indexes
#
#  index_timeslots_on_default_user_id  (default_user_id)
#  index_timeslots_on_time_range_id    (time_range_id)
#
# Foreign Keys
#
#  fk_rails_...  (default_user_id => users.id)
#  fk_rails_...  (time_range_id => time_ranges.id)
#

FactoryBot.define do
  factory :timeslot do
    association :default_user, factory: :user
    day { Date::DAYNAMES[1] }
    time_range
    place
  end
end