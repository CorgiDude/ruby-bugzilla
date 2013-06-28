# xmlrpc.rb
# Copyright (C) 2010-2012 Red Hat, Inc.
#
# Authors:
#   Akira TAGOH  <tagoh@redhat.com>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330,
# Boston, MA 02111-1307, USA.

require 'xmlrpc/client'
require 'uri'

module Bugzilla

=begin rdoc

=== Bugzilla::XMLRPC

=end

  class XMLRPC

=begin rdoc

==== Bugzilla::XMLRPC#new(url = 'http://bugs/xmlrpc.cgi', proxy_host = nil, proxy_port = nil, timeout = 60)

Connects to the Bugzilla instance at _url_, optionally using the proxy specified
by _proxy_host_ and _proxy_port_.  Will timeout connecting after _timeout_ seconds
(default: 60)

=end

    def initialize(url, proxy_host = nil, proxy_port = nil, timeout = 60)
      raise ArgumentError, 'No URL specified' if url.nil?

      parsed_uri = URI.parse(url)
      parsed_uri.path = '/xmlrpc.cgi' if parsed_uri.path.empty?
      use_ssl = parsed_uri.port == 443 ? true : false
      @xmlrpc = ::XMLRPC::Client.new(parsed_uri.host, parsed_uri.path, parsed_uri.port, proxy_host, proxy_port, nil, nil, use_ssl, timeout)
    end # def initialize

=begin rdoc

==== Bugzilla::XMLRPC#call(cmd, params, user = nil, password = nil)

=end

    def call(cmd, params = {}, user = nil, password = nil)
      params = {} if params.nil?
      params['Bugzilla_login'] = user unless user.nil? || password.nil?
      params['Bugzilla_password'] = password unless user.nil? || password.nil?
      @xmlrpc.call(cmd, params)
    end # def call

=begin rdoc

==== Bugzilla::XMLRPC#cookie

=end

    def cookie
      @xmlrpc.cookie
    end # def cookie

=begin rdoc

==== Bugzilla::XMLRPC#cookie=(val)

=end

    def cookie=(val)
      @xmlrpc.cookie = val
    end # def cookie

  end # class XMLRPC

end # module Bugzilla
