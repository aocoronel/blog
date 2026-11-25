(require 'seq)
(require 'htmlize)
(require 'ox-publish)
(require 'ox-rss)

(setq org-html-htmlize-output-type 'inline-css)
(setq org-html-head-include-default-style nil)
(setq org-html-head-extra
"<meta name=\"twitter:title\" content=\"Augusto Coronel\" />
<meta name=\"twitter:card\" content=\"summary_large_image\" />
<meta name=\"twitter:image\"
      content=\"https://raw.githubusercontent.com/aocoronel/aocoronel.github.io/refs/heads/main/media/favicons/banner.png\"/>
<style type=\"text/css\">
#content { max-width: 60em; margin: auto; }
.title  { margin-bottom: .2em; }
.subtitle { text-align: center; font-size: medium; font-weight: bold;
            margin-top:0; }
.todo   { font-family: monospace; color: #eba0ac; font-weight: bolder; font-size: 110%; }
.done   { font-family: monospace; color: #a6e3a1; font-weight: bolder; font-size: 110%; }
.priority { font-family: monospace; color: #cba6f7; }
.tag    { background-color: #eee; font-family: monospace;
          padding: 2px; font-size: 80%; font-weight: normal; }
.timestamp { color: #bebebe; }
.timestamp-kwd { color: #5f9ea0; }
.org-right  { margin-left: auto; margin-right: 0px;  text-align: right; }
.org-left   { margin-left: 0px;  margin-right: auto; text-align: left; }
.org-center { margin-left: auto; margin-right: auto; text-align: center; }
.underline { text-decoration: underline; }
#postamble p, #preamble p { font-size: 90%; margin: .2em; }
p.verse { margin-left: 3%; }
pre {
  border: 1px solid #e6e6e6;
  padding: 8pt;
  font-family: monospace;
  overflow: auto;
  margin: 1.2em;
}
pre.src {
  position: relative;
  overflow: auto;
}
table { border-collapse:collapse; }
caption.t-above { caption-side: top; }
caption.t-bottom { caption-side: bottom; }
td, th { vertical-align:top;  }
th.org-right  { text-align: center;  }
th.org-left   { text-align: center;   }
th.org-center { text-align: center; }
td.org-right  { text-align: right;  }
td.org-left   { text-align: left;   }
td.org-center { text-align: center; }
dt { font-weight: bold; }
.footpara { display: inline; }
.footdef  { margin-bottom: 1em; }
.figure { padding: 1em; }
.figure p { text-align: center; }
.equation-container {
  display: table;
  text-align: center;
  width: 100%;
}
.equation {
  vertical-align: middle;
}
.equation-label {
  display: table-cell;
  text-align: right;
  vertical-align: middle;
}
.inlinetask {
  padding: 10px;
  border: 2px solid gray;
  margin: 10px;
  background: #ffffcc;
}
#org-div-home-and-up
 { text-align: right; font-size: 70%; white-space: nowrap; }
textarea { overflow-x: auto; }
.linenr { font-size: smaller }
.code-highlighted { background-color: #ffff00; }
.org-info-js_info-navigation { border-style: none; }
#org-info-js_console-label
  { font-size: 10px; font-weight: bold; white-space: nowrap; }
.org-info-js_search-highlight
  { background-color: #ffff00; color: #000000; font-weight: bold; }
.org-svg { }
</style>")

(setq org-publish-project-alist
      '(("index"
         :base-directory "~/blog/"
         :base-extension "org"
         :publishing-directory "~/public/"
         :publishing-function org-html-publish-to-html
         :exclude "feed\\.org"
         :section-numbers nil
         :language "en"
         :with-toc nil
         :html-head "<link rel=\"stylesheet\" type=\"text/css\" href=\"/index.css\" />")

        ("rss"
         :base-directory "~/blog/"
         :base-extension "org"
         :author "Augusto Coronel"
         :email "aocoronelx@gmail.com"
         :publishing-directory "~/public/"
         :publishing-function org-rss-publish-to-rss
         :exclude "index\\.org\\|archive\\.org"
         :section-numbers nil
         :html-preamble ""
         :html-postamble "")

        ("pages"
         :base-directory "~/blog/pages"
         :base-extension "org"
         :publishing-directory "~/public/"
         :publishing-function org-html-publish-to-html
         :language "en"
         :section-numbers nil
         :with-toc nil
         :html-head "<link rel=\"stylesheet\" type=\"text/css\" href=\"/pages.css\"/>")

        ("posts"
         :base-directory "~/blog/posts"
         :base-extension "org"
         :publishing-directory "~/public/posts"
         :publishing-function org-html-publish-to-html
         :recursive t
         :with-author t
         :with-creator t
         :with-toc t
         :language "en"
         :author "Augusto Coronel"
         :section-numbers nil
         :html-postamble blog/post-postamble
         :html-head "<link rel=\"stylesheet\" type=\"text/css\" href=\"/posts.css\" />")

        ("code"
         :base-directory "~/blog/code"
         :base-extension "org"
         :publishing-directory "~/public/code"
         :publishing-function org-html-publish-to-html
         :recursive t
         :with-toc nil
         :language "en"
         :section-numbers nil
         :html-head "<link rel=\"stylesheet\" type=\"text/css\" href=\"/posts.css\" />")

        ("static"
         :base-directory "~/blog/"
         :base-extension any
         :publishing-directory "~/public/"
         :exclude "\\.\\(?:org\\|git\\|gitignore\\|el\\)\\'"
         :recursive t
         :publishing-function org-publish-attachment)

        ("all"
         :components ("posts" "pages" "index" "static"))))

(setq org-html-preamble
      "<header><div class=\"header_content\">
        <div class=\"navbar\">
          <a class=\"ctitle\" href=\"/\">Coronel</a>
          <div class=\"nav_item\">
            <a href=\"/about.html\">About</a>
          </div>
          <div class=\"nav_item\">
            <a href=\"/\">Home</a>
          </div>
        </div>
      </div></header><br>")

(defun blog/post-postamble (plist)
   (concat
     "<p class=\"license\">
     This post is licensed under
     <a class=\"license\" href=\"https://creativecommons.org/licenses/by/4.0/\">
     CC BY 4.0</a>
     by the author.
     </p>"
     org-html-postamble))

(setq org-html-postamble
    "<footer>
      <div class=\"footer_content\">
        <a
          href=\"https://github.com/aocoronel\"
          class=\"glass-btn !px-3\"
          target=\"_blank\"
          ><svg
            xmlns=\"http://www.w3.org/2000/svg\"
            width=\"22\"
            height=\"22\"
            fill=\"var(--blue)\"
            viewBox=\"0 0 256 256\"
          >
            <title>GitHub</title>
            <path
              d=\"M208,104v8a48,48,0,0,1-48,48H136a32,32,0,0,1,32,32v40H104V192a32,32,0,0,1,32-32H112a48,48,0,0,1-48-48v-8a49.28,49.28,0,0,1,8.51-27.3A51.92,51.92,0,0,1,76,32a52,52,0,0,1,43.83,24h32.34A52,52,0,0,1,196,32a51.92,51.92,0,0,1,3.49,44.7A49.28,49.28,0,0,1,208,104Z\"
              opacity=\"0.2\"
            ></path>
            <path
              d=\"M208.3,75.68A59.74,59.74,0,0,0,202.93,28,8,8,0,0,0,196,24a59.75,59.75,0,0,0-48,24H124A59.75,59.75,0,0,0,76,24a8,8,0,0,0-6.93,4,59.78,59.78,0,0,0-5.38,47.68A58.14,58.14,0,0,0,56,104v8a56.06,56.06,0,0,0,48.44,55.47A39.8,39.8,0,0,0,96,192v8H72a24,24,0,0,1-24-24A40,40,0,0,0,8,136a8,8,0,0,0,0,16,24,24,0,0,1,24,24,40,40,0,0,0,40,40H96v16a8,8,0,0,0,16,0V192a24,24,0,0,1,48,0v40a8,8,0,0,0,16,0V192a39.8,39.8,0,0,0-8.44-24.53A56.06,56.06,0,0,0,216,112v-8A58,58,0,0,0,208.3,75.68ZM200,112a40,40,0,0,1-40,40H112a40,40,0,0,1-40-40v-8a41.74,41.74,0,0,1,6.9-22.48A8,8,0,0,0,80,73.83a43.81,43.81,0,0,1,.79-33.58,43.88,43.88,0,0,1,32.32,20.06A8,8,0,0,0,119.82,64h32.35a8,8,0,0,0,6.74-3.69,43.87,43.87,0,0,1,32.32-20.06A43.81,43.81,0,0,1,192,73.83a8.09,8.09,0,0,0,1,7.65A41.76,41.76,0,0,1,200,104Z\"
            ></path></svg
        ></a>
        <a href=\"/feed.xml\" target=\"_blank\">
          <svg
            width=\"22\"
            height=\"22\"
            viewBox=\"0 0 24 24\"
            id=\"Layer_1\"
            data-name=\"Layer 1\"
            xmlns=\"http://www.w3.org/2000/svg\"
          >
            <title>RSS Feeds</title>
            <defs>
              <style>
                .cls-1 {
                  fill: none;
                  stroke: var(--blue);
                  stroke-miterlimit: 10;
                  stroke-width: 1.91px;
                }
              </style>
            </defs>
            <path class=\"cls-1\" d=\"M6.27,11.05A6.68,6.68,0,0,1,13,17.73\" />
            <path class=\"cls-1\" d=\"M6.27,6.27A11.46,11.46,0,0,1,17.73,17.73\" />
            <circle class=\"cls-1\" cx=\"7.23\" cy=\"16.77\" r=\"0.95\" />
            <rect class=\"cls-1\" x=\"1.5\" y=\"1.5\" width=\"21\" height=\"21\" />
          </svg>
        </a>
        <span style=\"padding-right: 15px; text-wrap: auto\">
          <p>
            © 2025
            <a href=\"https://github.com/aocoronel/\">Augusto Coronel.</a>
            <a href=\"https://creativecommons.org/licenses/by/4.0/\"
              >All rights reserved.</a
            >
          </p>
        </span>
      </div>
    </footer>")


(defun blog/generate-archive ()
  (interactive)
  (let* ((posts-dir (expand-file-name "~/blog/posts/"))
         (blog-dir (expand-file-name "~/blog/"))
         (archive-file (expand-file-name "~/blog/archive.org"))
         (rss-file (expand-file-name "~/blog/feed.org"))
         (index-file (expand-file-name "~/blog/index.org"))

         (post-info
          (lambda (file)
            (let* ((date-string (substring file 0 10))
                   (date (date-to-time
                          (concat date-string " 00:00:00")))
                   (title
                    (with-temp-buffer
                      (insert-file-contents
                       (expand-file-name file posts-dir))
                      (goto-char (point-min))
                      (if (re-search-forward
                           "^#\\+title:[ \t]*\\(.+\\)$"
                           nil t)
                          (string-trim (match-string 1))
                        (file-name-base file))))
                    (desc
                      (with-temp-buffer
                       (insert-file-contents
                        (expand-file-name file posts-dir))
								      (goto-char (point-min))
								      (if (re-search-forward "^#\\+description:[ \t]*\\(.+\\)$" nil t)
								          (string-trim (match-string 1))
                          ("no description")))))

              (list
               :file file
               :title title
               :desc desc
               :date date
               :date-long (format-time-string "%b %-d, %Y" date)
               :date-short (format-time-string "%b %-d" date)
               :html
               (concat
                (file-name-sans-extension
                 (file-relative-name
                  (expand-file-name file posts-dir)
                  blog-dir))
                ".html")))))

         ;; YYYY-MM-DD-description.org
         (posts
          (sort
           (directory-files
            posts-dir
            nil
            "^[0-9]\\{4\\}-[0-9]\\{2\\}-[0-9]\\{2\\}-.*\\.org$")
           #'string>))

         (post-data
          (mapcar post-info posts))

         (latest (seq-take post-data 6)))

    ;; archive.org
    (with-temp-file archive-file
      (insert "#+TITLE: Archive\n\n")

      (dolist (post post-data)
        (insert
         (format "%s [[file:%s][%s]]\n\n"
                 (plist-get post :date-long)
                 (plist-get post :html)
                 (plist-get post :title)))))

    ;; rss.org
    (with-temp-file rss-file
      (insert "#+TITLE: Augusto Coronel\n")
      (insert "#+DESCRIPTION: Latest posts from Augusto Coronel\n")
      (insert "#+LANGUAGE: en\n\n")

      (dolist (file latest)
          (insert (format "* %s\n" (plist-get file :title)))
          (insert ":PROPERTIES:\n")
          (insert (format ":RSS_DATE: %s\n" (format-time-string "%Y-%m-%-d" (plist-get file :date))))
          (insert (format ":RSS_PERMALINK: /%s\n" (plist-get file :html)))
          (insert ":END:\n")
          (when-let* ((desc (plist-get file :desc)))
            (insert  desc "\n"))))

    ;; index.org
    (with-temp-buffer
      (insert-file-contents index-file)

      (goto-char (point-min))
      (when (re-search-forward
             "^\\* Latest posts\n"
             nil t)
        (let ((start (point))
              end)

          (setq end
                (or (save-excursion
                      (when (re-search-forward "See all posts" nil t)
                        (line-beginning-position)))
                    (point-max)))

          (delete-region start end)

          (dolist (post latest)
            (insert
             (format "%s [[file:%s][%s]]\n\n"
                     (plist-get post :date-short)
                     (plist-get post :html)
                     (plist-get post :title))))

          (insert "\n")))

      (write-region (point-min) (point-max) index-file))))
