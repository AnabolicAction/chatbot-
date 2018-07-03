require 'parse'
class KakaoController < ApplicationController
  def keyboard
   @keyboard = {
    :type => "buttons",
    :buttons => ["다이어트메뉴", "로또번호", "맹수"]
}

  render json: @keyboard

  end
  
  def message 
      @user_msg = params[:content]
      @text = "기본응답"
    if @user_msg =="다이어트메뉴"
       @text =["락스","생강","똠양꿍","칫솔","다마내기","생마늘","건빵","독버섯","농약","쥐약","물수제비"].sample
    elsif @user_msg=="로또번호"
       @text =(1..45).to_a.sample(6).sort.to_s
    elsif @user_msg == "맹수"
          @cat_url = Parse::Animal.cat
    end
    
    @return_msg = {
      :text => @text
    }
    
    @return_msg_photo={
      :text => "사나운 맹수",
      :photo => {
        :url => @cat_url,
        :width => 720,
        :height => 630 
      }
    }
    @return_keyboard = {
    :type => "buttons",
    :buttons => ["다이어트메뉴", "로또번호", "맹수"]
}
    if @user_msg =="맹수"
    @result ={
      :message => @return_msg_photo,
      :keyboard => @return_keyboard
    }  
  else
    @result ={
      :message => @return_msg,
      :keyboard => @return_keyboard
    }
    
  end
  
    
    render json: @result
  end
  
  def friend_add
    #유저가 치구추가했을때 추가하는코드
    User.create(user_key: params[:user_key], chat_room: 0) 
    render json: true
  end
  
  def friend_delete
    User.find_by(user_key: params[:user_key]).destroy
    render nothing: true
  end
  def chat_room
    user=User.find_by(user_key: params[:user_key])
    user.plus
    user.save
    render nothing: true
  end
end
