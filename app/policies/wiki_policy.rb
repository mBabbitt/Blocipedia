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
       if user.role == 'admin'
         wikis = scope.all # if the user is an admin, show them all the wikis
       elsif user.role == 'premium'
         all_wikis = scope.all
         all_wikis.each do |wiki|
           if wiki.public? || wiki.user == user || wiki.users.include?(user)
             wikis << wiki # if the user is premium, only show them public wikis, or that private wikis they created, or private wikis they are a collaborator on
           end
         end
       else 
         all_wikis = scope.all
         wikis = []
         all_wikis.each do |wiki|
           if wiki.public? || wiki.users.include?(user)
             wikis << wiki # only show standard users public wikis and private wikis they are a collaborator on
           end
         end
       end
       wikis # return the wikis array we've built up
     end
   end
 end