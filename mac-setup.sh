#!/bin/bash
# ==============================================================================
# 2026 Mac 터미널 완벽 세팅 스크립트
# Ghostty + Starship + AI 코딩 환경
# 출처: https://blog.dnd.ac/settings-mac-terminal-2026/
# ==============================================================================
# 주의: 실행 전에 스크립트 내용을 반드시 직접 검토하세요.
# 실행 방법: chmod +x mac_terminal_setup.sh && ./mac_terminal_setup.sh
# ==============================================================================

set -euo pipefail

# ------------------------------------------------------------------------------
# 색상 정의
# ------------------------------------------------------------------------------
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# ------------------------------------------------------------------------------
# 헬퍼 함수
# ------------------------------------------------------------------------------
info()    { echo -e "${CYAN}ℹ️  $1${NC}"; }
success() { echo -e "${GREEN}✅ $1${NC}"; }
warn()    { echo -e "${YELLOW}⚠️  $1${NC}"; }
error()   { echo -e "${RED}❌ $1${NC}"; exit 1; }
section() { echo -e "\n${BOLD}${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"; \
            echo -e "${BOLD}${BLUE}  $1${NC}"; \
            echo -e "${BOLD}${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"; }

# macOS 확인
if [[ "$(uname)" != "Darwin" ]]; then
  error "이 스크립트는 macOS 전용입니다."
fi

echo ""
echo -e "${BOLD}${CYAN}"
echo "  ███╗   ███╗ █████╗  ██████╗    ████████╗███████╗██████╗ ███╗   ███╗██╗███╗   ██╗ █████╗ ██╗     "
echo "  ████╗ ████║██╔══██╗██╔════╝    ╚══██╔══╝██╔════╝██╔══██╗████╗ ████║██║████╗  ██║██╔══██╗██║     "
echo "  ██╔████╔██║███████║██║            ██║   █████╗  ██████╔╝██╔████╔██║██║██╔██╗ ██║███████║██║     "
echo "  ██║╚██╔╝██║██╔══██║██║            ██║   ██╔══╝  ██╔══██╗██║╚██╔╝██║██║██║╚██╗██║██╔══██║██║     "
echo "  ██║ ╚═╝ ██║██║  ██║╚██████╗       ██║   ███████╗██║  ██║██║ ╚═╝ ██║██║██║ ╚████║██║  ██║███████╗"
echo "  ╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝       ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝"
echo -e "${NC}"
echo -e "${BOLD}     2026 Mac 터미널 완벽 세팅 | Ghostty + Starship + AI 코딩 환경${NC}"
echo ""

# .zshrc 백업
if [[ -f "$HOME/.zshrc" ]]; then
  BACKUP="$HOME/.zshrc.backup.$(date +%Y%m%d_%H%M%S)"
  warn "기존 .zshrc를 백업합니다: $BACKUP"
  cp "$HOME/.zshrc" "$BACKUP"
fi

# ==============================================================================
# 1. Homebrew 설치
# ==============================================================================
section "1/12  Homebrew 설치"

if ! command -v brew &>/dev/null; then
  info "Homebrew를 설치합니다..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # Apple Silicon / Intel 분기
  if [[ -f /opt/homebrew/bin/brew ]]; then
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    echo 'eval "$(/usr/local/bin/brew shellenv)"' >> "$HOME/.zprofile"
    eval "$(/usr/local/bin/brew shellenv)"
  fi
  success "Homebrew 설치 완료"
else
  info "Homebrew가 이미 설치되어 있습니다. 업데이트합니다..."
  brew update
  success "Homebrew 업데이트 완료"
fi

# ==============================================================================
# 2. Ghostty 터미널 설치
# ==============================================================================
section "2/12  Ghostty 터미널 설치"

if ! brew list --cask ghostty &>/dev/null; then
  info "Ghostty를 설치합니다..."
  brew install --cask ghostty
  success "Ghostty 설치 완료"
else
  info "Ghostty가 이미 설치되어 있습니다."
fi

# ==============================================================================
# 3. 폰트 설치
# ==============================================================================
section "3/12  폰트 설치 (Hack Nerd Font + Noto Sans CJK KR)"

