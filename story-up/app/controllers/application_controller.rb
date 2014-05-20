class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :devise_parameter_sanitizer, if: :devise_controller?

  # devise strong parameters
  protected
  def devise_parameter_sanitizer
 
    if resource_class == User
    	p '==User'
      #User::ParameterSanitizer.new(User, :user, params)
      super
    else
    	p '!=user'
      super
    end
  end

 # add the first user to admin
  def after_sign_in_path_for(resoruce)
 
    if resource.is_a?(User)
      if User.count == 1
        resource.add_role 'admin'
      end
      resource
    end
    root_path
  end

def get_info(openid,openkey,pf)
 		userip="10.0.0.1"
 		
 		
 		http="http://119.147.19.43"
 		uri= "/v3/user/get_info"
		method="get"
		appkey="FNya6Dy7xOXl7GZB"
	  appid="1101248465"
	  format="json"
	  
	  parameters="openid="+openid+"&openkey="+openkey +"&userip="+ userip+"&pf="+pf+"&appid="+appid+"&format="+format
 		sig=getSig(uri,method,appkey,parameters)
 		 
 		parameters="openid="+openid+"&openkey="+openkey +"&userip="+ userip+"&pf="+pf+"&appid="+appid+"&format="+format
 		http= http+uri+"?"+parameters+"&sig="+sig
 		 
 		data={ret:1002,msg:"err"}
 		open(http){|file|  
				#puts file.class #Tempfile  
			  data= file.read
		}
			
			p '3333333333333333'
			p data
	   
	end
	
	
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
