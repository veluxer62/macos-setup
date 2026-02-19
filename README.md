이 문서는 macOS를 새로 설치한 뒤 개발/업무 환경을 빠르게 세팅하기 위한 기본 설정을 정리합니다.

## 설치

### brew

https://github.com/Homebrew/brew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Oh My ZSH

https://github.com/ohmyzsh/ohmyzsh/

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### Ghostty

https://github.com/ghostty-org/ghostty

```bash
brew install --cask ghostty
```

### GIT

```
brew install git
```

### GIT cli

```bash
brew install gh
```

## GIT 설정

```bash
git config --global user.name "veluxer62"
```
```bash
git config --global user.email "veluxer62@gmail.com"
```
```bash
git config --global core.editor "code --wait"
```
```bash
git config maintenance.worktree-prune.enabled true
```
