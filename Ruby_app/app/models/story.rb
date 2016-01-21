class Story < ActiveRecord::Base
  belongs_to :user
  has_many :tags
  
  #attr_accessible :title, :description
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  
  validates :title,
            :presence => {:message => "You have to give a title"},
             length: { maximum: 50 }
            
  validates :description,
            :presence => {:message => "You have to give a description"},
             length: { maximum: 200 }
end
