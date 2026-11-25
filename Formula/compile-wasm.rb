class CompileWasm < Formula
  desc "The compile-wasm application"
  homepage "https://github.com/EthanBlackburn/tangent"
  version "0.3.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/EthanBlackburn/tangent/releases/download/v0.3.2/compile-wasm-aarch64-apple-darwin.tar.xz"
      sha256 "a15471af91d1ff84dc85587509825edb9f7612e17d9c8e450b4f7833602d1776"
    end
    if Hardware::CPU.intel?
      url "https://github.com/EthanBlackburn/tangent/releases/download/v0.3.2/compile-wasm-x86_64-apple-darwin.tar.xz"
      sha256 "295c8796c39f9b7190f4246390607424c8fd811340633ab8bd3aae075939c725"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/EthanBlackburn/tangent/releases/download/v0.3.2/compile-wasm-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "339d5edef414dc6c06bc211197734a3d4a875538d184ca88781b91d18d3431fb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/EthanBlackburn/tangent/releases/download/v0.3.2/compile-wasm-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "702f6daf7fac770a7f266957a536564f8e3b99b2a355274841121d495c5a2242"
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
