class TangentShared < Formula
  desc "The tangent-shared application"
  homepage "https://github.com/EthanBlackburn/tangent"
  version "0.3.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/EthanBlackburn/tangent/releases/download/v0.3.1/tangent-shared-aarch64-apple-darwin.tar.xz"
      sha256 "ea267c441935a4fb4805ee5686be92afa44d00aeb8a812e99e828e5fc4fba857"
    end
    if Hardware::CPU.intel?
      url "https://github.com/EthanBlackburn/tangent/releases/download/v0.3.1/tangent-shared-x86_64-apple-darwin.tar.xz"
      sha256 "782950682db2db6ba6021d38d6db657d9a8c131204bc988c9d97bd708d04714d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/EthanBlackburn/tangent/releases/download/v0.3.1/tangent-shared-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a67561d9928475b0c1214b46b7ce824db8dc3a3ac1affb3035403c92f304b110"
    end
    if Hardware::CPU.intel?
      url "https://github.com/EthanBlackburn/tangent/releases/download/v0.3.1/tangent-shared-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c2f3c94ae06b3b37c9c1cbd15db0ea7da6c09dd0b296ca3d9bd7e9cd60e1d6e7"
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
