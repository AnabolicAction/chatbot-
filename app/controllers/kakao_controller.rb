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
    elsif @user_msg=="맹수"
    @url = "http://thecatapi.com/api/images/get?format=xml&type=jpg"
    @cat_xml = RestClient.get(@url)
    @cat_doc = Nokogiri::XML(@cat_xml)
    @cat_url= @cat_doc.xpath('//url').text
    @text =@cat_url
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
end
