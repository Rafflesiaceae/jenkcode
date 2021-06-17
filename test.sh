#!/bin/bash
set -eo pipefail

# fAnCY AsCiI CoLoRs
cBgreen=$(2>/dev/null  tput setab 2) || true
cbold=$(2>/dev/null    tput bold)    || true
cgreen=$(2>/dev/null   tput setaf 2) || true
cmagenta=$(2>/dev/null tput setaf 5) || true
cred=$(2>/dev/null     tput setaf 1) || true
creset=$(2>/dev/null   tput sgr0)    || true

failed=0

tmpfile=$(mktemp)
cleanup_tmpfile() {
    rm "$tmpfile"
}; trap 'cleanup_tmpfile' EXIT

# we will test with your local version
gversion=$(groovy -e "println GroovySystem.version" 2>/dev/null)

# just pretty print stuff
maxpathlen=0
for path in ./test_jenkode_*; do [[ ${#path} -gt $maxpathlen ]] && maxpathlen=${#path}; done
for path in ./test_jenkode_*; do # actually run tests
    printf "%s[TEST]%s %-${maxpathlen}s " "$cmagenta" "$creset" "$path"
    # encode then decode and compare if we got the input back out
    if cat "$path" | ./jenkode -e "$gversion" | ./jenkode -d "$gversion" | diff --color -u "$path" -; then
        # run encoded through groovy's `print()` and compare if we got the input back out
        printf "print(" > "$tmpfile"
        cat "$path" | ./jenkode -e "$gversion" >> "$tmpfile"
        printf ")" >> "$tmpfile"
        if groovy "$tmpfile" 2>/dev/null | diff --color -u "$path" -; then
            printf "%s  %s\n" "$cBgreen" "$creset"
        else
            ((failed++)) || true
        fi
    else
        ((failed++)) || true
    fi
done
if [[ $failed -gt 0 ]]; then
    printf "\n%s%s%s tests %sfailed%s 🙁\n" "$cbold" "$failed" "$creset" \
        "$cred" "$creset"
else
    printf "\nall tests %ssucceeded%s, have a nice day 😀\n" "$cgreen" "$creset"
fi
