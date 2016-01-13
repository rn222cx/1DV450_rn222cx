class Tag < ActiveRecord::Base
  belongs_to :tag_type
  belongs_to :story
end