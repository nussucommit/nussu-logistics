# frozen_string_literal: true

# == Schema Information
#
# Table name: places
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# rubocop:enable Metrics/LineLength

FactoryBot.define do
  factory :place do
    name 'MyString'
  end
end
