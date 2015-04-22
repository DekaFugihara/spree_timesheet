class AbilityDecorator
  include CanCan::Ability
  
  def initialize(user)
    if user.respond_to?(:has_spree_role?) && user.has_spree_role?('employee')
      can [:admin, :create, :index], Spree::Effort
      can [:admin, :update], Spree::Effort, :user_id => user.id
      can [:admin, :create, :index], Spree::TimeSheet
      can [:admin, :update], Spree::TimeSheet, :user_id => user.id
    end
  end
  
end

Spree::Ability.register_ability(AbilityDecorator)
