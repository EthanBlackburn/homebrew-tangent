class TangentCli < Formula
  desc "The tangent-cli application"
  homepage "https://github.com/EthanBlackburn/tangent"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/EthanBlackburn/tangent/releases/download/v0.3.0/tangent-cli-aarch64-apple-darwin.tar.xz"
      sha256 "75246a607b91ded9a6e26e3a943d83154d6ae10ef8011f9e5c0153ecc467310b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/EthanBlackburn/tangent/releases/download/v0.3.0/tangent-cli-x86_64-apple-darwin.tar.xz"
      sha256 "b8b85739d20bef50fb1feb2c9f037dbce297c2ebeacf6b39222a008083984d21"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/EthanBlackburn/tangent/releases/download/v0.3.0/tangent-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ae3e71d125a7bd1ffae9ec85405fb29b8d2bf5234c429549aaccfd643ad1863d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/EthanBlackburn/tangent/releases/download/v0.3.0/tangent-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8debee34d968e0d769134019aa0f7f3f1e5dd6a7d7531563ac8fe4b2aead8d69"
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
