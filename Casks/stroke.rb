cask "stroke" do
  arch arm: "aarch64", intel: "x64"

  version "2.2.0"

  on_arm do
    sha256 "4c9af6d3b562f70f15d2febe436ef3ee426057c641a4d329e7d6cfdf5ec6e154"
  end
  on_intel do
    sha256 "b62891e7021a6efa4c26bbefe41c37ce6c715fc0de29a484135965f420587e1d"
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
