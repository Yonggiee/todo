class Item < ApplicationRecord
    def self.search(search, type)
        if search
            key = "%#{search}%"
            if type == '1'               
                Item.where('title LIKE :search OR description LIKE :search', search: key)
            elsif type == '2'
                Item.where('category LIKE :search', search: key)
            end
        else
            all.order("created_at DESC") 
        end
    end
end
