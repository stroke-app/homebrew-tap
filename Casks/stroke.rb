cask "stroke" do
  arch arm: "aarch64", intel: "x64"

  version "2.0.0"

  on_arm do
    sha256 "c1b51c91ccafd5174b9f905e2b8ec7b9ae55c3c88dc513c6ba259a08ad3f0f1a"
  end
  on_intel do
    sha256 "107a3fa7c0cdf96f31a6a4f76848c45b521b1cc82c4f37f815c511152fe66d36"
  end

  url "https://github.com/broisnischal/stroke/releases/download/v#{version}/stroke_#{version}_#{arch}.dmg"
  name "Stroke"
  desc "Fast desktop database client for PostgreSQL, MySQL, SQLite, and Cloudflare D1"
  homepage "https://github.com/broisnischal/stroke"

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
