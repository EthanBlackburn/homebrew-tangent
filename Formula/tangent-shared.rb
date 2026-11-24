class TangentShared < Formula
  desc "The tangent-shared application"
  homepage "https://github.com/EthanBlackburn/tangent"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/EthanBlackburn/tangent/releases/download/v0.3.0/tangent-shared-aarch64-apple-darwin.tar.xz"
      sha256 "1a68b44061f211f31f6fcd2f0577542f236633762894b4c821ddb6bf5a0330a7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/EthanBlackburn/tangent/releases/download/v0.3.0/tangent-shared-x86_64-apple-darwin.tar.xz"
      sha256 "8f1cf61b7e728d08501f6d41926cd1f261a4465e04581c3ac926d0c2352fd0cb"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/EthanBlackburn/tangent/releases/download/v0.3.0/tangent-shared-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a459b0b0b4c56b7dfcbc1f03373213cdf512c7d95dd9173b2569f13e5208ddad"
    end
    if Hardware::CPU.intel?
      url "https://github.com/EthanBlackburn/tangent/releases/download/v0.3.0/tangent-shared-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "929c009d78a6b7bdc973f697084125d9a4abd4aebb86aa3b4be2ccce89e7df04"
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
      bin.install "shared-cli"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "shared-cli"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "shared-cli"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "shared-cli"
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
