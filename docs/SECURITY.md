# Security and Privacy

- Never commit API keys, signing keys, private DOCX masters, or production secrets.
- Accept only HTTPS production endpoints and supported JSON/pack schemas.
- Verify declared size, SHA-256, SQLite integrity, stable IDs, and safe archive paths before activation.
- Keep the prior collection active until replacement succeeds.
- AI sends only the question and capped locally retrieved excerpts. It never sends notes, highlights, bookmarks, history, or the database.
- Validate returned source IDs against the supplied source set in both Worker and app.
- Logs must omit questions, excerpts, personal study data, and secrets.
