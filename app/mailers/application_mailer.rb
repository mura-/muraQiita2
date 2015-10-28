### この Mailer は使っていませんか ?
### であれば、消してしまった方がよいと思います.
class ApplicationMailer < ActionMailer::Base
  default from: "kazuki.murahama@gmail.com"
  layout 'mailer'
end
