class TangentRuntime < Formula
  desc "The tangent-runtime application"
  homepage "https://github.com/EthanBlackburn/tangent"
  version "0.3.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/EthanBlackburn/tangent/releases/download/v0.3.1/tangent-runtime-aarch64-apple-darwin.tar.xz"
      sha256 "899986595aa4b4c4ea514dd7a457dbb109714aba71b2b318f58b9fa411c00c99"
    end
    if Hardware::CPU.intel?
      url "https://github.com/EthanBlackburn/tangent/releases/download/v0.3.1/tangent-runtime-x86_64-apple-darwin.tar.xz"
      sha256 "ac46fdc92dd931d257a09c5cb7d9b8d4d56eeba1b4fa486cb1e14644db5fd7f6"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/EthanBlackburn/tangent/releases/download/v0.3.1/tangent-runtime-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "831dc1b71ff68315f9364228320e8db0cf511979fa2ef7b4e803eba5d6223e0b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/EthanBlackburn/tangent/releases/download/v0.3.1/tangent-runtime-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "acb337faf708f8b613f7df50642e677a3334e0ae4e4fc3bb167b443e70ce8b5b"
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
      bin.install "tangentd"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "tangentd"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "tangentd"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "tangentd"
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
