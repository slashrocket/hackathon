module TeamsHelper
  def user_status(user, team)
    out = ''
    return out.html_safe unless current_user == team.owner
    if team.owner == user
      out << "<span class=\"team_status team_owner\">OWNER<span>"
    elsif user.team_member.accepted
      out << "<span class=\"team_status team_approved\">APPROVED<span>"
    else
      out << "<span class=\"team_status team_pending\">PENDING APPROVAL <span>"
      out << link_to('<i class="glyphicon glyphicon-ok"></i> Approve!'.html_safe, approve_member_url(team, user), class: 'btn btn-success btn-sm')
    end
    out.html_safe
  end

  def join_button(team)
    out = ''
    unless team.users.include?(current_user) || !current_user
      out << "<span class=\"pull-right\">"
      out << link_to('<i class="glyphicon glyphicon-ok"></i> Join Team!'.html_safe, join_team_url(team), class: 'btn btn-success btn-sm ')
      out << "</span>"
    end
    out.html_safe
  end

  def edit_button(team)
    if current_user == team.owner || current_user && current_user.role == 'admin'
      link_to "Edit Team", edit_team_path(@team), class: 'btn btn-lg btn-primary'
    end
  end
end
