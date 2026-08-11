# Content Guide

## Collections

V1 has exactly four top-level collections: Prophetic Scrolls, Special Writings, Translation Alerts, and Monthly Letters. Preliminary Pages are ordered inside Prophetic Scrolls before Scroll 1; they are not a collection, Scroll 0, introduction, or preface.

Prophetic Scrolls contains 320 unique numbered Scrolls. Multipart files remain separate documents using stable IDs such as `scroll-320-part-1`, but all parts share `parentNumber: 320` and do not increase the unique Scroll count.

## Naming

- Scroll PDFs: `Scroll 001.pdf`; originals: `Scroll 001 - Original.pdf`.
- Multipart: `Scroll 320 - Part 1.pdf` and `Scroll 320 - Part 1 - Original.pdf`.
- Special Writings: `001 - Title.pdf`; unknown source numbers remain null and unverified.
- Translation Alerts: `001 - The Qualifications.pdf`; do not repeat “Translation Alert” inside the collection.
- Monthly Letters: `2005-06 - June 2005.pdf`; author/signatory metadata is nullable and never inferred.

## Structured content

Documents contain stable ordered blocks: `heading`, `paragraph`, `numbered_item`, `quotation`, `scripture_reference`, `image`, and `divider`. Translation Alert point numbers remain explicit and independently addressable. IDs and block IDs must not change for spelling/title corrections.

Capabilities control actions. Pages may have responsive text and PDF but never Original Scan. PDFs and Original Scans are independent assets and may not overwrite one another.

Run `dart run tool/content_pipeline/main.dart --validate-only` before publishing. DOCX masters are private editing material and must not be committed or distributed.