info "Hack Nerd Font Mono 설치 중..."
brew install --cask font-hack-nerd-font || warn "font-hack-nerd-font 설치 실패 (이미 설치됐을 수 있음)"

info "Noto Sans CJK KR (한글 폴백) 설치 중..."
brew install --cask font-noto-sans-cjk-kr || warn "font-noto-sans-cjk-kr 설치 실패 (이미 설치됐을 수 있음)"

success "폰트 설치 완료"

# ==============================================================================
# 4. 모던 CLI 도구 설치
# ==============================================================================
section "4/12  Git + GitHub CLI + 모던 CLI 도구 설치"

info "Git, GitHub CLI 및 모던 CLI 도구들을 설치합니다..."
brew install \
  git \
  gh \
  lsd \
  bat \
  fzf \
  fd \
  ripgrep \
  git-delta \
  btop \
  dust \
  duf \
  fastfetch \
  neovim \
  zoxide \
  lazygit \
  navi \
  starship \
  mise \
  gemini-cli

success "모던 CLI 도구 설치 완료"

# ==============================================================================
# 5. Oh My Zsh 설치
# ==============================================================================
section "5/12  Oh My Zsh 설치"

if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  info "Oh My Zsh를 설치합니다..."
  RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  success "Oh My Zsh 설치 완료"
else
  info "Oh My Zsh가 이미 설치되어 있습니다."
fi

# ==============================================================================
# 6. Zinit 플러그인 매니저 설치
# ==============================================================================
section "6/12  Zinit 플러그인 매니저 설치"

if [[ ! -d "$HOME/.local/share/zinit/zinit.git" ]]; then
  info "Zinit을 설치합니다..."
  mkdir -p "$HOME/.local/share/zinit"
  git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git"
  success "Zinit 설치 완료"
else
  info "Zinit이 이미 설치되어 있습니다."
fi

# ==============================================================================
# 7. SCM Breeze 설치 (Git 단축키)
# ==============================================================================
section "7/12  SCM Breeze 설치 (Git 단축키)"

if [[ ! -d "$HOME/.scm_breeze" ]]; then
  info "SCM Breeze를 설치합니다..."
  git clone https://github.com/scmbreeze/scm_breeze.git "$HOME/.scm_breeze"
  # install.sh는 .zshrc/.bashrc에 로드 구문을 자동 추가하지만,
  # 이 스크립트는 말미에 .zshrc를 직접 생성하므로 자동 추가분은 무시됨.
  # SCM Breeze 로드는 아래 .zshrc heredoc에서 직접 처리함.
  "$HOME/.scm_breeze/install.sh" || warn "SCM Breeze install.sh 실행 중 경고 발생 (무시 가능)"
  success "SCM Breeze 설치 완료"
else
  info "SCM Breeze가 이미 설치되어 있습니다."
fi

# ==============================================================================
# 8. mise로 Node.js 설치 (AI 도구용)
# ==============================================================================
section "8/12  mise로 Node.js 24 설치"

export PATH="$HOME/.local/bin:$PATH"
eval "$(mise activate bash)" 2>/dev/null || true

if command -v mise &>/dev/null; then
  info "Node.js 24를 설치합니다..."
  mise use --global node@24
  success "Node.js 24 설치 완료"
else
  warn "mise를 찾을 수 없습니다. Node.js 설치를 건너뜁니다."
fi

# ==============================================================================
# 9. AI 코딩 도구 설치
# ==============================================================================
section "9/12  AI 코딩 도구 설치"

# Claude Code
info "Claude Code 설치 확인 중..."
if ! command -v claude &>/dev/null; then
  info "Claude Code를 설치합니다..."
  # 공식 설치 스크립트 시도, 실패 시 npm으로 fallback
  if curl -fsSL https://claude.ai/install.sh | bash 2>/dev/null; then
    success "Claude Code 설치 완료 (install.sh)"
  elif command -v npm &>/dev/null; then
    warn "install.sh 실패 → npm으로 재시도합니다..."
    npm install -g @anthropic-ai/claude-code
    success "Claude Code 설치 완료 (npm)"
  else
    warn "Claude Code 설치 실패. npm 설치 후 직접 실행하세요: npm install -g @anthropic-ai/claude-code"
  fi
