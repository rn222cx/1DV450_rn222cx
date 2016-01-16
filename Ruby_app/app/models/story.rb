class Story < ActiveRecord::Base
  belongs_to :user
  has_many :tags
  
  #attr_accessible :title, :description
  
  validates :title,
            :presence => {:message => "Du måste ange en titel"}
end
