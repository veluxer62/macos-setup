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

## 4. Oh My ZSH 자동완성 설정

### 4-1. `zsh-autosuggestions` 설치

```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

### 4-2. `.zshrc` 플러그인 등록

- `~/.zshrc`의 `plugins` 항목에 `zsh-autosuggestions`를 추가합니다.

```text
plugins=(git zsh-autosuggestions)
```

### 4-3. 적용

```bash
source ~/.zshrc
```

## 5. LazyVim 설정

### 5-1. Neovim 설치

```bash
brew install neovim
```

### 5-2. 기존 Neovim 설정 백업

```bash
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak
```

### 5-3. LazyVim Starter 설치

```bash
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git
```

### 5-4. 실행

```bash
nvim
```

### 5-5. `vim` alias 설정

- `~/.zshrc`에 아래 내용을 추가합니다.

```bash
alias vim='nvim'
alias vi='nvim'
```

- 설정 반영:

```bash
source ~/.zshrc
```
