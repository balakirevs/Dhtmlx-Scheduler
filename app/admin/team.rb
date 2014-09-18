ActiveAdmin.register Team do

  permit_params :label, :open, :user

  index do
    column :label
    column :open
    column :users, User.all do |u| [u.id]  end
    actions
  end

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
      user.input :role, as: :radio, collection: {Manager: "Manager", TeamLeader: "Team Leader", Reviewer: "Reviewer", Editor: "Editor", Administrator: "Administrator"}
    end

    f.actions
  end
end