else
  info "Claude Code가 이미 설치되어 있습니다."
fi

# Codex CLI
info "Codex CLI 설치 확인 중..."
if command -v npm &>/dev/null; then
  if ! command -v codex &>/dev/null; then
    info "Codex CLI를 설치합니다..."
    npm install -g @openai/codex
    success "Codex CLI 설치 완료"
  else
    info "Codex CLI가 이미 설치되어 있습니다."
  fi
else
  warn "npm을 찾을 수 없습니다. Node.js 설치 후 'npm install -g @openai/codex'를 실행하세요."
fi

success "AI 코딩 도구 설치 완료"

# ==============================================================================
# 10. GW 설치 (Git Worktree 래퍼)
# ==============================================================================
section "10/12  GW 설치 (Git Worktree 래퍼)"

if ! command -v gw &>/dev/null; then
  info "GW를 설치합니다..."
  GW_TMP=$(mktemp -d)
  git clone https://github.com/eezy0/gw "$GW_TMP/gw"
  (cd "$GW_TMP/gw" && ./install.sh)
  rm -rf "$GW_TMP"
  success "GW 설치 완료"
else
  info "GW가 이미 설치되어 있습니다."
fi

# ==============================================================================
# 11. Git 전역 설정
# ==============================================================================
section "11/12  Git 전역 설정"

# Git user.name 입력
echo -e "${CYAN}Git 전역 설정을 진행합니다.${NC}"
echo -e "${YELLOW}(엔터를 누르면 현재 값을 유지합니다)${NC}"
echo ""

CURRENT_NAME=$(git config --global user.name 2>/dev/null || echo "")
if [[ -n "$CURRENT_NAME" ]]; then
  info "현재 Git user.name: $CURRENT_NAME"
fi
read -rp "$(echo -e "${CYAN}Git user.name을 입력하세요: ${NC}")" GIT_NAME
if [[ -n "$GIT_NAME" ]]; then
  git config --global user.name "$GIT_NAME"
  success "user.name 설정: $GIT_NAME"
elif [[ -n "$CURRENT_NAME" ]]; then
  info "기존 user.name 유지: $CURRENT_NAME"
else
  warn "user.name이 설정되지 않았습니다. 나중에 직접 설정하세요: git config --global user.name \"이름\""
fi

# Git user.email 입력
CURRENT_EMAIL=$(git config --global user.email 2>/dev/null || echo "")
if [[ -n "$CURRENT_EMAIL" ]]; then
  info "현재 Git user.email: $CURRENT_EMAIL"
fi
read -rp "$(echo -e "${CYAN}Git user.email을 입력하세요: ${NC}")" GIT_EMAIL
if [[ -n "$GIT_EMAIL" ]]; then
  git config --global user.email "$GIT_EMAIL"
  success "user.email 설정: $GIT_EMAIL"
elif [[ -n "$CURRENT_EMAIL" ]]; then
  info "기존 user.email 유지: $CURRENT_EMAIL"
else
  warn "user.email이 설정되지 않았습니다. 나중에 직접 설정하세요: git config --global user.email \"이메일\""
fi

# 나머지 Git 전역 설정
# core.editor: VS Code가 설치된 경우에만 설정
if command -v code &>/dev/null; then
  git config --global core.editor "code --wait"
  success "Git core.editor → VS Code"
else
  warn "VS Code(code 명령어)를 찾을 수 없어 core.editor 설정을 건너뜁니다."
  warn "VS Code 설치 후 직접 설정하세요: git config --global core.editor \"code --wait\""
fi
git config --global maintenance.worktree-prune.enabled true
git config --global pull.ff only

success "Git 전역 설정 완료"

# ==============================================================================
# 12. LazyVim 설치 (Neovim 설정)
# ==============================================================================
section "12/12  LazyVim 설치 (Neovim 설정)"

