actions :install

attribute :version, :kind_of => String
attribute :install_options, :kind_of => String
attribute :installed, :default => false
attribute :using, :kind_of => String, :default => "global"

attribute :user, :kind_of => String
attribute :root_dir, :kind_of => String

def initialize(*args)
  super
  @action = :install
end
