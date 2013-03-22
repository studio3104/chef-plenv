actions :install

attribute :version, :kind_of => String

attribute :user, :kind_of => String
attribute :root_dir, :kind_of => String

def initialize(*args)
  super
  @action = :install
end
