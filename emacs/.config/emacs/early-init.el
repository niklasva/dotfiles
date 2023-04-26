  (setq default-frame-alist
        (append (list
                 '(min-height . 1)
                 '(height     . 45)
                 '(min-width  . 1)
                 '(width      . 155)
                 '(vertical-scroll-bars . nil)
                 '(internal-border-width . 8)
                 '(left-fringe    . 1)
                 '(right-fringe   . 1)
                 '(tool-bar-lines . 0)
                 '(ns-transparent-titlebar . t)
                 '(ns-appearance . dark)
                 ;; '(undecorated-round . t)
                 )))

;;(add-to-list 'default-frame-alist '(font . "Liga mononoki 13"))
(add-to-list 'default-frame-alist '(font . "Iosevka Light 13"))
