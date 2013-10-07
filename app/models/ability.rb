class Ability
  include CanCan::Ability

  def initialize(user)
    user || User.new

        can :read, Folder do |folder|
            folder.try(:user ) == user
        end

        can :create, Folder

        can :ajax_load_events, Folder

        can :update, Folder do |folder|
            folder.try(:user) == user
        end

        can :destroy, Folder do |folder|
            folder.try(:user) === user
        end

        can :read, Submission do |submission|
            submission.try(:user) == user
        end

        can :create, Submission

        can :parent, Submission

        can :update, Submission do |submission|
            submission.try(:user) == user
        end

        can :new_submission, Submission do |submission|
            submission.try(:user) == user
        end
    
        can :create_submission_view, Submission
    
        can :highlight_node, Submission  
 
        can :destroy, Submission do |submission|
            submission.try(:user) == user
        end

        can :read, User do |user|
            user.try(:user) == user
        end


    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
