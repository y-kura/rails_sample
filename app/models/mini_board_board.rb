class Board < ActiveRecord::Base
  validates :title,
    presence: {:message =>'タイトルを入力してください'},
    length: {:maximum => 32, :message => 'タイトルは32文字以内にしてください'}
 
  validates :password,
    presence: {:message =>'パスワードを入力してください'},
    length: {:maximum => 16, :message => 'パスワードは16文字以内にしてください'},
    format: {:with => /\A[a-zA-Z0-9]+\Z/, :message => 'パスワードには英数字を入力してください'}
end
