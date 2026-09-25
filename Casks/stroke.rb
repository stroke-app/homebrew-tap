cask "stroke" do
  arch arm: "aarch64", intel: "x64"

  version "2.1.1"

  on_arm do
    sha256 "e9d5dd489b3ff99a2add9f6fb45a20f870a360846695580892856bc0541facb5"
  end
  on_intel do
    sha256 "e2f3108ac9c2f6bb06e7203a960ce2d66df74d726fef67a841e6df12d2d67a26"
  end

  url "https://github.com/stroke-app/stroke/releases/download/v#{version}/stroke_#{version}_#{arch}.dmg"
  name "Stroke"
  desc "Fast desktop database client for PostgreSQL, MySQL, SQLite, and Cloudflare D1"
  homepage "https://github.com/stroke-app/stroke"

  app "Stroke.app"

  # Stroke is ad-hoc signed (no paid Apple Developer cert), so strip the
  # quarantine flag Homebrew applies on download. Without this, Gatekeeper
  # shows "Stroke is damaged and can't be opened."
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-cr", "#{appdir}/Stroke.app"]
  end

  zap trash: [
    "~/Library/Application Support/com.broisnischal.stroke",
    "~/Library/Caches/com.broisnischal.stroke",
    "~/Library/Preferences/com.broisnischal.stroke.plist",
    "~/Library/Saved Application State/com.broisnischal.stroke.savedState",
  ]
end
