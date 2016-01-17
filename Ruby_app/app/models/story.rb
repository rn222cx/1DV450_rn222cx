class Story < ActiveRecord::Base
  belongs_to :user
  has_many :tags
  
  #attr_accessible :title, :description
  
  validates :title,
            :presence => {:message => "Du måste ange en titel"}
            
  validates :description,
            :presence => {:message => "Du måste ange description"}
end
