class Chef
  class Resource
    class File
      def include?(str)
        return false unless ::File.exists?(@path)

        file_content = IO.read @path
        if file_content =~ /#{str}/
          Chef::Log.info("file[#{@path}] contains the string '#{str}'")
          true
        else
          Chef::Log.info("file[#{@path}] doesn't contains the string '#{str}'")
          false
        end
      end

      def replace(str, str2)
        Chef::Log.info("replacing '#{str}' with '#{str2}' at #{@path}")
        old_content = IO.read @path
        puts old_content.gsub(str, str2)
        content old_content.gsub(str, str2)
      end
    end
  end
end