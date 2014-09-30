json.array!(@holidays) do |holiday|
  json.id holiday.id
  json.date holiday.date.strftime('%d-%b-%Y')
end

