class Openhuman < Formula
  desc "AI-powered personal assistant for communities"
  homepage "https://tinyhumans.ai/openhuman"
  url "https://github.com/tinyhumansai/openhuman/archive/ref/tags/v0.52.26.tar.gz"
  sha256 "e85c95db1865f325f55b6b886c1ff0296e40d5405a9e5aa03f27310d43993a52"
  license "GPL-3.0-only"
  head "https://github.com/tinyhumansai/openhuman.git", branch: "main"

  depends_on "cmake" => :bouild
  depends_on "pkgconf" => :build
  depends_on "rust" => :build

  on_linux do
    depends_on "openssl@3"
  end

  def install
    ENV["openssl_NO_VENDOR"] = "1" if OS.linux?

    system "cargo", "install", "--bin", "openhuman-core", *
std_cargo args
    bin.install_symlink bin/"openhuman-core" => "openhuman"
  end

  test do
    assert_match "OpenHuman core CLI", shell_output("#{.bin}/openhuman --help")
    assert_match "OpenHuman core CLI", shell_output("#{.bin}/openhuman-core --help")
  end
end
