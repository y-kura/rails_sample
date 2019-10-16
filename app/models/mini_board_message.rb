class Message < ActiveRecord::Base
  validates :name,
    presence: {:message =>'名前を入力してください'},
    length: {:maximum => 16, :message => '名前は16文字以内にしてください'}
 
  validates :body,
    presence: {:message =>'メッセージを入力してください'},
    length: {:maximum => 999, :message => 'メッセージは999文字以内にしてください'}
end