if [[ -d "$HOME/.config/nvim" ]]; then
  NVIM_BACKUP_DATE=$(date +%Y%m%d_%H%M%S)
  warn "기존 Neovim 설정을 백업합니다..."
  [[ -d "$HOME/.config/nvim" ]]              && mv "$HOME/.config/nvim"              "$HOME/.config/nvim.bak.$NVIM_BACKUP_DATE"
  [[ -d "$HOME/.local/share/nvim" ]]         && mv "$HOME/.local/share/nvim"         "$HOME/.local/share/nvim.bak.$NVIM_BACKUP_DATE"
  [[ -d "$HOME/.local/state/nvim" ]]         && mv "$HOME/.local/state/nvim"         "$HOME/.local/state/nvim.bak.$NVIM_BACKUP_DATE"
  [[ -d "$HOME/.cache/nvim" ]]               && mv "$HOME/.cache/nvim"               "$HOME/.cache/nvim.bak.$NVIM_BACKUP_DATE"
  success "기존 Neovim 설정 백업 완료 (suffix: .bak.$NVIM_BACKUP_DATE)"
fi

info "LazyVim Starter를 설치합니다..."
git clone https://github.com/LazyVim/starter "$HOME/.config/nvim"
rm -rf "$HOME/.config/nvim/.git"
success "LazyVim 설치 완료 (첫 실행 시 'nvim' 입력하면 플러그인이 자동 설치됩니다)"

# ==============================================================================
# Ghostty 설정 파일 생성
# ==============================================================================
section "⚙️  Ghostty 설정 파일 생성"

mkdir -p "$HOME/.config/ghostty"
cat > "$HOME/.config/ghostty/config" << 'GHOSTTY_EOF'
# ==============================================================================
# Ghostty Configuration - Dark Modern (Catppuccin Mocha)
# ==============================================================================

# Theme
theme = Catppuccin Mocha

# Font
font-family = "Hack Nerd Font Mono"
font-family = "Noto Sans CJK KR"

# Window
window-padding-x = 12
window-padding-y = 10
window-decoration = true
macos-titlebar-style = tabs

# Background (반투명 + 블러)
background-opacity = 0.9
background-blur-radius = 20

# Autosuggestion color (가독성을 위해 밝게)
palette = 8=#7f849c

# Cursor
cursor-style = block
cursor-style-blink = false

# Mouse
mouse-hide-while-typing = true

# Clipboard
copy-on-select = true
clipboard-paste-protection = false

# Scrollback
scrollback-limit = 10000

# macOS
macos-option-as-alt = true

# Shell Integration
shell-integration = zsh
shell-integration-features = cursor,sudo,title

# Keybindings - Split/Tab
keybind = cmd+d=new_split:right
keybind = cmd+shift+d=new_split:down
keybind = cmd+w=close_surface
keybind = cmd+alt+left=goto_split:left
keybind = cmd+alt+right=goto_split:right
keybind = cmd+alt+up=goto_split:top
keybind = cmd+alt+down=goto_split:bottom

# Quick Terminal (cmd+` 로 토글)
keybind = global:cmd+backquote=toggle_quick_terminal
quick-terminal-position = bottom
GHOSTTY_EOF

success "Ghostty 설정 파일 생성 완료 (~/.config/ghostty/config)"

# ==============================================================================
# Starship 설정 파일 생성 (Catppuccin Mocha)
# ==============================================================================
section "⚙️  Starship 설정 파일 생성 (Catppuccin Mocha)"

mkdir -p "$HOME/.config"
cat > "$HOME/.config/starship.toml" << 'STARSHIP_EOF'
# ==============================================================================
# Starship Configuration - Catppuccin Mocha
# 디렉토리(mauve) → Git 브랜치/상태(blue) → 실행시간 → ❯ 커서
# ==============================================================================

"$schema" = 'https://starship.rs/config-schema.json'

format = """
[](mauve)\
$directory\
[](fg:mauve bg:blue)\
$git_branch\
$git_status\
[](fg:blue) \
$cmd_duration\
$character"""

palette = 'catppuccin_mocha'

[directory]
style = "bg:mauve fg:crust"
format = "[ $path ]($style)"
truncation_length = 3
truncation_symbol = "…/"

[git_branch]
symbol = " "
style = "bg:blue"
format = '[[ $symbol$branch ](fg:crust bg:blue)]($style)'

[git_status]
style = "bg:blue"
format = '[[($all_status$ahead_behind )](fg:crust bg:blue)]($style)'

[line_break]
disabled = true

