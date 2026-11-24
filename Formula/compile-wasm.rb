class CompileWasm < Formula
  desc "The compile-wasm application"
  homepage "https://github.com/EthanBlackburn/tangent"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/EthanBlackburn/tangent/releases/download/v0.3.0/compile-wasm-aarch64-apple-darwin.tar.xz"
      sha256 "adabc109b1ff6c4925530c8ceca2f1b99cdf1c75dd2bbe0540ad172a01bf0df1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/EthanBlackburn/tangent/releases/download/v0.3.0/compile-wasm-x86_64-apple-darwin.tar.xz"
      sha256 "96ceae9e92f1da9e5ba77fbb6cf2236ab6e314539c62f417cfd477ea924279b3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/EthanBlackburn/tangent/releases/download/v0.3.0/compile-wasm-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d20dd84bfbdd10f985abadf0f379f0e6859762e1d1b03505cf863cf6d1d32b2e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/EthanBlackburn/tangent/releases/download/v0.3.0/compile-wasm-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0a09acff2c8ade9c7ae8f447844f57feb75a93fc2611eceaf7acdf4c4527053f"
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
