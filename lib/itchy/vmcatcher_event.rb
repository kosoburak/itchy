module Itchy
  # Wraps vmcatcher event meta data.
  class VmcatcherEvent < VmcatcherEnv
    # Known methods names used by this class
    KNOWN_METHOD_NAMES = %w(
      type
      dc_description
      dc_identifier
      dc_title
      hv_hypervisor
      hv_size
      hv_uri
      hv_format
      hv_version
      sl_arch
      sl_checksum_sha512
      sl_comments
      sl_os
      sl_osversion
      il_dc_identifier
      ad_mpuri
      filename
      vo).freeze

    # Prefix for making vmcatcher attributes
    VMCATCHER_ATTR_PREFIX = 'VMCATCHER_EVENT_'

    # Known event attributes used by vmcatcher
    REGISTERED_ENV_KEYS = %w(
      VMCATCHER_EVENT_TYPE
      VMCATCHER_EVENT_DC_DESCRIPTION
      VMCATCHER_EVENT_DC_IDENTIFIER
      VMCATCHER_EVENT_DC_TITLE
      VMCATCHER_EVENT_HV_HYPERVISOR
      VMCATCHER_EVENT_HV_SIZE
      VMCATCHER_EVENT_HV_URI
      VMCATCHER_EVENT_HV_FORMAT
      VMCATCHER_EVENT_HV_VERSION
      VMCATCHER_EVENT_SL_ARCH
      VMCATCHER_EVENT_SL_CHECKSUM_SHA512
      VMCATCHER_EVENT_SL_COMMENTS
      VMCATCHER_EVENT_SL_OS
      VMCATCHER_EVENT_SL_OSVERSION
      VMCATCHER_EVENT_IL_DC_IDENTIFIER
      VMCATCHER_EVENT_AD_MPURI
      VMCATCHER_EVENT_FILENAME
      VMCATCHER_EVENT_VO).freeze

    def method_missing(method_id, *arguments, &block)
      if KNOWN_METHOD_NAMES.include? method_id.to_s
        self.class.send :define_method, method_id do
          temp = VMCATCHER_ATTR_PREFIX + method_id.to_s.upcase

          attributes[temp]
        end
        send(method_id)
      else
        super
      end
    end

    def respond_to?(method_id, include_private = false)
      if KNOWN_METHOD_NAMES.include? method_id.to_s
        true
      else
        super
      end
    end
  end
end