[character]
success_symbol = '[❯](bold fg:green)'
error_symbol = '[❯](bold fg:red)'

[cmd_duration]
min_time = 2_000
format = "[  $duration](fg:overlay1) "

# ------------------------------------------------------------------------------
# Catppuccin Mocha 팔레트
# ------------------------------------------------------------------------------
[palettes.catppuccin_mocha]
rosewater = "#f5e0dc"
flamingo  = "#f2cdcd"
pink      = "#f5c2e7"
mauve     = "#cba6f7"
red       = "#f38ba8"
maroon    = "#eba0ac"
peach     = "#fab387"
yellow    = "#f9e2af"
green     = "#a6e3a1"
teal      = "#94e2d5"
sky       = "#89dceb"
sapphire  = "#74c7ec"
blue      = "#89b4fa"
lavender  = "#b4befe"
text      = "#cdd6f4"
subtext1  = "#bac2de"
subtext0  = "#a6adc8"
overlay2  = "#9399b2"
overlay1  = "#7f849c"
overlay0  = "#6c7086"
surface2  = "#585b70"
surface1  = "#45475a"
surface0  = "#313244"
base      = "#1e1e2e"
mantle    = "#181825"
crust     = "#11111b"
STARSHIP_EOF

success "Starship 설정 파일 생성 완료 (~/.config/starship.toml)"

# ==============================================================================
# Git Delta 설정
# ==============================================================================
section "⚙️  Git Delta 설정"

git config --global core.pager delta
git config --global interactive.diffFilter "delta --color-only"
git config --global delta.navigate true
git config --global delta.side-by-side true

success "Git Delta 설정 완료 (~/.gitconfig)"

# ==============================================================================
# Claude Code 알림 설정 (hooks)
# ==============================================================================
section "⚙️  Claude Code 알림 설정"

mkdir -p "$HOME/.claude"
cat > "$HOME/.claude/settings.json" << 'CLAUDE_EOF'
{
  "hooks": {
    "Stop": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "afplay /System/Library/Sounds/Glass.aiff &"
          }
        ]
      }
    ],
    "Notification": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "afplay /System/Library/Sounds/Ping.aiff &"
          }
        ]
      }
    ]
  }
}
CLAUDE_EOF

success "Claude Code 알림 설정 완료 (~/.claude/settings.json)"

# ==============================================================================
# .zshrc 생성 (전체 통합)
# ==============================================================================
section "⚙️  .zshrc 생성 (전체 통합)"

cat > "$HOME/.zshrc" << 'ZSHRC_EOF'
# ==============================================================================
# 2026 Mac Terminal Configuration
# Ghostty + Starship + AI 코딩 환경
# ==============================================================================

# ------------------------------------------------------------------------------
# Fastfetch - 터미널 시작 시 시스템 정보 표시 (인터랙티브 셸에서만)
# ------------------------------------------------------------------------------
if [[ $- == *i* ]] && command -v fastfetch &>/dev/null; then
  fastfetch
fi

# ------------------------------------------------------------------------------
# Oh My Zsh
# ------------------------------------------------------------------------------
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""       # Starship이 프롬프트를 관리하므로 비워둠
plugins=(git)
source "$ZSH/oh-my-zsh.sh"

# ------------------------------------------------------------------------------
# Starship 프롬프트 (oh-my-zsh 이후에 로드해야 테마가 덮어쓰이지 않음)
# ------------------------------------------------------------------------------
if command -v starship &>/dev/null; then
  eval "$(starship init zsh)"
fi

# ------------------------------------------------------------------------------
# Zinit 플러그인 매니저
# ------------------------------------------------------------------------------
if [[ ! -f "$HOME/.local/share/zinit/zinit.git/zinit.zsh" ]]; then
  command mkdir -p "$HOME/.local/share/zinit"
  command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git"
fi
source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# 필수 플러그인 3종
zinit light zdharma-continuum/fast-syntax-highlighting  # 명령어 구문 강조
zinit light zsh-users/zsh-autosuggestions               # 히스토리 기반 자동 완성 (→ 키)
zinit light zsh-users/zsh-completions                   # 추가 자동 완성 정의

