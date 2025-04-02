class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new(role: :patient) 

    if user.admin?
      can :manage, :all  
    elsif user.doctor?
      can :read, Department  
    elsif user.patient?
      can :read, Department  
    else
      cannot :read, Department  
    end
  end
end
