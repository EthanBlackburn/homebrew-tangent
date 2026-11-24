class TangentRuntime < Formula
  desc "The tangent-runtime application"
  homepage "https://github.com/EthanBlackburn/tangent"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/EthanBlackburn/tangent/releases/download/v0.3.0/tangent-runtime-aarch64-apple-darwin.tar.xz"
      sha256 "a0a70ce883319d1ea608198812d120643f6bae8e773ae04fe92f58074732ce3e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/EthanBlackburn/tangent/releases/download/v0.3.0/tangent-runtime-x86_64-apple-darwin.tar.xz"
      sha256 "b90755919fa4365f2b7fc738a7b2435e8c14740ff8a328bce69eb3bb2b4825ce"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/EthanBlackburn/tangent/releases/download/v0.3.0/tangent-runtime-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6d3d3493e5f5f580767fe78c7f7a31303d467cf5746e3482322cb57f0abf5f63"
    end
    if Hardware::CPU.intel?
      url "https://github.com/EthanBlackburn/tangent/releases/download/v0.3.0/tangent-runtime-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d8a94afe62c45d1ed90c566e406d3075b7aa69be119a82f2eb7b62e79eab8507"
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
