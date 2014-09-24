ActiveAdmin.register Work, :as => "Period" do

	filter :user, as:  :select, collection: proc { User.all.map {|user| [user.label, user.id] } }
	filter :events, as:  :select, collection: proc { Event.all.map {|event| [event.text, event.id] } }

end
