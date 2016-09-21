authorization do
  role :guest do
    has_permission_on :user_sessions, :to => [:create , :destroy]
    has_permission_on :users, :to => [:create]
  end

  # permissions on other roles, such as
  role :serviceprovider do
    has_permission_on :accounts, :to => :manage
    has_permission_on :accounting_periods, :to => :manage
  end
  role :admin do
    includes :guest
    includes :serviceprovider
    has_permission_on :products, :to => :manage
    has_permission_on :users, :to => :manage
    has_permission_on :admini_url, :to => :manage
    has_permission_on :listusers_url, :to => :manage
    has_permission_on :inventories, :to => :manage
    has_permission_on :transaction_types, :to => :manage
    has_permission_on :gl_mappings, :to => :manage
  end

  role :user do
    has_permission_on :products, :to => :read
  end

 
  # role :user do
  #   has_permission_on :conferences, :to => [:read, :create]
  #   has_permission_on :conferences, :to => [:update, :delete] do
  #     if_attribute :user_id => is {user.id}
  #   end
  # end
  # See the readme or GitHub for more examples
end

privileges do
  # default privilege hierarchies to facilitate RESTful Rails apps
  privilege :manage, :includes => [:create, :read, :update, :delete]
  privilege :read, :includes => [:index, :show]
  privilege :create, :includes => :new
  privilege :update, :includes => :edit
  privilege :delete, :includes => :destroy
end
