class TangentShared < Formula
  desc "The tangent-shared application"
  homepage "https://github.com/EthanBlackburn/tangent"
  version "0.3.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/EthanBlackburn/tangent/releases/download/v0.3.4/tangent-shared-aarch64-apple-darwin.tar.xz"
      sha256 "14bce6efb62237d6b03ab8ea2ce18a64f1b4776be568fb88f7f98626dc0311e6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/EthanBlackburn/tangent/releases/download/v0.3.4/tangent-shared-x86_64-apple-darwin.tar.xz"
      sha256 "fc560c272d1c7b704de28219038260ca344a0062dbfedf1a1f8eb78548643770"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/EthanBlackburn/tangent/releases/download/v0.3.4/tangent-shared-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "af06833ce24ab8019eceba87f9f4402ef25db583814d8ad9f94b268ac1162181"
    end
    if Hardware::CPU.intel?
      url "https://github.com/EthanBlackburn/tangent/releases/download/v0.3.4/tangent-shared-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6a99c4ef7e68a32fa11e473faa873749743dcfd8b42045cf203f33baad883b4c"
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
