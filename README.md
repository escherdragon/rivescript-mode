# rivescript-mode
Emacs major mode for composing rivescript files.

## What is Rivescript?

Rivescript is a very simple, line-oriented mark-up language for scripting chatbots.

For more details, visit: https://www.rivescript.com

## Installation

Put this file somewhere in your load-path, and then add the following line to your `.emacs` file:

```{elisp}
(require 'rivescript)
```

then you can manually enable the mode with M-x rivescript-mode, or you can associate it with a file extension:

```{elisp}
(add-to-list 'auto-mode-alist '("\\.rive\\'" . rivescript-mode))
```
