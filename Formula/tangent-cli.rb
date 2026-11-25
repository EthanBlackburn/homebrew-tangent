class TangentCli < Formula
  desc "The tangent-cli application"
  homepage "https://github.com/EthanBlackburn/tangent"
  version "0.3.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/EthanBlackburn/tangent/releases/download/v0.3.2/tangent-cli-aarch64-apple-darwin.tar.xz"
      sha256 "54b031ba19d4d293f1cc1aa7bcf27978a4192e31ceba3714b228ce85ed6a06af"
    end
    if Hardware::CPU.intel?
      url "https://github.com/EthanBlackburn/tangent/releases/download/v0.3.2/tangent-cli-x86_64-apple-darwin.tar.xz"
      sha256 "87e1e861840c26c6b188ff232e3a48837a26e5ad667c54a3689aee4e63426e4f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/EthanBlackburn/tangent/releases/download/v0.3.2/tangent-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "68c77976a1781b18ac43d64457577618e09904ef5ae4388b828202094e0e8b9a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/EthanBlackburn/tangent/releases/download/v0.3.2/tangent-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0dbbd60032de56ff8baf4e581bf95eb873cab10a241e6ff64a8735157ca4e59a"
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
