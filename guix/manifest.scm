;; This "manifest" file can be passed to 'guix package -m' to reproduce
;; the content of your profile.  This is "symbolic": it only specifies
;; package names.  To reproduce the exact same profile, you also need to
;; capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.

(use-modules (guix transformations))

(define transform1
  (options->transformation
    '((with-branch . "neovim=release-0.10")
      (with-branch . "tree-sitter=release-0.24"))))

(packages->manifest
  (list (specification->package "cmatrix")
        (specification->package "zsh")
        (specification->package "cmake")
        (transform1 (specification->package "neovim"))
        (transform1
          (specification->package "tree-sitter"))
        (specification->package "docker")
        (specification->package "vlc")
        (specification->package "sbcl")
        (specification->package "telegram-desktop")
        (specification->package "tor-client")
        (specification->package "tor")
        (specification->package "clang")
        (specification->package "llvm")
        (specification->package "tmux")
        (specification->package "rlwrap")
        (specification->package "gcc-toolchain")
        (specification->package "alacritty")
        (specification->package "guile")
        (specification->package "nftables")
        (specification->package "w3m")
        (specification->package "wireguard-tools")
        (specification->package "torsocks")
        (specification->package "postgresql")
        (specification->package "less")
        (specification->package "man-db")
        (specification->package "coreutils")
        (specification->package "ncurses")
        (specification->package "neomutt")
        (specification->package "mutt")
        (specification->package "glibc-locales")))
