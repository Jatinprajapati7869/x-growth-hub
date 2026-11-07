# cronjob_manage examples

Run inside `hermes -p <profile>` after skill `x-post` is installed.

## Daily queue processor

Natural language prompt for the agent:

```
Use cronjob_manage action=create to run every day at 09:00. Attach skill x-post.
Each run: read workspace/queue.json; for items where status is pending and scheduled_at <= now,
verify logged in at x.com/home via browser_exec; if logged in, post text and mark posted; if not, mark skipped with not_logged_in.
Never enter passwords.
```

## Dry-run only

```
Create a one-shot cronjob_manage run in 2 minutes that only checks x.com/home login state and prints queue summary — no posting.
```

## Learn after failure

```
After fixing compose selectors, use skill_manage to append a "Last known selectors" section to x-post with the steps that worked.
```
