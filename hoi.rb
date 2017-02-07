require 'formula'

HOMEBREW_HOI_VERSION='0.1.3'
class Hoi < Formula
  homepage 'https://github.com/monochromegane/hoi'
  url "https://github.com/monochromegane/hoi/releases/download/v#{HOMEBREW_HOI_VERSION}/hoi_darwin_amd64.zip"
  sha256 'd7042ae87b2e4bba87da08b0c92db0ce83da4252a903dab89a96883b65905673'

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
