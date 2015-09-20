tips = Tip.all
users = User.all
count = 20

count.times do |n|
  tip = tips.sample
  user = users.sample

  comment = tip.comments.build

  comment.user_id = user.id
  comment.content = "これは#{user.username}によって書かれたコメントです"
  comment.created_at = (count - n).hours.ago
  comment.save!
end
