(profiler-start 'cpu)

(setq vc-follow-symlinks t)

(if (file-exists-p "~/.config/emacs/config.elc")
  (load "~/.config/emacs/config.elc")
  (if (file-exists-p "~/.config/emacs/config.elc")
    (org-babel-load-file (expand-file-name "config.el" user-emacs-directory))
    (org-babel-load-file (expand-file-name "config.org" user-emacs-directory))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("dc8285f7f4d86c0aebf1ea4b448842a6868553eded6f71d1de52f3dcbc960039" "f458b92de1f6cf0bdda6bce23433877e94816c3364b821eb4ea9852112f5d7dc" "680f62b751481cc5b5b44aeab824e5683cf13792c006aeba1c25ce2d89826426" "8d3ef5ff6273f2a552152c7febc40eabca26bae05bd12bc85062e2dc224cde9a" "3199be8536de4a8300eaf9ce6d864a35aa802088c0925e944e2b74a574c68fd0" "7dc296b80df1b29bfc4062d1a66ee91efb462d6a7a934955e94e786394d80b71" "bfe046af7359f81d6bd4c47e09ecba8304940107752616124fbf405208b90c8f" "c505ae23385324c21821b24c9cc1d68d8da6f3cfb117eb18826d146b8ec01b15" "96998f6f11ef9f551b427b8853d947a7857ea5a578c75aa9c4e7c73fe04d10b4" "a138ec18a6b926ea9d66e61aac28f5ce99739cf38566876dc31e29ec8757f6e2" "570263442ce6735821600ec74a9b032bc5512ed4539faf61168f2fdf747e0668" "3cc2385c39257fed66238921602d8104d8fd6266ad88a006d0a4325336f5ee02" "3d5ef3d7ed58c9ad321f05360ad8a6b24585b9c49abcee67bdcbb0fe583a6950" "e0d42a58c84161a0744ceab595370cbe290949968ab62273aed6212df0ea94b4" "b3775ba758e7d31f3bb849e7c9e48ff60929a792961a2d536edec8f68c671ca5" "9b59e147dbbde5e638ea1cde5ec0a358d5f269d27bd2b893a0947c4a867e14c1" "c865644bfc16c7a43e847828139b74d1117a6077a845d16e71da38c8413a5aaa" "3fe1ebb870cc8a28e69763dde7b08c0f6b7e71cc310ffc3394622e5df6e4f0da" "2721b06afaf1769ef63f942bf3e977f208f517b187f2526f0e57c1bd4a000350" "b99e334a4019a2caa71e1d6445fc346c6f074a05fcbb989800ecbe54474ae1b0" "49acd691c89118c0768c4fb9a333af33e3d2dca48e6f79787478757071d64e68" "2f8eadc12bf60b581674a41ddc319a40ed373dd4a7c577933acaff15d2bf7cc6" "aec7b55f2a13307a55517fdf08438863d694550565dee23181d2ebd973ebd6b8" "944d52450c57b7cbba08f9b3d08095eb7a5541b0ecfb3a0a9ecd4a18f3c28948" "60ada0ff6b91687f1a04cc17ad04119e59a7542644c7c59fc135909499400ab8" "7e377879cbd60c66b88e51fad480b3ab18d60847f31c435f15f5df18bdb18184" "e1f4f0158cd5a01a9d96f1f7cdcca8d6724d7d33267623cc433fe1c196848554" "f64189544da6f16bab285747d04a92bd57c7e7813d8c24c30f382f087d460a33" "5b9a45080feaedc7820894ebbfe4f8251e13b66654ac4394cb416fef9fdca789" "00cec71d41047ebabeb310a325c365d5bc4b7fab0a681a2a108d32fb161b4006" "f053f92735d6d238461da8512b9c071a5ce3b9d972501f7a5e6682a90bf29725" "4ff1c4d05adad3de88da16bd2e857f8374f26f9063b2d77d38d14686e3868d8d" "2853dd90f0d49439ebd582a8cbb82b9b3c2a02593483341b257f88add195ad76" "512ce140ea9c1521ccaceaa0e73e2487e2d3826cc9d287275550b47c04072bc4" "6945dadc749ac5cbd47012cad836f92aea9ebec9f504d32fe89a956260773ca4" "7ea883b13485f175d3075c72fceab701b5bf76b2076f024da50dff4107d0db25" "991ca4dbb23cab4f45c1463c187ac80de9e6a718edc8640003892a2523cb6259" "5586a5db9dadef93b6b6e72720205a4fa92fd60e4ccfd3a5fa389782eab2371b" "e3daa8f18440301f3e54f2093fe15f4fe951986a8628e98dcd781efbec7a46f2" "bf948e3f55a8cd1f420373410911d0a50be5a04a8886cabe8d8e471ad8fdba8e" "7a424478cb77a96af2c0f50cfb4e2a88647b3ccca225f8c650ed45b7f50d9525" "2e05569868dc11a52b08926b4c1a27da77580daa9321773d92822f7a639956ce" "631c52620e2953e744f2b56d102eae503017047fb43d65ce028e88ef5846ea3b" "2dd4951e967990396142ec54d376cced3f135810b2b69920e77103e0bcedfba9" "0d01e1e300fcafa34ba35d5cf0a21b3b23bc4053d388e352ae6a901994597ab1" "a0be7a38e2de974d1598cf247f607d5c1841dbcef1ccd97cded8bea95a7c7639" "f6665ce2f7f56c5ed5d91ed5e7f6acb66ce44d0ef4acfaa3a42c7cfe9e9a9013" "c5ded9320a346146bbc2ead692f0c63be512747963257f18cc8518c5254b7bf5" "3319c893ff355a88b86ef630a74fad7f1211f006d54ce451aab91d35d018158f" "1704976a1797342a1b4ea7a75bdbb3be1569f4619134341bd5a4c1cfb16abad4" "76ed126dd3c3b653601ec8447f28d8e71a59be07d010cd96c55794c3008df4d7" "e2c926ced58e48afc87f4415af9b7f7b58e62ec792659fcb626e8cba674d2065" "c2aeb1bd4aa80f1e4f95746bda040aafb78b1808de07d340007ba898efa484f5" "4a5aa2ccb3fa837f322276c060ea8a3d10181fecbd1b74cb97df8e191b214313" "e19ac4ef0f028f503b1ccafa7c337021834ce0d1a2bca03fcebc1ef635776bea" "1278c5f263cdb064b5c86ab7aa0a76552082cf0189acf6df17269219ba496053" "22ce392ec78cd5e512169f8960edf5cbbad70e01d3ed0284ea62ab813d4ff250" "47db50ff66e35d3a440485357fb6acb767c100e135ccdf459060407f8baea7b2" "d47f868fd34613bd1fc11721fe055f26fd163426a299d45ce69bef1f109e1e71" "4f1d2476c290eaa5d9ab9d13b60f2c0f1c8fa7703596fa91b235db7f99a9441b" "a7b20039f50e839626f8d6aa96df62afebb56a5bbd1192f557cb2efb5fcfb662" "66bdbe1c7016edfa0db7efd03bb09f9ded573ed392722fb099f6ac6c6aefce32" "5784d048e5a985627520beb8a101561b502a191b52fa401139f4dd20acb07607" "da53441eb1a2a6c50217ee685a850c259e9974a8fa60e899d393040b4b8cc922" "f7fed1aadf1967523c120c4c82ea48442a51ac65074ba544a5aefc5af490893b" "b186688fbec5e00ee8683b9f2588523abdf2db40562839b2c5458fcfb322c8a4" "266ecb1511fa3513ed7992e6cd461756a895dcc5fef2d378f165fed1c894a78c" "6c98bc9f39e8f8fd6da5b9c74a624cbb3782b4be8abae8fd84cbc43053d7c175" "6f4421bf31387397f6710b6f6381c448d1a71944d9e9da4e0057b3fe5d6f2fad" "f91395598d4cb3e2ae6a2db8527ceb83fed79dbaf007f435de3e91e5bda485fb" "3d54650e34fa27561eb81fc3ceed504970cc553cfd37f46e8a80ec32254a3ec3" "9b54ba84f245a59af31f90bc78ed1240fca2f5a93f667ed54bbf6c6d71f664ac" "23c806e34594a583ea5bbf5adf9a964afe4f28b4467d28777bcba0d35aa0872e" "6c531d6c3dbc344045af7829a3a20a09929e6c41d7a7278963f7d3215139f6a7" "e8df30cd7fb42e56a4efc585540a2e63b0c6eeb9f4dc053373e05d774332fc13" "353ffc8e6b53a91ac87b7e86bebc6796877a0b76ddfc15793e4d7880976132ae" "028c226411a386abc7f7a0fba1a2ebfae5fe69e2a816f54898df41a6a3412bb5" "613aedadd3b9e2554f39afe760708fc3285bf594f6447822dd29f947f0775d6c" "d6844d1e698d76ef048a53cefe713dbbe3af43a1362de81cdd3aefa3711eae0d" "fe2539ccf78f28c519541e37dc77115c6c7c2efcec18b970b16e4a4d2cd9891d" "1d44ec8ec6ec6e6be32f2f73edf398620bb721afeed50f75df6b12ccff0fbb15" "e6f3a4a582ffb5de0471c9b640a5f0212ccf258a987ba421ae2659f1eaa39b09" "4699e3a86b1863bbc695236036158d175a81f0f3ea504e2b7c71f8f7025e19e3" "cbdf8c2e1b2b5c15b34ddb5063f1b21514c7169ff20e081d39cf57ffee89bc1e" "1bddd01e6851f5c4336f7d16c56934513d41cc3d0233863760d1798e74809b4b" "a6e620c9decbea9cac46ea47541b31b3e20804a4646ca6da4cce105ee03e8d0e" "5f19cb23200e0ac301d42b880641128833067d341d22344806cdad48e6ec62f6" "4b6b6b0a44a40f3586f0f641c25340718c7c626cbf163a78b5a399fbe0226659" "84b14a0a41bb2728568d40c545280dbe7d6891221e7fbe7c2b1c54a3f5959289" "a82ab9f1308b4e10684815b08c9cac6b07d5ccb12491f44a942d845b406b0296" "234dbb732ef054b109a9e5ee5b499632c63cc24f7c2383a849815dacc1727cb6" "da186cce19b5aed3f6a2316845583dbee76aea9255ea0da857d1c058ff003546" "97db542a8a1731ef44b60bc97406c1eb7ed4528b0d7296997cbb53969df852d6" "b5803dfb0e4b6b71f309606587dd88651efe0972a5be16ece6a958b197caeed8" "c4063322b5011829f7fdd7509979b5823e8eea2abf1fe5572ec4b7af1dd78519" "1d5e33500bc9548f800f9e248b57d1b2a9ecde79cb40c0b1398dec51ee820daf" "8d7b028e7b7843ae00498f68fad28f3c6258eda0650fe7e17bfb017d51d0e2a2" "d268b67e0935b9ebc427cad88ded41e875abfcc27abd409726a92e55459e0d01" "a9a67b318b7417adbedaab02f05fa679973e9718d9d26075c6235b1f0db703c8" "3d47380bf5aa650e7b8e049e7ae54cdada54d0637e7bac39e4cc6afb44e8463b" "1f1b545575c81b967879a5dddc878783e6ebcca764e4916a270f9474215289e5" "8146edab0de2007a99a2361041015331af706e7907de9d6a330a3493a541e5a6" "7a7b1d475b42c1a0b61f3b1d1225dd249ffa1abb1b7f726aec59ac7ca3bf4dae" "846b3dc12d774794861d81d7d2dcdb9645f82423565bfb4dad01204fa322dbd5" "850bb46cc41d8a28669f78b98db04a46053eca663db71a001b40288a9b36796c" "745d03d647c4b118f671c49214420639cb3af7152e81f132478ed1c649d4597d" default))
 '(helm-minibuffer-history-key "M-p")
 '(package-selected-packages
   '(esup aggressive-indent which-key-posframe color-theme-modern helm-themes tree-sitter-langs tree-sitter mermaid-mode lsp-pyright projectile dired-open vertico-posframe evil-collection dashboard ripgrep ivy-prescient prescient ivy-posframe vertico dired-single crux lsp-ui flycheck eglot company-box lsp-treemacs lsp-ivy clang-format git-gutter org-superstar mixed-pitch peep-dired treemacs-tab-bar treemacs-persp treemacs-magit treemacs-evil treemacs smex ivy-rich counsel which-key simpleclip elpy general evil-tutor centaur-tabs powerline doom-themes transpose-frame flycheck-posframe flycheck-popup-tip flycheck-popup quick-peek flycheck-inline agressive-indent modus-themes leuven-theme sublime-themes emacs-color-themes mood-line lsp-clangd doom-modeline ivy command-log-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background nil))))
 '(doom-modeline ((t (:font "Iosevka Light" :height 0.9))))
 '(doom-modeline-inactive ((t (:font "Iosevka Light" :height 0.9))))
 '(link ((t (:underline t :weight bold)))))
(put 'downcase-region 'disabled nil)        
