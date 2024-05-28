# frozen_string_literal: true

# Player class and its validations
class Player < ApplicationRecord
  validates_uniqueness_of :username, case_sensitive: false, message: 'has already been taken.'
  validates :username, :name, presence: true
end
