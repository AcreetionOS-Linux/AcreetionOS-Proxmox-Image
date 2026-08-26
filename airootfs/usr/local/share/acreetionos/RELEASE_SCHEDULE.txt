# Release Schedule

AcreetionOS Server follows an **LTS-based Semi-LTS** release schedule with
**quarterly ISO builds**.

## Cycle

| Quarter | Month     | Type                   |
|---------|-----------|------------------------|
| Q1      | January   | LTS point release      |
| Q2      | April     | Maintenance release    |
| Q3      | July      | LTS point release      |
| Q4      | October   | Maintenance release    |

- **LTS point releases** (Q1, Q3): Include new features, updated packages,
  kernel bumps within the LTS branch, and improvements
- **Maintenance releases** (Q2, Q4): Security updates, bug fixes, package
  refreshes. No breaking changes.

## Versioning

```
YYYY.quarter.patch
Example: 2026.2.1 → Q2 2026, first patch
```

## Support Window

Each major LTS release receives **2 years of support** from its initial
release date, with quarterly ISO snapshots.

## Build Pipeline

ISOs are automatically built via GitHub Actions on a cron schedule:
- 1st of January, April, July, October
- Manual trigger available for urgent releases

## Why Semi-LTS?

Unlike rolling release models (where things break unexpectedly) or fixed
LTS models (where packages stagnate for years), Semi-LTS gives you:

- **Stability** — The core system is tested and frozen between quarters
- **Freshness** — Packages are updated quarterly, not every 2-5 years
- **Predictability** — You know exactly when updates will land
- **Security** — Backported fixes for the lifetime of each release

This is Arch-based, just better, more stable.
