# frozen_string_literal: true

# == Schema Information
#
# Table name: announcements
#
#  id         :integer          not null, primary key
#  subject    :text             not null
#  details    :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Announcement < ApplicationRecord
end