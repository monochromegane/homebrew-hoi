require 'formula'

HOMEBREW_HOI_VERSION='0.1.4'
class Hoi < Formula
  homepage 'https://github.com/monochromegane/hoi'
  url "https://github.com/monochromegane/hoi/releases/download/v#{HOMEBREW_HOI_VERSION}/hoi_darwin_amd64.zip"
  sha256 'f8df0bd1a03db7bf43248c9714dc93a0f465fa4e6ed31ba0f9ff6890a374b7e7'

  version HOMEBREW_HOI_VERSION
  head 'https://github.com/monochromegane/hoi.git', :branch => 'master'

  if build.head?
    depends_on 'go' => :build
    depends_on 'hg' => :build
  end

  def install
    if build.head?
      ENV['GOPATH'] = buildpath
      system 'go', 'get', 'github.com/jessevdk/go-flags'
      system 'go', 'get', 'github.com/nlopes/slack'
      system 'go', 'get', 'golang.org/x/net/websocket'
      mkdir_p buildpath/'src/github.com/monochromegane'
      ln_s buildpath, buildpath/'src/github.com/monochromegane/hoi'
      system 'go', 'build', '-o', 'hoi', 'cmd/hoi/main.go'
    end
    bin.install 'hoi'
  end
end
