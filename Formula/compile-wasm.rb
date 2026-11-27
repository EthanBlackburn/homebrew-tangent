class CompileWasm < Formula
  desc "The compile-wasm application"
  homepage "https://github.com/EthanBlackburn/tangent"
  version "0.3.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/EthanBlackburn/tangent/releases/download/v0.3.4/compile-wasm-aarch64-apple-darwin.tar.xz"
      sha256 "bf20169270b70590d73ecb6d89fbe88d580dea5b177cfb98344f89742d7cf232"
    end
    if Hardware::CPU.intel?
      url "https://github.com/EthanBlackburn/tangent/releases/download/v0.3.4/compile-wasm-x86_64-apple-darwin.tar.xz"
      sha256 "de95a917416274469af77abeb1a55135079812a91e3d96fe148e690dbcf88926"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/EthanBlackburn/tangent/releases/download/v0.3.4/compile-wasm-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "490705e9dc06af9d156c854378acf005597514131cbfd51d408a3c4f7d6c6bf1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/EthanBlackburn/tangent/releases/download/v0.3.4/compile-wasm-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b0e6c4cb50d13ac560b451f16ae0f3388ca187a288a29b534c84812420481b85"
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
      bin.install "compile-wasm"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "compile-wasm"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "compile-wasm"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "compile-wasm"
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
