class Song < ApplicationRecord
    validates :title, presence: true 
    validates :artist_name, presence: true
    validate :title_cannot_be_released_by_same_artist_in_same_year, :release_year_cannot_be_blank_if_released_is_true, :release_year_cannot_be_in_future

    

    private 
    
    def title_cannot_be_released_by_same_artist_in_same_year
        song = Song.all.find_by(:title => title)
        if song && song.release_year == release_year && song.artist_name == artist_name
            errors.add(:title, "artist can't release duplicate title in the same year")
        end
    end

    def release_year_cannot_be_blank_if_released_is_true
        if released == true && !release_year.present?
            errors.add(:release_year, "release year cannot be empty if released is true")
        end
    end

    def release_year_cannot_be_in_future 
        if release_year.present? && release_year > Date.today.year
            errors.add(:release_year, "release year cannot be in the future")
        end
    end
end
