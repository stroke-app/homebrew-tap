cask "stroke" do
  arch arm: "aarch64", intel: "x64"

  version "2.3.0"

  on_arm do
    sha256 "1e9433a815af984a6ef4abf394d711c62f2e88f4f6b6c0c19a0a2b77a65729fd"
  end
  on_intel do
    sha256 "3d6a7830dceb7201bfcba4442ae3cde1b1487601528e8c1c7a80f7180b4b71b2"
  end

  url "https://github.com/stroke-app/stroke/releases/download/v#{version}/stroke_#{version}_#{arch}.dmg"
  name "Stroke"
  desc "Fast desktop database client for PostgreSQL, MySQL, SQLite, and Cloudflare D1"
  homepage "https://github.com/stroke-app/stroke"

  # Stroke updates itself in place, so `brew upgrade` leaves it alone instead
  # of reinstalling over a newer build the app already put there.
  auto_updates true

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
