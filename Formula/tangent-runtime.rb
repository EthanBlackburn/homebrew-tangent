class TangentRuntime < Formula
  desc "The tangent-runtime application"
  homepage "https://github.com/EthanBlackburn/tangent"
  version "0.3.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/EthanBlackburn/tangent/releases/download/v0.3.2/tangent-runtime-aarch64-apple-darwin.tar.xz"
      sha256 "7e9468019059b66d094dc6d207e5c5cb9c58a65a618da92e6da42cd6b7192c49"
    end
    if Hardware::CPU.intel?
      url "https://github.com/EthanBlackburn/tangent/releases/download/v0.3.2/tangent-runtime-x86_64-apple-darwin.tar.xz"
      sha256 "56be3293953a8d1a940b82891121d7e339f6cb29bcbcb07bddd70bc2fbd81874"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/EthanBlackburn/tangent/releases/download/v0.3.2/tangent-runtime-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3d34a9397f631f72d42954119b447eca64304991bd9f099884f06e9623d27375"
    end
    if Hardware::CPU.intel?
      url "https://github.com/EthanBlackburn/tangent/releases/download/v0.3.2/tangent-runtime-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "fcc5d73254a5303041398a7ed621340fe411c9a03f4197dc6fd4e48c24b47d74"
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
