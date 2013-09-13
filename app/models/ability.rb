class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    # check if you've got a registered user
    if user.id != nil
      can [:new, :create], Group
      can [:new, :create], Event
      can [:edit, :update, :destroy], Group do |group|
        # check if the user leads the group
        user.led_group_ids.include?(group.id)
      end
      can [:edit, :update, :destroy], Event do |event|
        # check if the user leads the group which the event is for
        user.led_group_ids.include?(event.group_id)
      end
      can :manage, User, :id => user.id
    end
      # check guests can see groups and events
      can :show, Group
      can :show, Event
      can :show, User

  end
end
