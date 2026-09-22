// Renders Casks/stroke.rb from version + per-arch sha256.
// Usage: VERSION=.. ARM_SHA=.. INTEL_SHA=.. node scripts/render-cask.mjs
import fs from 'node:fs'

const { VERSION, ARM_SHA, INTEL_SHA } = process.env
if (!VERSION || !ARM_SHA || !INTEL_SHA) {
  console.error('VERSION, ARM_SHA and INTEL_SHA are required')
  process.exit(1)
}

const cask = `cask "stroke" do
  arch arm: "aarch64", intel: "x64"

  version "${VERSION}"

  on_arm do
    sha256 "${ARM_SHA}"
  end
  on_intel do
    sha256 "${INTEL_SHA}"
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
`

fs.writeFileSync('Casks/stroke.rb', cask)
console.log(`Rendered Casks/stroke.rb for ${VERSION}`)
