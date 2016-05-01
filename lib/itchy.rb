require 'active_support/all'
require 'settingslogic'
require 'multi_json'
require 'mixlib/shellout'
require 'logger'
require 'uri'
require 'erb'
require 'hashie/mash'
require 'cloud-appliance-descriptor'
require 'rubygems/package'

# Wraps all internals of the handler.
module Itchy
  BASIC_QEMU_COMMAND = 'qemu-img'
end

require 'itchy/version'
require 'itchy/settings'
require 'itchy/log'
require 'itchy/errors'
require 'itchy/helpers'
require 'itchy/event_handlers'
require 'itchy/metadata_archiver'
require 'itchy/image_transformer'
require 'itchy/vmcatcher_env'
require 'itchy/vmcatcher_configuration'
require 'itchy/vmcatcher_event'
require 'itchy/event_processer'
require 'itchy/format_converter'
