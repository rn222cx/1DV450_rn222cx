class Story < ActiveRecord::Base
  belongs_to :user

  has_many :story_tags, dependent: :destroy
  has_many :tags, through: :story_tags, dependent: :destroy


  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  
  validates :title,
            :presence => {:message => "You have to give a title"},
             length: { maximum: 50 }
            
  validates :description,
            :presence => {:message => "You have to give a description"},
             length: { maximum: 200 }

  # search for stories by title or description if present
  def self.search(params)
    arel = order('created_at DESC') # note: default is all, just sorted
    arel = where('title LIKE ? OR description LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%") if params[:search].present?
    arel
  end


  # Insert each tag in db separated with comma.
  def all_tags=(names)
    self.tags = names.split(",").map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end
  # Render all the tags separated by commas.
  def all_tags
    self.tags.map(&:name).join(", ")
  end

  def self.tagged_with(name)
    Tag.find_by_name!(name).posts
  end
end
