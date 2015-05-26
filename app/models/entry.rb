class Entry < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :name
  validates_presence_of :url
  validates_presence_of :about
end
