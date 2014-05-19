class QqopenController < ApplicationController
 

	def word_filter
			p ' -----------word_filter      '
		 content=params[:content]
		 p '--------cont'
		 # session get :http,openid,openkey,pf 
		 http="http://119.147.19.43"
	 	 openid="F0D7024EB511DB0D8BD52E7C2FCC7C45" 
		 openkey="883F5B3F955568EFE793C57204203B11"
		 pf="qzone"
		 
		 uri= "/v3/csec/word_filter"
		 method="get"
		 
	   appkey="FNya6Dy7xOXl7GZB"
	   appid="1101248465"
	   format="json"
	   #userip=request.remote_ip 
	   userip="10.0.0.1"
 		 parameters="openid="+openid+"&openkey="+openkey +"&userip="+ userip+"&pf="+pf+"&appid="+appid+"&format="+format+"&content="+content
 	 p '----------------sig-'
 		 sig=getSig(uri,method,appkey,parameters)
 		 
 		 parameters="openid="+openid+"&openkey="+openkey +"&userip="+ userip+"&pf="+pf+"&appid="+appid+"&format="+format+"&content="+URLEncoder(content)
 		 http= http+uri+"?"+parameters+"&sig="+sig
 		 p '-----------------'
 		 p http
 		 data={ret:1002,msg:"err"}
 		 open(http){|file|  
				#puts file.class #Tempfile  
			  data= file.read
			}
		 p "------data"
		 p data
	   respond_to do |format|
        format.html { @sig }
       # format.json { render action: 'show', location: @node}
        format.json { render json: data, status: :ok}
     end
	end
 private
  #  getSig(uri,method,appkey,parameters)
  def getSig(uri,method,appkey,parameters)
     
    #1
    uri= URLEncoder(uri)
    
    #2
 	
   	parameters=sort(parameters)
    
    #3
    parameters=URLEncoder(parameters)
    
    #4
    signature=method.upcase+ "&" + uri + "&" + parameters
  
    #5
    key = appkey + "&"
   
    #6
    	sha1= hmacSHA1(key,signature)
    
    #7
     sig=encode64(sha1)
    
    sig=  sig.chomp  
    
    #8
    @sig=URLEncoder(sig)
  end

  #  
  
 
  
  #@sort=hmacSHA1(key,signature)
  def hmacSHA1( key ,signature  ) 
  	  OpenSSL::HMAC.digest("sha1",key, signature)
  	  
  	 #OpenSSL::HMAC.digest('sha1', key,signature)
	end
	 
	def URLEncoder (url)
		#URI.escape  == URI.encode  URI.unescape ==URI.decode
		 CGI.escape( url ) 
	end
	
  def encode64(src)
			Base64.encode64(src)
	end
	
	#2
	def sort(array)
    array=array.split(%r{&\s*})
    keyArray=Array.new
    src=""
    hash = Hash.new
		 
    i=0
    for item in array do  
    	  keyArray[i]= item.split(%r{=\s*})[0]
    	  hash[item.split(%r{=\s*})[0]]=item.split(%r{=\s*})[1]
    	  i=i+1
    end
		keyArray=keyArray.sort
		 
		 for item in keyArray do 
		 		if ("sig"!=(item)) 
		 	 
		 	 		src=src+"&"+item+"="+hash[item]
		 		end
		 end 
		src[1,src.length]
  end  
end
