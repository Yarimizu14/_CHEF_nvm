#
# Cookbook Name:: nvm
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "git" do
    action :install
end

directory "/home/vagrant/.nvm" do
    user "vagrant"
    group "vagrant"
    action :create
end

git "/home/vagrant/.nvm" do
    #destination "/user/local/nvm"
    #cdestination node['user']['home']
    #repository "git://github.com/creationix/nvm.git"
    repository "https://github.com/creationix/nvm.git"
    revision "master"
    user "vagrant"
    group "vagrant"
    action :sync
    notifies :run, "bash[nvm.sh]"
end

bash "nvm.sh" do
    code <<-EOH
        . /home/vagrant/.nvm/nvm.sh
        nvm install v0.10.1
        echo 'source ~/.nvm/nvm.sh' >> /home/vagrant/.bashrc
        echo 'nvm use v0.10.1' >> /home/vagrant/.bashrc
    EOH
    action :nothing
end

template "/home/vagrant/nvm.sh" do                        # nvm.sh.erb (後述)を/etc/profile.d/nvm.shにコピー
    source "nvm.sh.erb"
    mode 00644
end
