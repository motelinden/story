class QqopenController < ApplicationController
 	
 	

	def word_filter
		    
		 content=params[:content]
		 
		 # session get :http,openid,openkey,pf 
		
		 
		 # test
		  http="http://119.147.19.43"
		  #userip=request.remote_ip 
	   userip="10.0.0.1"
	 	 #openid="F0D7024EB511DB0D8BD52E7C2FCC7C45" 
		 #openkey="55AB9D45D09026C0B678D68F925C7614"
		 #pf="qzone"
		 
		 openid=session[:openid]
	   openkey=session[:openkey]
	   pf=session[:pf]
	 
		 uri= "/v3/csec/word_filter"
		 method="get"
		 
	   appkey="FNya6Dy7xOXl7GZB"
	   appid="1101248465"
	   format="json"
	  
 		 parameters="openid="+openid+"&openkey="+openkey +"&userip="+ userip+"&pf="+pf+"&appid="+appid+"&format="+format+"&content="+content
 		 sig=getSig(uri,method,appkey,parameters)
 		 
 		 parameters="openid="+openid+"&openkey="+openkey +"&userip="+ userip+"&pf="+pf+"&appid="+appid+"&format="+format+"&content="+URLEncoder(content)
 		 http= http+uri+"?"+parameters+"&sig="+sig
 		 
 		 data={ret:1002,msg:"err"}
 		 
 		 open(http){|file|  
				#puts file.class #Tempfile  
			  data= file.read
			}
		p '333333333333'
    p data
	   respond_to do |format|
        format.html { @sig }
       # format.json { render action: 'show', location: @node}
        format.json { render json: data, status: :ok}
     end
	end
  
end
