json.data do
	json.array!(@events) do |event|
	  json.id event.id
	  json.text event.text
	  json.start_date event.start_date.strftime('%Y-%m-%d %H:%M')
	  json.end_date event.end_date.strftime('%Y-%m-%d %H:%M')
	  json.user_id event.user_id
	  #json.label event.user.label  
	  json.unit_id event.user_id 
	end
end