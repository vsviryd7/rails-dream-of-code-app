class Topic < ApplicationRecord
  has_many :lesson_topics
  has_many :lessons, through: :lesson_topics
end
