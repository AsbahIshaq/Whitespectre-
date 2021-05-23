class User < ApplicationRecord
  has_many :group_events, foreign_key: :created_by_id
end
