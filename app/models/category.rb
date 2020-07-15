class Category < ApplicationRecord
    before_validation { self.title = self.title&.downcase }

    validates :title, presence: true, allow_blank: false

    def title_and_description
        self.title.humanize + " - " + self.description
    end
end
