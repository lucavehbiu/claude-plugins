# Changelog

All notable changes to the team-workspace-setup plugin will be documented in this file.

## [1.1.0] - 2026-02-05

### Fixed
- **Skills structure**: Reorganized skills from flat `.md` files to proper subdirectory structure
  - Each skill now in its own directory: `skills/<skill-name>/SKILL.md`
  - This fixes the issue where skills were not being recognized by Claude Code
  - Affected skills: context, format, puppeter, serena

### Added
- **3 new MCP servers**:
  - `context7`: Latest library documentation (requires UPSTASH_CONTEXT7_TOKEN)
  - `serena`: Code analysis and refactoring (no config needed)
  - `playwright`: Browser automation for testing (no config needed)
- **Verification script**: `verify-setup.sh` to check plugin installation
- **Enhanced documentation**:
  - Updated MCP-SETUP.md with all 7 MCP servers
  - Clear indication of which MCPs need environment variables
  - Better troubleshooting guidance

### Changed
- Updated README.md to reflect 7 MCP servers (up from 4)
- Improved MCP-SETUP.md with clearer instructions
- Plugin description now mentions "4 skills, 7 MCP servers"

### Technical Details
**Skills Structure Before:**
```
skills/
├── context.md
├── format.md
├── puppeter.md
└── serena.md
```

**Skills Structure After:**
```
skills/
├── context/
│   └── SKILL.md
├── format/
│   └── SKILL.md
├── puppeter/
│   └── SKILL.md
└── serena/
    └── SKILL.md
```

## [1.0.0] - 2026-02-05

### Initial Release
- 4 custom skills (context, format, puppeter, serena)
- 4 MCP servers (brave-search, postgres, filesystem, memory)
- Sound notification on stop
- Team-standardized configurations
