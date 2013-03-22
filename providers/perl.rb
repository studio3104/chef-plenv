require 'chef/mixin/shell_out'
require 'chef/mixin/language'
include Chef::Mixin::ShellOut

action :install do
  new_resource.root_dir("/home/#{new_resource.user}/.plenv") unless new_resource.root_dir
  new_resource.version(new_resource.name) unless new_resource.version
  bash "Install plenv perl #{new_resource.name}" do
    code <<-EOF
    su - #{new_resource.user} -c "#{new_resource.root_dir}/bin/plenv install #{new_resource.version}"
    EOF
    not_if { ::File.exists?("#{new_resource.root_dir}/versions/#{new_resource.version}/bin/perl") }
  end

  bash "apply perl version" do
    user new_resource.user
    environment ({
      'PLENV_ROOT' => new_resource.root_dir,
      'PLENV_HOME' => new_resource.root_dir,
    })
    code <<-EOC
    echo #{new_resource.name} > #{new_resource.root_dir}/version
    EOC
  end

  bash "Install plenv-cpanm" do
    code <<-EOF
    su - #{new_resource.user} -c "#{new_resource.root_dir}/bin/plenv install-cpanm"
    su - #{new_resource.user} -c "#{new_resource.root_dir}/bin/plenv rehash"
    EOF
    not_if { ::File.exists?("#{new_resource.root_dir}/versions/#{new_resource.version}/bin/cpanm") }
  end
end
