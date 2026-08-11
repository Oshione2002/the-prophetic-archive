# ADR 0002: Provider boundaries

Catalogue hosting, downloads, storage, PDF, TTS, AI, and future sync are accessed through contracts. Flutter widgets consume Riverpod-provided repositories and contain no raw SQL or provider credentials.
