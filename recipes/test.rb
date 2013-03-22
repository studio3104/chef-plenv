group "test" do
  gid 1001
end
user "test" do
  uid   1001
  gid   1001
  shell "/bin/bash"
  home  "/home/test"
end

plenv_run "install plenv" do
  user "test"
end
plenv_perl "5.16" do
  user "test"
  version "perl-5.16.2"
end
