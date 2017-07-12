class AccountTrackerPolicy < ApplicationPolicy
  def destroy?
    scope.where(id: record.id).exists?
  end

  class Scope < Scope
  end
end
