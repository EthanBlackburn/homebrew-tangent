class TangentCli < Formula
  desc "The tangent-cli application"
  homepage "https://github.com/EthanBlackburn/tangent"
  version "0.3.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/EthanBlackburn/tangent/releases/download/v0.3.1/tangent-cli-aarch64-apple-darwin.tar.xz"
      sha256 "f27c92571d17946a8a4725c4775bbc4aa8aa6a196ac744fd4ba71443cfd94f8f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/EthanBlackburn/tangent/releases/download/v0.3.1/tangent-cli-x86_64-apple-darwin.tar.xz"
      sha256 "0b277099a5daec0ff8e008181b607a52fe3e62749224b275f4f367da74e43b55"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/EthanBlackburn/tangent/releases/download/v0.3.1/tangent-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "4971968bae974fae19807affb5cd15ea1d5b10b66d4f7112714322bc0df2e46b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/EthanBlackburn/tangent/releases/download/v0.3.1/tangent-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "63f2ee9566e8df6970945c84a96ef1091d55a563bbc9047be70d7caf0b6bb287"
    end
  end

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "tangent"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "tangent"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "tangent"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "tangent"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
