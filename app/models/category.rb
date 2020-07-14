class Category < ApplicationRecord
    before_validation { self.title = self.title.downcase }

    def title_and_description
        self.title.humanize + " - " + self.description
    end
end
