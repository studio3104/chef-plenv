actions :install

attribute :user, :kind_of => String
attribute :user_home, :kind_of => String
attribute :root_dir, :kind_of => String

def initialize(*args)
  super
  @action = :install
end
