class Message < ApplicationRecord
    belongs_to :chef
    validates :content, presence: true
    validates :chef_id, presence: true

    def self.most_recent
        #orders the result set by created at and only fetches the last 20
        order(:created_at).last(20)
    end
end
