module WorksHelper
	# Returns a dynamic path based on the provided parameters
	def sti_work_path(period = "work", work = nil, action = nil)
	  send "#{format_sti(action, period, work)}_path", work
	end

	def format_sti(action, period, work)
	  action || work ? "#{format_action(action)}#{period.underscore}" : "#{period.underscore.pluralize}"
	end

	def format_action(action)
	  action ? "#{action}_" : ""
	end
end
