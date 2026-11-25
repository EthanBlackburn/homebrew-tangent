class CompileWasm < Formula
  desc "The compile-wasm application"
  homepage "https://github.com/EthanBlackburn/tangent"
  version "0.3.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/EthanBlackburn/tangent/releases/download/v0.3.1/compile-wasm-aarch64-apple-darwin.tar.xz"
      sha256 "00034a5b458c44c74df2e446180af2f90dcab621526c856a1f37e64740dee671"
    end
    if Hardware::CPU.intel?
      url "https://github.com/EthanBlackburn/tangent/releases/download/v0.3.1/compile-wasm-x86_64-apple-darwin.tar.xz"
      sha256 "160a60bf2485e9cf9f38791cd21709f852410bfb6a7f86d4ef5235fdfcc6d75a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/EthanBlackburn/tangent/releases/download/v0.3.1/compile-wasm-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c722db286c88380c752c614157eeaf83d4b7b629fea83cfb9c7fec157473ba7c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/EthanBlackburn/tangent/releases/download/v0.3.1/compile-wasm-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f5d528873244bf656a651145fe8a232944a603ed53c91b93591bd2b7e77bcce5"
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
