"use strict";
/**
 * Tests for mint.json — JarvisOS Mintlify configuration
 *
 * Covers the structural and value changes introduced in this PR:
 *   - Logo and favicon paths updated to jarvis_logo.png
 *   - Color scheme changed to cyber-green palette (#39FF14 primary)
 *   - colors.background block removed
 *   - anchor gradient updated to cyan (#00F3FF)
 *   - Discord added to footerSocials
 *   - Navigation structure preserved (same groups and pages)
 *
 * Runs with: node tests/mint.test.js
 * No external dependencies required — uses Node.js built-in `assert`.
 */

const assert = require("assert");
const fs = require("fs");
const path = require("path");

// ---------------------------------------------------------------------------
// Load the config
// ---------------------------------------------------------------------------
const configPath = path.resolve(__dirname, "..", "mint.json");

// Strip BOM if present before parsing
let rawContent = fs.readFileSync(configPath, "utf8");
if (rawContent.charCodeAt(0) === 0xfeff) {
  rawContent = rawContent.slice(1);
}
const config = JSON.parse(rawContent);

// ---------------------------------------------------------------------------
// Simple test harness
// ---------------------------------------------------------------------------
let passed = 0;
let failed = 0;

function test(description, fn) {
  try {
    fn();
    console.log(`  ✓  ${description}`);
    passed++;
  } catch (err) {
    console.error(`  ✗  ${description}`);
    console.error(`     ${err.message}`);
    failed++;
  }
}

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

console.log("\nmint.json — logo and favicon\n");

test("logo.dark is jarvis_logo.png (not cube_logo.png)", () => {
  assert.strictEqual(config.logo.dark, "/logo/jarvis_logo.png");
});

test("logo.light is jarvis_logo.png (not cube_logo.png)", () => {
  assert.strictEqual(config.logo.light, "/logo/jarvis_logo.png");
});

test("favicon is jarvis_logo.png", () => {
  assert.strictEqual(config.favicon, "/logo/jarvis_logo.png");
});

test("logo.dark does not reference the old cube_logo.png", () => {
  assert.ok(
    !config.logo.dark.includes("cube_logo"),
    `Expected no 'cube_logo' in logo.dark, got: ${config.logo.dark}`
  );
});

// ---------------------------------------------------------------------------
console.log("\nmint.json — color scheme (cyber-green palette)\n");

test("primary color is cyber-lime #39FF14", () => {
  assert.strictEqual(config.colors.primary.toUpperCase(), "#39FF14");
});

test("light color is #8FFF75", () => {
  assert.strictEqual(config.colors.light.toUpperCase(), "#8FFF75");
});

test("dark color is #1A8A00", () => {
  assert.strictEqual(config.colors.dark.toUpperCase(), "#1A8A00");
});

test("primary color is NOT the old orange #FF6B00", () => {
  assert.notStrictEqual(config.colors.primary.toUpperCase(), "#FF6B00");
});

test("anchor gradient 'from' is cyber-lime #39FF14", () => {
  assert.strictEqual(config.colors.anchors.from.toUpperCase(), "#39FF14");
});

test("anchor gradient 'to' is cyber-cyan #00F3FF", () => {
  assert.strictEqual(config.colors.anchors.to.toUpperCase(), "#00F3FF");
});

test("anchor gradient 'to' is NOT the old amber #FFB800", () => {
  assert.notStrictEqual(config.colors.anchors.to.toUpperCase(), "#FFB800");
});

test("colors.background block has been removed", () => {
  assert.strictEqual(
    config.colors.background,
    undefined,
    "colors.background should not exist in the new config"
  );
});

// ---------------------------------------------------------------------------
console.log("\nmint.json — footer socials\n");

test("footerSocials contains a github entry", () => {
  assert.ok(
    config.footerSocials.github,
    "footerSocials.github should be present"
  );
});

test("footerSocials.github points to the JarvisOS repository", () => {
  assert.strictEqual(
    config.footerSocials.github,
    "https://github.com/PsProsen-Dev/JarvisOS"
  );
});

test("footerSocials contains a discord entry (new in this PR)", () => {
  assert.ok(
    config.footerSocials.discord,
    "footerSocials.discord should be present after this PR"
  );
});

test("footerSocials.discord is a non-empty string", () => {
  assert.strictEqual(typeof config.footerSocials.discord, "string");
  assert.ok(
    config.footerSocials.discord.length > 0,
    "footerSocials.discord should not be empty"
  );
});

// ---------------------------------------------------------------------------
console.log("\nmint.json — navigation structure preserved\n");

test("navigation contains exactly 3 groups", () => {
  assert.strictEqual(config.navigation.length, 3);
});

test("first navigation group is 'Getting Started'", () => {
  assert.strictEqual(config.navigation[0].group, "Getting Started");
});

test("'Getting Started' group contains docs/introduction", () => {
  assert.ok(
    config.navigation[0].pages.includes("docs/introduction"),
    "Missing docs/introduction in Getting Started"
  );
});

test("'Getting Started' group contains docs/installation/getting-started", () => {
  assert.ok(
    config.navigation[0].pages.includes("docs/installation/getting-started"),
    "Missing docs/installation/getting-started"
  );
});

test("second navigation group is 'Core Tools'", () => {
  assert.strictEqual(config.navigation[1].group, "Core Tools");
});

test("'Core Tools' group contains docs/features/privacy-plus-cli", () => {
  assert.ok(
    config.navigation[1].pages.includes("docs/features/privacy-plus-cli"),
    "Missing docs/features/privacy-plus-cli in Core Tools"
  );
});

test("third navigation group is 'Support'", () => {
  assert.strictEqual(config.navigation[2].group, "Support");
});

test("'Support' group contains docs/support/faq and docs/support/troubleshooting", () => {
  assert.ok(
    config.navigation[2].pages.includes("docs/support/faq"),
    "Missing docs/support/faq"
  );
  assert.ok(
    config.navigation[2].pages.includes("docs/support/troubleshooting"),
    "Missing docs/support/troubleshooting"
  );
});

// ---------------------------------------------------------------------------
console.log("\nmint.json — required top-level fields\n");

test("config has a $schema field", () => {
  assert.ok(config["$schema"], "Missing $schema field");
});

test("config name is 'JarvisOS'", () => {
  assert.strictEqual(config.name, "JarvisOS");
});

test("topbarCtaButton download URL points to GitHub releases", () => {
  assert.strictEqual(
    config.topbarCtaButton.url,
    "https://github.com/PsProsen-Dev/JarvisOS/releases/latest"
  );
});

test("tabs array has an Overview tab", () => {
  const overviewTab = config.tabs.find((t) => t.name === "Overview");
  assert.ok(overviewTab, "No Overview tab found in tabs");
});

test("tabs array has a Features tab", () => {
  const featuresTab = config.tabs.find((t) => t.name === "Features");
  assert.ok(featuresTab, "No Features tab found in tabs");
});

// Regression: ensure the config is valid JSON (i.e., parsing succeeded)
test("file parses as valid JSON (regression — BOM does not break parsing)", () => {
  // If we reached this point, JSON.parse succeeded
  assert.ok(config !== null && typeof config === "object");
});

// ---------------------------------------------------------------------------
// Summary
// ---------------------------------------------------------------------------
console.log(`\n${"─".repeat(50)}`);
console.log(`Results: ${passed} passed, ${failed} failed`);
console.log("─".repeat(50));

if (failed > 0) {
  process.exit(1);
}