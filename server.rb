require 'goliath'
require 'em-synchrony'
require 'em-synchrony/em-mongo'
require 'grape'

Dir[File.dirname(__FILE__) + '/app/helpers/*.rb'].each {|file| require file }

class API < Grape::API
  
	version 'v1', :using => :path
	format :json

	helpers do
		def logger
		    logger = Logger.new(File.dirname(__FILE__) + '/log/pearson_order.log')
		    logger.formatter = Logger::Formatter.new
			logger.level = Logger::INFO
			logger
		end
	end

    resource 'numbers' do

	    # curl -i -H "Accept: application/json" http://127.0.0.1:9000/v1/numbers -v

    	desc "Retrieve all number translation"
	    get "/" do  
		    logger.info "Find all Number translations"

		    coll = env.mongo.collection('numbers') #Connection Pool from Goliath ENV
		    # coll.remove()
		    number = coll.find() 
	    end  


	    # curl -i -H "Accept: application/json" http://127.0.0.1:9000/v1/numbers/1 -v

	    desc "Retrieve a specific number translation"
	    params do
	      requires :number, :type => Integer, :desc => "Number id."
	    end
	    get "/:number" do  
		    logger.info "Find a Number with value: #{params[:number]}"

		    formatted_number = params[:number].to_i
		    coll = env.mongo.collection('numbers') #Connection Pool from Goliath ENV
		    # coll.remove()
		    number = coll.find( { number: formatted_number } ) 

		    if !number.empty?
		    	logger.info "Found number for matching request: #{formatted_number}"
		     	number.first
		    else
		    	logger.info "Did not find number for matching request: #{formatted_number}"
 		     
			    translated_number = NumberToEnglishHelper::to_English(formatted_number)
				logger.info  "Translated Number: #{translated_number}"

			    presentation = Array.new
			    presentation << translated_number

			    doc = {"number" => formatted_number, "presentations" => presentation}
				id = coll.insert(doc)

				number = coll.find( { number: formatted_number } ) 
			    			
			    number.first   
		    end
	    end  
    
    end
end

class App < Goliath::API 
  def response(env)
    API.call(env)    
  end
end