ActiveAdmin.register Team do

  permit_params :label, :open, :user_id

  index do
    column :label
    column :open
    actions
  end

  filter :users, as:  :select, collection: proc { User.all.map {|user| [user.label, user.id] } }

  form do |f|
    f.inputs "Team Details" do
      f.input :label
      f.input :open
    end

    f.has_many :users do |user|
      user.input :label
      user.input :email
      user.input :password
      user.input :password_confirmation
      user.input :role, as: :radio, collection: {manager: "Manager", teamleader: "Team Leader", reviewer: "Reviewer", editor: "Editor", administrator: "Administrator"}
    end

    f.actions
  end
end
