require 'chef/mixin/shell_out'
require 'chef/mixin/language'
include Chef::Mixin::ShellOut

action :install do
  new_resource.root_dir("/home/#{new_resource.user}/.plenv") unless new_resource.root_dir

  git "#{new_resource.root_dir}" do
    repository "git://github.com/tokuhirom/plenv.git"
    reference  "master"
    user       new_resource.user
    action     :sync
    notifies   :run, "bash[apply_to_bashrc]", :immediately
  end

  bash "apply_to_bashrc" do
    code <<-EOF
    echo 'export PATH=#{new_resource.root_dir}/bin:$PATH' >> .bashrc
    echo 'eval "$(plenv init -)"' >> .bashrc
    EOF
    user   new_resource.user
    cwd    "/home/#{new_resource.user}"
    action :nothing
  end
end
