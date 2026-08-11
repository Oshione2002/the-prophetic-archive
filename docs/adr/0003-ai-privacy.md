# ADR 0003: Local retrieval before AI

SQLite FTS5 retrieves at most eight blocks locally. Only those blocks and the question cross the network. AI is disabled by default; citations are allow-listed against the submitted source IDs.
