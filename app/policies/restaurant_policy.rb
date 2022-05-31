class RestaurantPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def new?
    true
  end

  def create?
    true
  end

  def show?
    true
  end

  def edit?
    owner_or_admin?
  end

  def update?
    # Hyphotetical Scenario
    # user.role == "admin" || (user.role == "business_employee")


    #############################
    ##### REAL DEAL #############
    #############################
    owner_or_admin?
  end

  def destroy?
    owner_or_admin?
  end

  def owner_or_admin?
    # @restaurant.user == current_user
    # user which is the current_user from devise
    # record which is the instance that we send in the authorize method in the controller
    record.user == user || user.admin
  end
end
