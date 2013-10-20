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

  end
end
