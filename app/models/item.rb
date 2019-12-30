class Item < ApplicationRecord
    belongs_to :user
    def self.search(search, type, arr)
        if search
            key = "%#{search}%"
            if type == '1'               
                arr.where('title ILIKE :search OR description ILIKE :search', search: key)
            elsif type == '2'
                arr.where('category ILIKE :search', search: key)
            end
        else
            arr.order("created_at DESC") 
        end
    end
end
