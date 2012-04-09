maintainer       "Stuart Caborn"
maintainer_email "stuart.caborn@gmail.com"
license          "All rights reserved"
description      "Installs/Configures minecraft"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"

%w{ ubuntu debian centos redhat fedora }.each do |os|
  supports os
end
 
%w{ apt screen }.each do |cook_book|
  depends cook_book
end
