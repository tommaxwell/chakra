class Submission < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :folder
  belongs_to :parent, :class_name => 'Submission'
  has_many :children, :class_name => 'Submission', :foreign_key => 'parent_id', :order => ('updated_at DESC')
  
  attr_accessible :content, :title, :user_id, :folder_id, :parent_id, :children
  
  def self.search(search)
      if search
          where('name LIKE ?', "%#{search}%")
      else
          scoped
      end
  end
  
  def attributes_with_children
      attributes.merge(children: children.map(&:attributes_with_children))
  end

end