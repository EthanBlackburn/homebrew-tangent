class TangentShared < Formula
  desc "The tangent-shared application"
  homepage "https://github.com/EthanBlackburn/tangent"
  version "0.3.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/EthanBlackburn/tangent/releases/download/v0.3.2/tangent-shared-aarch64-apple-darwin.tar.xz"
      sha256 "df9cf1db217d78a830bd59a54c3cd69fa86162add49a974ef409e8529e017216"
    end
    if Hardware::CPU.intel?
      url "https://github.com/EthanBlackburn/tangent/releases/download/v0.3.2/tangent-shared-x86_64-apple-darwin.tar.xz"
      sha256 "798896a98bae17b53e4ab43221363a618e7501a1f2fcb118378a5d77cc5a7181"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/EthanBlackburn/tangent/releases/download/v0.3.2/tangent-shared-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "cda74b9416f73a49e96d0187eefd6deacb9cf1b3af14ade24570633885b3ddaa"
    end
    if Hardware::CPU.intel?
      url "https://github.com/EthanBlackburn/tangent/releases/download/v0.3.2/tangent-shared-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1ff195dd91ceb08e27125723aa62e068f8f7edd39f0e82182c7d16a1957edc5c"
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
