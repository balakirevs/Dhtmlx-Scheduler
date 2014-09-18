ActiveAdmin.register User do
  permit_params :label, :email, :password, :password_confirmation, :role, :events
 
    index do
      column :label
      column :email
      column :current_sign_in_at
      column :last_sign_in_at
      column :sign_in_count
      column :role
      actions
    end
 
    filter :email
    filter :events
    filter :team
 
    form do |f|
      f.inputs "User Details" do
        f.input :label
        f.input :email
        f.input :password
        f.input :password_confirmation
        f.input :role, as: :radio, collection: {Manager: "Manager", TeamLeader: "Team Leader", Reviewer: "Reviewer", Editor: "Editor", Administrator: "Administrator"}
      end
      f.actions
    end

    controller do
    def update_resource object, attributes
      attributes.each do |attr|
        if attr[:password].blank? and attr[:password_confirmation].blank?
          attr.delete :password
          attr.delete :password_confirmation
        end
      end

      object.send :update_attributes, *attributes
    end
  end
end
