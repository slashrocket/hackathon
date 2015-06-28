# Entry model
class Entry < ActiveRecord::Base
  belongs_to :ownable, polymorphic: true

  validates_presence_of :name
  validates_presence_of :url
  validates_presence_of :about
end
