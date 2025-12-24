# Mars.nvim AI Integration Analysis Report

**Project**: mars.nvim
**Date**: 2025-12-23
**Subject**: AI-Powered Development Tools Integration Analysis

---

## Table of Contents

1. [Executive Summary](#executive-summary)
2. [Claude Code Integration](#1-claude-code-integration)
3. [Gemini AI Integration](#2-gemini-ai-integration)
4. [Supermaven Integration](#3-supermaven-integration)
5. [Tool Comparison Matrix](#tool-comparison-matrix)
6. [Integration Architecture](#integration-architecture)
7. [Configuration Reference](#configuration-reference)
8. [Usage Scenarios](#usage-scenarios)
9. [Appendix: Key Bindings](#appendix-key-bindings)

---

## Executive Summary

Mars.nvim integrates three distinct AI-powered development tools, each designed for different use cases in the software development workflow:

| Tool | Primary Purpose | Interaction Model | Response Time |
|------|-----------------|-------------------|---------------|
| **Claude Code** | Complex, multi-step tasks | Embedded terminal | Medium (streaming) |
| **Gemini AI** | Diagnostic-driven fixes | Sidebar chat | Medium |
| **Supermaven** | Real-time code completion | Inline ghost text | Ultra-fast (<100ms) |

These tools are designed to be **complementary**, not competitive. They cover the entire spectrum of AI-assisted development:
- **High-frequency, low-latency** needs (Supermaven)
- **Diagnostic-driven** problem solving (Gemini AI)
- **Complex, project-wide** operations (Claude Code)

---

## 1. Claude Code Integration

### 1.1 Overview

**Plugin**: `coder/claudecode.nvim`
**Purpose**: Full-featured AI pair programming through embedded terminal
**External Dependency**: Claude Code CLI (must be installed separately)

### 1.2 Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                        Neovim Editor Interface                 │
├─────────────────────────────────────────────────────────────────┤
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────────────────┐│
│  │ Code Buffer │  │ File Tree   │  │   Claude Code Terminal  ││
│  │             │  │ (neo-tree)  │  │   (Floating/Sidebar)    ││
│  │  function() │  │             │  │                         ││
│  │  {         │  │ 📁 src/     │  │ $ Explain this code...   ││
│  │    ...     │  │ 📄 main.lua │  │ > [AI streaming response]││
│  │  }         │  │             │  │                         ││
│  └─────────────┘  └─────────────┘  └─────────────────────────┘│
│         │                │                      │              │
│         └────────────────┼──────────────────────┘              │
│                          ▼                                     │
│              ┌─────────────────────────────┐                   │
│              │    snacks.nvim              │                   │
│              │  (Terminal Emulation)       │                   │
│              └─────────────────────────────┘                   │
└─────────────────────────────────────────────────────────────────┘
                          │
                          ▼
              ┌─────────────────────────────┐
              │    Claude Code CLI          │
              │  (System-level tool)        │
              │  - Full API access          │
              │  - File operations          │
              │  - Multi-turn conversation  │
              └─────────────────────────────┘
```

### 1.3 Configuration Breakdown

```lua
{
  'coder/claudecode.nvim',
  dependencies = {
    'folke/snacks.nvim',  -- Terminal rendering engine
  },
  config = true,
  opts = {
    terminal = {
      snacks_win_opts = {
        wo = {
          winblend = 100,  -- 100% transparency (fully transparent)
          winhighlight = 'NormalFloat:MyTransparentGroup',
        },
      },
    },
  },
  terminal = { enabled = true },  -- Enable terminal mode
  keys = { ... }
}
```

**Configuration Details**:

| Setting | Value | Purpose |
|---------|-------|---------|
| `winblend` | `100` | Makes terminal window fully transparent, blending with background |
| `winhighlight` | `NormalFloat:MyTransparentGroup` | Links float window to custom transparent highlight group |
| `terminal.enabled` | `true` | Enables terminal-based integration (vs. alternative modes) |

### 1.4 Workflow

```
┌─────────────────────────────────────────────────────────────────────┐
│                      Claude Code Workflow                          │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│  1. INITIATION                                                      │
│     User presses <leader>cc                                         │
│     → Triggers :ClaudeCode command                                  │
│     → snacks.nvim creates floating terminal window                  │
│     → Claude Code CLI starts in terminal                            │
│                                                                     │
│  2. ADDING CONTEXT                                                  │
│     <leader>cb       → Add current buffer to context                │
│     <leader>cs (v)  → Send visual selection to Claude               │
│     <leader>cs       → Add file from file tree (neo-tree, etc.)     │
│                                                                     │
│  3. INTERACTION                                                     │
│     User types in terminal                                          │
│     → CLI sends request to Claude API                               │
│     → Response streams back in real-time                            │
│                                                                     │
│  4. APPLYING SUGGESTIONS                                            │
│     <leader>ca  → Accept suggested diff                             │
│     <leader>cd  → Deny suggested diff                               │
│                                                                     │
│  5. SESSION MANAGEMENT                                              │
│     <leader>cr  → Resume previous conversation                      │
│     <leader>cC  → Continue last request                             │
│     <leader>cm  → Select different Claude model                     │
│     <leader>cf  → Focus (jump to) Claude terminal                   │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

### 1.5 Key Features

| Feature | Description |
|---------|-------------|
| **Full CLI Access** | Complete Claude Code CLI functionality available |
| **Project-Wide Context** | Can add multiple files/buffers to context |
| **Diff Workflow** | Suggested changes shown as diffs, accept/deny individually |
| **Session Persistence** | Conversations saved, can resume later |
| **Model Selection** | Switch between Claude models (Haiku, Sonnet, Opus) |
| **Transparent UI** | Blends seamlessly with Tokyo Night theme |

### 1.6 Use Cases

- **Refactoring**: Complex multi-file refactoring with detailed planning
- **Code Generation**: Generate new features from scratch
- **Debugging**: Analyze logs, trace errors, propose fixes
- **Documentation**: Generate comprehensive docs for existing code
- **Test Generation**: Create unit tests based on code analysis
- **Code Reviews**: Get AI feedback on pull requests or code changes

---

## 2. Gemini AI Integration

### 2.1 Overview

**Plugin**: `nvim-gemini-companion` (local development)
**Purpose**: Diagnostic-driven AI assistance via sidebar
**External Dependency**: Google Gemini API key

### 2.2 Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│  ┌──────────┐  ┌──────────────────┐  ┌─────────────────────┐   │
│  │ Code     │  │  Gemini Sidebar  │  │                     │   │
│  │ Buffer   │  │                  │  │                     │   │
│  │          │  │ ┌──────────────┐ │  │                     │   │
│  │ const x  │  │ │ Chat History │ │  │                     │   │
│  │   = 1    │  │ │              │ │  │                     │   │
│  │          │  │ │ User: Fix    │ │  │                     │   │
│  │          │  │ │ AI: ...      │ │  │                     │   │
│  │          │  │ │              │ │  │                     │   │
│  │          │  │ │ [Code Sugg]  │ │  │                     │   │
│  │          │  │ └──────────────┘ │  │                     │   │
│  └──────────┘  └──────────────────┘  └─────────────────────┘   │
│       │                                    ▲                     │
│       │                                    │                     │
│       │    ┌────────────────────────────────┘                    │
│       │    │                                                │
│       ▼    ▼                                                │
│  ┌─────────────────────────────────────────────────────────┐    │
│  │              nvim-gemini-companion                       │    │
│  │  - plenary.nvim (async utilities)                       │    │
│  │  - LSP diagnostic integration                           │    │
│  │  - Diff application system                              │    │
│  └─────────────────────────────────────────────────────────┘    │
│                            │                                     │
│                            ▼                                     │
│  ┌─────────────────────────────────────────────────────────┐    │
│  │              Google Gemini API                           │    │
│  └─────────────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────────────┘
```

### 2.3 Configuration Breakdown

```lua
{
  dir = '~/Code/nvim-gemini-companion',  -- Local plugin development
  name = 'nvim-gemini-companion',
  dependencies = { 'nvim-lua/plenary.nvim' },  -- Async library
  event = 'VeryLazy',  -- Load after startup
  config = function()
    require('gemini').setup()
  end,
  keys = {
    { '<leader>g', nil, desc = 'Gemini Code' },
    { '<leader>gg', '<cmd>GeminiToggle<cr>', desc = 'Toggle sidebar' },
    { '<leader>gc', '<cmd>GeminiSwitchToCli<cr>', desc = 'Spawn/switch session' },
    { '<leader>gd', '<cmd>GeminiSendLineDiagnostic<cr>', mode = 'n', desc = 'Send diagnostic' },
    { '<leader>gD', '<cmd>GeminiSendFileDiagnostic<cr>', mode = 'n', desc = 'Send file diagnostics' },
    { '<leader>ga', '<cmd>GeminiAccept<cr>', mode = 'n', desc = 'Accept diff' },
    { '<leader>gd', '<cmd>GeminiDeny<cr>', mode = 'n', desc = 'Deny diff' },
    { '<leader>gs', '<cmd>GeminiSend<cr>', mode = { 'v' }, desc = 'Send selection' },
  },
}
```

**Configuration Details**:

| Setting | Value | Purpose |
|---------|-------|---------|
| `dir` | `~/Code/nvim-gemini-companion` | Loads plugin from local path (active development) |
| `event` | `VeryLazy` | Defers loading until after initial startup for faster boot |
| `dependencies.plenary.nvim` | - | Provides async utilities and HTTP client |

### 2.4 Workflow

```
┌─────────────────────────────────────────────────────────────────────┐
│                       Gemini AI Workflow                           │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│  1. TOGGLE SIDEBAR                                                  │
│     <leader>gg                                                      │
│     → Opens/closes Gemini sidebar window                            │
│     → Sidebar maintains conversation history                        │
│                                                                     │
│  2. SENDING CONTEXT                                                 │
│     ┌─────────────────────────────────────────────────────────┐    │
│     │ Method              Key              Content             │    │
│     ├─────────────────────────────────────────────────────────┤    │
│     │ Visual selection   <leader>gs      Selected code        │    │
│     │ Line diagnostic    <leader>gd      Current line + LSP   │    │
│     │ File diagnostic    <leader>gD      All file diagnostics │    │
│     │ CLI session        <leader>gc      Switch to AI session │    │
│     └─────────────────────────────────────────────────────────┘    │
│                                                                     │
│  3. DIAGNOSTIC INTEGRATION                                          │
│     LSP detects error → User presses <leader>gd → Error context    │
│     automatically sent to Gemini → AI provides fix                  │
│                                                                     │
│  4. APPLYING SUGGESTIONS                                            │
│     <leader>ga  → Accept suggested change                           │
│     <leader>gd  → Deny suggested change                             │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

### 2.5 Key Features

| Feature | Description |
|---------|-------------|
| **Diagnostic Integration** | Directly sends LSP diagnostics to AI |
| **Sidebar Chat** | Persistent conversation history |
| **Local Development** | Plugin loaded from local path (customizable) |
| **Multi-Modal Input** | Selections, diagnostics, or manual prompts |
| **Diff Workflow** | Accept/deny individual suggestions |
| **Session Management** | Multiple AI sessions possible |

### 2.6 Use Cases

- **Error Fixing**: Send LSP diagnostics directly for quick fixes
- **Code Explanation**: Get explanations for selected code snippets
- **Simple Refactoring**: Small-scale code improvements
- **Learning**: Understand why certain diagnostics are raised
- **Quick Questions**: Simple coding questions without leaving editor

---

## 3. Supermaven Integration

### 3.1 Overview

**Plugin**: `supermaven-inc/supermaven-nvim`
**Purpose**: Ultra-fast AI code completion
**External Dependency**: Supermaven account (API service)

### 3.2 Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│  USER INPUT                                                      │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │ function calculateSum(a, b) {                            │  │
│  │   return a + b│  ← Cursor position                       │  │
│  │ }                                           ← Ghost text │  │
│  └──────────────────────────────────────────────────────────┘  │
│                    ▲                                             │
│                    │                                             │
│  ┌─────────────────────────────────────────────────────────┐    │
│  │  Supermaven Background Engine                           │    │
│  │  ┌─────────────────────────────────────────────────┐    │    │
│  │  │ Context Analysis:                                │    │    │
│  │  │ - Current file content                           │    │    │
│  │  │ - Syntax tree (Treesitter)                       │    │    │
│  │  │ - Cross-file references                          │    │    │
│  │  │ - Coding patterns                                │    │    │
│  │  │                                                  │    │    │
│  │  │ Prediction Model:                                │    │    │
│  │  │ - Next token prediction                          │    │    │
│  │  │ - Indentation awareness                          │    │    │
│  │  │ - Semantic understanding                         │    │    │
│  │  └─────────────────────────────────────────────────┘    │    │
│  │                         │                                 │    │
│  │                         ▼                                 │    │
│  │  ┌─────────────────────────────────────────────────┐    │    │
│  │  │ Inline Ghost Text Rendering                     │    │    │
│  │  │ - Color: #ffffff (white)                        │    │    │
│  │  │ - Style: Virtual/ghost text                     │    │    │
│  │  │ - Accept: <Tab> or continue typing             │    │    │
│  │  │ - Dismiss: <Esc> or different token            │    │    │
│  │  └─────────────────────────────────────────────────┘    │    │
│  └─────────────────────────────────────────────────────────┘    │
│                                                                  │
│  INTEGRATION WITH COMPLETION SYSTEM:                             │
│  ┌──────────────────────────────────────────────┐              │
│  │ ┌─────────┐ ┌─────────┐ ┌─────────────────┐ │              │
│  │ │  LSP    │ │Snippets │ │  Supermaven     │ │              │
│  │ │Completion│ │         │ │  (Independent)  │ │              │
│  │ └─────────┘ └─────────┘ └─────────────────┘ │              │
│  │            ↓                                 │              │
│  │     ┌─────────────────┐                     │              │
│  │     │   blink.cmp     │ ← Main completion   │              │
│  │     │   (UI Layer)    │   menu for LSP      │              │
│  │     └─────────────────┘                     │              │
│  └──────────────────────────────────────────────┘              │
│                                                                  │
│  Note: Supermaven renders INDEPENDENTLY of blink.cmp menu       │
└─────────────────────────────────────────────────────────────────┘
```

### 3.3 Configuration Breakdown

```lua
{
  'saghen/blink.cmp',              -- Main completion engine
  version = '1.*',
  event = 'VimEnter',
  dependencies = {
    {
      'supermaven-inc/supermaven-nvim',
      config = function()
        require('supermaven-nvim').setup {
          color = {
            suggestion_color = '#ffffff',  -- White ghost text
          },
        }
      end,
    },
    -- Other dependencies: LuaSnip, lazydev, etc.
  },
  opts = {
    keymap = {
      preset = 'default',
      ['<C-s>'] = { 'show', 'show_signature', 'hide_signature' },
      ['<C-l>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<C-e>'] = { 'hide', 'show' },
      ['<C-j>'] = { 'select_next', 'fallback' },
      ['<C-k>'] = { 'select_prev', 'fallback' },
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'lazydev' },
      providers = {
        lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
      },
      -- NOTE: supermaven is NOT in sources list
      -- It operates independently, rendering ghost text directly
    },
  },
}
```

**Configuration Details**:

| Setting | Value | Purpose |
|---------|-------|---------|
| `suggestion_color` | `#ffffff` | White color for ghost text suggestions |
| **NOT in** `sources.default` | - | Supermaven operates independently from blink.cmp's source system |
| Dependency relationship | Supermaven → blink.cmp | Only for plugin loading order, not for completion routing |

### 3.4 Workflow

```
┌─────────────────────────────────────────────────────────────────────┐
│                      Supermaven Workflow                           │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│  1. USER TYPES IN INSERT MODE                                      │
│     function calculateSum(                                         │
│       return a + [CURSOR HERE]                                     │
│                                                                     │
│  2. BACKGROUND ANALYSIS (instant, < 50ms)                          │
│     Supermaven engine analyzes:                                    │
│     - Current function signature                                   │
│     - Variable types (a, b are numbers)                            │
│     - Common patterns for "sum" functions                          │
│     - Indentation and style                                        │
│                                                                     │
│  3. GHOST TEXT APPEARS                                             │
│     function calculateSum(                                         │
│       return a + b;                                               │
│     }                                                               │
│     [^^^^^^^ ← Ghost text in white]                                │
│                                                                     │
│  4. USER ACTION                                                     │
│     ┌─────────────────────────────────────────────────────────┐    │
│     │ Action              Result                              │    │
│     ├─────────────────────────────────────────────────────────┤    │
│     │ Press <Tab>         Accept ghost text                   │    │
│     │ Continue typing     Accept + keep typing                │    │
│     │ Press <Esc>         Dismiss ghost text                  │    │
│     │ Type different char Dismiss + insert new char           │    │
│     └─────────────────────────────────────────────────────────┘    │
│                                                                     │
│  5. SEAMLESS INTEGRATION                                            │
│     No disruption to typing flow                                   │
│     No popup menu to navigate                                      │
│     Just-in-time suggestions                                       │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

### 3.5 Key Features

| Feature | Description |
|---------|-------------|
| **Sub-100ms Response** | Suggestions appear almost instantly |
| **Inline Rendering** | Ghost text, not popup menu |
| **Context-Aware** | Understands code semantics, not just patterns |
| **Cross-File Awareness** | Uses project-wide context for predictions |
| **Zero Disruption** | Doesn't interrupt typing flow |
| **Independent Operation** | Works separately from LSP completion |

### 3.6 Use Cases

- **Boilerplate Completion**: Function bodies, class definitions
- **Pattern Matching**: Completes repetitive code structures
- **API Usage**: Suggests correct method parameters
- **Statement Completion**: Finishes if-statements, loops, etc.
- **Idiomatic Code**: Suggests language-specific patterns

---

## Tool Comparison Matrix

### Functional Comparison

| Dimension | Claude Code | Gemini AI | Supermaven |
|-----------|-------------|-----------|------------|
| **Primary Mode** | Terminal | Sidebar | Inline |
| **Initiation** | Manual (command) | Manual (toggle) | Automatic |
| **Input Method** | Terminal CLI | Chat interface | Typing context |
| **Response Style** | Streaming text | Chat messages | Ghost text |
| **Code Application** | Diff accept/deny | Diff accept/deny | Tab to accept |
| **Context Scope** | Project-wide | File/selection | File |
| **Session Persistence** | Yes | Yes | N/A |
| **Requires External Tool** | Yes (CLI) | No | No (account) |

### Performance Comparison

| Metric | Claude Code | Gemini AI | Supermaven |
|--------|-------------|-----------|------------|
| **Response Time** | 1-5s (streaming) | 1-3s | <100ms |
| **Startup Time** | ~500ms (CLI init) | ~300ms | Instant |
| **Memory Impact** | Medium (terminal) | Low-Medium | Low |
| **Network Usage** | High (full context) | Medium | Low (tokens only) |

### Use Case Fit

| Scenario | Best Tool | Rationale |
|----------|-----------|-----------|
| Quick typo fix | Supermaven | Fastest, inline |
| Explain complex function | Claude Code | Deep analysis |
| Fix LSP error | Gemini AI | Direct diagnostic integration |
| Generate new file | Claude Code | Full project context |
| Complete if-statement | Supermaven | Pattern matching |
| Debug complex issue | Claude Code | Multi-step reasoning |
| Quick code question | Gemini AI | Simple chat interface |
| Refactor across files | Claude Code | Project-wide operations |

---

## Integration Architecture

### System Overview

```
┌─────────────────────────────────────────────────────────────────────┐
│                        NEOVIM EDITOR                               │
│                        ┌─────────────────┐                         │
│                        │  Buffer Manager │                         │
│                        │  LSP Clients    │                         │
│                        │  Treesitter     │                         │
│                        └────────┬────────┘                         │
└─────────────────────────────────┼─────────────────────────────────┘
                                  │
        ┌─────────────────────────┼─────────────────────────┐
        │                         │                         │
        ▼                         ▼                         ▼
┌───────────────┐         ┌───────────────┐         ┌───────────────┐
│  Claude Code  │         │  Gemini AI    │         │  Supermaven   │
│  Integration  │         │  Integration  │         │  Integration  │
├───────────────┤         ├───────────────┤         ├───────────────┤
│ • snacks.nvim │         │ • Sidebar UI  │         │ • Inline API  │
│ • Terminal    │         │ • plenary.nvim│         │ • Ghost text  │
│ • CLI bridge  │         │ • LSP diag    │         │ • Independent │
└───────┬───────┘         └───────┬───────┘         └───────┬───────┘
        │                         │                         │
        ▼                         ▼                         ▼
┌───────────────┐         ┌───────────────┐         ┌───────────────┐
│ Claude Code   │         │ Gemini API    │         │ Supermaven    │
│ CLI           │         │               │         │ API           │
│ • File ops    │         │ • Chat        │         │ • Completion  │
│ • Agent mode  │         │ • Diagnostics │         │ • Prediction  │
│ • Full API    │         │ • Code gen    │         │ • Fast model  │
└───────────────┘         └───────────────┘         └───────────────┘
        │                         │                         │
        └─────────────────────────┴─────────────────────────┘
                                  │
                                  ▼
                        ┌───────────────────┐
                        │   User Workflow   │
                        │                   │
                        │ ┌─────────────┐   │
                        │ │ Supermaven  │   │ ← Continuous
                        │ │ (always on) │   │
                        │ └─────────────┘   │
                        │                   │
                        │ ┌─────────────┐   │
                        │ │ Gemini AI   │   │ ← Errors/Quick Qs
                        │ └─────────────┘   │
                        │                   │
                        │ ┌─────────────┐   │
                        │ │ Claude Code │   │ ← Complex tasks
                        │ └─────────────┘   │
                        └───────────────────┘
```

### Plugin Loading Order

```lua
-- From nvim/init.lua
-- Loading order ensures dependencies are available

1. Lazy.nvim (plugin manager)
   └─> 2. snacks.nvim (terminal engine)
       └─> 3. claudecode.nvim (depends on snacks)
   └─> 4. plenary.nvim (async utilities)
       └─> 5. nvim-gemini-companion (depends on plenary)
   └─> 6. blink.cmp (completion engine)
       └─> 7. supermaven-nvim (loaded with blink, operates independently)
```

### Keybinding Architecture

```
<leader> (Space)
    │
    ├── c (Claude Code)
    │   ├── cc  → Toggle terminal
    │   ├── cf  → Focus terminal
    │   ├── cr  → Resume conversation
    │   ├── cC  → Continue last request
    │   ├── cm  → Select model
    │   ├── cb  → Add buffer to context
    │   ├── cs  → Send selection (visual mode)
    │   ├── ca  → Accept diff
    │   └── cd  → Deny diff
    │
    ├── g (Gemini)
    │   ├── gg  → Toggle sidebar
    │   ├── gc  → Switch CLI session
    │   ├── gd  → Send line diagnostic
    │   ├── gD  → Send file diagnostics
    │   ├── ga  → Accept diff
    │   └── gs  → Send selection (visual mode)
    │
    └── (Supermaven: no keybindings, automatic)
```

---

## Configuration Reference

### File Locations

```
mars.nvim/
├── nvim/
│   ├── init.lua                    # Main entry point
│   │   ├── blink.cmp configuration # (lines 128-180)
│   │   └── supermaven setup        # (lines 148-156)
│   └── lua/mars/
│       └── plugins/
│           └── ai.lua              # Claude + Gemini configs
└── docs/
    └── ai-integration-analysis.md  # This document
```

### Complete AI Configuration

**File**: `nvim/lua/mars/plugins/ai.lua`

```lua
return {
  -- Claude Code Integration
  {
    'coder/claudecode.nvim',
    dependencies = { 'folke/snacks.nvim' },
    config = true,
    opts = {
      terminal = {
        snacks_win_opts = {
          wo = {
            winblend = 100,
            winhighlight = 'NormalFloat:MyTransparentGroup',
          },
        },
      },
    },
    terminal = { enabled = true },
    keys = {
      { '<leader>c', nil, desc = 'Claude Code' },
      { '<leader>cc', '<cmd>ClaudeCode<cr>', desc = 'Toggle Claude' },
      { '<leader>cf', '<cmd>ClaudeCodeFocus<cr>', desc = 'Focus Claude' },
      { '<leader>cr', '<cmd>ClaudeCode --resume<cr>', desc = 'Resume Claude' },
      { '<leader>cC', '<cmd>ClaudeCode --continue<cr>', desc = 'Continue Claude' },
      { '<leader>cm', '<cmd>ClaudeCodeSelectModel<cr>', desc = 'Select Claude model' },
      { '<leader>cb', '<cmd>ClaudeCodeAdd %<cr>', desc = 'Add current buffer' },
      { '<leader>cs', '<cmd>ClaudeCodeSend<cr>', mode = 'v', desc = 'Send to Claude' },
      { '<leader>ca', '<cmd>ClaudeCodeDiffAccept<cr>', desc = 'Accept diff' },
      { '<leader>cd', '<cmd>ClaudeCodeDiffDeny<cr>', desc = 'Deny diff' },
    },
  },

  -- Gemini AI Integration
  {
    dir = '~/Code/nvim-gemini-companion',
    name = 'nvim-gemini-companion',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = 'VeryLazy',
    config = function()
      require('gemini').setup()
    end,
    keys = {
      { '<leader>g', nil, desc = 'Gemini Code' },
      { '<leader>gg', '<cmd>GeminiToggle<cr>', desc = 'Toggle sidebar' },
      { '<leader>gc', '<cmd>GeminiSwitchToCli<cr>', desc = 'Spawn or switch to session' },
      { '<leader>gd', '<cmd>GeminiSendLineDiagnostic<cr>', mode = 'n', desc = 'Send diagnostic' },
      { '<leader>gD', '<cmd>GeminiSendFileDiagnostic<cr>', mode = 'n', desc = 'Send file diagnostics' },
      { '<leader>ga', '<cmd>GeminiAccept<cr>', mode = 'n', desc = 'Accept diff' },
      { '<leader>gs', '<cmd>GeminiSend<cr>', mode = { 'v' }, desc = 'Send selection' },
    },
  },
}
```

**File**: `nvim/init.lua` (Supermaven + blink.cmp)

```lua
{
  'saghen/blink.cmp',
  version = '1.*',
  event = 'VimEnter',
  dependencies = {
    'L3MON4D3/LuaSnip',
    'folke/lazydev.nvim',
    'saghen/blink.compat',
    {
      'supermaven-inc/supermaven-nvim',
      config = function()
        require('supermaven-nvim').setup {
          color = {
            suggestion_color = '#ffffff',
          },
        }
      end,
    },
  },
  opts = {
    keymap = {
      preset = 'default',
      ['<C-s>'] = { 'show', 'show_signature', 'hide_signature' },
      ['<C-l>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<C-e>'] = { 'hide', 'show' },
      ['<C-j>'] = { 'select_next', 'fallback' },
      ['<C-k>'] = { 'select_prev', 'fallback' },
    },
    appearance = {
      nerd_font_variant = 'mono',
    },
    completion = {
      documentation = { auto_show = false, auto_show_delay_ms = 500 },
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'lazydev' },
      providers = {
        lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
      },
    },
  },
},
```

### Theme Integration

All three tools integrate with the Tokyo Night theme:

```lua
-- From options.lua
vim.o.termguicolors = true
vim.cmd.colorscheme 'tokyonight'

-- Transparent background for Claude Code terminal
vim.api.nvim_set_hl(0, 'MyTransparentGroup', { link = 'Normal' })
```

---

## Usage Scenarios

### Scenario 1: Debugging a Complex Bug

**Problem**: Application crashes in production, logs show error in user authentication.

```
┌─────────────────────────────────────────────────────────────────────┐
│  Step 1: Gather Context                                            │
│  ─────────────────────────────────────────────────────────────────  │
│  • Use neo-tree to navigate to auth module                         │
│  • Read relevant files (auth.js, user.js, session.js)              │
│                                                                     │
│  Step 2: Initiate Claude Code                                      │
│  ─────────────────────────────────────────────────────────────────  │
│  <leader>cc                                                        │
│  • Terminal opens with Claude CLI                                  │
│  • <leader>cb on each file to add to context                       │
│                                                                     │
│  Step 3: Describe Problem                                          │
│  ─────────────────────────────────────────────────────────────────  │
│  "The app crashes with 'token expired' error. Here's the log: ..." │
│                                                                     │
│  Step 4: AI Analysis                                                │
│  ─────────────────────────────────────────────────────────────────  │
│  • Claude analyzes all added files                                  │
│  • Identifies race condition in token refresh logic                │
│  • Suggests fix with explanation                                   │
│                                                                     │
│  Step 5: Review and Apply                                          │
│  ─────────────────────────────────────────────────────────────────  │
│  • Review suggested diff                                           │
│  • <leader>ca to accept fix                                        │
│  • Run tests to verify                                             │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

### Scenario 2: Quick LSP Error Fix

**Problem**: TypeScript shows "Type 'string' is not assignable to type 'number'".

```
┌─────────────────────────────────────────────────────────────────────┐
│  Step 1: Notice Error                                              │
│  ─────────────────────────────────────────────────────────────────  │
│  • Red underline appears on line                                   │
│  • Cursor shows: "Type 'string' is not assignable to 'number'"     │
│                                                                     │
│  Step 2: Send to Gemini                                            │
│  ─────────────────────────────────────────────────────────────────  │
│  <leader>gg (toggle sidebar)                                       │
│  <leader>gd (send line diagnostic)                                 │
│                                                                     │
│  Step 3: Receive Fix                                               │
│  ─────────────────────────────────────────────────────────────────  │
│  Gemini: "The error occurs because parseId returns string but     │
│           count expects number. Fix: add parseInt()..."           │
│                                                                     │
│  Step 4: Apply Fix                                                  │
│  ─────────────────────────────────────────────────────────────────  │
│  • Review suggested change                                         │
│  • <leader>ga to accept                                            │
│  • Error disappears                                                │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

### Scenario 3: Writing Boilerplate Code

**Problem**: Need to create a new React component with props, state, and event handlers.

```
┌─────────────────────────────────────────────────────────────────────┐
│  Step 1: Start Typing                                              │
│  ─────────────────────────────────────────────────────────────────  │
│  function UserCard({ user }) {                                     │
│    const [isLoaded, setIsLoaded] = useState(false);               │
│                                                                     │
│  Step 2: Supermaven Suggests                                       │
│  ─────────────────────────────────────────────────────────────────  │
│  function UserCard({ user }) {                                     │
│    const [isLoaded, setIsLoaded] = useState(false);               │
│    useEffect(() => {                                              │
│       [Ghost text appears: fetchUser().then(...)]                  │
│                                                                     │
│  Step 3: Accept Suggestion                                        │
│  ─────────────────────────────────────────────────────────────────  │
│  • Press <Tab> to accept                                           │
│  • Supermaven continues suggesting more lines                       │
│  • Keep typing or accepting as needed                              │
│                                                                     │
│  Step 4: Complete Component                                        │
│  ─────────────────────────────────────────────────────────────────  │
│  function UserCard({ user }) {                                     │
│    const [isLoaded, setIsLoaded] = useState(false);               │
│    useEffect(() => {                                              │
│      fetchUser(user.id).then(() => setIsLoaded(true));            │
│    }, [user.id]);                                                  │
│    return (                                                        │
│      <div className="user-card">...</div>                          │
│    );                                                              │
│  }                                                                  │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

### Scenario 4: Multi-File Refactoring

**Problem**: Need to extract database logic from multiple controllers into a repository layer.

```
┌─────────────────────────────────────────────────────────────────────┐
│  Step 1: Open Claude Code                                          │
│  ─────────────────────────────────────────────────────────────────  │
│  <leader>cc                                                        │
│                                                                     │
│  Step 2: Add All Affected Files                                    │
│  ─────────────────────────────────────────────────────────────────  │
│  • Navigate to each controller file                                │
│  • Press <leader>cb to add to context                              │
│  • Files: UserController.js, ProductController.js, OrderController │
│                                                                     │
│  Step 3: Describe Refactoring                                      │
│  ─────────────────────────────────────────────────────────────────  │
│  "Extract all database queries from these controllers into a       │
│   new Repository layer. Create base repository class and specific  │
│   implementations for each entity."                                 │
│                                                                     │
│  Step 4: Review Plan                                                │
│  ─────────────────────────────────────────────────────────────────  │
│  Claude provides:                                                   │
│  1. Architecture diagram                                           │
│  2. File structure for new repositories                            │
│  3. Step-by-step migration plan                                     │
│                                                                     │
│  Step 5: Execute Refactoring                                       │
│  ─────────────────────────────────────────────────────────────────  │
│  • Accept each file's diff individually                             │
│  • Test after each migration                                       │
│  • Use <leader>cr to resume if interrupted                         │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

---

## Appendix: Key Bindings

### Claude Code (`<leader>c`)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>cc` | n | Toggle Claude Code terminal |
| `<leader>cf` | n | Focus (jump to) Claude terminal |
| `<leader>cr` | n | Resume previous conversation |
| `<leader>cC` | n | Continue last request |
| `<leader>cm` | n | Select Claude model |
| `<leader>cb` | n | Add current buffer to context |
| `<leader>cs` | v | Send visual selection to Claude |
| `<leader>ca` | n | Accept suggested diff |
| `<leader>cd` | n | Deny suggested diff |

### Gemini AI (`<leader>g`)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>gg` | n | Toggle Gemini sidebar |
| `<leader>gc` | n | Spawn or switch to AI session |
| `<leader>gd` | n | Send current line diagnostic to Gemini |
| `<leader>gD` | n | Send all file diagnostics to Gemini |
| `<leader>ga` | n | Accept Gemini's suggested diff |
| `<leader>gd` | n | Deny Gemini's suggested diff |
| `<leader>gs` | v | Send visual selection to Gemini |

### Supermaven (Automatic)

| Key | Mode | Description |
|-----|------|-------------|
| `<Tab>` | i | Accept ghost text suggestion |
| (Any typing) | i | Accept and continue typing |
| `<Esc>` | i | Dismiss ghost text |
| (Different char) | i | Dismiss and insert new character |

### blink.cmp Completion

| Key | Mode | Description |
|-----|------|-------------|
| `<C-j>` | i | Select next completion item |
| `<C-k>` | i | Select previous completion item |
| `<C-e>` | i | Hide/completion toggle |
| `<C-s>` | i | Show signature help |
| `<C-l>` | i | Show documentation |

---

## Conclusion

Mars.nvim's AI integration strategy follows a **layered approach**:

1. **Always-on Layer** (Supermaven): Continuous, invisible assistance for routine coding
2. **Quick-Fix Layer** (Gemini AI): Targeted help for specific problems
3. **Deep-Work Layer** (Claude Code): Comprehensive AI collaboration for complex tasks

This design ensures developers have the right tool for each situation, without redundancy or overlap. The tools complement each other rather than compete, creating a seamless AI-assisted development experience.

---

**Document Version**: 1.0
**Last Updated**: 2025-12-23
**Author**: Analysis of mars.nvim configuration
