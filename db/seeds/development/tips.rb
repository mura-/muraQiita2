users = User.all

100.times do |no|
  user = users.sample
  Tip.create(
    title: "タイトル#{no}",
    user_id: user.id,
    content: "本本文本文本文本文本文本文本文本文本文本文本文本文本文文"
  )
end
