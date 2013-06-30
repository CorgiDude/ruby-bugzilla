# user.rb
# Copyright (C) 2010-2012 Red Hat, Inc.
#
# Authors:
#   Akira TAGOH  <tagoh@redhat.com>
#
# Copyright (C) 2013 Wilcox Technologies, LLC
#

require 'bugzilla/api_tmpl'

module Bugzilla

=begin rdoc

=== Bugzilla::User

Bugzilla user and session management

=end

  class User < APITemplate

=begin rdoc

==== Bugzilla::User#session(credentials)

Performs a block while signed in using the credentials specified.

If no credentials are specified, or they are invalid, we will attempt to use the Bugzilla cookie found at
~/.ruby-bugzilla-cookie.yml.  Please ensure that this file is chmod'd 0600 if you want to use it.

=end

    def session(credentials = nil)
      if credentials.nil?
        fname = File.join(ENV['HOME'], '.ruby-bugzilla-cookie.yml')

        if File.exist?(fname) && File.lstat(fname).mode & 0600 == 0600 then
          conf = YAML.load(File.open(fname).read)
          host = @iface.instance_variable_get(:@xmlrpc).instance_variable_get(:@host)
          cookie = conf[host]

          unless cookie.nil? then
            @iface.cookie = cookie

            yield

            # update cookie, if necessary
            if @iface.cookie != cookie
              conf[host] = @iface.cookie
              File.open(fname, 'w') {|f| f.chmod(0600); f.write(conf.to_yaml)}
            end
          end
        end
      else
        login(credentials.merge({'remember' => true}))
        yield
        logout
      end
      
    end # def session

=begin rdoc

==== Bugzilla::User#login(params)

Raw Bugzilla API to log into Bugzilla.

=end

=begin rdoc

==== Bugzilla::User#logout

Raw Bugzilla API to log out the user.

=end

    protected

    def _login(cmd, *args)
      raise ArgumentError, "Invalid parameters" unless args[0].kind_of?(Hash)

      @iface.call(cmd,args[0])
    end # def _login

    def _logout(cmd, *args)
      @iface.call(cmd)
    end # def _logout

    def __offer_account_by_email(cmd, *args)
      # FIXME
    end # def _offer_account_by_email

    def __create(cmd, *args)
      # FIXME
    end # def _create

    def __get(cmd, *args)
      requires_version(cmd, 3.4)
      # FIXME
    end # def _get

  end # class User

end # module Bugzilla
