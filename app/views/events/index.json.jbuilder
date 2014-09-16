json.data do
	json.array!(@events) do |event|
	  json.id event.id
	  json.text event.text
	  json.start_date event.start_date.strftime('%Y-%m-%d %H:%M')
	  json.end_date event.end_date.strftime('%Y-%m-%d %H:%M')
	  json.unit_id event.work.user_id 
	  json.user_id event.work.user_id
	  json.section_id event.work_id 
	end
end