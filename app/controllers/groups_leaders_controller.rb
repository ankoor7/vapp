class GroupsLeadersController < ApplicationController

  def invite
    @group = Group.find(params[:id])
    @invitee = User.find(params[:invitee_id])

    redirect_to edit_group_path
  end

  def uninvite
    @group = Group.find(params[:id])
    @invitee = User.find(params[:invitee_id])

    redirect_to edit_group_path
  end

end
