class TangentRuntime < Formula
  desc "The tangent-runtime application"
  homepage "https://github.com/EthanBlackburn/tangent"
  version "0.3.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/EthanBlackburn/tangent/releases/download/v0.3.3/tangent-runtime-aarch64-apple-darwin.tar.xz"
      sha256 "5330c2d8a16a712aafb6c304fdb62b3da1cbbc5f684110168c5bb30f38c3edd7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/EthanBlackburn/tangent/releases/download/v0.3.3/tangent-runtime-x86_64-apple-darwin.tar.xz"
      sha256 "b5ce191b4ae3694cb52a60e137459941f7bdf90ed895edaedeec16556306ff17"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/EthanBlackburn/tangent/releases/download/v0.3.3/tangent-runtime-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8cdf64e858c77a4b0b881d4d5e6e41e243a3e1b9948820f29fabb202b24ebf79"
    end
    if Hardware::CPU.intel?
      url "https://github.com/EthanBlackburn/tangent/releases/download/v0.3.3/tangent-runtime-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "21bac7bda13dfdfb8e05d6b0f6eb6e570bbc2beeb6aded12d52805219dc08223"
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
