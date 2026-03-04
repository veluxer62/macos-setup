# macOS Setup

macOS를 새로 설치한 뒤, 개발/업무 환경을 빠르게 구성하기 위한 기본 설정 가이드입니다.

## 1. 설치

### 1-1. Homebrew
- 공식 저장소: [Homebrew](https://github.com/Homebrew/brew)

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 1-2. Oh My ZSH
- 공식 저장소: [ohmyzsh/ohmyzsh](https://github.com/ohmyzsh/ohmyzsh)

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### 1-3. Ghostty
- 공식 저장소: [ghostty-org/ghostty](https://github.com/ghostty-org/ghostty)

```bash
brew install --cask ghostty
```

### 1-4. Git

```bash
brew install git
```

### 1-5. GitHub CLI

```bash
brew install gh
```

### 1-6. GW

```bash
git clone https://github.com/eezy0/gw
cd gw
./install.sh
```

## 2. Git 설정

```bash
git config --global user.name "veluxer62"
git config --global user.email "veluxer62@gmail.com"
git config --global core.editor "code --wait"
git config maintenance.worktree-prune.enabled true
```

## 3. Ghostty 설정

- 설정 파일 경로: `~/Library/Application Support/com.mitchellh.ghostty/config`

### 3-1. Quick Terminal 토글 단축키
- 문서: [toggle_quick_terminal](https://ghostty.org/docs/config/keybind/reference#toggle_quick_terminal)

```text
keybind = global:cmd+backquote=toggle_quick_terminal
```

### 3-2. Quick Terminal 위치
- 문서: [quick-terminal-position](https://ghostty.org/docs/config/reference#quick-terminal-position)

```text
quick-terminal-position = bottom
```
