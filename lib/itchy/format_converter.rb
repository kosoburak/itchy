module Itchy
  # Converting different image formats
  class FormatConverter


    # Creates and converter instance for converting image to requried format
    #
    # @param unpacking_dir [String] path to directory where image is stored
    # @param metadata [VmcatcherEvent] metadata of event corresponding to image
    # @param vmcatcher_configuration [VmcatcherConfiguration] vmcatcher configuration
    def initialize(unpacking_dir, metadata, vmcatcher_configuration)
      
      unless vmcatcher_configuration.is_a?(Itchy::VmcatcherConfiguration)
        fail ArgumentError, '\'vmcatcher_configuration\' must be an instance of ' \
                            'Itchy::VmcatcherConfiguration!'
      end

      @unpacking_dir = unpacking_dir
      @metadata = metadata
      @vmcatcher_configuration = vmcatcher_configuration
    end

    # Converts image to required format. It uses Mixlib::ShelOut.
    #
    # @param file_format [String] actual format of the image
    # @param required_format [String] required format
    # @param output_dir [String] path to a directory where converted image should be stored
    def convert!(file_format, required_format, output_dir, qemu_img_binary)
      Itchy::Log.info "[#{self.class.name}] Converting image " \
                             "#{@metadata.dc_identifier.inspect} from " \
                             "original format: #{file_format} to " \
                             "required format: #{required_format}."

      new_file_name = "#{::Time.now.to_i}_#{@metadata.dc_identifier}"
      qemu_command = qemu_img_binary || Itchy::BASIC_QEMU_COMMAND
      convert_cmd = Mixlib::ShellOut.new("#{qemu_command} convert -f #{file_format} -O #{required_format} #{@unpacking_dir}/#{@metadata.dc_identifier} #{output_dir}/#{new_file_name}")
      convert_cmd.run_command
      begin
        convert_cmd.error!
      rescue Mixlib::ShellOut::ShellCommandFailed, Mixlib::ShellOut::CommandTimeout,
             Mixlib::Shellout::InvalidCommandOption => ex
        Itchy::Log.fatal "[#{self.class.name}] Converting of image failed with " \
          "error messages #{convert_cmd.stderr}."
        fail Itchy::Errors::FormatConversionError, ex
      end
      new_file_name
    end
  end
end
