class TangentCli < Formula
  desc "The tangent-cli application"
  homepage "https://github.com/EthanBlackburn/tangent"
  version "0.3.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/EthanBlackburn/tangent/releases/download/v0.3.4/tangent-cli-aarch64-apple-darwin.tar.xz"
      sha256 "1675b650fc5703e7636c8b9043307dca89697ebcefa8ea2ce5f4274df9e05c48"
    end
    if Hardware::CPU.intel?
      url "https://github.com/EthanBlackburn/tangent/releases/download/v0.3.4/tangent-cli-x86_64-apple-darwin.tar.xz"
      sha256 "6fe20c64b97c77bcb77948d1e5be4d9358df91ac6e956e4397700a5afd8ad62e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/EthanBlackburn/tangent/releases/download/v0.3.4/tangent-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "81bb8fa24143e3592c6bce098f8cdb381c1f2348cbedf5c67e3c4282e2bf279b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/EthanBlackburn/tangent/releases/download/v0.3.4/tangent-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d014aa5615e555896e870d0b275490c4261ec9a29b502b9dab72a7814a867d47"
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
