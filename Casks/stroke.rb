cask "stroke" do
  arch arm: "aarch64", intel: "x64"

  version "2.2.5"

  on_arm do
    sha256 "a7050dbb54aa1bb9b8f706e02e3c23975d56add2670e30cad36ab90f2e09c500"
  end
  on_intel do
    sha256 "aa256d33a754a8b812c81aa67efdc88ec5646e457def199f16a1caddd38dbf45"
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
