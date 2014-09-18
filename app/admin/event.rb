ActiveAdmin.register Event do

  permit_params :text, :start_date, :end_date
 
    index do
      column :text
      column :start_date
      column :end_date
      actions
    end
 
    filter :email
 
    form do |f|
      f.inputs "Event Details" do
        f.input :text
        f.input :start_date
        f.input :end_date
      end
      f.actions
    end

end
