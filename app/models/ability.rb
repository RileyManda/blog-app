class Ability
  include CanCan::Ability

  def initialize(user)
    if user.role == 'admin'
      can :manage, :all
    else
      can :read, :all
      can :manage, Post, author_id: user.id
      can :manage, Comment, user_id: user.id
      can :create, Comment
      can :destroy, Comment do |comment|
        comment.user == user || comment.post.author == user
      end
    end
  end
end
