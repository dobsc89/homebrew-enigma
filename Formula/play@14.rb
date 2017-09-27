class PlayAT14 < Formula
  desc "Play’s goal is to ease Java web applications development."
  homepage "https://www.playframework.com"
  url "https://downloads.typesafe.com/play/1.4.4/play-1.4.4.zip"
  sha256 "1dd7ef51c8698e997d72187932124b853e7e2e4519d098890fadc4ef10316cab"

  bottle :unneeded

  conflicts_with "sox", :because => "Both install a `play` executable"
  conflicts_with "play@12", :because => "Both install a `play` executable"

  def install
    rm_rf "python" # we don't need the bundled Python for windows
    rm Dir["*.bat"]
    libexec.install Dir["*"]
    chmod 0755, libexec/"play"
    bin.install_symlink libexec/"play"
  end

  test do
    require "open3"
    Open3.popen3("#{bin}/play new #{testpath}/app") do |stdin, _, _|
      stdin.write "\n"
      stdin.close
    end
    %w[app conf lib public test].each do |d|
      File.directory? testpath/"app/#{d}"
    end
  end
end
