class WikiPolicy < ApplicationPolicy
  def show?
    record.public? || user.present?
  end

  def make_private?
    user_role?('premium', 'admin')
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
     @user = user
     @scope = scope
    end

    def resolve
      wikis = []
      if user.admin?
        wikis = scope.all
      elsif user.premium?
        all = scope.all
        all.each do |wiki|
          if wiki.public? # add || check if user is collaborator
            wikis << wiki
          end
        end
      else
        wikis = Wiki.where(public: true)
      end
      wikis
    end
  end
end