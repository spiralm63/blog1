class Post < ActiveRecord::Base
  # Remember to create a migration!
      has_many :tags

      validates :body, :presence => true
      validates :title, :presence => true
end
