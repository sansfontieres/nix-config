#!/usr/bin/env awk -f
# mcolor - colorize rendered mail

function co(n, c) { e = ENVIRON["MCOLOR_" n]; return e ? e : c }
function hfg(s) { k = index(s,":"); return sprintf("\033[1m%s\033[0m%s", $1, substr(s, k+1)) }
function fg(c, s) { return sprintf("\033[38;5;%03dm%s\033[0m", c, s) }
function so(s) { return sprintf("\033[1m%s\033[0m", s) }
function em(s) { return sprintf("\033[3m%s\033[0m", s) }
BEGIN { hdr = 1; if ("NO_COLOR" in ENVIRON || match(ENVIRON["TERM"], "^(dumb|network|9term)")) no_color = 1 }
no_color { print; next }
/\r$/ { sub(/\r$/, "") }
/^\014$/ { nextmail = 1; next }
/^$/ { hdr = 0 }
/^-- $/ { ftr = 1 }
/^--- .* ---/ { print fg(co("SEP",242), $0); ftr = 0; sig = 0; next }
/^-----BEGIN .* SIGNATURE-----/ { sig = 1 }
nextmail && /^From:/ { hdr = 1 }
hdr && /^From:/ { print so(hfg($0)); next }
hdr { print so(hfg($0)); next }
ftr { print fg(co("FOOTER",244), $0); next }
/^-----BEGIN .* MESSAGE-----/ ||
/^-----END .* SIGNATURE-----/ { print fg(co("SIG",244), $0); sig = 0; next }
sig { print fg(co("SIG",244), $0); next }

/^---$/ { patch = 1; print; next }
/^@.* (commented on|approved) this pull request.$/ { patch = 1; pr =1; print; next }
patch && /^--- .*$/ || patch && /^\+\+\+ .*$/ { print em(fg(co("PATCH_HDR", 7), $0)); next }
patch && /^@@ .*/ { print fg(co("PATCH_LOC", 4), $0); next }
patch && /^-/     { print fg(co("PATCH_RM", 1), $0); next }
pr    && /^> -/   { print fg(co("PATCH_RM", 1), $0); next }
patch && /^\+/    { print fg(co("PATCH_ADD", 2), $0); next }
pr    && /^> \+/  { print fg(co("PATCH_ADD", 2), $0); next }
patch && /^\!/    { print fg(co("PATCH_CH", 3), $0); next }
patch { print; next }

/^> *> *>/ { print fg(co("QQQUOTE",152), $0); next }
/^> *>/ { print fg(co("QQUOTE",149), $0); next }
/^>/ { print fg(co("QUOTE",151), $0); next }


{ nextmail = 0; print }
