class Folder < ActiveRecord::Base
  attr_accessible :title, :user_id, :parent_id

  belongs_to :user
  belongs_to :parent, :class_name => 'Folder'
  has_many :children, :class_name => 'Folder', :foreign_key => 'parent_id'
  has_many :submissions, :order => ('updated_at DESC')

  def self.search(search)
  	where("title like ?", "%#{search}%")
  end

end
