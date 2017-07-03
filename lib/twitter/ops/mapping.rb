module Ops
  class Mapping
    MAP = {
      'cmd.auth.signup'                     => Ops::Auth::CmdSignup,
      'cmd.auth.login'                      => Ops::Auth::CmdLogin,
      'cmd.auth.confirm_email'              => Ops::Auth::CmdConfirmEmail,
      'cmd.user.send_friendship_request'    => Ops::User::CmdSendFriendshipRequest,
      'cmd.user.accept_friendship_request'  => Ops::User::CmdAcceptFriendshipRequest,
      'cmd.user.decline_friendship_request' => Ops::User::CmdDeclineFriendshipRequest,
      'cmd.user.block_user'                 => Ops::User::CmdBlockFriendship,
      'qry.user.all_friends'                => Ops::User::QryAllFriends,
      'qry.user.all_friend_posts'           => Ops::User::QryAllFriendsPosts,
      'qry.user.by_email'                   => Ops::User::QryByEmail,
      'cmd.user.comment_post'               => Ops::User::CmdCommentPost,
      'cmd.user.create_post'                => Ops::User::CmdCreatePost,
      'cmd.user.remove_friend'              => Ops::User::CmdRemoveFriend,
      'qry.user.search_user'                => Ops::User::QrySearchUser,
      'qry.user.user_posts_query'           => Ops::User::QryUserPosts
    }.freeze
    def self.get(str)
      MAP.fetch(str)
    end
  end
end
