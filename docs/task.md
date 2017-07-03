Twitter Coding test:

The task will be evaluated on the structure, the extendability, testability etc..
Meaning that adding more features is not necessarily better than ensuring the overall quality and readability of the code.

Task
  Build an app, where a user can log in and perhaps edit his account (username, real name etc.)

The following features needs to be available to the user:
  - Add friend (from other users)
  - Remove friend (from friend list)
  - Post a message
  - Show all messages from friends
  - Ability to lookup another user and see his posts

You might add the following as well:
  - A user can block another user, so that other user can’t see his posts or add him as friend
  - Users can comment on posts



Usecases:

Command:
  SignupUser
  LoginUser
  AddFriendToUser
  RemoveFriendFromUser
  PostMessage
  CommentPost
  BlockUser

Query:
  SearchUser
  ShowUserPosts
  ShowAllFriendMessages

Tables:
  User
  Post
  Comment
  FriendBlock
  Friendship
