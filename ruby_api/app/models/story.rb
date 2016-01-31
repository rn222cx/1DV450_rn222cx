class Story < ActiveRecord::Base
  belongs_to :user

  has_many :taggings
  has_many :tags, through: :taggings

  # render all the tags separated by commas.
  def all_tags=(names)
    self.tags = names.split(",").map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end

  def all_tags
    self.tags.map(&:name).join(", ")
  end

  def self.tagged_with(name)
    Tag.find_by_name!(name).posts
  end

  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  
  validates :title,
            :presence => {:message => "You have to give a title"},
             length: { maximum: 50 }
            
  validates :description,
            :presence => {:message => "You have to give a description"},
             length: { maximum: 200 }
end
