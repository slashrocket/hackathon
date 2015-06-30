class TeamMember < ActiveRecord::Base
  belongs_to :user
  belongs_to :team
  before_save :accept_owner

  def accept_owner
    if TeamMember.where(team_id: self.team_id).count < 1
      self.accepted = true
    end
  end

  def accept!
    self.accepted = true
    self.save!
  end
end
