---
layout: post
title: Getting rid of the routine in rebase using autosquash flag
categories : [git]
---

Getting rid of the routine in rebase using autosquash flag
============================================================

Everybody who uses forks and rebase, know that after squashing your commit in one,
you probably will do some more fixes after testing or code-review. And every time you
are annoyed by requirement to write something normal in small fix commit, because it
is only fixes and you still will squash it in one commit. I'd like not to think of
the first or on the second, as this routine.

There is solution:

1. Remember SHA1-hash of the last commit (e.g., 3141592).
2. Commit fixes with `fixup` flag, like  `--fixup=SHA1` (e.g. `git commit --fixup=3141592`) — at this step, we get rid of thinking about commit message for small fix.
3. Run interactive rebase for number of fixing commit + last commit (n+1) with `autosquash` flag. (e.g. `git rebase -i HEAD~4 --autosquash`) — at this step, we get rid of manual replacing statuses of fixing commits from `pick` to `f|fixup`, at the last we need only to save commit after rebase.

Let see how it work in real life

    git commit -m 'WOW, SUCH COMMIT'; # SHA1-hash (e.g., 3141592)
    git add first.md # fix 1
    git commit --fixup=3141592
    git add second.md # fix 2
    git commit --fixup=3141592
    git add third.md # fix 3
    git commit --fixup=3141592
    git rebase -i HEAD~4 --autosquash

After that, default text editor will open the commit editing interface to control the rebase and it should look like that:

      1 pick 3141592 WOW, SUCH COMMIT
      2 fixup 52edd9f fixup! WOW, SUCH COMMIT
      3 fixup bd89b3d fixup! WOW, SUCH COMMIT
      4 fixup 6b5f58f fixup! WOW, SUCH COMMIT
      5
      6 # Rebase 3141592..6b5f58f onto 62f6139
      7 #
      8 # Commands:
      9 #  p, pick = use commit
     10 #  r, reword = use commit, but edit the commit message
     11 #  e, edit = use commit, but stop for amending
     12 #  s, squash = use commit, but meld into previous commit
     13 #  f, fixup = like "squash", but discard this commit's log message
     14 #  x, exec = run command (the rest of the line) using shell
     15 #
     16 # These lines can be re-ordered; they are executed from top to bottom.
     17 #
     18 # If you remove a line here THAT COMMIT WILL BE LOST.
     19 #
     20 # However, if you remove everything, the rebase will be aborted.
     21 #
     22 # Note that empty commits are commented out

After you save this commit, rebase will be finished without unneccessary movements.

Thus, now you have less routine in your life.
