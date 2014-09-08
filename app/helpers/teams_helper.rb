module TeamsHelper
	def members
		data = ""
    Team.all.each do |t|
      data += "{key: #{t.id}, label: \"#{t.label}\", open: true, children: ["
      t.users.all.each do |u|
        data += "{key: #{u.id}, label: \"#{u.label}\"},"
      end
      data += "]},"
    end
    return data
	end
end