# ------------------------------------------------------------------------------
# SCM Breeze (Git 단축키) - Claude Code 환경에서는 제외
# gs → git status (번호 부여), ga 1 → git add, gd 2 → git diff
# ------------------------------------------------------------------------------
if [[ -z "${CLAUDECODE:-}" ]]; then
  [ -s "$HOME/.scm_breeze/scm_breeze.sh" ] && source "$HOME/.scm_breeze/scm_breeze.sh"
fi

# ------------------------------------------------------------------------------
# 모던 CLI 별칭 (기본 명령어 → Rust/Go 기반 도구로 교체)
# ------------------------------------------------------------------------------
alias ls="lsd"              # 파일 아이콘 + 컬러 + Git 상태
alias ll="lsd -la"          # 상세 목록
alias lt="lsd --tree"       # 트리 뷰
alias cat="bat"             # 구문 강조 + 줄 번호
alias find="fd"             # 직관적 문법, .gitignore 자동 적용
alias grep="rg"             # 초고속 정규식 검색
alias top="btop"            # 그래프 기반 시스템 모니터
alias df="duf"              # 디스크 정보 테이블
alias du="dust"             # 디스크 사용량 트리 시각화
alias vim="nvim"
alias vi="nvim"
alias lg="lazygit"          # 터미널 기반 Git GUI
alias c="clear"
alias ..="cd .."
alias ...="cd ../.."

# Claude Code headless 빌드 검증
alias cc-check="claude -p 'Run tsc --noEmit, then eslint, then run all unit tests. Report any errors found.'"

# ------------------------------------------------------------------------------
# fzf + zoxide + navi 연동
# ------------------------------------------------------------------------------
# fzf: Ctrl+R → 히스토리 검색, Ctrl+T → 파일 검색
if command -v fzf &>/dev/null; then
  source <(fzf --zsh)
fi

# zoxide: 스마트 cd - 자주 가는 디렉토리 자동 추천
if command -v zoxide &>/dev/null; then
  eval "$(zoxide init --cmd cd zsh)"
fi

# navi: Ctrl+G → 명령어 치트시트 검색
if command -v navi &>/dev/null; then
  eval "$(navi widget zsh)"
fi

# ------------------------------------------------------------------------------
# mise (런타임 버전 관리자: nvm + pyenv + rbenv 통합 대체)
# ------------------------------------------------------------------------------
if command -v mise &>/dev/null; then
  eval "$(mise activate zsh)"
fi

# ------------------------------------------------------------------------------
# 도구 런처 (fzf 퍼지 검색으로 도구 선택 실행)
# 사용법: 터미널에서 'tools' 입력
# ------------------------------------------------------------------------------
function tools() {
  local cmds=(
    "btop:🖥  시스템 모니터링"
    "lazygit:📦  Git UI"
    "duf:💾  디스크 사용량"
    "dust:📁  폴더 크기 분석"
    "fastfetch:ℹ️  시스템 정보"
  )
  local selected
  selected=$(printf '%s\n' "${cmds[@]}" | fzf --delimiter=: --with-nth=2 --prompt="🔧 도구 선택: ")
  local cmd="${selected%%:*}"
  [[ -n "$cmd" ]] && eval "$cmd"
}

# ==============================================================================
# END OF .zshrc
# ==============================================================================
ZSHRC_EOF

success ".zshrc 생성 완료 (~/.zshrc)"

