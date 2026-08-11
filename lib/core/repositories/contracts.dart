import '../domain/archive_models.dart';

abstract interface class CatalogueRepository {
  Future<ArchiveCatalogue> loadCatalogue({bool forceRefresh = false});
}

abstract interface class LibraryRepository {
  Future<List<CollectionSummary>> getCollections();
  Future<Map<String, String>> getDownloadStates();
  Future<Set<String>> getInstalledCollectionIds();
  Future<List<ArchiveDocument>> getDocuments(String collectionId);
  Future<void> downloadCollection(String collectionId);
  Future<int> updateDownloadedCollections();
  Future<void> removeCollection(String collectionId);
}

abstract interface class DocumentRepository {
  Future<ArchiveDocument?> getDocument(String id);
  Future<List<DocumentBlock>> getBlocks(String documentId);
  Future<List<BibleBook>> getBibleBooks(String collectionId);
  Future<List<BibleVerse>> getBibleVerses(
    String collectionId,
    String bookId,
    int chapter,
  );
  Future<BibleReferenceTarget?> resolveBibleReference(String reference);
}

abstract interface class SearchRepository {
  Future<List<SearchHit>> search(
    String query, {
    String? collectionId,
    int limit = 50,
  });
}

abstract interface class DownloadRepository {
  Future<void> downloadCollection(String collectionId);
  Future<void> downloadAsset(String documentId, DocumentAsset asset);
  Future<void> removeAsset(String assetId);
  Future<void> cancel(String collectionId);
  Future<void> retry(String collectionId);
}

abstract interface class StudyRepository {
  Future<List<BookmarkRecord>> getBookmarks();
  Future<bool> isBookmarked(String documentId, {String? blockId});
  Future<void> toggleBookmark(ArchiveDocument document, {String? blockId});
  Future<List<HighlightRecord>> getHighlights({String? documentId});
  Future<void> addHighlight({
    required String documentId,
    required String blockId,
    required int startOffset,
    required int endOffset,
    required String selectedText,
  });
  Future<List<NoteRecord>> getNotes({String? documentId});
  Future<void> addNote(
    ArchiveDocument document,
    String body, {
    String? blockId,
  });
  Future<List<ReadingProgressRecord>> getReadingHistory();
  Future<void> saveProgress(
    ArchiveDocument document, {
    String? blockId,
    required double percentage,
  });
}

abstract interface class SettingsRepository {
  Future<String> getStoragePath();
  Future<String?> getValue(String key);
  Future<void> setValue(String key, String value);
}

abstract interface class AIRepository {
  Future<AiAnswer> ask(String question, List<AiSource> sources);
}

abstract interface class SyncRepository {
  Future<void> synchronize();
}

abstract interface class FileStore {
  Future<String> temporaryPath(String name);
  Future<String> assetPath(String assetId, String fileName);
}

abstract interface class DiskSpaceService {
  Future<int?> getFreeBytes(String path);
}

abstract interface class TextToSpeechService {
  Future<void> speak(
    List<DocumentBlock> blocks, {
    double rate = 0.5,
    void Function(DocumentBlock block)? onBlockChanged,
    void Function(DocumentBlock block, int start, int end)? onProgress,
  });
  Future<void> pause();
  Future<void> resume();
  Future<void> stop();
}

abstract interface class ContentInstaller {
  Future<void> install(CollectionSummary collection);
  Future<void> remove(String collectionId);
}
