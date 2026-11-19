cask "stroke" do
  arch arm: "aarch64", intel: "x64"

  version "3.0.0"

  on_arm do
    sha256 "47c01d767a7cd193872c4be285d8eb7260e457b2122e82915ef4dfe20d37c20a"
  end
  on_intel do
    sha256 "fe51f75a20f25f0dc8526b51ec1c13c094d94b3152f7f55d977c935c83cf8401"
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
