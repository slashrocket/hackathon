# Entry model
class Entry < ActiveRecord::Base
  belongs_to :team

  validates_presence_of :name
  validates_presence_of :url
  validates_presence_of :about
end