# ==============================================================================
# 완료 메시지
# ==============================================================================
echo ""
echo -e "${BOLD}${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BOLD}${GREEN}  🎉 Mac 터미널 세팅 완료!${NC}"
echo -e "${BOLD}${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "${BOLD}📁 생성된 설정 파일:${NC}"
echo -e "  ${CYAN}~/.zshrc${NC}                       - Zsh 전체 통합 설정"
echo -e "  ${CYAN}~/.config/ghostty/config${NC}       - Ghostty 터미널 설정 (Quick Terminal 포함)"
echo -e "  ${CYAN}~/.config/starship.toml${NC}        - Starship 프롬프트 설정"
echo -e "  ${CYAN}~/.claude/settings.json${NC}        - Claude Code 알림 훅 설정"
echo -e "  ${CYAN}~/.config/nvim${NC}                 - LazyVim 설정"
echo ""
echo -e "${BOLD}🔧 설치된 주요 도구:${NC}"
echo -e "  ${CYAN}Ghostty${NC}      GPU 가속 터미널 (Quick Terminal: cmd+\`)"
echo -e "  ${CYAN}Starship${NC}     Rust 기반 미니멀 프롬프트 (Catppuccin Mocha)"
echo -e "  ${CYAN}git / gh${NC}     Git 최신 버전 + GitHub CLI"
echo -e "  ${CYAN}gw${NC}           Git Worktree 래퍼"
echo -e "  ${CYAN}lsd/bat/fd/rg${NC} 모던 CLI 도구 (ls/cat/find/grep 대체)"
echo -e "  ${CYAN}zoxide${NC}       스마트 cd (자주 가는 디렉토리 자동 추천)"
echo -e "  ${CYAN}lazygit${NC}      터미널 기반 Git GUI"
echo -e "  ${CYAN}LazyVim${NC}      Neovim 기반 IDE 환경"
echo -e "  ${CYAN}fzf/navi${NC}     퍼지 검색 / 치트시트 (Ctrl+R, Ctrl+T, Ctrl+G)"
echo -e "  ${CYAN}btop/dust/duf${NC} 시스템/디스크 모니터링"
echo -e "  ${CYAN}fastfetch${NC}    터미널 시작 시 시스템 정보 표시"
echo -e "  ${CYAN}mise${NC}         Node/Python/Go 통합 버전 관리"
echo -e "  ${CYAN}Claude Code${NC}  AI 코딩 에이전트"
echo -e "  ${CYAN}Codex CLI${NC}    OpenAI 코딩 에이전트"
echo -e "  ${CYAN}Gemini CLI${NC}   Google AI 코딩 에이전트"
echo ""
echo -e "${BOLD}📌 다음 단계:${NC}"
echo -e "  ${YELLOW}1.${NC} 새 터미널을 열거나 아래 명령어 실행:"
echo -e "     ${CYAN}source ~/.zshrc${NC}"
echo -e "  ${YELLOW}2.${NC} Ghostty 앱을 실행 → ${CYAN}cmd+\`${NC} 으로 Quick Terminal 토글 확인"
echo -e "  ${YELLOW}3.${NC} LazyVim 플러그인 자동 설치:"
echo -e "     ${CYAN}nvim${NC}  (첫 실행 시 자동으로 플러그인 설치됨)"
echo -e "  ${YELLOW}4.${NC} AI 도구 첫 실행 인증:"
echo -e "     ${CYAN}claude${NC}   (Anthropic 계정 로그인)"
echo -e "     ${CYAN}codex${NC}    (OpenAI 계정 로그인)"
echo -e "     ${CYAN}gemini${NC}   (Google 계정 로그인)"
echo -e "  ${YELLOW}5.${NC} Claude Code 멀티 에이전트 플러그인 (선택):"
echo -e "     claude 실행 후: ${CYAN}/plugin marketplace add https://github.com/Yeachan-Heo/oh-my-claudecode${NC}"
echo -e "     이후: ${CYAN}/plugin install oh-my-claudecode${NC}"
echo ""
echo -e "${BOLD}💡 주요 단축키:${NC}"
echo -e "  ${CYAN}cmd+\`${NC}        Ghostty Quick Terminal 토글"
echo -e "  ${CYAN}Ctrl+R${NC}       히스토리 퍼지 검색 (fzf)"
echo -e "  ${CYAN}Ctrl+T${NC}       파일 퍼지 검색 (fzf)"
echo -e "  ${CYAN}Ctrl+G${NC}       명령어 치트시트 (navi)"
echo -e "  ${CYAN}→ 키${NC}         자동완성 제안 적용 (zsh-autosuggestions)"
echo -e "  ${CYAN}cmd+D${NC}        Ghostty 수직 화면 분할"
echo -e "  ${CYAN}cmd+Shift+D${NC}  Ghostty 수평 화면 분할"
echo -e "  ${CYAN}tools${NC}        도구 런처 (fzf)"
echo -e "  ${CYAN}lg${NC}           lazygit 실행"
echo ""
echo -e "${BOLD}${GREEN}  즐거운 코딩 되세요! 🚀${NC}"
echo ""
