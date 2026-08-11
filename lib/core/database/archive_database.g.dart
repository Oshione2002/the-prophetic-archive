// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'archive_database.dart';

// ignore_for_file: type=lint
class ArchiveCollections extends Table
    with TableInfo<ArchiveCollections, ArchiveCollection> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  ArchiveCollections(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _slugMeta = const VerificationMeta('slug');
  late final GeneratedColumn<String> slug = GeneratedColumn<String>(
    'slug',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL UNIQUE',
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _collectionTypeMeta = const VerificationMeta(
    'collectionType',
  );
  late final GeneratedColumn<String> collectionType = GeneratedColumn<String>(
    'collection_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _displayOrderMeta = const VerificationMeta(
    'displayOrder',
  );
  late final GeneratedColumn<int> displayOrder = GeneratedColumn<int>(
    'display_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _documentCountMeta = const VerificationMeta(
    'documentCount',
  );
  late final GeneratedColumn<int> documentCount = GeneratedColumn<int>(
    'document_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _uniqueItemCountMeta = const VerificationMeta(
    'uniqueItemCount',
  );
  late final GeneratedColumn<int> uniqueItemCount = GeneratedColumn<int>(
    'unique_item_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _contentVersionMeta = const VerificationMeta(
    'contentVersion',
  );
  late final GeneratedColumn<int> contentVersion = GeneratedColumn<int>(
    'content_version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _metadataJsonMeta = const VerificationMeta(
    'metadataJson',
  );
  late final GeneratedColumn<String> metadataJson = GeneratedColumn<String>(
    'metadata_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT \'{}\'',
    defaultValue: const CustomExpression('\'{}\''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    slug,
    name,
    description,
    collectionType,
    displayOrder,
    documentCount,
    uniqueItemCount,
    contentVersion,
    metadataJson,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'archive_collections';
  @override
  VerificationContext validateIntegrity(
    Insertable<ArchiveCollection> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('slug')) {
      context.handle(
        _slugMeta,
        slug.isAcceptableOrUnknown(data['slug']!, _slugMeta),
      );
    } else if (isInserting) {
      context.missing(_slugMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('collection_type')) {
      context.handle(
        _collectionTypeMeta,
        collectionType.isAcceptableOrUnknown(
          data['collection_type']!,
          _collectionTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_collectionTypeMeta);
    }
    if (data.containsKey('display_order')) {
      context.handle(
        _displayOrderMeta,
        displayOrder.isAcceptableOrUnknown(
          data['display_order']!,
          _displayOrderMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayOrderMeta);
    }
    if (data.containsKey('document_count')) {
      context.handle(
        _documentCountMeta,
        documentCount.isAcceptableOrUnknown(
          data['document_count']!,
          _documentCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_documentCountMeta);
    }
    if (data.containsKey('unique_item_count')) {
      context.handle(
        _uniqueItemCountMeta,
        uniqueItemCount.isAcceptableOrUnknown(
          data['unique_item_count']!,
          _uniqueItemCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_uniqueItemCountMeta);
    }
    if (data.containsKey('content_version')) {
      context.handle(
        _contentVersionMeta,
        contentVersion.isAcceptableOrUnknown(
          data['content_version']!,
          _contentVersionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contentVersionMeta);
    }
    if (data.containsKey('metadata_json')) {
      context.handle(
        _metadataJsonMeta,
        metadataJson.isAcceptableOrUnknown(
          data['metadata_json']!,
          _metadataJsonMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ArchiveCollection map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ArchiveCollection(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      slug: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}slug'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      collectionType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}collection_type'],
      )!,
      displayOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}display_order'],
      )!,
      documentCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}document_count'],
      )!,
      uniqueItemCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}unique_item_count'],
      )!,
      contentVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}content_version'],
      )!,
      metadataJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metadata_json'],
      )!,
    );
  }

  @override
  ArchiveCollections createAlias(String alias) {
    return ArchiveCollections(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class ArchiveCollection extends DataClass
    implements Insertable<ArchiveCollection> {
  final String id;
  final String slug;
  final String name;
  final String description;
  final String collectionType;
  final int displayOrder;
  final int documentCount;
  final int uniqueItemCount;
  final int contentVersion;
  final String metadataJson;
  const ArchiveCollection({
    required this.id,
    required this.slug,
    required this.name,
    required this.description,
    required this.collectionType,
    required this.displayOrder,
    required this.documentCount,
    required this.uniqueItemCount,
    required this.contentVersion,
    required this.metadataJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['slug'] = Variable<String>(slug);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['collection_type'] = Variable<String>(collectionType);
    map['display_order'] = Variable<int>(displayOrder);
    map['document_count'] = Variable<int>(documentCount);
    map['unique_item_count'] = Variable<int>(uniqueItemCount);
    map['content_version'] = Variable<int>(contentVersion);
    map['metadata_json'] = Variable<String>(metadataJson);
    return map;
  }

  ArchiveCollectionsCompanion toCompanion(bool nullToAbsent) {
    return ArchiveCollectionsCompanion(
      id: Value(id),
      slug: Value(slug),
      name: Value(name),
      description: Value(description),
      collectionType: Value(collectionType),
      displayOrder: Value(displayOrder),
      documentCount: Value(documentCount),
      uniqueItemCount: Value(uniqueItemCount),
      contentVersion: Value(contentVersion),
      metadataJson: Value(metadataJson),
    );
  }

  factory ArchiveCollection.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ArchiveCollection(
      id: serializer.fromJson<String>(json['id']),
      slug: serializer.fromJson<String>(json['slug']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      collectionType: serializer.fromJson<String>(json['collection_type']),
      displayOrder: serializer.fromJson<int>(json['display_order']),
      documentCount: serializer.fromJson<int>(json['document_count']),
      uniqueItemCount: serializer.fromJson<int>(json['unique_item_count']),
      contentVersion: serializer.fromJson<int>(json['content_version']),
      metadataJson: serializer.fromJson<String>(json['metadata_json']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'slug': serializer.toJson<String>(slug),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'collection_type': serializer.toJson<String>(collectionType),
      'display_order': serializer.toJson<int>(displayOrder),
      'document_count': serializer.toJson<int>(documentCount),
      'unique_item_count': serializer.toJson<int>(uniqueItemCount),
      'content_version': serializer.toJson<int>(contentVersion),
      'metadata_json': serializer.toJson<String>(metadataJson),
    };
  }

  ArchiveCollection copyWith({
    String? id,
    String? slug,
    String? name,
    String? description,
    String? collectionType,
    int? displayOrder,
    int? documentCount,
    int? uniqueItemCount,
    int? contentVersion,
    String? metadataJson,
  }) => ArchiveCollection(
    id: id ?? this.id,
    slug: slug ?? this.slug,
    name: name ?? this.name,
    description: description ?? this.description,
    collectionType: collectionType ?? this.collectionType,
    displayOrder: displayOrder ?? this.displayOrder,
    documentCount: documentCount ?? this.documentCount,
    uniqueItemCount: uniqueItemCount ?? this.uniqueItemCount,
    contentVersion: contentVersion ?? this.contentVersion,
    metadataJson: metadataJson ?? this.metadataJson,
  );
  ArchiveCollection copyWithCompanion(ArchiveCollectionsCompanion data) {
    return ArchiveCollection(
      id: data.id.present ? data.id.value : this.id,
      slug: data.slug.present ? data.slug.value : this.slug,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      collectionType: data.collectionType.present
          ? data.collectionType.value
          : this.collectionType,
      displayOrder: data.displayOrder.present
          ? data.displayOrder.value
          : this.displayOrder,
      documentCount: data.documentCount.present
          ? data.documentCount.value
          : this.documentCount,
      uniqueItemCount: data.uniqueItemCount.present
          ? data.uniqueItemCount.value
          : this.uniqueItemCount,
      contentVersion: data.contentVersion.present
          ? data.contentVersion.value
          : this.contentVersion,
      metadataJson: data.metadataJson.present
          ? data.metadataJson.value
          : this.metadataJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ArchiveCollection(')
          ..write('id: $id, ')
          ..write('slug: $slug, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('collectionType: $collectionType, ')
          ..write('displayOrder: $displayOrder, ')
          ..write('documentCount: $documentCount, ')
          ..write('uniqueItemCount: $uniqueItemCount, ')
          ..write('contentVersion: $contentVersion, ')
          ..write('metadataJson: $metadataJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    slug,
    name,
    description,
    collectionType,
    displayOrder,
    documentCount,
    uniqueItemCount,
    contentVersion,
    metadataJson,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ArchiveCollection &&
          other.id == this.id &&
          other.slug == this.slug &&
          other.name == this.name &&
          other.description == this.description &&
          other.collectionType == this.collectionType &&
          other.displayOrder == this.displayOrder &&
          other.documentCount == this.documentCount &&
          other.uniqueItemCount == this.uniqueItemCount &&
          other.contentVersion == this.contentVersion &&
          other.metadataJson == this.metadataJson);
}

class ArchiveCollectionsCompanion extends UpdateCompanion<ArchiveCollection> {
  final Value<String> id;
  final Value<String> slug;
  final Value<String> name;
  final Value<String> description;
  final Value<String> collectionType;
  final Value<int> displayOrder;
  final Value<int> documentCount;
  final Value<int> uniqueItemCount;
  final Value<int> contentVersion;
  final Value<String> metadataJson;
  final Value<int> rowid;
  const ArchiveCollectionsCompanion({
    this.id = const Value.absent(),
    this.slug = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.collectionType = const Value.absent(),
    this.displayOrder = const Value.absent(),
    this.documentCount = const Value.absent(),
    this.uniqueItemCount = const Value.absent(),
    this.contentVersion = const Value.absent(),
    this.metadataJson = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ArchiveCollectionsCompanion.insert({
    required String id,
    required String slug,
    required String name,
    required String description,
    required String collectionType,
    required int displayOrder,
    required int documentCount,
    required int uniqueItemCount,
    required int contentVersion,
    this.metadataJson = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       slug = Value(slug),
       name = Value(name),
       description = Value(description),
       collectionType = Value(collectionType),
       displayOrder = Value(displayOrder),
       documentCount = Value(documentCount),
       uniqueItemCount = Value(uniqueItemCount),
       contentVersion = Value(contentVersion);
  static Insertable<ArchiveCollection> custom({
    Expression<String>? id,
    Expression<String>? slug,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? collectionType,
    Expression<int>? displayOrder,
    Expression<int>? documentCount,
    Expression<int>? uniqueItemCount,
    Expression<int>? contentVersion,
    Expression<String>? metadataJson,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (slug != null) 'slug': slug,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (collectionType != null) 'collection_type': collectionType,
      if (displayOrder != null) 'display_order': displayOrder,
      if (documentCount != null) 'document_count': documentCount,
      if (uniqueItemCount != null) 'unique_item_count': uniqueItemCount,
      if (contentVersion != null) 'content_version': contentVersion,
      if (metadataJson != null) 'metadata_json': metadataJson,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ArchiveCollectionsCompanion copyWith({
    Value<String>? id,
    Value<String>? slug,
    Value<String>? name,
    Value<String>? description,
    Value<String>? collectionType,
    Value<int>? displayOrder,
    Value<int>? documentCount,
    Value<int>? uniqueItemCount,
    Value<int>? contentVersion,
    Value<String>? metadataJson,
    Value<int>? rowid,
  }) {
    return ArchiveCollectionsCompanion(
      id: id ?? this.id,
      slug: slug ?? this.slug,
      name: name ?? this.name,
      description: description ?? this.description,
      collectionType: collectionType ?? this.collectionType,
      displayOrder: displayOrder ?? this.displayOrder,
      documentCount: documentCount ?? this.documentCount,
      uniqueItemCount: uniqueItemCount ?? this.uniqueItemCount,
      contentVersion: contentVersion ?? this.contentVersion,
      metadataJson: metadataJson ?? this.metadataJson,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (slug.present) {
      map['slug'] = Variable<String>(slug.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (collectionType.present) {
      map['collection_type'] = Variable<String>(collectionType.value);
    }
    if (displayOrder.present) {
      map['display_order'] = Variable<int>(displayOrder.value);
    }
    if (documentCount.present) {
      map['document_count'] = Variable<int>(documentCount.value);
    }
    if (uniqueItemCount.present) {
      map['unique_item_count'] = Variable<int>(uniqueItemCount.value);
    }
    if (contentVersion.present) {
      map['content_version'] = Variable<int>(contentVersion.value);
    }
    if (metadataJson.present) {
      map['metadata_json'] = Variable<String>(metadataJson.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ArchiveCollectionsCompanion(')
          ..write('id: $id, ')
          ..write('slug: $slug, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('collectionType: $collectionType, ')
          ..write('displayOrder: $displayOrder, ')
          ..write('documentCount: $documentCount, ')
          ..write('uniqueItemCount: $uniqueItemCount, ')
          ..write('contentVersion: $contentVersion, ')
          ..write('metadataJson: $metadataJson, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class Documents extends Table with TableInfo<Documents, Document> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Documents(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _collectionIdMeta = const VerificationMeta(
    'collectionId',
  );
  late final GeneratedColumn<String> collectionId = GeneratedColumn<String>(
    'collection_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints:
        'NOT NULL REFERENCES archive_collections(id)ON DELETE CASCADE',
  );
  static const VerificationMeta _slugMeta = const VerificationMeta('slug');
  late final GeneratedColumn<String> slug = GeneratedColumn<String>(
    'slug',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL UNIQUE',
  );
  static const VerificationMeta _displayTitleMeta = const VerificationMeta(
    'displayTitle',
  );
  late final GeneratedColumn<String> displayTitle = GeneratedColumn<String>(
    'display_title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _documentTypeMeta = const VerificationMeta(
    'documentType',
  );
  late final GeneratedColumn<String> documentType = GeneratedColumn<String>(
    'document_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _documentNumberMeta = const VerificationMeta(
    'documentNumber',
  );
  late final GeneratedColumn<int> documentNumber = GeneratedColumn<int>(
    'document_number',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _parentNumberMeta = const VerificationMeta(
    'parentNumber',
  );
  late final GeneratedColumn<int> parentNumber = GeneratedColumn<int>(
    'parent_number',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _partNumberMeta = const VerificationMeta(
    'partNumber',
  );
  late final GeneratedColumn<int> partNumber = GeneratedColumn<int>(
    'part_number',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _partLabelMeta = const VerificationMeta(
    'partLabel',
  );
  late final GeneratedColumn<String> partLabel = GeneratedColumn<String>(
    'part_label',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _subtitleMeta = const VerificationMeta(
    'subtitle',
  );
  late final GeneratedColumn<String> subtitle = GeneratedColumn<String>(
    'subtitle',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _authorMeta = const VerificationMeta('author');
  late final GeneratedColumn<String> author = GeneratedColumn<String>(
    'author',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _speakerMeta = const VerificationMeta(
    'speaker',
  );
  late final GeneratedColumn<String> speaker = GeneratedColumn<String>(
    'speaker',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _publicationDateMeta = const VerificationMeta(
    'publicationDate',
  );
  late final GeneratedColumn<String> publicationDate = GeneratedColumn<String>(
    'publication_date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _yearMeta = const VerificationMeta('year');
  late final GeneratedColumn<int> year = GeneratedColumn<int>(
    'year',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _monthMeta = const VerificationMeta('month');
  late final GeneratedColumn<int> month = GeneratedColumn<int>(
    'month',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _hasResponsiveTextMeta = const VerificationMeta(
    'hasResponsiveText',
  );
  late final GeneratedColumn<int> hasResponsiveText = GeneratedColumn<int>(
    'has_responsive_text',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints:
        'NOT NULL DEFAULT 1 CHECK (has_responsive_text IN (0, 1))',
    defaultValue: const CustomExpression('1'),
  );
  static const VerificationMeta _hasCleanPdfMeta = const VerificationMeta(
    'hasCleanPdf',
  );
  late final GeneratedColumn<int> hasCleanPdf = GeneratedColumn<int>(
    'has_clean_pdf',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT 0 CHECK (has_clean_pdf IN (0, 1))',
    defaultValue: const CustomExpression('0'),
  );
  static const VerificationMeta _hasOriginalScanMeta = const VerificationMeta(
    'hasOriginalScan',
  );
  late final GeneratedColumn<int> hasOriginalScan = GeneratedColumn<int>(
    'has_original_scan',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints:
        'NOT NULL DEFAULT 0 CHECK (has_original_scan IN (0, 1))',
    defaultValue: const CustomExpression('0'),
  );
  static const VerificationMeta _contentVersionMeta = const VerificationMeta(
    'contentVersion',
  );
  late final GeneratedColumn<int> contentVersion = GeneratedColumn<int>(
    'content_version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _numberVerifiedMeta = const VerificationMeta(
    'numberVerified',
  );
  late final GeneratedColumn<int> numberVerified = GeneratedColumn<int>(
    'number_verified',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT 0 CHECK (number_verified IN (0, 1))',
    defaultValue: const CustomExpression('0'),
  );
  static const VerificationMeta _metadataJsonMeta = const VerificationMeta(
    'metadataJson',
  );
  late final GeneratedColumn<String> metadataJson = GeneratedColumn<String>(
    'metadata_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT \'{}\'',
    defaultValue: const CustomExpression('\'{}\''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    collectionId,
    slug,
    displayTitle,
    documentType,
    documentNumber,
    parentNumber,
    partNumber,
    partLabel,
    subtitle,
    author,
    speaker,
    publicationDate,
    year,
    month,
    sortOrder,
    hasResponsiveText,
    hasCleanPdf,
    hasOriginalScan,
    contentVersion,
    numberVerified,
    metadataJson,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'documents';
  @override
  VerificationContext validateIntegrity(
    Insertable<Document> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('collection_id')) {
      context.handle(
        _collectionIdMeta,
        collectionId.isAcceptableOrUnknown(
          data['collection_id']!,
          _collectionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_collectionIdMeta);
    }
    if (data.containsKey('slug')) {
      context.handle(
        _slugMeta,
        slug.isAcceptableOrUnknown(data['slug']!, _slugMeta),
      );
    } else if (isInserting) {
      context.missing(_slugMeta);
    }
    if (data.containsKey('display_title')) {
      context.handle(
        _displayTitleMeta,
        displayTitle.isAcceptableOrUnknown(
          data['display_title']!,
          _displayTitleMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayTitleMeta);
    }
    if (data.containsKey('document_type')) {
      context.handle(
        _documentTypeMeta,
        documentType.isAcceptableOrUnknown(
          data['document_type']!,
          _documentTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_documentTypeMeta);
    }
    if (data.containsKey('document_number')) {
      context.handle(
        _documentNumberMeta,
        documentNumber.isAcceptableOrUnknown(
          data['document_number']!,
          _documentNumberMeta,
        ),
      );
    }
    if (data.containsKey('parent_number')) {
      context.handle(
        _parentNumberMeta,
        parentNumber.isAcceptableOrUnknown(
          data['parent_number']!,
          _parentNumberMeta,
        ),
      );
    }
    if (data.containsKey('part_number')) {
      context.handle(
        _partNumberMeta,
        partNumber.isAcceptableOrUnknown(data['part_number']!, _partNumberMeta),
      );
    }
    if (data.containsKey('part_label')) {
      context.handle(
        _partLabelMeta,
        partLabel.isAcceptableOrUnknown(data['part_label']!, _partLabelMeta),
      );
    }
    if (data.containsKey('subtitle')) {
      context.handle(
        _subtitleMeta,
        subtitle.isAcceptableOrUnknown(data['subtitle']!, _subtitleMeta),
      );
    }
    if (data.containsKey('author')) {
      context.handle(
        _authorMeta,
        author.isAcceptableOrUnknown(data['author']!, _authorMeta),
      );
    }
    if (data.containsKey('speaker')) {
      context.handle(
        _speakerMeta,
        speaker.isAcceptableOrUnknown(data['speaker']!, _speakerMeta),
      );
    }
    if (data.containsKey('publication_date')) {
      context.handle(
        _publicationDateMeta,
        publicationDate.isAcceptableOrUnknown(
          data['publication_date']!,
          _publicationDateMeta,
        ),
      );
    }
    if (data.containsKey('year')) {
      context.handle(
        _yearMeta,
        year.isAcceptableOrUnknown(data['year']!, _yearMeta),
      );
    }
    if (data.containsKey('month')) {
      context.handle(
        _monthMeta,
        month.isAcceptableOrUnknown(data['month']!, _monthMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    if (data.containsKey('has_responsive_text')) {
      context.handle(
        _hasResponsiveTextMeta,
        hasResponsiveText.isAcceptableOrUnknown(
          data['has_responsive_text']!,
          _hasResponsiveTextMeta,
        ),
      );
    }
    if (data.containsKey('has_clean_pdf')) {
      context.handle(
        _hasCleanPdfMeta,
        hasCleanPdf.isAcceptableOrUnknown(
          data['has_clean_pdf']!,
          _hasCleanPdfMeta,
        ),
      );
    }
    if (data.containsKey('has_original_scan')) {
      context.handle(
        _hasOriginalScanMeta,
        hasOriginalScan.isAcceptableOrUnknown(
          data['has_original_scan']!,
          _hasOriginalScanMeta,
        ),
      );
    }
    if (data.containsKey('content_version')) {
      context.handle(
        _contentVersionMeta,
        contentVersion.isAcceptableOrUnknown(
          data['content_version']!,
          _contentVersionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contentVersionMeta);
    }
    if (data.containsKey('number_verified')) {
      context.handle(
        _numberVerifiedMeta,
        numberVerified.isAcceptableOrUnknown(
          data['number_verified']!,
          _numberVerifiedMeta,
        ),
      );
    }
    if (data.containsKey('metadata_json')) {
      context.handle(
        _metadataJsonMeta,
        metadataJson.isAcceptableOrUnknown(
          data['metadata_json']!,
          _metadataJsonMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Document map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Document(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      collectionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}collection_id'],
      )!,
      slug: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}slug'],
      )!,
      displayTitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_title'],
      )!,
      documentType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}document_type'],
      )!,
      documentNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}document_number'],
      ),
      parentNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}parent_number'],
      ),
      partNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}part_number'],
      ),
      partLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}part_label'],
      ),
      subtitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subtitle'],
      ),
      author: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}author'],
      ),
      speaker: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}speaker'],
      ),
      publicationDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}publication_date'],
      ),
      year: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}year'],
      ),
      month: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}month'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      hasResponsiveText: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}has_responsive_text'],
      )!,
      hasCleanPdf: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}has_clean_pdf'],
      )!,
      hasOriginalScan: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}has_original_scan'],
      )!,
      contentVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}content_version'],
      )!,
      numberVerified: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}number_verified'],
      )!,
      metadataJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metadata_json'],
      )!,
    );
  }

  @override
  Documents createAlias(String alias) {
    return Documents(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class Document extends DataClass implements Insertable<Document> {
  final String id;
  final String collectionId;
  final String slug;
  final String displayTitle;
  final String documentType;
  final int? documentNumber;
  final int? parentNumber;
  final int? partNumber;
  final String? partLabel;
  final String? subtitle;
  final String? author;
  final String? speaker;
  final String? publicationDate;
  final int? year;
  final int? month;
  final int sortOrder;
  final int hasResponsiveText;
  final int hasCleanPdf;
  final int hasOriginalScan;
  final int contentVersion;
  final int numberVerified;
  final String metadataJson;
  const Document({
    required this.id,
    required this.collectionId,
    required this.slug,
    required this.displayTitle,
    required this.documentType,
    this.documentNumber,
    this.parentNumber,
    this.partNumber,
    this.partLabel,
    this.subtitle,
    this.author,
    this.speaker,
    this.publicationDate,
    this.year,
    this.month,
    required this.sortOrder,
    required this.hasResponsiveText,
    required this.hasCleanPdf,
    required this.hasOriginalScan,
    required this.contentVersion,
    required this.numberVerified,
    required this.metadataJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['collection_id'] = Variable<String>(collectionId);
    map['slug'] = Variable<String>(slug);
    map['display_title'] = Variable<String>(displayTitle);
    map['document_type'] = Variable<String>(documentType);
    if (!nullToAbsent || documentNumber != null) {
      map['document_number'] = Variable<int>(documentNumber);
    }
    if (!nullToAbsent || parentNumber != null) {
      map['parent_number'] = Variable<int>(parentNumber);
    }
    if (!nullToAbsent || partNumber != null) {
      map['part_number'] = Variable<int>(partNumber);
    }
    if (!nullToAbsent || partLabel != null) {
      map['part_label'] = Variable<String>(partLabel);
    }
    if (!nullToAbsent || subtitle != null) {
      map['subtitle'] = Variable<String>(subtitle);
    }
    if (!nullToAbsent || author != null) {
      map['author'] = Variable<String>(author);
    }
    if (!nullToAbsent || speaker != null) {
      map['speaker'] = Variable<String>(speaker);
    }
    if (!nullToAbsent || publicationDate != null) {
      map['publication_date'] = Variable<String>(publicationDate);
    }
    if (!nullToAbsent || year != null) {
      map['year'] = Variable<int>(year);
    }
    if (!nullToAbsent || month != null) {
      map['month'] = Variable<int>(month);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    map['has_responsive_text'] = Variable<int>(hasResponsiveText);
    map['has_clean_pdf'] = Variable<int>(hasCleanPdf);
    map['has_original_scan'] = Variable<int>(hasOriginalScan);
    map['content_version'] = Variable<int>(contentVersion);
    map['number_verified'] = Variable<int>(numberVerified);
    map['metadata_json'] = Variable<String>(metadataJson);
    return map;
  }

  DocumentsCompanion toCompanion(bool nullToAbsent) {
    return DocumentsCompanion(
      id: Value(id),
      collectionId: Value(collectionId),
      slug: Value(slug),
      displayTitle: Value(displayTitle),
      documentType: Value(documentType),
      documentNumber: documentNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(documentNumber),
      parentNumber: parentNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(parentNumber),
      partNumber: partNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(partNumber),
      partLabel: partLabel == null && nullToAbsent
          ? const Value.absent()
          : Value(partLabel),
      subtitle: subtitle == null && nullToAbsent
          ? const Value.absent()
          : Value(subtitle),
      author: author == null && nullToAbsent
          ? const Value.absent()
          : Value(author),
      speaker: speaker == null && nullToAbsent
          ? const Value.absent()
          : Value(speaker),
      publicationDate: publicationDate == null && nullToAbsent
          ? const Value.absent()
          : Value(publicationDate),
      year: year == null && nullToAbsent ? const Value.absent() : Value(year),
      month: month == null && nullToAbsent
          ? const Value.absent()
          : Value(month),
      sortOrder: Value(sortOrder),
      hasResponsiveText: Value(hasResponsiveText),
      hasCleanPdf: Value(hasCleanPdf),
      hasOriginalScan: Value(hasOriginalScan),
      contentVersion: Value(contentVersion),
      numberVerified: Value(numberVerified),
      metadataJson: Value(metadataJson),
    );
  }

  factory Document.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Document(
      id: serializer.fromJson<String>(json['id']),
      collectionId: serializer.fromJson<String>(json['collection_id']),
      slug: serializer.fromJson<String>(json['slug']),
      displayTitle: serializer.fromJson<String>(json['display_title']),
      documentType: serializer.fromJson<String>(json['document_type']),
      documentNumber: serializer.fromJson<int?>(json['document_number']),
      parentNumber: serializer.fromJson<int?>(json['parent_number']),
      partNumber: serializer.fromJson<int?>(json['part_number']),
      partLabel: serializer.fromJson<String?>(json['part_label']),
      subtitle: serializer.fromJson<String?>(json['subtitle']),
      author: serializer.fromJson<String?>(json['author']),
      speaker: serializer.fromJson<String?>(json['speaker']),
      publicationDate: serializer.fromJson<String?>(json['publication_date']),
      year: serializer.fromJson<int?>(json['year']),
      month: serializer.fromJson<int?>(json['month']),
      sortOrder: serializer.fromJson<int>(json['sort_order']),
      hasResponsiveText: serializer.fromJson<int>(json['has_responsive_text']),
      hasCleanPdf: serializer.fromJson<int>(json['has_clean_pdf']),
      hasOriginalScan: serializer.fromJson<int>(json['has_original_scan']),
      contentVersion: serializer.fromJson<int>(json['content_version']),
      numberVerified: serializer.fromJson<int>(json['number_verified']),
      metadataJson: serializer.fromJson<String>(json['metadata_json']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'collection_id': serializer.toJson<String>(collectionId),
      'slug': serializer.toJson<String>(slug),
      'display_title': serializer.toJson<String>(displayTitle),
      'document_type': serializer.toJson<String>(documentType),
      'document_number': serializer.toJson<int?>(documentNumber),
      'parent_number': serializer.toJson<int?>(parentNumber),
      'part_number': serializer.toJson<int?>(partNumber),
      'part_label': serializer.toJson<String?>(partLabel),
      'subtitle': serializer.toJson<String?>(subtitle),
      'author': serializer.toJson<String?>(author),
      'speaker': serializer.toJson<String?>(speaker),
      'publication_date': serializer.toJson<String?>(publicationDate),
      'year': serializer.toJson<int?>(year),
      'month': serializer.toJson<int?>(month),
      'sort_order': serializer.toJson<int>(sortOrder),
      'has_responsive_text': serializer.toJson<int>(hasResponsiveText),
      'has_clean_pdf': serializer.toJson<int>(hasCleanPdf),
      'has_original_scan': serializer.toJson<int>(hasOriginalScan),
      'content_version': serializer.toJson<int>(contentVersion),
      'number_verified': serializer.toJson<int>(numberVerified),
      'metadata_json': serializer.toJson<String>(metadataJson),
    };
  }

  Document copyWith({
    String? id,
    String? collectionId,
    String? slug,
    String? displayTitle,
    String? documentType,
    Value<int?> documentNumber = const Value.absent(),
    Value<int?> parentNumber = const Value.absent(),
    Value<int?> partNumber = const Value.absent(),
    Value<String?> partLabel = const Value.absent(),
    Value<String?> subtitle = const Value.absent(),
    Value<String?> author = const Value.absent(),
    Value<String?> speaker = const Value.absent(),
    Value<String?> publicationDate = const Value.absent(),
    Value<int?> year = const Value.absent(),
    Value<int?> month = const Value.absent(),
    int? sortOrder,
    int? hasResponsiveText,
    int? hasCleanPdf,
    int? hasOriginalScan,
    int? contentVersion,
    int? numberVerified,
    String? metadataJson,
  }) => Document(
    id: id ?? this.id,
    collectionId: collectionId ?? this.collectionId,
    slug: slug ?? this.slug,
    displayTitle: displayTitle ?? this.displayTitle,
    documentType: documentType ?? this.documentType,
    documentNumber: documentNumber.present
        ? documentNumber.value
        : this.documentNumber,
    parentNumber: parentNumber.present ? parentNumber.value : this.parentNumber,
    partNumber: partNumber.present ? partNumber.value : this.partNumber,
    partLabel: partLabel.present ? partLabel.value : this.partLabel,
    subtitle: subtitle.present ? subtitle.value : this.subtitle,
    author: author.present ? author.value : this.author,
    speaker: speaker.present ? speaker.value : this.speaker,
    publicationDate: publicationDate.present
        ? publicationDate.value
        : this.publicationDate,
    year: year.present ? year.value : this.year,
    month: month.present ? month.value : this.month,
    sortOrder: sortOrder ?? this.sortOrder,
    hasResponsiveText: hasResponsiveText ?? this.hasResponsiveText,
    hasCleanPdf: hasCleanPdf ?? this.hasCleanPdf,
    hasOriginalScan: hasOriginalScan ?? this.hasOriginalScan,
    contentVersion: contentVersion ?? this.contentVersion,
    numberVerified: numberVerified ?? this.numberVerified,
    metadataJson: metadataJson ?? this.metadataJson,
  );
  Document copyWithCompanion(DocumentsCompanion data) {
    return Document(
      id: data.id.present ? data.id.value : this.id,
      collectionId: data.collectionId.present
          ? data.collectionId.value
          : this.collectionId,
      slug: data.slug.present ? data.slug.value : this.slug,
      displayTitle: data.displayTitle.present
          ? data.displayTitle.value
          : this.displayTitle,
      documentType: data.documentType.present
          ? data.documentType.value
          : this.documentType,
      documentNumber: data.documentNumber.present
          ? data.documentNumber.value
          : this.documentNumber,
      parentNumber: data.parentNumber.present
          ? data.parentNumber.value
          : this.parentNumber,
      partNumber: data.partNumber.present
          ? data.partNumber.value
          : this.partNumber,
      partLabel: data.partLabel.present ? data.partLabel.value : this.partLabel,
      subtitle: data.subtitle.present ? data.subtitle.value : this.subtitle,
      author: data.author.present ? data.author.value : this.author,
      speaker: data.speaker.present ? data.speaker.value : this.speaker,
      publicationDate: data.publicationDate.present
          ? data.publicationDate.value
          : this.publicationDate,
      year: data.year.present ? data.year.value : this.year,
      month: data.month.present ? data.month.value : this.month,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      hasResponsiveText: data.hasResponsiveText.present
          ? data.hasResponsiveText.value
          : this.hasResponsiveText,
      hasCleanPdf: data.hasCleanPdf.present
          ? data.hasCleanPdf.value
          : this.hasCleanPdf,
      hasOriginalScan: data.hasOriginalScan.present
          ? data.hasOriginalScan.value
          : this.hasOriginalScan,
      contentVersion: data.contentVersion.present
          ? data.contentVersion.value
          : this.contentVersion,
      numberVerified: data.numberVerified.present
          ? data.numberVerified.value
          : this.numberVerified,
      metadataJson: data.metadataJson.present
          ? data.metadataJson.value
          : this.metadataJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Document(')
          ..write('id: $id, ')
          ..write('collectionId: $collectionId, ')
          ..write('slug: $slug, ')
          ..write('displayTitle: $displayTitle, ')
          ..write('documentType: $documentType, ')
          ..write('documentNumber: $documentNumber, ')
          ..write('parentNumber: $parentNumber, ')
          ..write('partNumber: $partNumber, ')
          ..write('partLabel: $partLabel, ')
          ..write('subtitle: $subtitle, ')
          ..write('author: $author, ')
          ..write('speaker: $speaker, ')
          ..write('publicationDate: $publicationDate, ')
          ..write('year: $year, ')
          ..write('month: $month, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('hasResponsiveText: $hasResponsiveText, ')
          ..write('hasCleanPdf: $hasCleanPdf, ')
          ..write('hasOriginalScan: $hasOriginalScan, ')
          ..write('contentVersion: $contentVersion, ')
          ..write('numberVerified: $numberVerified, ')
          ..write('metadataJson: $metadataJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    collectionId,
    slug,
    displayTitle,
    documentType,
    documentNumber,
    parentNumber,
    partNumber,
    partLabel,
    subtitle,
    author,
    speaker,
    publicationDate,
    year,
    month,
    sortOrder,
    hasResponsiveText,
    hasCleanPdf,
    hasOriginalScan,
    contentVersion,
    numberVerified,
    metadataJson,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Document &&
          other.id == this.id &&
          other.collectionId == this.collectionId &&
          other.slug == this.slug &&
          other.displayTitle == this.displayTitle &&
          other.documentType == this.documentType &&
          other.documentNumber == this.documentNumber &&
          other.parentNumber == this.parentNumber &&
          other.partNumber == this.partNumber &&
          other.partLabel == this.partLabel &&
          other.subtitle == this.subtitle &&
          other.author == this.author &&
          other.speaker == this.speaker &&
          other.publicationDate == this.publicationDate &&
          other.year == this.year &&
          other.month == this.month &&
          other.sortOrder == this.sortOrder &&
          other.hasResponsiveText == this.hasResponsiveText &&
          other.hasCleanPdf == this.hasCleanPdf &&
          other.hasOriginalScan == this.hasOriginalScan &&
          other.contentVersion == this.contentVersion &&
          other.numberVerified == this.numberVerified &&
          other.metadataJson == this.metadataJson);
}

class DocumentsCompanion extends UpdateCompanion<Document> {
  final Value<String> id;
  final Value<String> collectionId;
  final Value<String> slug;
  final Value<String> displayTitle;
  final Value<String> documentType;
  final Value<int?> documentNumber;
  final Value<int?> parentNumber;
  final Value<int?> partNumber;
  final Value<String?> partLabel;
  final Value<String?> subtitle;
  final Value<String?> author;
  final Value<String?> speaker;
  final Value<String?> publicationDate;
  final Value<int?> year;
  final Value<int?> month;
  final Value<int> sortOrder;
  final Value<int> hasResponsiveText;
  final Value<int> hasCleanPdf;
  final Value<int> hasOriginalScan;
  final Value<int> contentVersion;
  final Value<int> numberVerified;
  final Value<String> metadataJson;
  final Value<int> rowid;
  const DocumentsCompanion({
    this.id = const Value.absent(),
    this.collectionId = const Value.absent(),
    this.slug = const Value.absent(),
    this.displayTitle = const Value.absent(),
    this.documentType = const Value.absent(),
    this.documentNumber = const Value.absent(),
    this.parentNumber = const Value.absent(),
    this.partNumber = const Value.absent(),
    this.partLabel = const Value.absent(),
    this.subtitle = const Value.absent(),
    this.author = const Value.absent(),
    this.speaker = const Value.absent(),
    this.publicationDate = const Value.absent(),
    this.year = const Value.absent(),
    this.month = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.hasResponsiveText = const Value.absent(),
    this.hasCleanPdf = const Value.absent(),
    this.hasOriginalScan = const Value.absent(),
    this.contentVersion = const Value.absent(),
    this.numberVerified = const Value.absent(),
    this.metadataJson = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DocumentsCompanion.insert({
    required String id,
    required String collectionId,
    required String slug,
    required String displayTitle,
    required String documentType,
    this.documentNumber = const Value.absent(),
    this.parentNumber = const Value.absent(),
    this.partNumber = const Value.absent(),
    this.partLabel = const Value.absent(),
    this.subtitle = const Value.absent(),
    this.author = const Value.absent(),
    this.speaker = const Value.absent(),
    this.publicationDate = const Value.absent(),
    this.year = const Value.absent(),
    this.month = const Value.absent(),
    required int sortOrder,
    this.hasResponsiveText = const Value.absent(),
    this.hasCleanPdf = const Value.absent(),
    this.hasOriginalScan = const Value.absent(),
    required int contentVersion,
    this.numberVerified = const Value.absent(),
    this.metadataJson = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       collectionId = Value(collectionId),
       slug = Value(slug),
       displayTitle = Value(displayTitle),
       documentType = Value(documentType),
       sortOrder = Value(sortOrder),
       contentVersion = Value(contentVersion);
  static Insertable<Document> custom({
    Expression<String>? id,
    Expression<String>? collectionId,
    Expression<String>? slug,
    Expression<String>? displayTitle,
    Expression<String>? documentType,
    Expression<int>? documentNumber,
    Expression<int>? parentNumber,
    Expression<int>? partNumber,
    Expression<String>? partLabel,
    Expression<String>? subtitle,
    Expression<String>? author,
    Expression<String>? speaker,
    Expression<String>? publicationDate,
    Expression<int>? year,
    Expression<int>? month,
    Expression<int>? sortOrder,
    Expression<int>? hasResponsiveText,
    Expression<int>? hasCleanPdf,
    Expression<int>? hasOriginalScan,
    Expression<int>? contentVersion,
    Expression<int>? numberVerified,
    Expression<String>? metadataJson,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (collectionId != null) 'collection_id': collectionId,
      if (slug != null) 'slug': slug,
      if (displayTitle != null) 'display_title': displayTitle,
      if (documentType != null) 'document_type': documentType,
      if (documentNumber != null) 'document_number': documentNumber,
      if (parentNumber != null) 'parent_number': parentNumber,
      if (partNumber != null) 'part_number': partNumber,
      if (partLabel != null) 'part_label': partLabel,
      if (subtitle != null) 'subtitle': subtitle,
      if (author != null) 'author': author,
      if (speaker != null) 'speaker': speaker,
      if (publicationDate != null) 'publication_date': publicationDate,
      if (year != null) 'year': year,
      if (month != null) 'month': month,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (hasResponsiveText != null) 'has_responsive_text': hasResponsiveText,
      if (hasCleanPdf != null) 'has_clean_pdf': hasCleanPdf,
      if (hasOriginalScan != null) 'has_original_scan': hasOriginalScan,
      if (contentVersion != null) 'content_version': contentVersion,
      if (numberVerified != null) 'number_verified': numberVerified,
      if (metadataJson != null) 'metadata_json': metadataJson,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DocumentsCompanion copyWith({
    Value<String>? id,
    Value<String>? collectionId,
    Value<String>? slug,
    Value<String>? displayTitle,
    Value<String>? documentType,
    Value<int?>? documentNumber,
    Value<int?>? parentNumber,
    Value<int?>? partNumber,
    Value<String?>? partLabel,
    Value<String?>? subtitle,
    Value<String?>? author,
    Value<String?>? speaker,
    Value<String?>? publicationDate,
    Value<int?>? year,
    Value<int?>? month,
    Value<int>? sortOrder,
    Value<int>? hasResponsiveText,
    Value<int>? hasCleanPdf,
    Value<int>? hasOriginalScan,
    Value<int>? contentVersion,
    Value<int>? numberVerified,
    Value<String>? metadataJson,
    Value<int>? rowid,
  }) {
    return DocumentsCompanion(
      id: id ?? this.id,
      collectionId: collectionId ?? this.collectionId,
      slug: slug ?? this.slug,
      displayTitle: displayTitle ?? this.displayTitle,
      documentType: documentType ?? this.documentType,
      documentNumber: documentNumber ?? this.documentNumber,
      parentNumber: parentNumber ?? this.parentNumber,
      partNumber: partNumber ?? this.partNumber,
      partLabel: partLabel ?? this.partLabel,
      subtitle: subtitle ?? this.subtitle,
      author: author ?? this.author,
      speaker: speaker ?? this.speaker,
      publicationDate: publicationDate ?? this.publicationDate,
      year: year ?? this.year,
      month: month ?? this.month,
      sortOrder: sortOrder ?? this.sortOrder,
      hasResponsiveText: hasResponsiveText ?? this.hasResponsiveText,
      hasCleanPdf: hasCleanPdf ?? this.hasCleanPdf,
      hasOriginalScan: hasOriginalScan ?? this.hasOriginalScan,
      contentVersion: contentVersion ?? this.contentVersion,
      numberVerified: numberVerified ?? this.numberVerified,
      metadataJson: metadataJson ?? this.metadataJson,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (collectionId.present) {
      map['collection_id'] = Variable<String>(collectionId.value);
    }
    if (slug.present) {
      map['slug'] = Variable<String>(slug.value);
    }
    if (displayTitle.present) {
      map['display_title'] = Variable<String>(displayTitle.value);
    }
    if (documentType.present) {
      map['document_type'] = Variable<String>(documentType.value);
    }
    if (documentNumber.present) {
      map['document_number'] = Variable<int>(documentNumber.value);
    }
    if (parentNumber.present) {
      map['parent_number'] = Variable<int>(parentNumber.value);
    }
    if (partNumber.present) {
      map['part_number'] = Variable<int>(partNumber.value);
    }
    if (partLabel.present) {
      map['part_label'] = Variable<String>(partLabel.value);
    }
    if (subtitle.present) {
      map['subtitle'] = Variable<String>(subtitle.value);
    }
    if (author.present) {
      map['author'] = Variable<String>(author.value);
    }
    if (speaker.present) {
      map['speaker'] = Variable<String>(speaker.value);
    }
    if (publicationDate.present) {
      map['publication_date'] = Variable<String>(publicationDate.value);
    }
    if (year.present) {
      map['year'] = Variable<int>(year.value);
    }
    if (month.present) {
      map['month'] = Variable<int>(month.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (hasResponsiveText.present) {
      map['has_responsive_text'] = Variable<int>(hasResponsiveText.value);
    }
    if (hasCleanPdf.present) {
      map['has_clean_pdf'] = Variable<int>(hasCleanPdf.value);
    }
    if (hasOriginalScan.present) {
      map['has_original_scan'] = Variable<int>(hasOriginalScan.value);
    }
    if (contentVersion.present) {
      map['content_version'] = Variable<int>(contentVersion.value);
    }
    if (numberVerified.present) {
      map['number_verified'] = Variable<int>(numberVerified.value);
    }
    if (metadataJson.present) {
      map['metadata_json'] = Variable<String>(metadataJson.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DocumentsCompanion(')
          ..write('id: $id, ')
          ..write('collectionId: $collectionId, ')
          ..write('slug: $slug, ')
          ..write('displayTitle: $displayTitle, ')
          ..write('documentType: $documentType, ')
          ..write('documentNumber: $documentNumber, ')
          ..write('parentNumber: $parentNumber, ')
          ..write('partNumber: $partNumber, ')
          ..write('partLabel: $partLabel, ')
          ..write('subtitle: $subtitle, ')
          ..write('author: $author, ')
          ..write('speaker: $speaker, ')
          ..write('publicationDate: $publicationDate, ')
          ..write('year: $year, ')
          ..write('month: $month, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('hasResponsiveText: $hasResponsiveText, ')
          ..write('hasCleanPdf: $hasCleanPdf, ')
          ..write('hasOriginalScan: $hasOriginalScan, ')
          ..write('contentVersion: $contentVersion, ')
          ..write('numberVerified: $numberVerified, ')
          ..write('metadataJson: $metadataJson, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class DocumentBlocks extends Table
    with TableInfo<DocumentBlocks, DocumentBlock> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  DocumentBlocks(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _documentIdMeta = const VerificationMeta(
    'documentId',
  );
  late final GeneratedColumn<String> documentId = GeneratedColumn<String>(
    'document_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES documents(id)ON DELETE CASCADE',
  );
  static const VerificationMeta _orderIndexMeta = const VerificationMeta(
    'orderIndex',
  );
  late final GeneratedColumn<int> orderIndex = GeneratedColumn<int>(
    'order_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _blockTypeMeta = const VerificationMeta(
    'blockType',
  );
  late final GeneratedColumn<String> blockType = GeneratedColumn<String>(
    'block_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _blockTextMeta = const VerificationMeta(
    'blockText',
  );
  late final GeneratedColumn<String> blockText = GeneratedColumn<String>(
    'block_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _numberLabelMeta = const VerificationMeta(
    'numberLabel',
  );
  late final GeneratedColumn<String> numberLabel = GeneratedColumn<String>(
    'number_label',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _headingLevelMeta = const VerificationMeta(
    'headingLevel',
  );
  late final GeneratedColumn<int> headingLevel = GeneratedColumn<int>(
    'heading_level',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _metadataJsonMeta = const VerificationMeta(
    'metadataJson',
  );
  late final GeneratedColumn<String> metadataJson = GeneratedColumn<String>(
    'metadata_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT \'{}\'',
    defaultValue: const CustomExpression('\'{}\''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    documentId,
    orderIndex,
    blockType,
    blockText,
    numberLabel,
    headingLevel,
    metadataJson,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'document_blocks';
  @override
  VerificationContext validateIntegrity(
    Insertable<DocumentBlock> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('document_id')) {
      context.handle(
        _documentIdMeta,
        documentId.isAcceptableOrUnknown(data['document_id']!, _documentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_documentIdMeta);
    }
    if (data.containsKey('order_index')) {
      context.handle(
        _orderIndexMeta,
        orderIndex.isAcceptableOrUnknown(data['order_index']!, _orderIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_orderIndexMeta);
    }
    if (data.containsKey('block_type')) {
      context.handle(
        _blockTypeMeta,
        blockType.isAcceptableOrUnknown(data['block_type']!, _blockTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_blockTypeMeta);
    }
    if (data.containsKey('block_text')) {
      context.handle(
        _blockTextMeta,
        blockText.isAcceptableOrUnknown(data['block_text']!, _blockTextMeta),
      );
    } else if (isInserting) {
      context.missing(_blockTextMeta);
    }
    if (data.containsKey('number_label')) {
      context.handle(
        _numberLabelMeta,
        numberLabel.isAcceptableOrUnknown(
          data['number_label']!,
          _numberLabelMeta,
        ),
      );
    }
    if (data.containsKey('heading_level')) {
      context.handle(
        _headingLevelMeta,
        headingLevel.isAcceptableOrUnknown(
          data['heading_level']!,
          _headingLevelMeta,
        ),
      );
    }
    if (data.containsKey('metadata_json')) {
      context.handle(
        _metadataJsonMeta,
        metadataJson.isAcceptableOrUnknown(
          data['metadata_json']!,
          _metadataJsonMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {documentId, orderIndex},
  ];
  @override
  DocumentBlock map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DocumentBlock(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      documentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}document_id'],
      )!,
      orderIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order_index'],
      )!,
      blockType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}block_type'],
      )!,
      blockText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}block_text'],
      )!,
      numberLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}number_label'],
      ),
      headingLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}heading_level'],
      ),
      metadataJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metadata_json'],
      )!,
    );
  }

  @override
  DocumentBlocks createAlias(String alias) {
    return DocumentBlocks(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
    'UNIQUE(document_id, order_index)',
  ];
  @override
  bool get dontWriteConstraints => true;
}

class DocumentBlock extends DataClass implements Insertable<DocumentBlock> {
  final String id;
  final String documentId;
  final int orderIndex;
  final String blockType;
  final String blockText;
  final String? numberLabel;
  final int? headingLevel;
  final String metadataJson;
  const DocumentBlock({
    required this.id,
    required this.documentId,
    required this.orderIndex,
    required this.blockType,
    required this.blockText,
    this.numberLabel,
    this.headingLevel,
    required this.metadataJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['document_id'] = Variable<String>(documentId);
    map['order_index'] = Variable<int>(orderIndex);
    map['block_type'] = Variable<String>(blockType);
    map['block_text'] = Variable<String>(blockText);
    if (!nullToAbsent || numberLabel != null) {
      map['number_label'] = Variable<String>(numberLabel);
    }
    if (!nullToAbsent || headingLevel != null) {
      map['heading_level'] = Variable<int>(headingLevel);
    }
    map['metadata_json'] = Variable<String>(metadataJson);
    return map;
  }

  DocumentBlocksCompanion toCompanion(bool nullToAbsent) {
    return DocumentBlocksCompanion(
      id: Value(id),
      documentId: Value(documentId),
      orderIndex: Value(orderIndex),
      blockType: Value(blockType),
      blockText: Value(blockText),
      numberLabel: numberLabel == null && nullToAbsent
          ? const Value.absent()
          : Value(numberLabel),
      headingLevel: headingLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(headingLevel),
      metadataJson: Value(metadataJson),
    );
  }

  factory DocumentBlock.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DocumentBlock(
      id: serializer.fromJson<String>(json['id']),
      documentId: serializer.fromJson<String>(json['document_id']),
      orderIndex: serializer.fromJson<int>(json['order_index']),
      blockType: serializer.fromJson<String>(json['block_type']),
      blockText: serializer.fromJson<String>(json['block_text']),
      numberLabel: serializer.fromJson<String?>(json['number_label']),
      headingLevel: serializer.fromJson<int?>(json['heading_level']),
      metadataJson: serializer.fromJson<String>(json['metadata_json']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'document_id': serializer.toJson<String>(documentId),
      'order_index': serializer.toJson<int>(orderIndex),
      'block_type': serializer.toJson<String>(blockType),
      'block_text': serializer.toJson<String>(blockText),
      'number_label': serializer.toJson<String?>(numberLabel),
      'heading_level': serializer.toJson<int?>(headingLevel),
      'metadata_json': serializer.toJson<String>(metadataJson),
    };
  }

  DocumentBlock copyWith({
    String? id,
    String? documentId,
    int? orderIndex,
    String? blockType,
    String? blockText,
    Value<String?> numberLabel = const Value.absent(),
    Value<int?> headingLevel = const Value.absent(),
    String? metadataJson,
  }) => DocumentBlock(
    id: id ?? this.id,
    documentId: documentId ?? this.documentId,
    orderIndex: orderIndex ?? this.orderIndex,
    blockType: blockType ?? this.blockType,
    blockText: blockText ?? this.blockText,
    numberLabel: numberLabel.present ? numberLabel.value : this.numberLabel,
    headingLevel: headingLevel.present ? headingLevel.value : this.headingLevel,
    metadataJson: metadataJson ?? this.metadataJson,
  );
  DocumentBlock copyWithCompanion(DocumentBlocksCompanion data) {
    return DocumentBlock(
      id: data.id.present ? data.id.value : this.id,
      documentId: data.documentId.present
          ? data.documentId.value
          : this.documentId,
      orderIndex: data.orderIndex.present
          ? data.orderIndex.value
          : this.orderIndex,
      blockType: data.blockType.present ? data.blockType.value : this.blockType,
      blockText: data.blockText.present ? data.blockText.value : this.blockText,
      numberLabel: data.numberLabel.present
          ? data.numberLabel.value
          : this.numberLabel,
      headingLevel: data.headingLevel.present
          ? data.headingLevel.value
          : this.headingLevel,
      metadataJson: data.metadataJson.present
          ? data.metadataJson.value
          : this.metadataJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DocumentBlock(')
          ..write('id: $id, ')
          ..write('documentId: $documentId, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('blockType: $blockType, ')
          ..write('blockText: $blockText, ')
          ..write('numberLabel: $numberLabel, ')
          ..write('headingLevel: $headingLevel, ')
          ..write('metadataJson: $metadataJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    documentId,
    orderIndex,
    blockType,
    blockText,
    numberLabel,
    headingLevel,
    metadataJson,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DocumentBlock &&
          other.id == this.id &&
          other.documentId == this.documentId &&
          other.orderIndex == this.orderIndex &&
          other.blockType == this.blockType &&
          other.blockText == this.blockText &&
          other.numberLabel == this.numberLabel &&
          other.headingLevel == this.headingLevel &&
          other.metadataJson == this.metadataJson);
}

class DocumentBlocksCompanion extends UpdateCompanion<DocumentBlock> {
  final Value<String> id;
  final Value<String> documentId;
  final Value<int> orderIndex;
  final Value<String> blockType;
  final Value<String> blockText;
  final Value<String?> numberLabel;
  final Value<int?> headingLevel;
  final Value<String> metadataJson;
  final Value<int> rowid;
  const DocumentBlocksCompanion({
    this.id = const Value.absent(),
    this.documentId = const Value.absent(),
    this.orderIndex = const Value.absent(),
    this.blockType = const Value.absent(),
    this.blockText = const Value.absent(),
    this.numberLabel = const Value.absent(),
    this.headingLevel = const Value.absent(),
    this.metadataJson = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DocumentBlocksCompanion.insert({
    required String id,
    required String documentId,
    required int orderIndex,
    required String blockType,
    required String blockText,
    this.numberLabel = const Value.absent(),
    this.headingLevel = const Value.absent(),
    this.metadataJson = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       documentId = Value(documentId),
       orderIndex = Value(orderIndex),
       blockType = Value(blockType),
       blockText = Value(blockText);
  static Insertable<DocumentBlock> custom({
    Expression<String>? id,
    Expression<String>? documentId,
    Expression<int>? orderIndex,
    Expression<String>? blockType,
    Expression<String>? blockText,
    Expression<String>? numberLabel,
    Expression<int>? headingLevel,
    Expression<String>? metadataJson,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (documentId != null) 'document_id': documentId,
      if (orderIndex != null) 'order_index': orderIndex,
      if (blockType != null) 'block_type': blockType,
      if (blockText != null) 'block_text': blockText,
      if (numberLabel != null) 'number_label': numberLabel,
      if (headingLevel != null) 'heading_level': headingLevel,
      if (metadataJson != null) 'metadata_json': metadataJson,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DocumentBlocksCompanion copyWith({
    Value<String>? id,
    Value<String>? documentId,
    Value<int>? orderIndex,
    Value<String>? blockType,
    Value<String>? blockText,
    Value<String?>? numberLabel,
    Value<int?>? headingLevel,
    Value<String>? metadataJson,
    Value<int>? rowid,
  }) {
    return DocumentBlocksCompanion(
      id: id ?? this.id,
      documentId: documentId ?? this.documentId,
      orderIndex: orderIndex ?? this.orderIndex,
      blockType: blockType ?? this.blockType,
      blockText: blockText ?? this.blockText,
      numberLabel: numberLabel ?? this.numberLabel,
      headingLevel: headingLevel ?? this.headingLevel,
      metadataJson: metadataJson ?? this.metadataJson,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (documentId.present) {
      map['document_id'] = Variable<String>(documentId.value);
    }
    if (orderIndex.present) {
      map['order_index'] = Variable<int>(orderIndex.value);
    }
    if (blockType.present) {
      map['block_type'] = Variable<String>(blockType.value);
    }
    if (blockText.present) {
      map['block_text'] = Variable<String>(blockText.value);
    }
    if (numberLabel.present) {
      map['number_label'] = Variable<String>(numberLabel.value);
    }
    if (headingLevel.present) {
      map['heading_level'] = Variable<int>(headingLevel.value);
    }
    if (metadataJson.present) {
      map['metadata_json'] = Variable<String>(metadataJson.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DocumentBlocksCompanion(')
          ..write('id: $id, ')
          ..write('documentId: $documentId, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('blockType: $blockType, ')
          ..write('blockText: $blockText, ')
          ..write('numberLabel: $numberLabel, ')
          ..write('headingLevel: $headingLevel, ')
          ..write('metadataJson: $metadataJson, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class DocumentFiles extends Table with TableInfo<DocumentFiles, DocumentFile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  DocumentFiles(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _documentIdMeta = const VerificationMeta(
    'documentId',
  );
  late final GeneratedColumn<String> documentId = GeneratedColumn<String>(
    'document_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES documents(id)ON DELETE CASCADE',
  );
  static const VerificationMeta _fileTypeMeta = const VerificationMeta(
    'fileType',
  );
  late final GeneratedColumn<String> fileType = GeneratedColumn<String>(
    'file_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _remoteUrlMeta = const VerificationMeta(
    'remoteUrl',
  );
  late final GeneratedColumn<String> remoteUrl = GeneratedColumn<String>(
    'remote_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _assetPathMeta = const VerificationMeta(
    'assetPath',
  );
  late final GeneratedColumn<String> assetPath = GeneratedColumn<String>(
    'asset_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _localPathMeta = const VerificationMeta(
    'localPath',
  );
  late final GeneratedColumn<String> localPath = GeneratedColumn<String>(
    'local_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _fileSizeMeta = const VerificationMeta(
    'fileSize',
  );
  late final GeneratedColumn<int> fileSize = GeneratedColumn<int>(
    'file_size',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _sha256Meta = const VerificationMeta('sha256');
  late final GeneratedColumn<String> sha256 = GeneratedColumn<String>(
    'sha256',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _durationSecondsMeta = const VerificationMeta(
    'durationSeconds',
  );
  late final GeneratedColumn<int> durationSeconds = GeneratedColumn<int>(
    'duration_seconds',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _metadataJsonMeta = const VerificationMeta(
    'metadataJson',
  );
  late final GeneratedColumn<String> metadataJson = GeneratedColumn<String>(
    'metadata_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT \'{}\'',
    defaultValue: const CustomExpression('\'{}\''),
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _downloadStateMeta = const VerificationMeta(
    'downloadState',
  );
  late final GeneratedColumn<String> downloadState = GeneratedColumn<String>(
    'download_state',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT \'not_downloaded\'',
    defaultValue: const CustomExpression('\'not_downloaded\''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    documentId,
    fileType,
    remoteUrl,
    assetPath,
    localPath,
    fileSize,
    sha256,
    durationSeconds,
    metadataJson,
    version,
    downloadState,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'document_files';
  @override
  VerificationContext validateIntegrity(
    Insertable<DocumentFile> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('document_id')) {
      context.handle(
        _documentIdMeta,
        documentId.isAcceptableOrUnknown(data['document_id']!, _documentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_documentIdMeta);
    }
    if (data.containsKey('file_type')) {
      context.handle(
        _fileTypeMeta,
        fileType.isAcceptableOrUnknown(data['file_type']!, _fileTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_fileTypeMeta);
    }
    if (data.containsKey('remote_url')) {
      context.handle(
        _remoteUrlMeta,
        remoteUrl.isAcceptableOrUnknown(data['remote_url']!, _remoteUrlMeta),
      );
    }
    if (data.containsKey('asset_path')) {
      context.handle(
        _assetPathMeta,
        assetPath.isAcceptableOrUnknown(data['asset_path']!, _assetPathMeta),
      );
    }
    if (data.containsKey('local_path')) {
      context.handle(
        _localPathMeta,
        localPath.isAcceptableOrUnknown(data['local_path']!, _localPathMeta),
      );
    }
    if (data.containsKey('file_size')) {
      context.handle(
        _fileSizeMeta,
        fileSize.isAcceptableOrUnknown(data['file_size']!, _fileSizeMeta),
      );
    }
    if (data.containsKey('sha256')) {
      context.handle(
        _sha256Meta,
        sha256.isAcceptableOrUnknown(data['sha256']!, _sha256Meta),
      );
    }
    if (data.containsKey('duration_seconds')) {
      context.handle(
        _durationSecondsMeta,
        durationSeconds.isAcceptableOrUnknown(
          data['duration_seconds']!,
          _durationSecondsMeta,
        ),
      );
    }
    if (data.containsKey('metadata_json')) {
      context.handle(
        _metadataJsonMeta,
        metadataJson.isAcceptableOrUnknown(
          data['metadata_json']!,
          _metadataJsonMeta,
        ),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    } else if (isInserting) {
      context.missing(_versionMeta);
    }
    if (data.containsKey('download_state')) {
      context.handle(
        _downloadStateMeta,
        downloadState.isAcceptableOrUnknown(
          data['download_state']!,
          _downloadStateMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DocumentFile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DocumentFile(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      documentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}document_id'],
      )!,
      fileType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_type'],
      )!,
      remoteUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_url'],
      ),
      assetPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}asset_path'],
      ),
      localPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_path'],
      ),
      fileSize: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}file_size'],
      ),
      sha256: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sha256'],
      ),
      durationSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_seconds'],
      ),
      metadataJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metadata_json'],
      )!,
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      downloadState: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}download_state'],
      )!,
    );
  }

  @override
  DocumentFiles createAlias(String alias) {
    return DocumentFiles(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class DocumentFile extends DataClass implements Insertable<DocumentFile> {
  final String id;
  final String documentId;
  final String fileType;
  final String? remoteUrl;
  final String? assetPath;
  final String? localPath;
  final int? fileSize;
  final String? sha256;
  final int? durationSeconds;
  final String metadataJson;
  final int version;
  final String downloadState;
  const DocumentFile({
    required this.id,
    required this.documentId,
    required this.fileType,
    this.remoteUrl,
    this.assetPath,
    this.localPath,
    this.fileSize,
    this.sha256,
    this.durationSeconds,
    required this.metadataJson,
    required this.version,
    required this.downloadState,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['document_id'] = Variable<String>(documentId);
    map['file_type'] = Variable<String>(fileType);
    if (!nullToAbsent || remoteUrl != null) {
      map['remote_url'] = Variable<String>(remoteUrl);
    }
    if (!nullToAbsent || assetPath != null) {
      map['asset_path'] = Variable<String>(assetPath);
    }
    if (!nullToAbsent || localPath != null) {
      map['local_path'] = Variable<String>(localPath);
    }
    if (!nullToAbsent || fileSize != null) {
      map['file_size'] = Variable<int>(fileSize);
    }
    if (!nullToAbsent || sha256 != null) {
      map['sha256'] = Variable<String>(sha256);
    }
    if (!nullToAbsent || durationSeconds != null) {
      map['duration_seconds'] = Variable<int>(durationSeconds);
    }
    map['metadata_json'] = Variable<String>(metadataJson);
    map['version'] = Variable<int>(version);
    map['download_state'] = Variable<String>(downloadState);
    return map;
  }

  DocumentFilesCompanion toCompanion(bool nullToAbsent) {
    return DocumentFilesCompanion(
      id: Value(id),
      documentId: Value(documentId),
      fileType: Value(fileType),
      remoteUrl: remoteUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteUrl),
      assetPath: assetPath == null && nullToAbsent
          ? const Value.absent()
          : Value(assetPath),
      localPath: localPath == null && nullToAbsent
          ? const Value.absent()
          : Value(localPath),
      fileSize: fileSize == null && nullToAbsent
          ? const Value.absent()
          : Value(fileSize),
      sha256: sha256 == null && nullToAbsent
          ? const Value.absent()
          : Value(sha256),
      durationSeconds: durationSeconds == null && nullToAbsent
          ? const Value.absent()
          : Value(durationSeconds),
      metadataJson: Value(metadataJson),
      version: Value(version),
      downloadState: Value(downloadState),
    );
  }

  factory DocumentFile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DocumentFile(
      id: serializer.fromJson<String>(json['id']),
      documentId: serializer.fromJson<String>(json['document_id']),
      fileType: serializer.fromJson<String>(json['file_type']),
      remoteUrl: serializer.fromJson<String?>(json['remote_url']),
      assetPath: serializer.fromJson<String?>(json['asset_path']),
      localPath: serializer.fromJson<String?>(json['local_path']),
      fileSize: serializer.fromJson<int?>(json['file_size']),
      sha256: serializer.fromJson<String?>(json['sha256']),
      durationSeconds: serializer.fromJson<int?>(json['duration_seconds']),
      metadataJson: serializer.fromJson<String>(json['metadata_json']),
      version: serializer.fromJson<int>(json['version']),
      downloadState: serializer.fromJson<String>(json['download_state']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'document_id': serializer.toJson<String>(documentId),
      'file_type': serializer.toJson<String>(fileType),
      'remote_url': serializer.toJson<String?>(remoteUrl),
      'asset_path': serializer.toJson<String?>(assetPath),
      'local_path': serializer.toJson<String?>(localPath),
      'file_size': serializer.toJson<int?>(fileSize),
      'sha256': serializer.toJson<String?>(sha256),
      'duration_seconds': serializer.toJson<int?>(durationSeconds),
      'metadata_json': serializer.toJson<String>(metadataJson),
      'version': serializer.toJson<int>(version),
      'download_state': serializer.toJson<String>(downloadState),
    };
  }

  DocumentFile copyWith({
    String? id,
    String? documentId,
    String? fileType,
    Value<String?> remoteUrl = const Value.absent(),
    Value<String?> assetPath = const Value.absent(),
    Value<String?> localPath = const Value.absent(),
    Value<int?> fileSize = const Value.absent(),
    Value<String?> sha256 = const Value.absent(),
    Value<int?> durationSeconds = const Value.absent(),
    String? metadataJson,
    int? version,
    String? downloadState,
  }) => DocumentFile(
    id: id ?? this.id,
    documentId: documentId ?? this.documentId,
    fileType: fileType ?? this.fileType,
    remoteUrl: remoteUrl.present ? remoteUrl.value : this.remoteUrl,
    assetPath: assetPath.present ? assetPath.value : this.assetPath,
    localPath: localPath.present ? localPath.value : this.localPath,
    fileSize: fileSize.present ? fileSize.value : this.fileSize,
    sha256: sha256.present ? sha256.value : this.sha256,
    durationSeconds: durationSeconds.present
        ? durationSeconds.value
        : this.durationSeconds,
    metadataJson: metadataJson ?? this.metadataJson,
    version: version ?? this.version,
    downloadState: downloadState ?? this.downloadState,
  );
  DocumentFile copyWithCompanion(DocumentFilesCompanion data) {
    return DocumentFile(
      id: data.id.present ? data.id.value : this.id,
      documentId: data.documentId.present
          ? data.documentId.value
          : this.documentId,
      fileType: data.fileType.present ? data.fileType.value : this.fileType,
      remoteUrl: data.remoteUrl.present ? data.remoteUrl.value : this.remoteUrl,
      assetPath: data.assetPath.present ? data.assetPath.value : this.assetPath,
      localPath: data.localPath.present ? data.localPath.value : this.localPath,
      fileSize: data.fileSize.present ? data.fileSize.value : this.fileSize,
      sha256: data.sha256.present ? data.sha256.value : this.sha256,
      durationSeconds: data.durationSeconds.present
          ? data.durationSeconds.value
          : this.durationSeconds,
      metadataJson: data.metadataJson.present
          ? data.metadataJson.value
          : this.metadataJson,
      version: data.version.present ? data.version.value : this.version,
      downloadState: data.downloadState.present
          ? data.downloadState.value
          : this.downloadState,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DocumentFile(')
          ..write('id: $id, ')
          ..write('documentId: $documentId, ')
          ..write('fileType: $fileType, ')
          ..write('remoteUrl: $remoteUrl, ')
          ..write('assetPath: $assetPath, ')
          ..write('localPath: $localPath, ')
          ..write('fileSize: $fileSize, ')
          ..write('sha256: $sha256, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('metadataJson: $metadataJson, ')
          ..write('version: $version, ')
          ..write('downloadState: $downloadState')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    documentId,
    fileType,
    remoteUrl,
    assetPath,
    localPath,
    fileSize,
    sha256,
    durationSeconds,
    metadataJson,
    version,
    downloadState,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DocumentFile &&
          other.id == this.id &&
          other.documentId == this.documentId &&
          other.fileType == this.fileType &&
          other.remoteUrl == this.remoteUrl &&
          other.assetPath == this.assetPath &&
          other.localPath == this.localPath &&
          other.fileSize == this.fileSize &&
          other.sha256 == this.sha256 &&
          other.durationSeconds == this.durationSeconds &&
          other.metadataJson == this.metadataJson &&
          other.version == this.version &&
          other.downloadState == this.downloadState);
}

class DocumentFilesCompanion extends UpdateCompanion<DocumentFile> {
  final Value<String> id;
  final Value<String> documentId;
  final Value<String> fileType;
  final Value<String?> remoteUrl;
  final Value<String?> assetPath;
  final Value<String?> localPath;
  final Value<int?> fileSize;
  final Value<String?> sha256;
  final Value<int?> durationSeconds;
  final Value<String> metadataJson;
  final Value<int> version;
  final Value<String> downloadState;
  final Value<int> rowid;
  const DocumentFilesCompanion({
    this.id = const Value.absent(),
    this.documentId = const Value.absent(),
    this.fileType = const Value.absent(),
    this.remoteUrl = const Value.absent(),
    this.assetPath = const Value.absent(),
    this.localPath = const Value.absent(),
    this.fileSize = const Value.absent(),
    this.sha256 = const Value.absent(),
    this.durationSeconds = const Value.absent(),
    this.metadataJson = const Value.absent(),
    this.version = const Value.absent(),
    this.downloadState = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DocumentFilesCompanion.insert({
    required String id,
    required String documentId,
    required String fileType,
    this.remoteUrl = const Value.absent(),
    this.assetPath = const Value.absent(),
    this.localPath = const Value.absent(),
    this.fileSize = const Value.absent(),
    this.sha256 = const Value.absent(),
    this.durationSeconds = const Value.absent(),
    this.metadataJson = const Value.absent(),
    required int version,
    this.downloadState = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       documentId = Value(documentId),
       fileType = Value(fileType),
       version = Value(version);
  static Insertable<DocumentFile> custom({
    Expression<String>? id,
    Expression<String>? documentId,
    Expression<String>? fileType,
    Expression<String>? remoteUrl,
    Expression<String>? assetPath,
    Expression<String>? localPath,
    Expression<int>? fileSize,
    Expression<String>? sha256,
    Expression<int>? durationSeconds,
    Expression<String>? metadataJson,
    Expression<int>? version,
    Expression<String>? downloadState,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (documentId != null) 'document_id': documentId,
      if (fileType != null) 'file_type': fileType,
      if (remoteUrl != null) 'remote_url': remoteUrl,
      if (assetPath != null) 'asset_path': assetPath,
      if (localPath != null) 'local_path': localPath,
      if (fileSize != null) 'file_size': fileSize,
      if (sha256 != null) 'sha256': sha256,
      if (durationSeconds != null) 'duration_seconds': durationSeconds,
      if (metadataJson != null) 'metadata_json': metadataJson,
      if (version != null) 'version': version,
      if (downloadState != null) 'download_state': downloadState,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DocumentFilesCompanion copyWith({
    Value<String>? id,
    Value<String>? documentId,
    Value<String>? fileType,
    Value<String?>? remoteUrl,
    Value<String?>? assetPath,
    Value<String?>? localPath,
    Value<int?>? fileSize,
    Value<String?>? sha256,
    Value<int?>? durationSeconds,
    Value<String>? metadataJson,
    Value<int>? version,
    Value<String>? downloadState,
    Value<int>? rowid,
  }) {
    return DocumentFilesCompanion(
      id: id ?? this.id,
      documentId: documentId ?? this.documentId,
      fileType: fileType ?? this.fileType,
      remoteUrl: remoteUrl ?? this.remoteUrl,
      assetPath: assetPath ?? this.assetPath,
      localPath: localPath ?? this.localPath,
      fileSize: fileSize ?? this.fileSize,
      sha256: sha256 ?? this.sha256,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      metadataJson: metadataJson ?? this.metadataJson,
      version: version ?? this.version,
      downloadState: downloadState ?? this.downloadState,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (documentId.present) {
      map['document_id'] = Variable<String>(documentId.value);
    }
    if (fileType.present) {
      map['file_type'] = Variable<String>(fileType.value);
    }
    if (remoteUrl.present) {
      map['remote_url'] = Variable<String>(remoteUrl.value);
    }
    if (assetPath.present) {
      map['asset_path'] = Variable<String>(assetPath.value);
    }
    if (localPath.present) {
      map['local_path'] = Variable<String>(localPath.value);
    }
    if (fileSize.present) {
      map['file_size'] = Variable<int>(fileSize.value);
    }
    if (sha256.present) {
      map['sha256'] = Variable<String>(sha256.value);
    }
    if (durationSeconds.present) {
      map['duration_seconds'] = Variable<int>(durationSeconds.value);
    }
    if (metadataJson.present) {
      map['metadata_json'] = Variable<String>(metadataJson.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (downloadState.present) {
      map['download_state'] = Variable<String>(downloadState.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DocumentFilesCompanion(')
          ..write('id: $id, ')
          ..write('documentId: $documentId, ')
          ..write('fileType: $fileType, ')
          ..write('remoteUrl: $remoteUrl, ')
          ..write('assetPath: $assetPath, ')
          ..write('localPath: $localPath, ')
          ..write('fileSize: $fileSize, ')
          ..write('sha256: $sha256, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('metadataJson: $metadataJson, ')
          ..write('version: $version, ')
          ..write('downloadState: $downloadState, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class BibleVerses extends Table with TableInfo<BibleVerses, BibleVerse> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  BibleVerses(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _collectionIdMeta = const VerificationMeta(
    'collectionId',
  );
  late final GeneratedColumn<String> collectionId = GeneratedColumn<String>(
    'collection_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints:
        'NOT NULL REFERENCES archive_collections(id)ON DELETE CASCADE',
  );
  static const VerificationMeta _translationCodeMeta = const VerificationMeta(
    'translationCode',
  );
  late final GeneratedColumn<String> translationCode = GeneratedColumn<String>(
    'translation_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _bookIdMeta = const VerificationMeta('bookId');
  late final GeneratedColumn<String> bookId = GeneratedColumn<String>(
    'book_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _bookNameMeta = const VerificationMeta(
    'bookName',
  );
  late final GeneratedColumn<String> bookName = GeneratedColumn<String>(
    'book_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _bookOrderMeta = const VerificationMeta(
    'bookOrder',
  );
  late final GeneratedColumn<int> bookOrder = GeneratedColumn<int>(
    'book_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _testamentMeta = const VerificationMeta(
    'testament',
  );
  late final GeneratedColumn<String> testament = GeneratedColumn<String>(
    'testament',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _chapterMeta = const VerificationMeta(
    'chapter',
  );
  late final GeneratedColumn<int> chapter = GeneratedColumn<int>(
    'chapter',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _verseMeta = const VerificationMeta('verse');
  late final GeneratedColumn<int> verse = GeneratedColumn<int>(
    'verse',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _verseTextMeta = const VerificationMeta(
    'verseText',
  );
  late final GeneratedColumn<String> verseText = GeneratedColumn<String>(
    'verse_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _documentIdMeta = const VerificationMeta(
    'documentId',
  );
  late final GeneratedColumn<String> documentId = GeneratedColumn<String>(
    'document_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES documents(id)ON DELETE CASCADE',
  );
  static const VerificationMeta _blockIdMeta = const VerificationMeta(
    'blockId',
  );
  late final GeneratedColumn<String> blockId = GeneratedColumn<String>(
    'block_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints:
        'NOT NULL REFERENCES document_blocks(id)ON DELETE CASCADE',
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    collectionId,
    translationCode,
    bookId,
    bookName,
    bookOrder,
    testament,
    chapter,
    verse,
    verseText,
    documentId,
    blockId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bible_verses';
  @override
  VerificationContext validateIntegrity(
    Insertable<BibleVerse> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('collection_id')) {
      context.handle(
        _collectionIdMeta,
        collectionId.isAcceptableOrUnknown(
          data['collection_id']!,
          _collectionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_collectionIdMeta);
    }
    if (data.containsKey('translation_code')) {
      context.handle(
        _translationCodeMeta,
        translationCode.isAcceptableOrUnknown(
          data['translation_code']!,
          _translationCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_translationCodeMeta);
    }
    if (data.containsKey('book_id')) {
      context.handle(
        _bookIdMeta,
        bookId.isAcceptableOrUnknown(data['book_id']!, _bookIdMeta),
      );
    } else if (isInserting) {
      context.missing(_bookIdMeta);
    }
    if (data.containsKey('book_name')) {
      context.handle(
        _bookNameMeta,
        bookName.isAcceptableOrUnknown(data['book_name']!, _bookNameMeta),
      );
    } else if (isInserting) {
      context.missing(_bookNameMeta);
    }
    if (data.containsKey('book_order')) {
      context.handle(
        _bookOrderMeta,
        bookOrder.isAcceptableOrUnknown(data['book_order']!, _bookOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_bookOrderMeta);
    }
    if (data.containsKey('testament')) {
      context.handle(
        _testamentMeta,
        testament.isAcceptableOrUnknown(data['testament']!, _testamentMeta),
      );
    } else if (isInserting) {
      context.missing(_testamentMeta);
    }
    if (data.containsKey('chapter')) {
      context.handle(
        _chapterMeta,
        chapter.isAcceptableOrUnknown(data['chapter']!, _chapterMeta),
      );
    } else if (isInserting) {
      context.missing(_chapterMeta);
    }
    if (data.containsKey('verse')) {
      context.handle(
        _verseMeta,
        verse.isAcceptableOrUnknown(data['verse']!, _verseMeta),
      );
    } else if (isInserting) {
      context.missing(_verseMeta);
    }
    if (data.containsKey('verse_text')) {
      context.handle(
        _verseTextMeta,
        verseText.isAcceptableOrUnknown(data['verse_text']!, _verseTextMeta),
      );
    } else if (isInserting) {
      context.missing(_verseTextMeta);
    }
    if (data.containsKey('document_id')) {
      context.handle(
        _documentIdMeta,
        documentId.isAcceptableOrUnknown(data['document_id']!, _documentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_documentIdMeta);
    }
    if (data.containsKey('block_id')) {
      context.handle(
        _blockIdMeta,
        blockId.isAcceptableOrUnknown(data['block_id']!, _blockIdMeta),
      );
    } else if (isInserting) {
      context.missing(_blockIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {collectionId, bookId, chapter, verse},
  ];
  @override
  BibleVerse map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BibleVerse(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      collectionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}collection_id'],
      )!,
      translationCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}translation_code'],
      )!,
      bookId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}book_id'],
      )!,
      bookName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}book_name'],
      )!,
      bookOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}book_order'],
      )!,
      testament: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}testament'],
      )!,
      chapter: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}chapter'],
      )!,
      verse: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}verse'],
      )!,
      verseText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}verse_text'],
      )!,
      documentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}document_id'],
      )!,
      blockId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}block_id'],
      )!,
    );
  }

  @override
  BibleVerses createAlias(String alias) {
    return BibleVerses(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
    'UNIQUE(collection_id, book_id, chapter, verse)',
  ];
  @override
  bool get dontWriteConstraints => true;
}

class BibleVerse extends DataClass implements Insertable<BibleVerse> {
  final String id;
  final String collectionId;
  final String translationCode;
  final String bookId;
  final String bookName;
  final int bookOrder;
  final String testament;
  final int chapter;
  final int verse;
  final String verseText;
  final String documentId;
  final String blockId;
  const BibleVerse({
    required this.id,
    required this.collectionId,
    required this.translationCode,
    required this.bookId,
    required this.bookName,
    required this.bookOrder,
    required this.testament,
    required this.chapter,
    required this.verse,
    required this.verseText,
    required this.documentId,
    required this.blockId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['collection_id'] = Variable<String>(collectionId);
    map['translation_code'] = Variable<String>(translationCode);
    map['book_id'] = Variable<String>(bookId);
    map['book_name'] = Variable<String>(bookName);
    map['book_order'] = Variable<int>(bookOrder);
    map['testament'] = Variable<String>(testament);
    map['chapter'] = Variable<int>(chapter);
    map['verse'] = Variable<int>(verse);
    map['verse_text'] = Variable<String>(verseText);
    map['document_id'] = Variable<String>(documentId);
    map['block_id'] = Variable<String>(blockId);
    return map;
  }

  BibleVersesCompanion toCompanion(bool nullToAbsent) {
    return BibleVersesCompanion(
      id: Value(id),
      collectionId: Value(collectionId),
      translationCode: Value(translationCode),
      bookId: Value(bookId),
      bookName: Value(bookName),
      bookOrder: Value(bookOrder),
      testament: Value(testament),
      chapter: Value(chapter),
      verse: Value(verse),
      verseText: Value(verseText),
      documentId: Value(documentId),
      blockId: Value(blockId),
    );
  }

  factory BibleVerse.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BibleVerse(
      id: serializer.fromJson<String>(json['id']),
      collectionId: serializer.fromJson<String>(json['collection_id']),
      translationCode: serializer.fromJson<String>(json['translation_code']),
      bookId: serializer.fromJson<String>(json['book_id']),
      bookName: serializer.fromJson<String>(json['book_name']),
      bookOrder: serializer.fromJson<int>(json['book_order']),
      testament: serializer.fromJson<String>(json['testament']),
      chapter: serializer.fromJson<int>(json['chapter']),
      verse: serializer.fromJson<int>(json['verse']),
      verseText: serializer.fromJson<String>(json['verse_text']),
      documentId: serializer.fromJson<String>(json['document_id']),
      blockId: serializer.fromJson<String>(json['block_id']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'collection_id': serializer.toJson<String>(collectionId),
      'translation_code': serializer.toJson<String>(translationCode),
      'book_id': serializer.toJson<String>(bookId),
      'book_name': serializer.toJson<String>(bookName),
      'book_order': serializer.toJson<int>(bookOrder),
      'testament': serializer.toJson<String>(testament),
      'chapter': serializer.toJson<int>(chapter),
      'verse': serializer.toJson<int>(verse),
      'verse_text': serializer.toJson<String>(verseText),
      'document_id': serializer.toJson<String>(documentId),
      'block_id': serializer.toJson<String>(blockId),
    };
  }

  BibleVerse copyWith({
    String? id,
    String? collectionId,
    String? translationCode,
    String? bookId,
    String? bookName,
    int? bookOrder,
    String? testament,
    int? chapter,
    int? verse,
    String? verseText,
    String? documentId,
    String? blockId,
  }) => BibleVerse(
    id: id ?? this.id,
    collectionId: collectionId ?? this.collectionId,
    translationCode: translationCode ?? this.translationCode,
    bookId: bookId ?? this.bookId,
    bookName: bookName ?? this.bookName,
    bookOrder: bookOrder ?? this.bookOrder,
    testament: testament ?? this.testament,
    chapter: chapter ?? this.chapter,
    verse: verse ?? this.verse,
    verseText: verseText ?? this.verseText,
    documentId: documentId ?? this.documentId,
    blockId: blockId ?? this.blockId,
  );
  BibleVerse copyWithCompanion(BibleVersesCompanion data) {
    return BibleVerse(
      id: data.id.present ? data.id.value : this.id,
      collectionId: data.collectionId.present
          ? data.collectionId.value
          : this.collectionId,
      translationCode: data.translationCode.present
          ? data.translationCode.value
          : this.translationCode,
      bookId: data.bookId.present ? data.bookId.value : this.bookId,
      bookName: data.bookName.present ? data.bookName.value : this.bookName,
      bookOrder: data.bookOrder.present ? data.bookOrder.value : this.bookOrder,
      testament: data.testament.present ? data.testament.value : this.testament,
      chapter: data.chapter.present ? data.chapter.value : this.chapter,
      verse: data.verse.present ? data.verse.value : this.verse,
      verseText: data.verseText.present ? data.verseText.value : this.verseText,
      documentId: data.documentId.present
          ? data.documentId.value
          : this.documentId,
      blockId: data.blockId.present ? data.blockId.value : this.blockId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BibleVerse(')
          ..write('id: $id, ')
          ..write('collectionId: $collectionId, ')
          ..write('translationCode: $translationCode, ')
          ..write('bookId: $bookId, ')
          ..write('bookName: $bookName, ')
          ..write('bookOrder: $bookOrder, ')
          ..write('testament: $testament, ')
          ..write('chapter: $chapter, ')
          ..write('verse: $verse, ')
          ..write('verseText: $verseText, ')
          ..write('documentId: $documentId, ')
          ..write('blockId: $blockId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    collectionId,
    translationCode,
    bookId,
    bookName,
    bookOrder,
    testament,
    chapter,
    verse,
    verseText,
    documentId,
    blockId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BibleVerse &&
          other.id == this.id &&
          other.collectionId == this.collectionId &&
          other.translationCode == this.translationCode &&
          other.bookId == this.bookId &&
          other.bookName == this.bookName &&
          other.bookOrder == this.bookOrder &&
          other.testament == this.testament &&
          other.chapter == this.chapter &&
          other.verse == this.verse &&
          other.verseText == this.verseText &&
          other.documentId == this.documentId &&
          other.blockId == this.blockId);
}

class BibleVersesCompanion extends UpdateCompanion<BibleVerse> {
  final Value<String> id;
  final Value<String> collectionId;
  final Value<String> translationCode;
  final Value<String> bookId;
  final Value<String> bookName;
  final Value<int> bookOrder;
  final Value<String> testament;
  final Value<int> chapter;
  final Value<int> verse;
  final Value<String> verseText;
  final Value<String> documentId;
  final Value<String> blockId;
  final Value<int> rowid;
  const BibleVersesCompanion({
    this.id = const Value.absent(),
    this.collectionId = const Value.absent(),
    this.translationCode = const Value.absent(),
    this.bookId = const Value.absent(),
    this.bookName = const Value.absent(),
    this.bookOrder = const Value.absent(),
    this.testament = const Value.absent(),
    this.chapter = const Value.absent(),
    this.verse = const Value.absent(),
    this.verseText = const Value.absent(),
    this.documentId = const Value.absent(),
    this.blockId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BibleVersesCompanion.insert({
    required String id,
    required String collectionId,
    required String translationCode,
    required String bookId,
    required String bookName,
    required int bookOrder,
    required String testament,
    required int chapter,
    required int verse,
    required String verseText,
    required String documentId,
    required String blockId,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       collectionId = Value(collectionId),
       translationCode = Value(translationCode),
       bookId = Value(bookId),
       bookName = Value(bookName),
       bookOrder = Value(bookOrder),
       testament = Value(testament),
       chapter = Value(chapter),
       verse = Value(verse),
       verseText = Value(verseText),
       documentId = Value(documentId),
       blockId = Value(blockId);
  static Insertable<BibleVerse> custom({
    Expression<String>? id,
    Expression<String>? collectionId,
    Expression<String>? translationCode,
    Expression<String>? bookId,
    Expression<String>? bookName,
    Expression<int>? bookOrder,
    Expression<String>? testament,
    Expression<int>? chapter,
    Expression<int>? verse,
    Expression<String>? verseText,
    Expression<String>? documentId,
    Expression<String>? blockId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (collectionId != null) 'collection_id': collectionId,
      if (translationCode != null) 'translation_code': translationCode,
      if (bookId != null) 'book_id': bookId,
      if (bookName != null) 'book_name': bookName,
      if (bookOrder != null) 'book_order': bookOrder,
      if (testament != null) 'testament': testament,
      if (chapter != null) 'chapter': chapter,
      if (verse != null) 'verse': verse,
      if (verseText != null) 'verse_text': verseText,
      if (documentId != null) 'document_id': documentId,
      if (blockId != null) 'block_id': blockId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BibleVersesCompanion copyWith({
    Value<String>? id,
    Value<String>? collectionId,
    Value<String>? translationCode,
    Value<String>? bookId,
    Value<String>? bookName,
    Value<int>? bookOrder,
    Value<String>? testament,
    Value<int>? chapter,
    Value<int>? verse,
    Value<String>? verseText,
    Value<String>? documentId,
    Value<String>? blockId,
    Value<int>? rowid,
  }) {
    return BibleVersesCompanion(
      id: id ?? this.id,
      collectionId: collectionId ?? this.collectionId,
      translationCode: translationCode ?? this.translationCode,
      bookId: bookId ?? this.bookId,
      bookName: bookName ?? this.bookName,
      bookOrder: bookOrder ?? this.bookOrder,
      testament: testament ?? this.testament,
      chapter: chapter ?? this.chapter,
      verse: verse ?? this.verse,
      verseText: verseText ?? this.verseText,
      documentId: documentId ?? this.documentId,
      blockId: blockId ?? this.blockId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (collectionId.present) {
      map['collection_id'] = Variable<String>(collectionId.value);
    }
    if (translationCode.present) {
      map['translation_code'] = Variable<String>(translationCode.value);
    }
    if (bookId.present) {
      map['book_id'] = Variable<String>(bookId.value);
    }
    if (bookName.present) {
      map['book_name'] = Variable<String>(bookName.value);
    }
    if (bookOrder.present) {
      map['book_order'] = Variable<int>(bookOrder.value);
    }
    if (testament.present) {
      map['testament'] = Variable<String>(testament.value);
    }
    if (chapter.present) {
      map['chapter'] = Variable<int>(chapter.value);
    }
    if (verse.present) {
      map['verse'] = Variable<int>(verse.value);
    }
    if (verseText.present) {
      map['verse_text'] = Variable<String>(verseText.value);
    }
    if (documentId.present) {
      map['document_id'] = Variable<String>(documentId.value);
    }
    if (blockId.present) {
      map['block_id'] = Variable<String>(blockId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BibleVersesCompanion(')
          ..write('id: $id, ')
          ..write('collectionId: $collectionId, ')
          ..write('translationCode: $translationCode, ')
          ..write('bookId: $bookId, ')
          ..write('bookName: $bookName, ')
          ..write('bookOrder: $bookOrder, ')
          ..write('testament: $testament, ')
          ..write('chapter: $chapter, ')
          ..write('verse: $verse, ')
          ..write('verseText: $verseText, ')
          ..write('documentId: $documentId, ')
          ..write('blockId: $blockId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class Topics extends Table with TableInfo<Topics, Topic> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Topics(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL UNIQUE',
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, description];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'topics';
  @override
  VerificationContext validateIntegrity(
    Insertable<Topic> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Topic map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Topic(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
    );
  }

  @override
  Topics createAlias(String alias) {
    return Topics(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class Topic extends DataClass implements Insertable<Topic> {
  final String id;
  final String name;
  final String? description;
  const Topic({required this.id, required this.name, this.description});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    return map;
  }

  TopicsCompanion toCompanion(bool nullToAbsent) {
    return TopicsCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
    );
  }

  factory Topic.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Topic(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
    };
  }

  Topic copyWith({
    String? id,
    String? name,
    Value<String?> description = const Value.absent(),
  }) => Topic(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
  );
  Topic copyWithCompanion(TopicsCompanion data) {
    return Topic(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Topic(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Topic &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description);
}

class TopicsCompanion extends UpdateCompanion<Topic> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<int> rowid;
  const TopicsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TopicsCompanion.insert({
    required String id,
    required String name,
    this.description = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name);
  static Insertable<Topic> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TopicsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? description,
    Value<int>? rowid,
  }) {
    return TopicsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TopicsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class DocumentTopics extends Table
    with TableInfo<DocumentTopics, DocumentTopic> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  DocumentTopics(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _documentIdMeta = const VerificationMeta(
    'documentId',
  );
  late final GeneratedColumn<String> documentId = GeneratedColumn<String>(
    'document_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES documents(id)ON DELETE CASCADE',
  );
  static const VerificationMeta _topicIdMeta = const VerificationMeta(
    'topicId',
  );
  late final GeneratedColumn<String> topicId = GeneratedColumn<String>(
    'topic_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES topics(id)ON DELETE CASCADE',
  );
  @override
  List<GeneratedColumn> get $columns => [documentId, topicId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'document_topics';
  @override
  VerificationContext validateIntegrity(
    Insertable<DocumentTopic> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('document_id')) {
      context.handle(
        _documentIdMeta,
        documentId.isAcceptableOrUnknown(data['document_id']!, _documentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_documentIdMeta);
    }
    if (data.containsKey('topic_id')) {
      context.handle(
        _topicIdMeta,
        topicId.isAcceptableOrUnknown(data['topic_id']!, _topicIdMeta),
      );
    } else if (isInserting) {
      context.missing(_topicIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {documentId, topicId};
  @override
  DocumentTopic map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DocumentTopic(
      documentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}document_id'],
      )!,
      topicId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}topic_id'],
      )!,
    );
  }

  @override
  DocumentTopics createAlias(String alias) {
    return DocumentTopics(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
    'PRIMARY KEY(document_id, topic_id)',
  ];
  @override
  bool get dontWriteConstraints => true;
}

class DocumentTopic extends DataClass implements Insertable<DocumentTopic> {
  final String documentId;
  final String topicId;
  const DocumentTopic({required this.documentId, required this.topicId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['document_id'] = Variable<String>(documentId);
    map['topic_id'] = Variable<String>(topicId);
    return map;
  }

  DocumentTopicsCompanion toCompanion(bool nullToAbsent) {
    return DocumentTopicsCompanion(
      documentId: Value(documentId),
      topicId: Value(topicId),
    );
  }

  factory DocumentTopic.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DocumentTopic(
      documentId: serializer.fromJson<String>(json['document_id']),
      topicId: serializer.fromJson<String>(json['topic_id']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'document_id': serializer.toJson<String>(documentId),
      'topic_id': serializer.toJson<String>(topicId),
    };
  }

  DocumentTopic copyWith({String? documentId, String? topicId}) =>
      DocumentTopic(
        documentId: documentId ?? this.documentId,
        topicId: topicId ?? this.topicId,
      );
  DocumentTopic copyWithCompanion(DocumentTopicsCompanion data) {
    return DocumentTopic(
      documentId: data.documentId.present
          ? data.documentId.value
          : this.documentId,
      topicId: data.topicId.present ? data.topicId.value : this.topicId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DocumentTopic(')
          ..write('documentId: $documentId, ')
          ..write('topicId: $topicId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(documentId, topicId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DocumentTopic &&
          other.documentId == this.documentId &&
          other.topicId == this.topicId);
}

class DocumentTopicsCompanion extends UpdateCompanion<DocumentTopic> {
  final Value<String> documentId;
  final Value<String> topicId;
  final Value<int> rowid;
  const DocumentTopicsCompanion({
    this.documentId = const Value.absent(),
    this.topicId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DocumentTopicsCompanion.insert({
    required String documentId,
    required String topicId,
    this.rowid = const Value.absent(),
  }) : documentId = Value(documentId),
       topicId = Value(topicId);
  static Insertable<DocumentTopic> custom({
    Expression<String>? documentId,
    Expression<String>? topicId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (documentId != null) 'document_id': documentId,
      if (topicId != null) 'topic_id': topicId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DocumentTopicsCompanion copyWith({
    Value<String>? documentId,
    Value<String>? topicId,
    Value<int>? rowid,
  }) {
    return DocumentTopicsCompanion(
      documentId: documentId ?? this.documentId,
      topicId: topicId ?? this.topicId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (documentId.present) {
      map['document_id'] = Variable<String>(documentId.value);
    }
    if (topicId.present) {
      map['topic_id'] = Variable<String>(topicId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DocumentTopicsCompanion(')
          ..write('documentId: $documentId, ')
          ..write('topicId: $topicId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class ScriptureReferences extends Table
    with TableInfo<ScriptureReferences, ScriptureReference> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  ScriptureReferences(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT',
  );
  static const VerificationMeta _documentIdMeta = const VerificationMeta(
    'documentId',
  );
  late final GeneratedColumn<String> documentId = GeneratedColumn<String>(
    'document_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES documents(id)ON DELETE CASCADE',
  );
  static const VerificationMeta _blockIdMeta = const VerificationMeta(
    'blockId',
  );
  late final GeneratedColumn<String> blockId = GeneratedColumn<String>(
    'block_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints:
        'NOT NULL REFERENCES document_blocks(id)ON DELETE CASCADE',
  );
  static const VerificationMeta _bookMeta = const VerificationMeta('book');
  late final GeneratedColumn<String> book = GeneratedColumn<String>(
    'book',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _chapterMeta = const VerificationMeta(
    'chapter',
  );
  late final GeneratedColumn<int> chapter = GeneratedColumn<int>(
    'chapter',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _verseStartMeta = const VerificationMeta(
    'verseStart',
  );
  late final GeneratedColumn<int> verseStart = GeneratedColumn<int>(
    'verse_start',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _verseEndMeta = const VerificationMeta(
    'verseEnd',
  );
  late final GeneratedColumn<int> verseEnd = GeneratedColumn<int>(
    'verse_end',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _canonicalReferenceMeta =
      const VerificationMeta('canonicalReference');
  late final GeneratedColumn<String> canonicalReference =
      GeneratedColumn<String>(
        'canonical_reference',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
        $customConstraints: 'NOT NULL',
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    documentId,
    blockId,
    book,
    chapter,
    verseStart,
    verseEnd,
    canonicalReference,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'scripture_references';
  @override
  VerificationContext validateIntegrity(
    Insertable<ScriptureReference> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('document_id')) {
      context.handle(
        _documentIdMeta,
        documentId.isAcceptableOrUnknown(data['document_id']!, _documentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_documentIdMeta);
    }
    if (data.containsKey('block_id')) {
      context.handle(
        _blockIdMeta,
        blockId.isAcceptableOrUnknown(data['block_id']!, _blockIdMeta),
      );
    } else if (isInserting) {
      context.missing(_blockIdMeta);
    }
    if (data.containsKey('book')) {
      context.handle(
        _bookMeta,
        book.isAcceptableOrUnknown(data['book']!, _bookMeta),
      );
    } else if (isInserting) {
      context.missing(_bookMeta);
    }
    if (data.containsKey('chapter')) {
      context.handle(
        _chapterMeta,
        chapter.isAcceptableOrUnknown(data['chapter']!, _chapterMeta),
      );
    } else if (isInserting) {
      context.missing(_chapterMeta);
    }
    if (data.containsKey('verse_start')) {
      context.handle(
        _verseStartMeta,
        verseStart.isAcceptableOrUnknown(data['verse_start']!, _verseStartMeta),
      );
    } else if (isInserting) {
      context.missing(_verseStartMeta);
    }
    if (data.containsKey('verse_end')) {
      context.handle(
        _verseEndMeta,
        verseEnd.isAcceptableOrUnknown(data['verse_end']!, _verseEndMeta),
      );
    }
    if (data.containsKey('canonical_reference')) {
      context.handle(
        _canonicalReferenceMeta,
        canonicalReference.isAcceptableOrUnknown(
          data['canonical_reference']!,
          _canonicalReferenceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_canonicalReferenceMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ScriptureReference map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ScriptureReference(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      documentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}document_id'],
      )!,
      blockId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}block_id'],
      )!,
      book: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}book'],
      )!,
      chapter: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}chapter'],
      )!,
      verseStart: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}verse_start'],
      )!,
      verseEnd: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}verse_end'],
      ),
      canonicalReference: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}canonical_reference'],
      )!,
    );
  }

  @override
  ScriptureReferences createAlias(String alias) {
    return ScriptureReferences(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class ScriptureReference extends DataClass
    implements Insertable<ScriptureReference> {
  final int id;
  final String documentId;
  final String blockId;
  final String book;
  final int chapter;
  final int verseStart;
  final int? verseEnd;
  final String canonicalReference;
  const ScriptureReference({
    required this.id,
    required this.documentId,
    required this.blockId,
    required this.book,
    required this.chapter,
    required this.verseStart,
    this.verseEnd,
    required this.canonicalReference,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['document_id'] = Variable<String>(documentId);
    map['block_id'] = Variable<String>(blockId);
    map['book'] = Variable<String>(book);
    map['chapter'] = Variable<int>(chapter);
    map['verse_start'] = Variable<int>(verseStart);
    if (!nullToAbsent || verseEnd != null) {
      map['verse_end'] = Variable<int>(verseEnd);
    }
    map['canonical_reference'] = Variable<String>(canonicalReference);
    return map;
  }

  ScriptureReferencesCompanion toCompanion(bool nullToAbsent) {
    return ScriptureReferencesCompanion(
      id: Value(id),
      documentId: Value(documentId),
      blockId: Value(blockId),
      book: Value(book),
      chapter: Value(chapter),
      verseStart: Value(verseStart),
      verseEnd: verseEnd == null && nullToAbsent
          ? const Value.absent()
          : Value(verseEnd),
      canonicalReference: Value(canonicalReference),
    );
  }

  factory ScriptureReference.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ScriptureReference(
      id: serializer.fromJson<int>(json['id']),
      documentId: serializer.fromJson<String>(json['document_id']),
      blockId: serializer.fromJson<String>(json['block_id']),
      book: serializer.fromJson<String>(json['book']),
      chapter: serializer.fromJson<int>(json['chapter']),
      verseStart: serializer.fromJson<int>(json['verse_start']),
      verseEnd: serializer.fromJson<int?>(json['verse_end']),
      canonicalReference: serializer.fromJson<String>(
        json['canonical_reference'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'document_id': serializer.toJson<String>(documentId),
      'block_id': serializer.toJson<String>(blockId),
      'book': serializer.toJson<String>(book),
      'chapter': serializer.toJson<int>(chapter),
      'verse_start': serializer.toJson<int>(verseStart),
      'verse_end': serializer.toJson<int?>(verseEnd),
      'canonical_reference': serializer.toJson<String>(canonicalReference),
    };
  }

  ScriptureReference copyWith({
    int? id,
    String? documentId,
    String? blockId,
    String? book,
    int? chapter,
    int? verseStart,
    Value<int?> verseEnd = const Value.absent(),
    String? canonicalReference,
  }) => ScriptureReference(
    id: id ?? this.id,
    documentId: documentId ?? this.documentId,
    blockId: blockId ?? this.blockId,
    book: book ?? this.book,
    chapter: chapter ?? this.chapter,
    verseStart: verseStart ?? this.verseStart,
    verseEnd: verseEnd.present ? verseEnd.value : this.verseEnd,
    canonicalReference: canonicalReference ?? this.canonicalReference,
  );
  ScriptureReference copyWithCompanion(ScriptureReferencesCompanion data) {
    return ScriptureReference(
      id: data.id.present ? data.id.value : this.id,
      documentId: data.documentId.present
          ? data.documentId.value
          : this.documentId,
      blockId: data.blockId.present ? data.blockId.value : this.blockId,
      book: data.book.present ? data.book.value : this.book,
      chapter: data.chapter.present ? data.chapter.value : this.chapter,
      verseStart: data.verseStart.present
          ? data.verseStart.value
          : this.verseStart,
      verseEnd: data.verseEnd.present ? data.verseEnd.value : this.verseEnd,
      canonicalReference: data.canonicalReference.present
          ? data.canonicalReference.value
          : this.canonicalReference,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ScriptureReference(')
          ..write('id: $id, ')
          ..write('documentId: $documentId, ')
          ..write('blockId: $blockId, ')
          ..write('book: $book, ')
          ..write('chapter: $chapter, ')
          ..write('verseStart: $verseStart, ')
          ..write('verseEnd: $verseEnd, ')
          ..write('canonicalReference: $canonicalReference')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    documentId,
    blockId,
    book,
    chapter,
    verseStart,
    verseEnd,
    canonicalReference,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScriptureReference &&
          other.id == this.id &&
          other.documentId == this.documentId &&
          other.blockId == this.blockId &&
          other.book == this.book &&
          other.chapter == this.chapter &&
          other.verseStart == this.verseStart &&
          other.verseEnd == this.verseEnd &&
          other.canonicalReference == this.canonicalReference);
}

class ScriptureReferencesCompanion extends UpdateCompanion<ScriptureReference> {
  final Value<int> id;
  final Value<String> documentId;
  final Value<String> blockId;
  final Value<String> book;
  final Value<int> chapter;
  final Value<int> verseStart;
  final Value<int?> verseEnd;
  final Value<String> canonicalReference;
  const ScriptureReferencesCompanion({
    this.id = const Value.absent(),
    this.documentId = const Value.absent(),
    this.blockId = const Value.absent(),
    this.book = const Value.absent(),
    this.chapter = const Value.absent(),
    this.verseStart = const Value.absent(),
    this.verseEnd = const Value.absent(),
    this.canonicalReference = const Value.absent(),
  });
  ScriptureReferencesCompanion.insert({
    this.id = const Value.absent(),
    required String documentId,
    required String blockId,
    required String book,
    required int chapter,
    required int verseStart,
    this.verseEnd = const Value.absent(),
    required String canonicalReference,
  }) : documentId = Value(documentId),
       blockId = Value(blockId),
       book = Value(book),
       chapter = Value(chapter),
       verseStart = Value(verseStart),
       canonicalReference = Value(canonicalReference);
  static Insertable<ScriptureReference> custom({
    Expression<int>? id,
    Expression<String>? documentId,
    Expression<String>? blockId,
    Expression<String>? book,
    Expression<int>? chapter,
    Expression<int>? verseStart,
    Expression<int>? verseEnd,
    Expression<String>? canonicalReference,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (documentId != null) 'document_id': documentId,
      if (blockId != null) 'block_id': blockId,
      if (book != null) 'book': book,
      if (chapter != null) 'chapter': chapter,
      if (verseStart != null) 'verse_start': verseStart,
      if (verseEnd != null) 'verse_end': verseEnd,
      if (canonicalReference != null) 'canonical_reference': canonicalReference,
    });
  }

  ScriptureReferencesCompanion copyWith({
    Value<int>? id,
    Value<String>? documentId,
    Value<String>? blockId,
    Value<String>? book,
    Value<int>? chapter,
    Value<int>? verseStart,
    Value<int?>? verseEnd,
    Value<String>? canonicalReference,
  }) {
    return ScriptureReferencesCompanion(
      id: id ?? this.id,
      documentId: documentId ?? this.documentId,
      blockId: blockId ?? this.blockId,
      book: book ?? this.book,
      chapter: chapter ?? this.chapter,
      verseStart: verseStart ?? this.verseStart,
      verseEnd: verseEnd ?? this.verseEnd,
      canonicalReference: canonicalReference ?? this.canonicalReference,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (documentId.present) {
      map['document_id'] = Variable<String>(documentId.value);
    }
    if (blockId.present) {
      map['block_id'] = Variable<String>(blockId.value);
    }
    if (book.present) {
      map['book'] = Variable<String>(book.value);
    }
    if (chapter.present) {
      map['chapter'] = Variable<int>(chapter.value);
    }
    if (verseStart.present) {
      map['verse_start'] = Variable<int>(verseStart.value);
    }
    if (verseEnd.present) {
      map['verse_end'] = Variable<int>(verseEnd.value);
    }
    if (canonicalReference.present) {
      map['canonical_reference'] = Variable<String>(canonicalReference.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScriptureReferencesCompanion(')
          ..write('id: $id, ')
          ..write('documentId: $documentId, ')
          ..write('blockId: $blockId, ')
          ..write('book: $book, ')
          ..write('chapter: $chapter, ')
          ..write('verseStart: $verseStart, ')
          ..write('verseEnd: $verseEnd, ')
          ..write('canonicalReference: $canonicalReference')
          ..write(')'))
        .toString();
  }
}

class ScriptureReferenceSpans extends Table
    with TableInfo<ScriptureReferenceSpans, ScriptureReferenceSpan> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  ScriptureReferenceSpans(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _collectionIdMeta = const VerificationMeta(
    'collectionId',
  );
  late final GeneratedColumn<String> collectionId = GeneratedColumn<String>(
    'collection_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints:
        'NOT NULL REFERENCES archive_collections(id)ON DELETE CASCADE',
  );
  static const VerificationMeta _documentIdMeta = const VerificationMeta(
    'documentId',
  );
  late final GeneratedColumn<String> documentId = GeneratedColumn<String>(
    'document_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES documents(id)ON DELETE CASCADE',
  );
  static const VerificationMeta _blockIdMeta = const VerificationMeta(
    'blockId',
  );
  late final GeneratedColumn<String> blockId = GeneratedColumn<String>(
    'block_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints:
        'NOT NULL REFERENCES document_blocks(id)ON DELETE CASCADE',
  );
  static const VerificationMeta _startOffsetMeta = const VerificationMeta(
    'startOffset',
  );
  late final GeneratedColumn<int> startOffset = GeneratedColumn<int>(
    'start_offset',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _endOffsetMeta = const VerificationMeta(
    'endOffset',
  );
  late final GeneratedColumn<int> endOffset = GeneratedColumn<int>(
    'end_offset',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _rawTextMeta = const VerificationMeta(
    'rawText',
  );
  late final GeneratedColumn<String> rawText = GeneratedColumn<String>(
    'raw_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _canonicalReferenceMeta =
      const VerificationMeta('canonicalReference');
  late final GeneratedColumn<String> canonicalReference =
      GeneratedColumn<String>(
        'canonical_reference',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
        $customConstraints: 'NOT NULL',
      );
  static const VerificationMeta _confidenceMeta = const VerificationMeta(
    'confidence',
  );
  late final GeneratedColumn<String> confidence = GeneratedColumn<String>(
    'confidence',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _parserVersionMeta = const VerificationMeta(
    'parserVersion',
  );
  late final GeneratedColumn<int> parserVersion = GeneratedColumn<int>(
    'parser_version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _overrideVersionMeta = const VerificationMeta(
    'overrideVersion',
  );
  late final GeneratedColumn<int> overrideVersion = GeneratedColumn<int>(
    'override_version',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    collectionId,
    documentId,
    blockId,
    startOffset,
    endOffset,
    rawText,
    canonicalReference,
    confidence,
    parserVersion,
    overrideVersion,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'scripture_reference_spans';
  @override
  VerificationContext validateIntegrity(
    Insertable<ScriptureReferenceSpan> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('collection_id')) {
      context.handle(
        _collectionIdMeta,
        collectionId.isAcceptableOrUnknown(
          data['collection_id']!,
          _collectionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_collectionIdMeta);
    }
    if (data.containsKey('document_id')) {
      context.handle(
        _documentIdMeta,
        documentId.isAcceptableOrUnknown(data['document_id']!, _documentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_documentIdMeta);
    }
    if (data.containsKey('block_id')) {
      context.handle(
        _blockIdMeta,
        blockId.isAcceptableOrUnknown(data['block_id']!, _blockIdMeta),
      );
    } else if (isInserting) {
      context.missing(_blockIdMeta);
    }
    if (data.containsKey('start_offset')) {
      context.handle(
        _startOffsetMeta,
        startOffset.isAcceptableOrUnknown(
          data['start_offset']!,
          _startOffsetMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_startOffsetMeta);
    }
    if (data.containsKey('end_offset')) {
      context.handle(
        _endOffsetMeta,
        endOffset.isAcceptableOrUnknown(data['end_offset']!, _endOffsetMeta),
      );
    } else if (isInserting) {
      context.missing(_endOffsetMeta);
    }
    if (data.containsKey('raw_text')) {
      context.handle(
        _rawTextMeta,
        rawText.isAcceptableOrUnknown(data['raw_text']!, _rawTextMeta),
      );
    } else if (isInserting) {
      context.missing(_rawTextMeta);
    }
    if (data.containsKey('canonical_reference')) {
      context.handle(
        _canonicalReferenceMeta,
        canonicalReference.isAcceptableOrUnknown(
          data['canonical_reference']!,
          _canonicalReferenceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_canonicalReferenceMeta);
    }
    if (data.containsKey('confidence')) {
      context.handle(
        _confidenceMeta,
        confidence.isAcceptableOrUnknown(data['confidence']!, _confidenceMeta),
      );
    } else if (isInserting) {
      context.missing(_confidenceMeta);
    }
    if (data.containsKey('parser_version')) {
      context.handle(
        _parserVersionMeta,
        parserVersion.isAcceptableOrUnknown(
          data['parser_version']!,
          _parserVersionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_parserVersionMeta);
    }
    if (data.containsKey('override_version')) {
      context.handle(
        _overrideVersionMeta,
        overrideVersion.isAcceptableOrUnknown(
          data['override_version']!,
          _overrideVersionMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {blockId, startOffset, endOffset},
  ];
  @override
  ScriptureReferenceSpan map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ScriptureReferenceSpan(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      collectionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}collection_id'],
      )!,
      documentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}document_id'],
      )!,
      blockId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}block_id'],
      )!,
      startOffset: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}start_offset'],
      )!,
      endOffset: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}end_offset'],
      )!,
      rawText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}raw_text'],
      )!,
      canonicalReference: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}canonical_reference'],
      )!,
      confidence: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}confidence'],
      )!,
      parserVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}parser_version'],
      )!,
      overrideVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}override_version'],
      ),
    );
  }

  @override
  ScriptureReferenceSpans createAlias(String alias) {
    return ScriptureReferenceSpans(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
    'UNIQUE(block_id, start_offset, end_offset)',
  ];
  @override
  bool get dontWriteConstraints => true;
}

class ScriptureReferenceSpan extends DataClass
    implements Insertable<ScriptureReferenceSpan> {
  final String id;
  final String collectionId;
  final String documentId;
  final String blockId;
  final int startOffset;
  final int endOffset;
  final String rawText;
  final String canonicalReference;
  final String confidence;
  final int parserVersion;
  final int? overrideVersion;
  const ScriptureReferenceSpan({
    required this.id,
    required this.collectionId,
    required this.documentId,
    required this.blockId,
    required this.startOffset,
    required this.endOffset,
    required this.rawText,
    required this.canonicalReference,
    required this.confidence,
    required this.parserVersion,
    this.overrideVersion,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['collection_id'] = Variable<String>(collectionId);
    map['document_id'] = Variable<String>(documentId);
    map['block_id'] = Variable<String>(blockId);
    map['start_offset'] = Variable<int>(startOffset);
    map['end_offset'] = Variable<int>(endOffset);
    map['raw_text'] = Variable<String>(rawText);
    map['canonical_reference'] = Variable<String>(canonicalReference);
    map['confidence'] = Variable<String>(confidence);
    map['parser_version'] = Variable<int>(parserVersion);
    if (!nullToAbsent || overrideVersion != null) {
      map['override_version'] = Variable<int>(overrideVersion);
    }
    return map;
  }

  ScriptureReferenceSpansCompanion toCompanion(bool nullToAbsent) {
    return ScriptureReferenceSpansCompanion(
      id: Value(id),
      collectionId: Value(collectionId),
      documentId: Value(documentId),
      blockId: Value(blockId),
      startOffset: Value(startOffset),
      endOffset: Value(endOffset),
      rawText: Value(rawText),
      canonicalReference: Value(canonicalReference),
      confidence: Value(confidence),
      parserVersion: Value(parserVersion),
      overrideVersion: overrideVersion == null && nullToAbsent
          ? const Value.absent()
          : Value(overrideVersion),
    );
  }

  factory ScriptureReferenceSpan.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ScriptureReferenceSpan(
      id: serializer.fromJson<String>(json['id']),
      collectionId: serializer.fromJson<String>(json['collection_id']),
      documentId: serializer.fromJson<String>(json['document_id']),
      blockId: serializer.fromJson<String>(json['block_id']),
      startOffset: serializer.fromJson<int>(json['start_offset']),
      endOffset: serializer.fromJson<int>(json['end_offset']),
      rawText: serializer.fromJson<String>(json['raw_text']),
      canonicalReference: serializer.fromJson<String>(
        json['canonical_reference'],
      ),
      confidence: serializer.fromJson<String>(json['confidence']),
      parserVersion: serializer.fromJson<int>(json['parser_version']),
      overrideVersion: serializer.fromJson<int?>(json['override_version']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'collection_id': serializer.toJson<String>(collectionId),
      'document_id': serializer.toJson<String>(documentId),
      'block_id': serializer.toJson<String>(blockId),
      'start_offset': serializer.toJson<int>(startOffset),
      'end_offset': serializer.toJson<int>(endOffset),
      'raw_text': serializer.toJson<String>(rawText),
      'canonical_reference': serializer.toJson<String>(canonicalReference),
      'confidence': serializer.toJson<String>(confidence),
      'parser_version': serializer.toJson<int>(parserVersion),
      'override_version': serializer.toJson<int?>(overrideVersion),
    };
  }

  ScriptureReferenceSpan copyWith({
    String? id,
    String? collectionId,
    String? documentId,
    String? blockId,
    int? startOffset,
    int? endOffset,
    String? rawText,
    String? canonicalReference,
    String? confidence,
    int? parserVersion,
    Value<int?> overrideVersion = const Value.absent(),
  }) => ScriptureReferenceSpan(
    id: id ?? this.id,
    collectionId: collectionId ?? this.collectionId,
    documentId: documentId ?? this.documentId,
    blockId: blockId ?? this.blockId,
    startOffset: startOffset ?? this.startOffset,
    endOffset: endOffset ?? this.endOffset,
    rawText: rawText ?? this.rawText,
    canonicalReference: canonicalReference ?? this.canonicalReference,
    confidence: confidence ?? this.confidence,
    parserVersion: parserVersion ?? this.parserVersion,
    overrideVersion: overrideVersion.present
        ? overrideVersion.value
        : this.overrideVersion,
  );
  ScriptureReferenceSpan copyWithCompanion(
    ScriptureReferenceSpansCompanion data,
  ) {
    return ScriptureReferenceSpan(
      id: data.id.present ? data.id.value : this.id,
      collectionId: data.collectionId.present
          ? data.collectionId.value
          : this.collectionId,
      documentId: data.documentId.present
          ? data.documentId.value
          : this.documentId,
      blockId: data.blockId.present ? data.blockId.value : this.blockId,
      startOffset: data.startOffset.present
          ? data.startOffset.value
          : this.startOffset,
      endOffset: data.endOffset.present ? data.endOffset.value : this.endOffset,
      rawText: data.rawText.present ? data.rawText.value : this.rawText,
      canonicalReference: data.canonicalReference.present
          ? data.canonicalReference.value
          : this.canonicalReference,
      confidence: data.confidence.present
          ? data.confidence.value
          : this.confidence,
      parserVersion: data.parserVersion.present
          ? data.parserVersion.value
          : this.parserVersion,
      overrideVersion: data.overrideVersion.present
          ? data.overrideVersion.value
          : this.overrideVersion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ScriptureReferenceSpan(')
          ..write('id: $id, ')
          ..write('collectionId: $collectionId, ')
          ..write('documentId: $documentId, ')
          ..write('blockId: $blockId, ')
          ..write('startOffset: $startOffset, ')
          ..write('endOffset: $endOffset, ')
          ..write('rawText: $rawText, ')
          ..write('canonicalReference: $canonicalReference, ')
          ..write('confidence: $confidence, ')
          ..write('parserVersion: $parserVersion, ')
          ..write('overrideVersion: $overrideVersion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    collectionId,
    documentId,
    blockId,
    startOffset,
    endOffset,
    rawText,
    canonicalReference,
    confidence,
    parserVersion,
    overrideVersion,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScriptureReferenceSpan &&
          other.id == this.id &&
          other.collectionId == this.collectionId &&
          other.documentId == this.documentId &&
          other.blockId == this.blockId &&
          other.startOffset == this.startOffset &&
          other.endOffset == this.endOffset &&
          other.rawText == this.rawText &&
          other.canonicalReference == this.canonicalReference &&
          other.confidence == this.confidence &&
          other.parserVersion == this.parserVersion &&
          other.overrideVersion == this.overrideVersion);
}

class ScriptureReferenceSpansCompanion
    extends UpdateCompanion<ScriptureReferenceSpan> {
  final Value<String> id;
  final Value<String> collectionId;
  final Value<String> documentId;
  final Value<String> blockId;
  final Value<int> startOffset;
  final Value<int> endOffset;
  final Value<String> rawText;
  final Value<String> canonicalReference;
  final Value<String> confidence;
  final Value<int> parserVersion;
  final Value<int?> overrideVersion;
  final Value<int> rowid;
  const ScriptureReferenceSpansCompanion({
    this.id = const Value.absent(),
    this.collectionId = const Value.absent(),
    this.documentId = const Value.absent(),
    this.blockId = const Value.absent(),
    this.startOffset = const Value.absent(),
    this.endOffset = const Value.absent(),
    this.rawText = const Value.absent(),
    this.canonicalReference = const Value.absent(),
    this.confidence = const Value.absent(),
    this.parserVersion = const Value.absent(),
    this.overrideVersion = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ScriptureReferenceSpansCompanion.insert({
    required String id,
    required String collectionId,
    required String documentId,
    required String blockId,
    required int startOffset,
    required int endOffset,
    required String rawText,
    required String canonicalReference,
    required String confidence,
    required int parserVersion,
    this.overrideVersion = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       collectionId = Value(collectionId),
       documentId = Value(documentId),
       blockId = Value(blockId),
       startOffset = Value(startOffset),
       endOffset = Value(endOffset),
       rawText = Value(rawText),
       canonicalReference = Value(canonicalReference),
       confidence = Value(confidence),
       parserVersion = Value(parserVersion);
  static Insertable<ScriptureReferenceSpan> custom({
    Expression<String>? id,
    Expression<String>? collectionId,
    Expression<String>? documentId,
    Expression<String>? blockId,
    Expression<int>? startOffset,
    Expression<int>? endOffset,
    Expression<String>? rawText,
    Expression<String>? canonicalReference,
    Expression<String>? confidence,
    Expression<int>? parserVersion,
    Expression<int>? overrideVersion,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (collectionId != null) 'collection_id': collectionId,
      if (documentId != null) 'document_id': documentId,
      if (blockId != null) 'block_id': blockId,
      if (startOffset != null) 'start_offset': startOffset,
      if (endOffset != null) 'end_offset': endOffset,
      if (rawText != null) 'raw_text': rawText,
      if (canonicalReference != null) 'canonical_reference': canonicalReference,
      if (confidence != null) 'confidence': confidence,
      if (parserVersion != null) 'parser_version': parserVersion,
      if (overrideVersion != null) 'override_version': overrideVersion,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ScriptureReferenceSpansCompanion copyWith({
    Value<String>? id,
    Value<String>? collectionId,
    Value<String>? documentId,
    Value<String>? blockId,
    Value<int>? startOffset,
    Value<int>? endOffset,
    Value<String>? rawText,
    Value<String>? canonicalReference,
    Value<String>? confidence,
    Value<int>? parserVersion,
    Value<int?>? overrideVersion,
    Value<int>? rowid,
  }) {
    return ScriptureReferenceSpansCompanion(
      id: id ?? this.id,
      collectionId: collectionId ?? this.collectionId,
      documentId: documentId ?? this.documentId,
      blockId: blockId ?? this.blockId,
      startOffset: startOffset ?? this.startOffset,
      endOffset: endOffset ?? this.endOffset,
      rawText: rawText ?? this.rawText,
      canonicalReference: canonicalReference ?? this.canonicalReference,
      confidence: confidence ?? this.confidence,
      parserVersion: parserVersion ?? this.parserVersion,
      overrideVersion: overrideVersion ?? this.overrideVersion,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (collectionId.present) {
      map['collection_id'] = Variable<String>(collectionId.value);
    }
    if (documentId.present) {
      map['document_id'] = Variable<String>(documentId.value);
    }
    if (blockId.present) {
      map['block_id'] = Variable<String>(blockId.value);
    }
    if (startOffset.present) {
      map['start_offset'] = Variable<int>(startOffset.value);
    }
    if (endOffset.present) {
      map['end_offset'] = Variable<int>(endOffset.value);
    }
    if (rawText.present) {
      map['raw_text'] = Variable<String>(rawText.value);
    }
    if (canonicalReference.present) {
      map['canonical_reference'] = Variable<String>(canonicalReference.value);
    }
    if (confidence.present) {
      map['confidence'] = Variable<String>(confidence.value);
    }
    if (parserVersion.present) {
      map['parser_version'] = Variable<int>(parserVersion.value);
    }
    if (overrideVersion.present) {
      map['override_version'] = Variable<int>(overrideVersion.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScriptureReferenceSpansCompanion(')
          ..write('id: $id, ')
          ..write('collectionId: $collectionId, ')
          ..write('documentId: $documentId, ')
          ..write('blockId: $blockId, ')
          ..write('startOffset: $startOffset, ')
          ..write('endOffset: $endOffset, ')
          ..write('rawText: $rawText, ')
          ..write('canonicalReference: $canonicalReference, ')
          ..write('confidence: $confidence, ')
          ..write('parserVersion: $parserVersion, ')
          ..write('overrideVersion: $overrideVersion, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class ScriptureReferenceSegments extends Table
    with TableInfo<ScriptureReferenceSegments, ScriptureReferenceSegment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  ScriptureReferenceSegments(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _spanIdMeta = const VerificationMeta('spanId');
  late final GeneratedColumn<String> spanId = GeneratedColumn<String>(
    'span_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints:
        'NOT NULL REFERENCES scripture_reference_spans(id)ON DELETE CASCADE',
  );
  static const VerificationMeta _bookIdMeta = const VerificationMeta('bookId');
  late final GeneratedColumn<String> bookId = GeneratedColumn<String>(
    'book_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _chapterMeta = const VerificationMeta(
    'chapter',
  );
  late final GeneratedColumn<int> chapter = GeneratedColumn<int>(
    'chapter',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _verseStartMeta = const VerificationMeta(
    'verseStart',
  );
  late final GeneratedColumn<int> verseStart = GeneratedColumn<int>(
    'verse_start',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _verseEndMeta = const VerificationMeta(
    'verseEnd',
  );
  late final GeneratedColumn<int> verseEnd = GeneratedColumn<int>(
    'verse_end',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _segmentOrderMeta = const VerificationMeta(
    'segmentOrder',
  );
  late final GeneratedColumn<int> segmentOrder = GeneratedColumn<int>(
    'segment_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [
    spanId,
    bookId,
    chapter,
    verseStart,
    verseEnd,
    segmentOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'scripture_reference_segments';
  @override
  VerificationContext validateIntegrity(
    Insertable<ScriptureReferenceSegment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('span_id')) {
      context.handle(
        _spanIdMeta,
        spanId.isAcceptableOrUnknown(data['span_id']!, _spanIdMeta),
      );
    } else if (isInserting) {
      context.missing(_spanIdMeta);
    }
    if (data.containsKey('book_id')) {
      context.handle(
        _bookIdMeta,
        bookId.isAcceptableOrUnknown(data['book_id']!, _bookIdMeta),
      );
    } else if (isInserting) {
      context.missing(_bookIdMeta);
    }
    if (data.containsKey('chapter')) {
      context.handle(
        _chapterMeta,
        chapter.isAcceptableOrUnknown(data['chapter']!, _chapterMeta),
      );
    } else if (isInserting) {
      context.missing(_chapterMeta);
    }
    if (data.containsKey('verse_start')) {
      context.handle(
        _verseStartMeta,
        verseStart.isAcceptableOrUnknown(data['verse_start']!, _verseStartMeta),
      );
    }
    if (data.containsKey('verse_end')) {
      context.handle(
        _verseEndMeta,
        verseEnd.isAcceptableOrUnknown(data['verse_end']!, _verseEndMeta),
      );
    }
    if (data.containsKey('segment_order')) {
      context.handle(
        _segmentOrderMeta,
        segmentOrder.isAcceptableOrUnknown(
          data['segment_order']!,
          _segmentOrderMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_segmentOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {spanId, segmentOrder};
  @override
  ScriptureReferenceSegment map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ScriptureReferenceSegment(
      spanId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}span_id'],
      )!,
      bookId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}book_id'],
      )!,
      chapter: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}chapter'],
      )!,
      verseStart: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}verse_start'],
      ),
      verseEnd: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}verse_end'],
      ),
      segmentOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}segment_order'],
      )!,
    );
  }

  @override
  ScriptureReferenceSegments createAlias(String alias) {
    return ScriptureReferenceSegments(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
    'PRIMARY KEY(span_id, segment_order)',
  ];
  @override
  bool get dontWriteConstraints => true;
}

class ScriptureReferenceSegment extends DataClass
    implements Insertable<ScriptureReferenceSegment> {
  final String spanId;
  final String bookId;
  final int chapter;
  final int? verseStart;
  final int? verseEnd;
  final int segmentOrder;
  const ScriptureReferenceSegment({
    required this.spanId,
    required this.bookId,
    required this.chapter,
    this.verseStart,
    this.verseEnd,
    required this.segmentOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['span_id'] = Variable<String>(spanId);
    map['book_id'] = Variable<String>(bookId);
    map['chapter'] = Variable<int>(chapter);
    if (!nullToAbsent || verseStart != null) {
      map['verse_start'] = Variable<int>(verseStart);
    }
    if (!nullToAbsent || verseEnd != null) {
      map['verse_end'] = Variable<int>(verseEnd);
    }
    map['segment_order'] = Variable<int>(segmentOrder);
    return map;
  }

  ScriptureReferenceSegmentsCompanion toCompanion(bool nullToAbsent) {
    return ScriptureReferenceSegmentsCompanion(
      spanId: Value(spanId),
      bookId: Value(bookId),
      chapter: Value(chapter),
      verseStart: verseStart == null && nullToAbsent
          ? const Value.absent()
          : Value(verseStart),
      verseEnd: verseEnd == null && nullToAbsent
          ? const Value.absent()
          : Value(verseEnd),
      segmentOrder: Value(segmentOrder),
    );
  }

  factory ScriptureReferenceSegment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ScriptureReferenceSegment(
      spanId: serializer.fromJson<String>(json['span_id']),
      bookId: serializer.fromJson<String>(json['book_id']),
      chapter: serializer.fromJson<int>(json['chapter']),
      verseStart: serializer.fromJson<int?>(json['verse_start']),
      verseEnd: serializer.fromJson<int?>(json['verse_end']),
      segmentOrder: serializer.fromJson<int>(json['segment_order']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'span_id': serializer.toJson<String>(spanId),
      'book_id': serializer.toJson<String>(bookId),
      'chapter': serializer.toJson<int>(chapter),
      'verse_start': serializer.toJson<int?>(verseStart),
      'verse_end': serializer.toJson<int?>(verseEnd),
      'segment_order': serializer.toJson<int>(segmentOrder),
    };
  }

  ScriptureReferenceSegment copyWith({
    String? spanId,
    String? bookId,
    int? chapter,
    Value<int?> verseStart = const Value.absent(),
    Value<int?> verseEnd = const Value.absent(),
    int? segmentOrder,
  }) => ScriptureReferenceSegment(
    spanId: spanId ?? this.spanId,
    bookId: bookId ?? this.bookId,
    chapter: chapter ?? this.chapter,
    verseStart: verseStart.present ? verseStart.value : this.verseStart,
    verseEnd: verseEnd.present ? verseEnd.value : this.verseEnd,
    segmentOrder: segmentOrder ?? this.segmentOrder,
  );
  ScriptureReferenceSegment copyWithCompanion(
    ScriptureReferenceSegmentsCompanion data,
  ) {
    return ScriptureReferenceSegment(
      spanId: data.spanId.present ? data.spanId.value : this.spanId,
      bookId: data.bookId.present ? data.bookId.value : this.bookId,
      chapter: data.chapter.present ? data.chapter.value : this.chapter,
      verseStart: data.verseStart.present
          ? data.verseStart.value
          : this.verseStart,
      verseEnd: data.verseEnd.present ? data.verseEnd.value : this.verseEnd,
      segmentOrder: data.segmentOrder.present
          ? data.segmentOrder.value
          : this.segmentOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ScriptureReferenceSegment(')
          ..write('spanId: $spanId, ')
          ..write('bookId: $bookId, ')
          ..write('chapter: $chapter, ')
          ..write('verseStart: $verseStart, ')
          ..write('verseEnd: $verseEnd, ')
          ..write('segmentOrder: $segmentOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(spanId, bookId, chapter, verseStart, verseEnd, segmentOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScriptureReferenceSegment &&
          other.spanId == this.spanId &&
          other.bookId == this.bookId &&
          other.chapter == this.chapter &&
          other.verseStart == this.verseStart &&
          other.verseEnd == this.verseEnd &&
          other.segmentOrder == this.segmentOrder);
}

class ScriptureReferenceSegmentsCompanion
    extends UpdateCompanion<ScriptureReferenceSegment> {
  final Value<String> spanId;
  final Value<String> bookId;
  final Value<int> chapter;
  final Value<int?> verseStart;
  final Value<int?> verseEnd;
  final Value<int> segmentOrder;
  final Value<int> rowid;
  const ScriptureReferenceSegmentsCompanion({
    this.spanId = const Value.absent(),
    this.bookId = const Value.absent(),
    this.chapter = const Value.absent(),
    this.verseStart = const Value.absent(),
    this.verseEnd = const Value.absent(),
    this.segmentOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ScriptureReferenceSegmentsCompanion.insert({
    required String spanId,
    required String bookId,
    required int chapter,
    this.verseStart = const Value.absent(),
    this.verseEnd = const Value.absent(),
    required int segmentOrder,
    this.rowid = const Value.absent(),
  }) : spanId = Value(spanId),
       bookId = Value(bookId),
       chapter = Value(chapter),
       segmentOrder = Value(segmentOrder);
  static Insertable<ScriptureReferenceSegment> custom({
    Expression<String>? spanId,
    Expression<String>? bookId,
    Expression<int>? chapter,
    Expression<int>? verseStart,
    Expression<int>? verseEnd,
    Expression<int>? segmentOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (spanId != null) 'span_id': spanId,
      if (bookId != null) 'book_id': bookId,
      if (chapter != null) 'chapter': chapter,
      if (verseStart != null) 'verse_start': verseStart,
      if (verseEnd != null) 'verse_end': verseEnd,
      if (segmentOrder != null) 'segment_order': segmentOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ScriptureReferenceSegmentsCompanion copyWith({
    Value<String>? spanId,
    Value<String>? bookId,
    Value<int>? chapter,
    Value<int?>? verseStart,
    Value<int?>? verseEnd,
    Value<int>? segmentOrder,
    Value<int>? rowid,
  }) {
    return ScriptureReferenceSegmentsCompanion(
      spanId: spanId ?? this.spanId,
      bookId: bookId ?? this.bookId,
      chapter: chapter ?? this.chapter,
      verseStart: verseStart ?? this.verseStart,
      verseEnd: verseEnd ?? this.verseEnd,
      segmentOrder: segmentOrder ?? this.segmentOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (spanId.present) {
      map['span_id'] = Variable<String>(spanId.value);
    }
    if (bookId.present) {
      map['book_id'] = Variable<String>(bookId.value);
    }
    if (chapter.present) {
      map['chapter'] = Variable<int>(chapter.value);
    }
    if (verseStart.present) {
      map['verse_start'] = Variable<int>(verseStart.value);
    }
    if (verseEnd.present) {
      map['verse_end'] = Variable<int>(verseEnd.value);
    }
    if (segmentOrder.present) {
      map['segment_order'] = Variable<int>(segmentOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScriptureReferenceSegmentsCompanion(')
          ..write('spanId: $spanId, ')
          ..write('bookId: $bookId, ')
          ..write('chapter: $chapter, ')
          ..write('verseStart: $verseStart, ')
          ..write('verseEnd: $verseEnd, ')
          ..write('segmentOrder: $segmentOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class ScriptureVerseOccurrences extends Table
    with TableInfo<ScriptureVerseOccurrences, ScriptureVerseOccurrence> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  ScriptureVerseOccurrences(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _spanIdMeta = const VerificationMeta('spanId');
  late final GeneratedColumn<String> spanId = GeneratedColumn<String>(
    'span_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints:
        'NOT NULL REFERENCES scripture_reference_spans(id)ON DELETE CASCADE',
  );
  static const VerificationMeta _collectionIdMeta = const VerificationMeta(
    'collectionId',
  );
  late final GeneratedColumn<String> collectionId = GeneratedColumn<String>(
    'collection_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints:
        'NOT NULL REFERENCES archive_collections(id)ON DELETE CASCADE',
  );
  static const VerificationMeta _documentIdMeta = const VerificationMeta(
    'documentId',
  );
  late final GeneratedColumn<String> documentId = GeneratedColumn<String>(
    'document_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES documents(id)ON DELETE CASCADE',
  );
  static const VerificationMeta _blockIdMeta = const VerificationMeta(
    'blockId',
  );
  late final GeneratedColumn<String> blockId = GeneratedColumn<String>(
    'block_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints:
        'NOT NULL REFERENCES document_blocks(id)ON DELETE CASCADE',
  );
  static const VerificationMeta _bookIdMeta = const VerificationMeta('bookId');
  late final GeneratedColumn<String> bookId = GeneratedColumn<String>(
    'book_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _chapterMeta = const VerificationMeta(
    'chapter',
  );
  late final GeneratedColumn<int> chapter = GeneratedColumn<int>(
    'chapter',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _verseMeta = const VerificationMeta('verse');
  late final GeneratedColumn<int> verse = GeneratedColumn<int>(
    'verse',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [
    spanId,
    collectionId,
    documentId,
    blockId,
    bookId,
    chapter,
    verse,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'scripture_verse_occurrences';
  @override
  VerificationContext validateIntegrity(
    Insertable<ScriptureVerseOccurrence> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('span_id')) {
      context.handle(
        _spanIdMeta,
        spanId.isAcceptableOrUnknown(data['span_id']!, _spanIdMeta),
      );
    } else if (isInserting) {
      context.missing(_spanIdMeta);
    }
    if (data.containsKey('collection_id')) {
      context.handle(
        _collectionIdMeta,
        collectionId.isAcceptableOrUnknown(
          data['collection_id']!,
          _collectionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_collectionIdMeta);
    }
    if (data.containsKey('document_id')) {
      context.handle(
        _documentIdMeta,
        documentId.isAcceptableOrUnknown(data['document_id']!, _documentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_documentIdMeta);
    }
    if (data.containsKey('block_id')) {
      context.handle(
        _blockIdMeta,
        blockId.isAcceptableOrUnknown(data['block_id']!, _blockIdMeta),
      );
    } else if (isInserting) {
      context.missing(_blockIdMeta);
    }
    if (data.containsKey('book_id')) {
      context.handle(
        _bookIdMeta,
        bookId.isAcceptableOrUnknown(data['book_id']!, _bookIdMeta),
      );
    } else if (isInserting) {
      context.missing(_bookIdMeta);
    }
    if (data.containsKey('chapter')) {
      context.handle(
        _chapterMeta,
        chapter.isAcceptableOrUnknown(data['chapter']!, _chapterMeta),
      );
    } else if (isInserting) {
      context.missing(_chapterMeta);
    }
    if (data.containsKey('verse')) {
      context.handle(
        _verseMeta,
        verse.isAcceptableOrUnknown(data['verse']!, _verseMeta),
      );
    } else if (isInserting) {
      context.missing(_verseMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {spanId, bookId, chapter, verse};
  @override
  ScriptureVerseOccurrence map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ScriptureVerseOccurrence(
      spanId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}span_id'],
      )!,
      collectionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}collection_id'],
      )!,
      documentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}document_id'],
      )!,
      blockId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}block_id'],
      )!,
      bookId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}book_id'],
      )!,
      chapter: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}chapter'],
      )!,
      verse: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}verse'],
      )!,
    );
  }

  @override
  ScriptureVerseOccurrences createAlias(String alias) {
    return ScriptureVerseOccurrences(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
    'PRIMARY KEY(span_id, book_id, chapter, verse)',
  ];
  @override
  bool get dontWriteConstraints => true;
}

class ScriptureVerseOccurrence extends DataClass
    implements Insertable<ScriptureVerseOccurrence> {
  final String spanId;
  final String collectionId;
  final String documentId;
  final String blockId;
  final String bookId;
  final int chapter;
  final int verse;
  const ScriptureVerseOccurrence({
    required this.spanId,
    required this.collectionId,
    required this.documentId,
    required this.blockId,
    required this.bookId,
    required this.chapter,
    required this.verse,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['span_id'] = Variable<String>(spanId);
    map['collection_id'] = Variable<String>(collectionId);
    map['document_id'] = Variable<String>(documentId);
    map['block_id'] = Variable<String>(blockId);
    map['book_id'] = Variable<String>(bookId);
    map['chapter'] = Variable<int>(chapter);
    map['verse'] = Variable<int>(verse);
    return map;
  }

  ScriptureVerseOccurrencesCompanion toCompanion(bool nullToAbsent) {
    return ScriptureVerseOccurrencesCompanion(
      spanId: Value(spanId),
      collectionId: Value(collectionId),
      documentId: Value(documentId),
      blockId: Value(blockId),
      bookId: Value(bookId),
      chapter: Value(chapter),
      verse: Value(verse),
    );
  }

  factory ScriptureVerseOccurrence.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ScriptureVerseOccurrence(
      spanId: serializer.fromJson<String>(json['span_id']),
      collectionId: serializer.fromJson<String>(json['collection_id']),
      documentId: serializer.fromJson<String>(json['document_id']),
      blockId: serializer.fromJson<String>(json['block_id']),
      bookId: serializer.fromJson<String>(json['book_id']),
      chapter: serializer.fromJson<int>(json['chapter']),
      verse: serializer.fromJson<int>(json['verse']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'span_id': serializer.toJson<String>(spanId),
      'collection_id': serializer.toJson<String>(collectionId),
      'document_id': serializer.toJson<String>(documentId),
      'block_id': serializer.toJson<String>(blockId),
      'book_id': serializer.toJson<String>(bookId),
      'chapter': serializer.toJson<int>(chapter),
      'verse': serializer.toJson<int>(verse),
    };
  }

  ScriptureVerseOccurrence copyWith({
    String? spanId,
    String? collectionId,
    String? documentId,
    String? blockId,
    String? bookId,
    int? chapter,
    int? verse,
  }) => ScriptureVerseOccurrence(
    spanId: spanId ?? this.spanId,
    collectionId: collectionId ?? this.collectionId,
    documentId: documentId ?? this.documentId,
    blockId: blockId ?? this.blockId,
    bookId: bookId ?? this.bookId,
    chapter: chapter ?? this.chapter,
    verse: verse ?? this.verse,
  );
  ScriptureVerseOccurrence copyWithCompanion(
    ScriptureVerseOccurrencesCompanion data,
  ) {
    return ScriptureVerseOccurrence(
      spanId: data.spanId.present ? data.spanId.value : this.spanId,
      collectionId: data.collectionId.present
          ? data.collectionId.value
          : this.collectionId,
      documentId: data.documentId.present
          ? data.documentId.value
          : this.documentId,
      blockId: data.blockId.present ? data.blockId.value : this.blockId,
      bookId: data.bookId.present ? data.bookId.value : this.bookId,
      chapter: data.chapter.present ? data.chapter.value : this.chapter,
      verse: data.verse.present ? data.verse.value : this.verse,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ScriptureVerseOccurrence(')
          ..write('spanId: $spanId, ')
          ..write('collectionId: $collectionId, ')
          ..write('documentId: $documentId, ')
          ..write('blockId: $blockId, ')
          ..write('bookId: $bookId, ')
          ..write('chapter: $chapter, ')
          ..write('verse: $verse')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    spanId,
    collectionId,
    documentId,
    blockId,
    bookId,
    chapter,
    verse,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScriptureVerseOccurrence &&
          other.spanId == this.spanId &&
          other.collectionId == this.collectionId &&
          other.documentId == this.documentId &&
          other.blockId == this.blockId &&
          other.bookId == this.bookId &&
          other.chapter == this.chapter &&
          other.verse == this.verse);
}

class ScriptureVerseOccurrencesCompanion
    extends UpdateCompanion<ScriptureVerseOccurrence> {
  final Value<String> spanId;
  final Value<String> collectionId;
  final Value<String> documentId;
  final Value<String> blockId;
  final Value<String> bookId;
  final Value<int> chapter;
  final Value<int> verse;
  final Value<int> rowid;
  const ScriptureVerseOccurrencesCompanion({
    this.spanId = const Value.absent(),
    this.collectionId = const Value.absent(),
    this.documentId = const Value.absent(),
    this.blockId = const Value.absent(),
    this.bookId = const Value.absent(),
    this.chapter = const Value.absent(),
    this.verse = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ScriptureVerseOccurrencesCompanion.insert({
    required String spanId,
    required String collectionId,
    required String documentId,
    required String blockId,
    required String bookId,
    required int chapter,
    required int verse,
    this.rowid = const Value.absent(),
  }) : spanId = Value(spanId),
       collectionId = Value(collectionId),
       documentId = Value(documentId),
       blockId = Value(blockId),
       bookId = Value(bookId),
       chapter = Value(chapter),
       verse = Value(verse);
  static Insertable<ScriptureVerseOccurrence> custom({
    Expression<String>? spanId,
    Expression<String>? collectionId,
    Expression<String>? documentId,
    Expression<String>? blockId,
    Expression<String>? bookId,
    Expression<int>? chapter,
    Expression<int>? verse,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (spanId != null) 'span_id': spanId,
      if (collectionId != null) 'collection_id': collectionId,
      if (documentId != null) 'document_id': documentId,
      if (blockId != null) 'block_id': blockId,
      if (bookId != null) 'book_id': bookId,
      if (chapter != null) 'chapter': chapter,
      if (verse != null) 'verse': verse,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ScriptureVerseOccurrencesCompanion copyWith({
    Value<String>? spanId,
    Value<String>? collectionId,
    Value<String>? documentId,
    Value<String>? blockId,
    Value<String>? bookId,
    Value<int>? chapter,
    Value<int>? verse,
    Value<int>? rowid,
  }) {
    return ScriptureVerseOccurrencesCompanion(
      spanId: spanId ?? this.spanId,
      collectionId: collectionId ?? this.collectionId,
      documentId: documentId ?? this.documentId,
      blockId: blockId ?? this.blockId,
      bookId: bookId ?? this.bookId,
      chapter: chapter ?? this.chapter,
      verse: verse ?? this.verse,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (spanId.present) {
      map['span_id'] = Variable<String>(spanId.value);
    }
    if (collectionId.present) {
      map['collection_id'] = Variable<String>(collectionId.value);
    }
    if (documentId.present) {
      map['document_id'] = Variable<String>(documentId.value);
    }
    if (blockId.present) {
      map['block_id'] = Variable<String>(blockId.value);
    }
    if (bookId.present) {
      map['book_id'] = Variable<String>(bookId.value);
    }
    if (chapter.present) {
      map['chapter'] = Variable<int>(chapter.value);
    }
    if (verse.present) {
      map['verse'] = Variable<int>(verse.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScriptureVerseOccurrencesCompanion(')
          ..write('spanId: $spanId, ')
          ..write('collectionId: $collectionId, ')
          ..write('documentId: $documentId, ')
          ..write('blockId: $blockId, ')
          ..write('bookId: $bookId, ')
          ..write('chapter: $chapter, ')
          ..write('verse: $verse, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class CrossReferences extends Table
    with TableInfo<CrossReferences, CrossReference> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  CrossReferences(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _sourceDocumentIdMeta = const VerificationMeta(
    'sourceDocumentId',
  );
  late final GeneratedColumn<String> sourceDocumentId = GeneratedColumn<String>(
    'source_document_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES documents(id)ON DELETE CASCADE',
  );
  static const VerificationMeta _sourceBlockIdMeta = const VerificationMeta(
    'sourceBlockId',
  );
  late final GeneratedColumn<String> sourceBlockId = GeneratedColumn<String>(
    'source_block_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _targetDocumentIdMeta = const VerificationMeta(
    'targetDocumentId',
  );
  late final GeneratedColumn<String> targetDocumentId = GeneratedColumn<String>(
    'target_document_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _relationshipTypeMeta = const VerificationMeta(
    'relationshipType',
  );
  late final GeneratedColumn<String> relationshipType = GeneratedColumn<String>(
    'relationship_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _displayTextMeta = const VerificationMeta(
    'displayText',
  );
  late final GeneratedColumn<String> displayText = GeneratedColumn<String>(
    'display_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _verifiedMeta = const VerificationMeta(
    'verified',
  );
  late final GeneratedColumn<int> verified = GeneratedColumn<int>(
    'verified',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT 0 CHECK (verified IN (0, 1))',
    defaultValue: const CustomExpression('0'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sourceDocumentId,
    sourceBlockId,
    targetDocumentId,
    relationshipType,
    displayText,
    verified,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cross_references';
  @override
  VerificationContext validateIntegrity(
    Insertable<CrossReference> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('source_document_id')) {
      context.handle(
        _sourceDocumentIdMeta,
        sourceDocumentId.isAcceptableOrUnknown(
          data['source_document_id']!,
          _sourceDocumentIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sourceDocumentIdMeta);
    }
    if (data.containsKey('source_block_id')) {
      context.handle(
        _sourceBlockIdMeta,
        sourceBlockId.isAcceptableOrUnknown(
          data['source_block_id']!,
          _sourceBlockIdMeta,
        ),
      );
    }
    if (data.containsKey('target_document_id')) {
      context.handle(
        _targetDocumentIdMeta,
        targetDocumentId.isAcceptableOrUnknown(
          data['target_document_id']!,
          _targetDocumentIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetDocumentIdMeta);
    }
    if (data.containsKey('relationship_type')) {
      context.handle(
        _relationshipTypeMeta,
        relationshipType.isAcceptableOrUnknown(
          data['relationship_type']!,
          _relationshipTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_relationshipTypeMeta);
    }
    if (data.containsKey('display_text')) {
      context.handle(
        _displayTextMeta,
        displayText.isAcceptableOrUnknown(
          data['display_text']!,
          _displayTextMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayTextMeta);
    }
    if (data.containsKey('verified')) {
      context.handle(
        _verifiedMeta,
        verified.isAcceptableOrUnknown(data['verified']!, _verifiedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CrossReference map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CrossReference(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      sourceDocumentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_document_id'],
      )!,
      sourceBlockId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_block_id'],
      ),
      targetDocumentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target_document_id'],
      )!,
      relationshipType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}relationship_type'],
      )!,
      displayText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_text'],
      )!,
      verified: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}verified'],
      )!,
    );
  }

  @override
  CrossReferences createAlias(String alias) {
    return CrossReferences(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class CrossReference extends DataClass implements Insertable<CrossReference> {
  final String id;
  final String sourceDocumentId;
  final String? sourceBlockId;
  final String targetDocumentId;
  final String relationshipType;
  final String displayText;
  final int verified;
  const CrossReference({
    required this.id,
    required this.sourceDocumentId,
    this.sourceBlockId,
    required this.targetDocumentId,
    required this.relationshipType,
    required this.displayText,
    required this.verified,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['source_document_id'] = Variable<String>(sourceDocumentId);
    if (!nullToAbsent || sourceBlockId != null) {
      map['source_block_id'] = Variable<String>(sourceBlockId);
    }
    map['target_document_id'] = Variable<String>(targetDocumentId);
    map['relationship_type'] = Variable<String>(relationshipType);
    map['display_text'] = Variable<String>(displayText);
    map['verified'] = Variable<int>(verified);
    return map;
  }

  CrossReferencesCompanion toCompanion(bool nullToAbsent) {
    return CrossReferencesCompanion(
      id: Value(id),
      sourceDocumentId: Value(sourceDocumentId),
      sourceBlockId: sourceBlockId == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceBlockId),
      targetDocumentId: Value(targetDocumentId),
      relationshipType: Value(relationshipType),
      displayText: Value(displayText),
      verified: Value(verified),
    );
  }

  factory CrossReference.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CrossReference(
      id: serializer.fromJson<String>(json['id']),
      sourceDocumentId: serializer.fromJson<String>(json['source_document_id']),
      sourceBlockId: serializer.fromJson<String?>(json['source_block_id']),
      targetDocumentId: serializer.fromJson<String>(json['target_document_id']),
      relationshipType: serializer.fromJson<String>(json['relationship_type']),
      displayText: serializer.fromJson<String>(json['display_text']),
      verified: serializer.fromJson<int>(json['verified']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'source_document_id': serializer.toJson<String>(sourceDocumentId),
      'source_block_id': serializer.toJson<String?>(sourceBlockId),
      'target_document_id': serializer.toJson<String>(targetDocumentId),
      'relationship_type': serializer.toJson<String>(relationshipType),
      'display_text': serializer.toJson<String>(displayText),
      'verified': serializer.toJson<int>(verified),
    };
  }

  CrossReference copyWith({
    String? id,
    String? sourceDocumentId,
    Value<String?> sourceBlockId = const Value.absent(),
    String? targetDocumentId,
    String? relationshipType,
    String? displayText,
    int? verified,
  }) => CrossReference(
    id: id ?? this.id,
    sourceDocumentId: sourceDocumentId ?? this.sourceDocumentId,
    sourceBlockId: sourceBlockId.present
        ? sourceBlockId.value
        : this.sourceBlockId,
    targetDocumentId: targetDocumentId ?? this.targetDocumentId,
    relationshipType: relationshipType ?? this.relationshipType,
    displayText: displayText ?? this.displayText,
    verified: verified ?? this.verified,
  );
  CrossReference copyWithCompanion(CrossReferencesCompanion data) {
    return CrossReference(
      id: data.id.present ? data.id.value : this.id,
      sourceDocumentId: data.sourceDocumentId.present
          ? data.sourceDocumentId.value
          : this.sourceDocumentId,
      sourceBlockId: data.sourceBlockId.present
          ? data.sourceBlockId.value
          : this.sourceBlockId,
      targetDocumentId: data.targetDocumentId.present
          ? data.targetDocumentId.value
          : this.targetDocumentId,
      relationshipType: data.relationshipType.present
          ? data.relationshipType.value
          : this.relationshipType,
      displayText: data.displayText.present
          ? data.displayText.value
          : this.displayText,
      verified: data.verified.present ? data.verified.value : this.verified,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CrossReference(')
          ..write('id: $id, ')
          ..write('sourceDocumentId: $sourceDocumentId, ')
          ..write('sourceBlockId: $sourceBlockId, ')
          ..write('targetDocumentId: $targetDocumentId, ')
          ..write('relationshipType: $relationshipType, ')
          ..write('displayText: $displayText, ')
          ..write('verified: $verified')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sourceDocumentId,
    sourceBlockId,
    targetDocumentId,
    relationshipType,
    displayText,
    verified,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CrossReference &&
          other.id == this.id &&
          other.sourceDocumentId == this.sourceDocumentId &&
          other.sourceBlockId == this.sourceBlockId &&
          other.targetDocumentId == this.targetDocumentId &&
          other.relationshipType == this.relationshipType &&
          other.displayText == this.displayText &&
          other.verified == this.verified);
}

class CrossReferencesCompanion extends UpdateCompanion<CrossReference> {
  final Value<String> id;
  final Value<String> sourceDocumentId;
  final Value<String?> sourceBlockId;
  final Value<String> targetDocumentId;
  final Value<String> relationshipType;
  final Value<String> displayText;
  final Value<int> verified;
  final Value<int> rowid;
  const CrossReferencesCompanion({
    this.id = const Value.absent(),
    this.sourceDocumentId = const Value.absent(),
    this.sourceBlockId = const Value.absent(),
    this.targetDocumentId = const Value.absent(),
    this.relationshipType = const Value.absent(),
    this.displayText = const Value.absent(),
    this.verified = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CrossReferencesCompanion.insert({
    required String id,
    required String sourceDocumentId,
    this.sourceBlockId = const Value.absent(),
    required String targetDocumentId,
    required String relationshipType,
    required String displayText,
    this.verified = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       sourceDocumentId = Value(sourceDocumentId),
       targetDocumentId = Value(targetDocumentId),
       relationshipType = Value(relationshipType),
       displayText = Value(displayText);
  static Insertable<CrossReference> custom({
    Expression<String>? id,
    Expression<String>? sourceDocumentId,
    Expression<String>? sourceBlockId,
    Expression<String>? targetDocumentId,
    Expression<String>? relationshipType,
    Expression<String>? displayText,
    Expression<int>? verified,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sourceDocumentId != null) 'source_document_id': sourceDocumentId,
      if (sourceBlockId != null) 'source_block_id': sourceBlockId,
      if (targetDocumentId != null) 'target_document_id': targetDocumentId,
      if (relationshipType != null) 'relationship_type': relationshipType,
      if (displayText != null) 'display_text': displayText,
      if (verified != null) 'verified': verified,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CrossReferencesCompanion copyWith({
    Value<String>? id,
    Value<String>? sourceDocumentId,
    Value<String?>? sourceBlockId,
    Value<String>? targetDocumentId,
    Value<String>? relationshipType,
    Value<String>? displayText,
    Value<int>? verified,
    Value<int>? rowid,
  }) {
    return CrossReferencesCompanion(
      id: id ?? this.id,
      sourceDocumentId: sourceDocumentId ?? this.sourceDocumentId,
      sourceBlockId: sourceBlockId ?? this.sourceBlockId,
      targetDocumentId: targetDocumentId ?? this.targetDocumentId,
      relationshipType: relationshipType ?? this.relationshipType,
      displayText: displayText ?? this.displayText,
      verified: verified ?? this.verified,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sourceDocumentId.present) {
      map['source_document_id'] = Variable<String>(sourceDocumentId.value);
    }
    if (sourceBlockId.present) {
      map['source_block_id'] = Variable<String>(sourceBlockId.value);
    }
    if (targetDocumentId.present) {
      map['target_document_id'] = Variable<String>(targetDocumentId.value);
    }
    if (relationshipType.present) {
      map['relationship_type'] = Variable<String>(relationshipType.value);
    }
    if (displayText.present) {
      map['display_text'] = Variable<String>(displayText.value);
    }
    if (verified.present) {
      map['verified'] = Variable<int>(verified.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CrossReferencesCompanion(')
          ..write('id: $id, ')
          ..write('sourceDocumentId: $sourceDocumentId, ')
          ..write('sourceBlockId: $sourceBlockId, ')
          ..write('targetDocumentId: $targetDocumentId, ')
          ..write('relationshipType: $relationshipType, ')
          ..write('displayText: $displayText, ')
          ..write('verified: $verified, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class TimelineEntries extends Table
    with TableInfo<TimelineEntries, TimelineEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  TimelineEntries(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _documentIdMeta = const VerificationMeta(
    'documentId',
  );
  late final GeneratedColumn<String> documentId = GeneratedColumn<String>(
    'document_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES documents(id)ON DELETE CASCADE',
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _dateTypeMeta = const VerificationMeta(
    'dateType',
  );
  late final GeneratedColumn<String> dateType = GeneratedColumn<String>(
    'date_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _displayLabelMeta = const VerificationMeta(
    'displayLabel',
  );
  late final GeneratedColumn<String> displayLabel = GeneratedColumn<String>(
    'display_label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    documentId,
    date,
    dateType,
    displayLabel,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'timeline_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<TimelineEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('document_id')) {
      context.handle(
        _documentIdMeta,
        documentId.isAcceptableOrUnknown(data['document_id']!, _documentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_documentIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('date_type')) {
      context.handle(
        _dateTypeMeta,
        dateType.isAcceptableOrUnknown(data['date_type']!, _dateTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_dateTypeMeta);
    }
    if (data.containsKey('display_label')) {
      context.handle(
        _displayLabelMeta,
        displayLabel.isAcceptableOrUnknown(
          data['display_label']!,
          _displayLabelMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayLabelMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TimelineEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TimelineEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      documentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}document_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date'],
      )!,
      dateType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date_type'],
      )!,
      displayLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_label'],
      )!,
    );
  }

  @override
  TimelineEntries createAlias(String alias) {
    return TimelineEntries(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class TimelineEntry extends DataClass implements Insertable<TimelineEntry> {
  final String id;
  final String documentId;
  final String date;
  final String dateType;
  final String displayLabel;
  const TimelineEntry({
    required this.id,
    required this.documentId,
    required this.date,
    required this.dateType,
    required this.displayLabel,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['document_id'] = Variable<String>(documentId);
    map['date'] = Variable<String>(date);
    map['date_type'] = Variable<String>(dateType);
    map['display_label'] = Variable<String>(displayLabel);
    return map;
  }

  TimelineEntriesCompanion toCompanion(bool nullToAbsent) {
    return TimelineEntriesCompanion(
      id: Value(id),
      documentId: Value(documentId),
      date: Value(date),
      dateType: Value(dateType),
      displayLabel: Value(displayLabel),
    );
  }

  factory TimelineEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TimelineEntry(
      id: serializer.fromJson<String>(json['id']),
      documentId: serializer.fromJson<String>(json['document_id']),
      date: serializer.fromJson<String>(json['date']),
      dateType: serializer.fromJson<String>(json['date_type']),
      displayLabel: serializer.fromJson<String>(json['display_label']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'document_id': serializer.toJson<String>(documentId),
      'date': serializer.toJson<String>(date),
      'date_type': serializer.toJson<String>(dateType),
      'display_label': serializer.toJson<String>(displayLabel),
    };
  }

  TimelineEntry copyWith({
    String? id,
    String? documentId,
    String? date,
    String? dateType,
    String? displayLabel,
  }) => TimelineEntry(
    id: id ?? this.id,
    documentId: documentId ?? this.documentId,
    date: date ?? this.date,
    dateType: dateType ?? this.dateType,
    displayLabel: displayLabel ?? this.displayLabel,
  );
  TimelineEntry copyWithCompanion(TimelineEntriesCompanion data) {
    return TimelineEntry(
      id: data.id.present ? data.id.value : this.id,
      documentId: data.documentId.present
          ? data.documentId.value
          : this.documentId,
      date: data.date.present ? data.date.value : this.date,
      dateType: data.dateType.present ? data.dateType.value : this.dateType,
      displayLabel: data.displayLabel.present
          ? data.displayLabel.value
          : this.displayLabel,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TimelineEntry(')
          ..write('id: $id, ')
          ..write('documentId: $documentId, ')
          ..write('date: $date, ')
          ..write('dateType: $dateType, ')
          ..write('displayLabel: $displayLabel')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, documentId, date, dateType, displayLabel);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TimelineEntry &&
          other.id == this.id &&
          other.documentId == this.documentId &&
          other.date == this.date &&
          other.dateType == this.dateType &&
          other.displayLabel == this.displayLabel);
}

class TimelineEntriesCompanion extends UpdateCompanion<TimelineEntry> {
  final Value<String> id;
  final Value<String> documentId;
  final Value<String> date;
  final Value<String> dateType;
  final Value<String> displayLabel;
  final Value<int> rowid;
  const TimelineEntriesCompanion({
    this.id = const Value.absent(),
    this.documentId = const Value.absent(),
    this.date = const Value.absent(),
    this.dateType = const Value.absent(),
    this.displayLabel = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TimelineEntriesCompanion.insert({
    required String id,
    required String documentId,
    required String date,
    required String dateType,
    required String displayLabel,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       documentId = Value(documentId),
       date = Value(date),
       dateType = Value(dateType),
       displayLabel = Value(displayLabel);
  static Insertable<TimelineEntry> custom({
    Expression<String>? id,
    Expression<String>? documentId,
    Expression<String>? date,
    Expression<String>? dateType,
    Expression<String>? displayLabel,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (documentId != null) 'document_id': documentId,
      if (date != null) 'date': date,
      if (dateType != null) 'date_type': dateType,
      if (displayLabel != null) 'display_label': displayLabel,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TimelineEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? documentId,
    Value<String>? date,
    Value<String>? dateType,
    Value<String>? displayLabel,
    Value<int>? rowid,
  }) {
    return TimelineEntriesCompanion(
      id: id ?? this.id,
      documentId: documentId ?? this.documentId,
      date: date ?? this.date,
      dateType: dateType ?? this.dateType,
      displayLabel: displayLabel ?? this.displayLabel,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (documentId.present) {
      map['document_id'] = Variable<String>(documentId.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (dateType.present) {
      map['date_type'] = Variable<String>(dateType.value);
    }
    if (displayLabel.present) {
      map['display_label'] = Variable<String>(displayLabel.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TimelineEntriesCompanion(')
          ..write('id: $id, ')
          ..write('documentId: $documentId, ')
          ..write('date: $date, ')
          ..write('dateType: $dateType, ')
          ..write('displayLabel: $displayLabel, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class SearchIndex extends Table
    with
        TableInfo<SearchIndex, SearchIndexData>,
        VirtualTableInfo<SearchIndex, SearchIndexData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  SearchIndex(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _collectionIdMeta = const VerificationMeta(
    'collectionId',
  );
  late final GeneratedColumn<String> collectionId = GeneratedColumn<String>(
    'collection_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: '',
  );
  static const VerificationMeta _collectionNameMeta = const VerificationMeta(
    'collectionName',
  );
  late final GeneratedColumn<String> collectionName = GeneratedColumn<String>(
    'collection_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: '',
  );
  static const VerificationMeta _documentIdMeta = const VerificationMeta(
    'documentId',
  );
  late final GeneratedColumn<String> documentId = GeneratedColumn<String>(
    'document_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: '',
  );
  static const VerificationMeta _documentTitleMeta = const VerificationMeta(
    'documentTitle',
  );
  late final GeneratedColumn<String> documentTitle = GeneratedColumn<String>(
    'document_title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: '',
  );
  static const VerificationMeta _blockIdMeta = const VerificationMeta(
    'blockId',
  );
  late final GeneratedColumn<String> blockId = GeneratedColumn<String>(
    'block_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: '',
  );
  static const VerificationMeta _blockLabelMeta = const VerificationMeta(
    'blockLabel',
  );
  late final GeneratedColumn<String> blockLabel = GeneratedColumn<String>(
    'block_label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: '',
  );
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
    'body',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: '',
  );
  @override
  List<GeneratedColumn> get $columns => [
    collectionId,
    collectionName,
    documentId,
    documentTitle,
    blockId,
    blockLabel,
    body,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'search_index';
  @override
  VerificationContext validateIntegrity(
    Insertable<SearchIndexData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('collection_id')) {
      context.handle(
        _collectionIdMeta,
        collectionId.isAcceptableOrUnknown(
          data['collection_id']!,
          _collectionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_collectionIdMeta);
    }
    if (data.containsKey('collection_name')) {
      context.handle(
        _collectionNameMeta,
        collectionName.isAcceptableOrUnknown(
          data['collection_name']!,
          _collectionNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_collectionNameMeta);
    }
    if (data.containsKey('document_id')) {
      context.handle(
        _documentIdMeta,
        documentId.isAcceptableOrUnknown(data['document_id']!, _documentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_documentIdMeta);
    }
    if (data.containsKey('document_title')) {
      context.handle(
        _documentTitleMeta,
        documentTitle.isAcceptableOrUnknown(
          data['document_title']!,
          _documentTitleMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_documentTitleMeta);
    }
    if (data.containsKey('block_id')) {
      context.handle(
        _blockIdMeta,
        blockId.isAcceptableOrUnknown(data['block_id']!, _blockIdMeta),
      );
    } else if (isInserting) {
      context.missing(_blockIdMeta);
    }
    if (data.containsKey('block_label')) {
      context.handle(
        _blockLabelMeta,
        blockLabel.isAcceptableOrUnknown(data['block_label']!, _blockLabelMeta),
      );
    } else if (isInserting) {
      context.missing(_blockLabelMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
        _bodyMeta,
        body.isAcceptableOrUnknown(data['body']!, _bodyMeta),
      );
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  SearchIndexData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SearchIndexData(
      collectionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}collection_id'],
      )!,
      collectionName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}collection_name'],
      )!,
      documentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}document_id'],
      )!,
      documentTitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}document_title'],
      )!,
      blockId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}block_id'],
      )!,
      blockLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}block_label'],
      )!,
      body: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body'],
      )!,
    );
  }

  @override
  SearchIndex createAlias(String alias) {
    return SearchIndex(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
  @override
  String get moduleAndArgs =>
      'fts5(collection_id UNINDEXED, collection_name, document_id UNINDEXED, document_title, block_id UNINDEXED, block_label, body, tokenize = \'unicode61 remove_diacritics 2\', prefix = \'2 3 4\')';
}

class SearchIndexData extends DataClass implements Insertable<SearchIndexData> {
  final String collectionId;
  final String collectionName;
  final String documentId;
  final String documentTitle;
  final String blockId;
  final String blockLabel;
  final String body;
  const SearchIndexData({
    required this.collectionId,
    required this.collectionName,
    required this.documentId,
    required this.documentTitle,
    required this.blockId,
    required this.blockLabel,
    required this.body,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['collection_id'] = Variable<String>(collectionId);
    map['collection_name'] = Variable<String>(collectionName);
    map['document_id'] = Variable<String>(documentId);
    map['document_title'] = Variable<String>(documentTitle);
    map['block_id'] = Variable<String>(blockId);
    map['block_label'] = Variable<String>(blockLabel);
    map['body'] = Variable<String>(body);
    return map;
  }

  SearchIndexCompanion toCompanion(bool nullToAbsent) {
    return SearchIndexCompanion(
      collectionId: Value(collectionId),
      collectionName: Value(collectionName),
      documentId: Value(documentId),
      documentTitle: Value(documentTitle),
      blockId: Value(blockId),
      blockLabel: Value(blockLabel),
      body: Value(body),
    );
  }

  factory SearchIndexData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SearchIndexData(
      collectionId: serializer.fromJson<String>(json['collection_id']),
      collectionName: serializer.fromJson<String>(json['collection_name']),
      documentId: serializer.fromJson<String>(json['document_id']),
      documentTitle: serializer.fromJson<String>(json['document_title']),
      blockId: serializer.fromJson<String>(json['block_id']),
      blockLabel: serializer.fromJson<String>(json['block_label']),
      body: serializer.fromJson<String>(json['body']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'collection_id': serializer.toJson<String>(collectionId),
      'collection_name': serializer.toJson<String>(collectionName),
      'document_id': serializer.toJson<String>(documentId),
      'document_title': serializer.toJson<String>(documentTitle),
      'block_id': serializer.toJson<String>(blockId),
      'block_label': serializer.toJson<String>(blockLabel),
      'body': serializer.toJson<String>(body),
    };
  }

  SearchIndexData copyWith({
    String? collectionId,
    String? collectionName,
    String? documentId,
    String? documentTitle,
    String? blockId,
    String? blockLabel,
    String? body,
  }) => SearchIndexData(
    collectionId: collectionId ?? this.collectionId,
    collectionName: collectionName ?? this.collectionName,
    documentId: documentId ?? this.documentId,
    documentTitle: documentTitle ?? this.documentTitle,
    blockId: blockId ?? this.blockId,
    blockLabel: blockLabel ?? this.blockLabel,
    body: body ?? this.body,
  );
  SearchIndexData copyWithCompanion(SearchIndexCompanion data) {
    return SearchIndexData(
      collectionId: data.collectionId.present
          ? data.collectionId.value
          : this.collectionId,
      collectionName: data.collectionName.present
          ? data.collectionName.value
          : this.collectionName,
      documentId: data.documentId.present
          ? data.documentId.value
          : this.documentId,
      documentTitle: data.documentTitle.present
          ? data.documentTitle.value
          : this.documentTitle,
      blockId: data.blockId.present ? data.blockId.value : this.blockId,
      blockLabel: data.blockLabel.present
          ? data.blockLabel.value
          : this.blockLabel,
      body: data.body.present ? data.body.value : this.body,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SearchIndexData(')
          ..write('collectionId: $collectionId, ')
          ..write('collectionName: $collectionName, ')
          ..write('documentId: $documentId, ')
          ..write('documentTitle: $documentTitle, ')
          ..write('blockId: $blockId, ')
          ..write('blockLabel: $blockLabel, ')
          ..write('body: $body')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    collectionId,
    collectionName,
    documentId,
    documentTitle,
    blockId,
    blockLabel,
    body,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SearchIndexData &&
          other.collectionId == this.collectionId &&
          other.collectionName == this.collectionName &&
          other.documentId == this.documentId &&
          other.documentTitle == this.documentTitle &&
          other.blockId == this.blockId &&
          other.blockLabel == this.blockLabel &&
          other.body == this.body);
}

class SearchIndexCompanion extends UpdateCompanion<SearchIndexData> {
  final Value<String> collectionId;
  final Value<String> collectionName;
  final Value<String> documentId;
  final Value<String> documentTitle;
  final Value<String> blockId;
  final Value<String> blockLabel;
  final Value<String> body;
  final Value<int> rowid;
  const SearchIndexCompanion({
    this.collectionId = const Value.absent(),
    this.collectionName = const Value.absent(),
    this.documentId = const Value.absent(),
    this.documentTitle = const Value.absent(),
    this.blockId = const Value.absent(),
    this.blockLabel = const Value.absent(),
    this.body = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SearchIndexCompanion.insert({
    required String collectionId,
    required String collectionName,
    required String documentId,
    required String documentTitle,
    required String blockId,
    required String blockLabel,
    required String body,
    this.rowid = const Value.absent(),
  }) : collectionId = Value(collectionId),
       collectionName = Value(collectionName),
       documentId = Value(documentId),
       documentTitle = Value(documentTitle),
       blockId = Value(blockId),
       blockLabel = Value(blockLabel),
       body = Value(body);
  static Insertable<SearchIndexData> custom({
    Expression<String>? collectionId,
    Expression<String>? collectionName,
    Expression<String>? documentId,
    Expression<String>? documentTitle,
    Expression<String>? blockId,
    Expression<String>? blockLabel,
    Expression<String>? body,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (collectionId != null) 'collection_id': collectionId,
      if (collectionName != null) 'collection_name': collectionName,
      if (documentId != null) 'document_id': documentId,
      if (documentTitle != null) 'document_title': documentTitle,
      if (blockId != null) 'block_id': blockId,
      if (blockLabel != null) 'block_label': blockLabel,
      if (body != null) 'body': body,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SearchIndexCompanion copyWith({
    Value<String>? collectionId,
    Value<String>? collectionName,
    Value<String>? documentId,
    Value<String>? documentTitle,
    Value<String>? blockId,
    Value<String>? blockLabel,
    Value<String>? body,
    Value<int>? rowid,
  }) {
    return SearchIndexCompanion(
      collectionId: collectionId ?? this.collectionId,
      collectionName: collectionName ?? this.collectionName,
      documentId: documentId ?? this.documentId,
      documentTitle: documentTitle ?? this.documentTitle,
      blockId: blockId ?? this.blockId,
      blockLabel: blockLabel ?? this.blockLabel,
      body: body ?? this.body,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (collectionId.present) {
      map['collection_id'] = Variable<String>(collectionId.value);
    }
    if (collectionName.present) {
      map['collection_name'] = Variable<String>(collectionName.value);
    }
    if (documentId.present) {
      map['document_id'] = Variable<String>(documentId.value);
    }
    if (documentTitle.present) {
      map['document_title'] = Variable<String>(documentTitle.value);
    }
    if (blockId.present) {
      map['block_id'] = Variable<String>(blockId.value);
    }
    if (blockLabel.present) {
      map['block_label'] = Variable<String>(blockLabel.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SearchIndexCompanion(')
          ..write('collectionId: $collectionId, ')
          ..write('collectionName: $collectionName, ')
          ..write('documentId: $documentId, ')
          ..write('documentTitle: $documentTitle, ')
          ..write('blockId: $blockId, ')
          ..write('blockLabel: $blockLabel, ')
          ..write('body: $body, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$ArchiveDatabase extends GeneratedDatabase {
  _$ArchiveDatabase(QueryExecutor e) : super(e);
  $ArchiveDatabaseManager get managers => $ArchiveDatabaseManager(this);
  late final ArchiveCollections archiveCollections = ArchiveCollections(this);
  late final Documents documents = Documents(this);
  late final Index documentsCollectionSort = Index(
    'documents_collection_sort',
    'CREATE INDEX documents_collection_sort ON documents (collection_id, sort_order, part_number)',
  );
  late final DocumentBlocks documentBlocks = DocumentBlocks(this);
  late final DocumentFiles documentFiles = DocumentFiles(this);
  late final BibleVerses bibleVerses = BibleVerses(this);
  late final Index bibleVersesNavigation = Index(
    'bible_verses_navigation',
    'CREATE INDEX bible_verses_navigation ON bible_verses (collection_id, book_order, chapter, verse)',
  );
  late final Topics topics = Topics(this);
  late final DocumentTopics documentTopics = DocumentTopics(this);
  late final ScriptureReferences scriptureReferences = ScriptureReferences(
    this,
  );
  late final ScriptureReferenceSpans scriptureReferenceSpans =
      ScriptureReferenceSpans(this);
  late final Index scriptureSpansDocumentBlock = Index(
    'scripture_spans_document_block',
    'CREATE INDEX scripture_spans_document_block ON scripture_reference_spans (document_id, block_id, start_offset)',
  );
  late final ScriptureReferenceSegments scriptureReferenceSegments =
      ScriptureReferenceSegments(this);
  late final Index scriptureSegmentsChapter = Index(
    'scripture_segments_chapter',
    'CREATE INDEX scripture_segments_chapter ON scripture_reference_segments (book_id, chapter, verse_start)',
  );
  late final ScriptureVerseOccurrences scriptureVerseOccurrences =
      ScriptureVerseOccurrences(this);
  late final Index scriptureOccurrencesLookup = Index(
    'scripture_occurrences_lookup',
    'CREATE INDEX scripture_occurrences_lookup ON scripture_verse_occurrences (book_id, chapter, verse, collection_id)',
  );
  late final CrossReferences crossReferences = CrossReferences(this);
  late final TimelineEntries timelineEntries = TimelineEntries(this);
  late final SearchIndex searchIndex = SearchIndex(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    archiveCollections,
    documents,
    documentsCollectionSort,
    documentBlocks,
    documentFiles,
    bibleVerses,
    bibleVersesNavigation,
    topics,
    documentTopics,
    scriptureReferences,
    scriptureReferenceSpans,
    scriptureSpansDocumentBlock,
    scriptureReferenceSegments,
    scriptureSegmentsChapter,
    scriptureVerseOccurrences,
    scriptureOccurrencesLookup,
    crossReferences,
    timelineEntries,
    searchIndex,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'archive_collections',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('documents', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'documents',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('document_blocks', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'documents',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('document_files', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'archive_collections',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('bible_verses', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'documents',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('bible_verses', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'document_blocks',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('bible_verses', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'documents',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('document_topics', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'topics',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('document_topics', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'documents',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('scripture_references', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'document_blocks',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('scripture_references', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'archive_collections',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [
        TableUpdate('scripture_reference_spans', kind: UpdateKind.delete),
      ],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'documents',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [
        TableUpdate('scripture_reference_spans', kind: UpdateKind.delete),
      ],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'document_blocks',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [
        TableUpdate('scripture_reference_spans', kind: UpdateKind.delete),
      ],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'scripture_reference_spans',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [
        TableUpdate('scripture_reference_segments', kind: UpdateKind.delete),
      ],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'scripture_reference_spans',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [
        TableUpdate('scripture_verse_occurrences', kind: UpdateKind.delete),
      ],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'archive_collections',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [
        TableUpdate('scripture_verse_occurrences', kind: UpdateKind.delete),
      ],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'documents',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [
        TableUpdate('scripture_verse_occurrences', kind: UpdateKind.delete),
      ],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'document_blocks',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [
        TableUpdate('scripture_verse_occurrences', kind: UpdateKind.delete),
      ],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'documents',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('cross_references', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'documents',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('timeline_entries', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $ArchiveCollectionsCreateCompanionBuilder =
    ArchiveCollectionsCompanion Function({
      required String id,
      required String slug,
      required String name,
      required String description,
      required String collectionType,
      required int displayOrder,
      required int documentCount,
      required int uniqueItemCount,
      required int contentVersion,
      Value<String> metadataJson,
      Value<int> rowid,
    });
typedef $ArchiveCollectionsUpdateCompanionBuilder =
    ArchiveCollectionsCompanion Function({
      Value<String> id,
      Value<String> slug,
      Value<String> name,
      Value<String> description,
      Value<String> collectionType,
      Value<int> displayOrder,
      Value<int> documentCount,
      Value<int> uniqueItemCount,
      Value<int> contentVersion,
      Value<String> metadataJson,
      Value<int> rowid,
    });

final class $ArchiveCollectionsReferences
    extends
        BaseReferences<
          _$ArchiveDatabase,
          ArchiveCollections,
          ArchiveCollection
        > {
  $ArchiveCollectionsReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<Documents, List<Document>> _documentsRefsTable(
    _$ArchiveDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.documents,
    aliasName: 'archive_collections__id__documents__collection_id',
  );

  $DocumentsProcessedTableManager get documentsRefs {
    final manager = $DocumentsTableManager(
      $_db,
      $_db.documents,
    ).filter((f) => f.collectionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_documentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<BibleVerses, List<BibleVerse>>
  _bibleVersesRefsTable(_$ArchiveDatabase db) => MultiTypedResultKey.fromTable(
    db.bibleVerses,
    aliasName: 'archive_collections__id__bible_verses__collection_id',
  );

  $BibleVersesProcessedTableManager get bibleVersesRefs {
    final manager = $BibleVersesTableManager(
      $_db,
      $_db.bibleVerses,
    ).filter((f) => f.collectionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_bibleVersesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    ScriptureReferenceSpans,
    List<ScriptureReferenceSpan>
  >
  _scriptureReferenceSpansRefsTable(_$ArchiveDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.scriptureReferenceSpans,
        aliasName:
            'archive_collections__id__scripture_reference_spans__collection_id',
      );

  $ScriptureReferenceSpansProcessedTableManager
  get scriptureReferenceSpansRefs {
    final manager = $ScriptureReferenceSpansTableManager(
      $_db,
      $_db.scriptureReferenceSpans,
    ).filter((f) => f.collectionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _scriptureReferenceSpansRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    ScriptureVerseOccurrences,
    List<ScriptureVerseOccurrence>
  >
  _scriptureVerseOccurrencesRefsTable(
    _$ArchiveDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.scriptureVerseOccurrences,
    aliasName:
        'archive_collections__id__scripture_verse_occurrences__collection_id',
  );

  $ScriptureVerseOccurrencesProcessedTableManager
  get scriptureVerseOccurrencesRefs {
    final manager = $ScriptureVerseOccurrencesTableManager(
      $_db,
      $_db.scriptureVerseOccurrences,
    ).filter((f) => f.collectionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _scriptureVerseOccurrencesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $ArchiveCollectionsFilterComposer
    extends Composer<_$ArchiveDatabase, ArchiveCollections> {
  $ArchiveCollectionsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get collectionType => $composableBuilder(
    column: $table.collectionType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get displayOrder => $composableBuilder(
    column: $table.displayOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get documentCount => $composableBuilder(
    column: $table.documentCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get uniqueItemCount => $composableBuilder(
    column: $table.uniqueItemCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get contentVersion => $composableBuilder(
    column: $table.contentVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> documentsRefs(
    Expression<bool> Function($DocumentsFilterComposer f) f,
  ) {
    final $DocumentsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.collectionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $DocumentsFilterComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> bibleVersesRefs(
    Expression<bool> Function($BibleVersesFilterComposer f) f,
  ) {
    final $BibleVersesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bibleVerses,
      getReferencedColumn: (t) => t.collectionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $BibleVersesFilterComposer(
            $db: $db,
            $table: $db.bibleVerses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> scriptureReferenceSpansRefs(
    Expression<bool> Function($ScriptureReferenceSpansFilterComposer f) f,
  ) {
    final $ScriptureReferenceSpansFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.scriptureReferenceSpans,
      getReferencedColumn: (t) => t.collectionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ScriptureReferenceSpansFilterComposer(
            $db: $db,
            $table: $db.scriptureReferenceSpans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> scriptureVerseOccurrencesRefs(
    Expression<bool> Function($ScriptureVerseOccurrencesFilterComposer f) f,
  ) {
    final $ScriptureVerseOccurrencesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.scriptureVerseOccurrences,
      getReferencedColumn: (t) => t.collectionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ScriptureVerseOccurrencesFilterComposer(
            $db: $db,
            $table: $db.scriptureVerseOccurrences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $ArchiveCollectionsOrderingComposer
    extends Composer<_$ArchiveDatabase, ArchiveCollections> {
  $ArchiveCollectionsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get collectionType => $composableBuilder(
    column: $table.collectionType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get displayOrder => $composableBuilder(
    column: $table.displayOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get documentCount => $composableBuilder(
    column: $table.documentCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get uniqueItemCount => $composableBuilder(
    column: $table.uniqueItemCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get contentVersion => $composableBuilder(
    column: $table.contentVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => ColumnOrderings(column),
  );
}

class $ArchiveCollectionsAnnotationComposer
    extends Composer<_$ArchiveDatabase, ArchiveCollections> {
  $ArchiveCollectionsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get slug =>
      $composableBuilder(column: $table.slug, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get collectionType => $composableBuilder(
    column: $table.collectionType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get displayOrder => $composableBuilder(
    column: $table.displayOrder,
    builder: (column) => column,
  );

  GeneratedColumn<int> get documentCount => $composableBuilder(
    column: $table.documentCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get uniqueItemCount => $composableBuilder(
    column: $table.uniqueItemCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get contentVersion => $composableBuilder(
    column: $table.contentVersion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => column,
  );

  Expression<T> documentsRefs<T extends Object>(
    Expression<T> Function($DocumentsAnnotationComposer a) f,
  ) {
    final $DocumentsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.collectionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $DocumentsAnnotationComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> bibleVersesRefs<T extends Object>(
    Expression<T> Function($BibleVersesAnnotationComposer a) f,
  ) {
    final $BibleVersesAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bibleVerses,
      getReferencedColumn: (t) => t.collectionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $BibleVersesAnnotationComposer(
            $db: $db,
            $table: $db.bibleVerses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> scriptureReferenceSpansRefs<T extends Object>(
    Expression<T> Function($ScriptureReferenceSpansAnnotationComposer a) f,
  ) {
    final $ScriptureReferenceSpansAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.scriptureReferenceSpans,
          getReferencedColumn: (t) => t.collectionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $ScriptureReferenceSpansAnnotationComposer(
                $db: $db,
                $table: $db.scriptureReferenceSpans,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> scriptureVerseOccurrencesRefs<T extends Object>(
    Expression<T> Function($ScriptureVerseOccurrencesAnnotationComposer a) f,
  ) {
    final $ScriptureVerseOccurrencesAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.scriptureVerseOccurrences,
          getReferencedColumn: (t) => t.collectionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $ScriptureVerseOccurrencesAnnotationComposer(
                $db: $db,
                $table: $db.scriptureVerseOccurrences,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $ArchiveCollectionsTableManager
    extends
        RootTableManager<
          _$ArchiveDatabase,
          ArchiveCollections,
          ArchiveCollection,
          $ArchiveCollectionsFilterComposer,
          $ArchiveCollectionsOrderingComposer,
          $ArchiveCollectionsAnnotationComposer,
          $ArchiveCollectionsCreateCompanionBuilder,
          $ArchiveCollectionsUpdateCompanionBuilder,
          (ArchiveCollection, $ArchiveCollectionsReferences),
          ArchiveCollection,
          PrefetchHooks Function({
            bool documentsRefs,
            bool bibleVersesRefs,
            bool scriptureReferenceSpansRefs,
            bool scriptureVerseOccurrencesRefs,
          })
        > {
  $ArchiveCollectionsTableManager(
    _$ArchiveDatabase db,
    ArchiveCollections table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $ArchiveCollectionsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $ArchiveCollectionsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $ArchiveCollectionsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> slug = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> collectionType = const Value.absent(),
                Value<int> displayOrder = const Value.absent(),
                Value<int> documentCount = const Value.absent(),
                Value<int> uniqueItemCount = const Value.absent(),
                Value<int> contentVersion = const Value.absent(),
                Value<String> metadataJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ArchiveCollectionsCompanion(
                id: id,
                slug: slug,
                name: name,
                description: description,
                collectionType: collectionType,
                displayOrder: displayOrder,
                documentCount: documentCount,
                uniqueItemCount: uniqueItemCount,
                contentVersion: contentVersion,
                metadataJson: metadataJson,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String slug,
                required String name,
                required String description,
                required String collectionType,
                required int displayOrder,
                required int documentCount,
                required int uniqueItemCount,
                required int contentVersion,
                Value<String> metadataJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ArchiveCollectionsCompanion.insert(
                id: id,
                slug: slug,
                name: name,
                description: description,
                collectionType: collectionType,
                displayOrder: displayOrder,
                documentCount: documentCount,
                uniqueItemCount: uniqueItemCount,
                contentVersion: contentVersion,
                metadataJson: metadataJson,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $ArchiveCollectionsReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                documentsRefs = false,
                bibleVersesRefs = false,
                scriptureReferenceSpansRefs = false,
                scriptureVerseOccurrencesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (documentsRefs) db.documents,
                    if (bibleVersesRefs) db.bibleVerses,
                    if (scriptureReferenceSpansRefs) db.scriptureReferenceSpans,
                    if (scriptureVerseOccurrencesRefs)
                      db.scriptureVerseOccurrences,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (documentsRefs)
                        await $_getPrefetchedData<
                          ArchiveCollection,
                          ArchiveCollections,
                          Document
                        >(
                          currentTable: table,
                          referencedTable: $ArchiveCollectionsReferences
                              ._documentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $ArchiveCollectionsReferences(
                                db,
                                table,
                                p0,
                              ).documentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.collectionId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (bibleVersesRefs)
                        await $_getPrefetchedData<
                          ArchiveCollection,
                          ArchiveCollections,
                          BibleVerse
                        >(
                          currentTable: table,
                          referencedTable: $ArchiveCollectionsReferences
                              ._bibleVersesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $ArchiveCollectionsReferences(
                                db,
                                table,
                                p0,
                              ).bibleVersesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.collectionId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (scriptureReferenceSpansRefs)
                        await $_getPrefetchedData<
                          ArchiveCollection,
                          ArchiveCollections,
                          ScriptureReferenceSpan
                        >(
                          currentTable: table,
                          referencedTable: $ArchiveCollectionsReferences
                              ._scriptureReferenceSpansRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $ArchiveCollectionsReferences(
                                db,
                                table,
                                p0,
                              ).scriptureReferenceSpansRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.collectionId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (scriptureVerseOccurrencesRefs)
                        await $_getPrefetchedData<
                          ArchiveCollection,
                          ArchiveCollections,
                          ScriptureVerseOccurrence
                        >(
                          currentTable: table,
                          referencedTable: $ArchiveCollectionsReferences
                              ._scriptureVerseOccurrencesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $ArchiveCollectionsReferences(
                                db,
                                table,
                                p0,
                              ).scriptureVerseOccurrencesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.collectionId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $ArchiveCollectionsProcessedTableManager =
    ProcessedTableManager<
      _$ArchiveDatabase,
      ArchiveCollections,
      ArchiveCollection,
      $ArchiveCollectionsFilterComposer,
      $ArchiveCollectionsOrderingComposer,
      $ArchiveCollectionsAnnotationComposer,
      $ArchiveCollectionsCreateCompanionBuilder,
      $ArchiveCollectionsUpdateCompanionBuilder,
      (ArchiveCollection, $ArchiveCollectionsReferences),
      ArchiveCollection,
      PrefetchHooks Function({
        bool documentsRefs,
        bool bibleVersesRefs,
        bool scriptureReferenceSpansRefs,
        bool scriptureVerseOccurrencesRefs,
      })
    >;
typedef $DocumentsCreateCompanionBuilder =
    DocumentsCompanion Function({
      required String id,
      required String collectionId,
      required String slug,
      required String displayTitle,
      required String documentType,
      Value<int?> documentNumber,
      Value<int?> parentNumber,
      Value<int?> partNumber,
      Value<String?> partLabel,
      Value<String?> subtitle,
      Value<String?> author,
      Value<String?> speaker,
      Value<String?> publicationDate,
      Value<int?> year,
      Value<int?> month,
      required int sortOrder,
      Value<int> hasResponsiveText,
      Value<int> hasCleanPdf,
      Value<int> hasOriginalScan,
      required int contentVersion,
      Value<int> numberVerified,
      Value<String> metadataJson,
      Value<int> rowid,
    });
typedef $DocumentsUpdateCompanionBuilder =
    DocumentsCompanion Function({
      Value<String> id,
      Value<String> collectionId,
      Value<String> slug,
      Value<String> displayTitle,
      Value<String> documentType,
      Value<int?> documentNumber,
      Value<int?> parentNumber,
      Value<int?> partNumber,
      Value<String?> partLabel,
      Value<String?> subtitle,
      Value<String?> author,
      Value<String?> speaker,
      Value<String?> publicationDate,
      Value<int?> year,
      Value<int?> month,
      Value<int> sortOrder,
      Value<int> hasResponsiveText,
      Value<int> hasCleanPdf,
      Value<int> hasOriginalScan,
      Value<int> contentVersion,
      Value<int> numberVerified,
      Value<String> metadataJson,
      Value<int> rowid,
    });

final class $DocumentsReferences
    extends BaseReferences<_$ArchiveDatabase, Documents, Document> {
  $DocumentsReferences(super.$_db, super.$_table, super.$_typedResult);

  static ArchiveCollections _collectionIdTable(_$ArchiveDatabase db) => db
      .archiveCollections
      .createAlias('documents__collection_id__archive_collections__id');

  $ArchiveCollectionsProcessedTableManager get collectionId {
    final $_column = $_itemColumn<String>('collection_id')!;

    final manager = $ArchiveCollectionsTableManager(
      $_db,
      $_db.archiveCollections,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_collectionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<DocumentBlocks, List<DocumentBlock>>
  _documentBlocksRefsTable(_$ArchiveDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.documentBlocks,
        aliasName: 'documents__id__document_blocks__document_id',
      );

  $DocumentBlocksProcessedTableManager get documentBlocksRefs {
    final manager = $DocumentBlocksTableManager(
      $_db,
      $_db.documentBlocks,
    ).filter((f) => f.documentId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_documentBlocksRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<DocumentFiles, List<DocumentFile>>
  _documentFilesRefsTable(_$ArchiveDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.documentFiles,
        aliasName: 'documents__id__document_files__document_id',
      );

  $DocumentFilesProcessedTableManager get documentFilesRefs {
    final manager = $DocumentFilesTableManager(
      $_db,
      $_db.documentFiles,
    ).filter((f) => f.documentId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_documentFilesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<BibleVerses, List<BibleVerse>>
  _bibleVersesRefsTable(_$ArchiveDatabase db) => MultiTypedResultKey.fromTable(
    db.bibleVerses,
    aliasName: 'documents__id__bible_verses__document_id',
  );

  $BibleVersesProcessedTableManager get bibleVersesRefs {
    final manager = $BibleVersesTableManager(
      $_db,
      $_db.bibleVerses,
    ).filter((f) => f.documentId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_bibleVersesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<DocumentTopics, List<DocumentTopic>>
  _documentTopicsRefsTable(_$ArchiveDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.documentTopics,
        aliasName: 'documents__id__document_topics__document_id',
      );

  $DocumentTopicsProcessedTableManager get documentTopicsRefs {
    final manager = $DocumentTopicsTableManager(
      $_db,
      $_db.documentTopics,
    ).filter((f) => f.documentId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_documentTopicsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<ScriptureReferences, List<ScriptureReference>>
  _scriptureReferencesRefsTable(_$ArchiveDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.scriptureReferences,
        aliasName: 'documents__id__scripture_references__document_id',
      );

  $ScriptureReferencesProcessedTableManager get scriptureReferencesRefs {
    final manager = $ScriptureReferencesTableManager(
      $_db,
      $_db.scriptureReferences,
    ).filter((f) => f.documentId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _scriptureReferencesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    ScriptureReferenceSpans,
    List<ScriptureReferenceSpan>
  >
  _scriptureReferenceSpansRefsTable(_$ArchiveDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.scriptureReferenceSpans,
        aliasName: 'documents__id__scripture_reference_spans__document_id',
      );

  $ScriptureReferenceSpansProcessedTableManager
  get scriptureReferenceSpansRefs {
    final manager = $ScriptureReferenceSpansTableManager(
      $_db,
      $_db.scriptureReferenceSpans,
    ).filter((f) => f.documentId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _scriptureReferenceSpansRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    ScriptureVerseOccurrences,
    List<ScriptureVerseOccurrence>
  >
  _scriptureVerseOccurrencesRefsTable(_$ArchiveDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.scriptureVerseOccurrences,
        aliasName: 'documents__id__scripture_verse_occurrences__document_id',
      );

  $ScriptureVerseOccurrencesProcessedTableManager
  get scriptureVerseOccurrencesRefs {
    final manager = $ScriptureVerseOccurrencesTableManager(
      $_db,
      $_db.scriptureVerseOccurrences,
    ).filter((f) => f.documentId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _scriptureVerseOccurrencesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<CrossReferences, List<CrossReference>>
  _crossReferencesRefsTable(_$ArchiveDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.crossReferences,
        aliasName: 'documents__id__cross_references__source_document_id',
      );

  $CrossReferencesProcessedTableManager get crossReferencesRefs {
    final manager = $CrossReferencesTableManager($_db, $_db.crossReferences)
        .filter(
          (f) => f.sourceDocumentId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _crossReferencesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<TimelineEntries, List<TimelineEntry>>
  _timelineEntriesRefsTable(_$ArchiveDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.timelineEntries,
        aliasName: 'documents__id__timeline_entries__document_id',
      );

  $TimelineEntriesProcessedTableManager get timelineEntriesRefs {
    final manager = $TimelineEntriesTableManager(
      $_db,
      $_db.timelineEntries,
    ).filter((f) => f.documentId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _timelineEntriesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $DocumentsFilterComposer extends Composer<_$ArchiveDatabase, Documents> {
  $DocumentsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayTitle => $composableBuilder(
    column: $table.displayTitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get documentType => $composableBuilder(
    column: $table.documentType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get documentNumber => $composableBuilder(
    column: $table.documentNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get parentNumber => $composableBuilder(
    column: $table.parentNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get partNumber => $composableBuilder(
    column: $table.partNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get partLabel => $composableBuilder(
    column: $table.partLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subtitle => $composableBuilder(
    column: $table.subtitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get author => $composableBuilder(
    column: $table.author,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get speaker => $composableBuilder(
    column: $table.speaker,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get publicationDate => $composableBuilder(
    column: $table.publicationDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get year => $composableBuilder(
    column: $table.year,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get month => $composableBuilder(
    column: $table.month,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get hasResponsiveText => $composableBuilder(
    column: $table.hasResponsiveText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get hasCleanPdf => $composableBuilder(
    column: $table.hasCleanPdf,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get hasOriginalScan => $composableBuilder(
    column: $table.hasOriginalScan,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get contentVersion => $composableBuilder(
    column: $table.contentVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get numberVerified => $composableBuilder(
    column: $table.numberVerified,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => ColumnFilters(column),
  );

  $ArchiveCollectionsFilterComposer get collectionId {
    final $ArchiveCollectionsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.collectionId,
      referencedTable: $db.archiveCollections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ArchiveCollectionsFilterComposer(
            $db: $db,
            $table: $db.archiveCollections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> documentBlocksRefs(
    Expression<bool> Function($DocumentBlocksFilterComposer f) f,
  ) {
    final $DocumentBlocksFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.documentBlocks,
      getReferencedColumn: (t) => t.documentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $DocumentBlocksFilterComposer(
            $db: $db,
            $table: $db.documentBlocks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> documentFilesRefs(
    Expression<bool> Function($DocumentFilesFilterComposer f) f,
  ) {
    final $DocumentFilesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.documentFiles,
      getReferencedColumn: (t) => t.documentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $DocumentFilesFilterComposer(
            $db: $db,
            $table: $db.documentFiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> bibleVersesRefs(
    Expression<bool> Function($BibleVersesFilterComposer f) f,
  ) {
    final $BibleVersesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bibleVerses,
      getReferencedColumn: (t) => t.documentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $BibleVersesFilterComposer(
            $db: $db,
            $table: $db.bibleVerses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> documentTopicsRefs(
    Expression<bool> Function($DocumentTopicsFilterComposer f) f,
  ) {
    final $DocumentTopicsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.documentTopics,
      getReferencedColumn: (t) => t.documentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $DocumentTopicsFilterComposer(
            $db: $db,
            $table: $db.documentTopics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> scriptureReferencesRefs(
    Expression<bool> Function($ScriptureReferencesFilterComposer f) f,
  ) {
    final $ScriptureReferencesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.scriptureReferences,
      getReferencedColumn: (t) => t.documentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ScriptureReferencesFilterComposer(
            $db: $db,
            $table: $db.scriptureReferences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> scriptureReferenceSpansRefs(
    Expression<bool> Function($ScriptureReferenceSpansFilterComposer f) f,
  ) {
    final $ScriptureReferenceSpansFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.scriptureReferenceSpans,
      getReferencedColumn: (t) => t.documentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ScriptureReferenceSpansFilterComposer(
            $db: $db,
            $table: $db.scriptureReferenceSpans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> scriptureVerseOccurrencesRefs(
    Expression<bool> Function($ScriptureVerseOccurrencesFilterComposer f) f,
  ) {
    final $ScriptureVerseOccurrencesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.scriptureVerseOccurrences,
      getReferencedColumn: (t) => t.documentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ScriptureVerseOccurrencesFilterComposer(
            $db: $db,
            $table: $db.scriptureVerseOccurrences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> crossReferencesRefs(
    Expression<bool> Function($CrossReferencesFilterComposer f) f,
  ) {
    final $CrossReferencesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.crossReferences,
      getReferencedColumn: (t) => t.sourceDocumentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $CrossReferencesFilterComposer(
            $db: $db,
            $table: $db.crossReferences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> timelineEntriesRefs(
    Expression<bool> Function($TimelineEntriesFilterComposer f) f,
  ) {
    final $TimelineEntriesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.timelineEntries,
      getReferencedColumn: (t) => t.documentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $TimelineEntriesFilterComposer(
            $db: $db,
            $table: $db.timelineEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $DocumentsOrderingComposer
    extends Composer<_$ArchiveDatabase, Documents> {
  $DocumentsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayTitle => $composableBuilder(
    column: $table.displayTitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get documentType => $composableBuilder(
    column: $table.documentType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get documentNumber => $composableBuilder(
    column: $table.documentNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get parentNumber => $composableBuilder(
    column: $table.parentNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get partNumber => $composableBuilder(
    column: $table.partNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get partLabel => $composableBuilder(
    column: $table.partLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subtitle => $composableBuilder(
    column: $table.subtitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get author => $composableBuilder(
    column: $table.author,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get speaker => $composableBuilder(
    column: $table.speaker,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get publicationDate => $composableBuilder(
    column: $table.publicationDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get year => $composableBuilder(
    column: $table.year,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get month => $composableBuilder(
    column: $table.month,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get hasResponsiveText => $composableBuilder(
    column: $table.hasResponsiveText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get hasCleanPdf => $composableBuilder(
    column: $table.hasCleanPdf,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get hasOriginalScan => $composableBuilder(
    column: $table.hasOriginalScan,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get contentVersion => $composableBuilder(
    column: $table.contentVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get numberVerified => $composableBuilder(
    column: $table.numberVerified,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => ColumnOrderings(column),
  );

  $ArchiveCollectionsOrderingComposer get collectionId {
    final $ArchiveCollectionsOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.collectionId,
      referencedTable: $db.archiveCollections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ArchiveCollectionsOrderingComposer(
            $db: $db,
            $table: $db.archiveCollections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $DocumentsAnnotationComposer
    extends Composer<_$ArchiveDatabase, Documents> {
  $DocumentsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get slug =>
      $composableBuilder(column: $table.slug, builder: (column) => column);

  GeneratedColumn<String> get displayTitle => $composableBuilder(
    column: $table.displayTitle,
    builder: (column) => column,
  );

  GeneratedColumn<String> get documentType => $composableBuilder(
    column: $table.documentType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get documentNumber => $composableBuilder(
    column: $table.documentNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get parentNumber => $composableBuilder(
    column: $table.parentNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get partNumber => $composableBuilder(
    column: $table.partNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get partLabel =>
      $composableBuilder(column: $table.partLabel, builder: (column) => column);

  GeneratedColumn<String> get subtitle =>
      $composableBuilder(column: $table.subtitle, builder: (column) => column);

  GeneratedColumn<String> get author =>
      $composableBuilder(column: $table.author, builder: (column) => column);

  GeneratedColumn<String> get speaker =>
      $composableBuilder(column: $table.speaker, builder: (column) => column);

  GeneratedColumn<String> get publicationDate => $composableBuilder(
    column: $table.publicationDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get year =>
      $composableBuilder(column: $table.year, builder: (column) => column);

  GeneratedColumn<int> get month =>
      $composableBuilder(column: $table.month, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<int> get hasResponsiveText => $composableBuilder(
    column: $table.hasResponsiveText,
    builder: (column) => column,
  );

  GeneratedColumn<int> get hasCleanPdf => $composableBuilder(
    column: $table.hasCleanPdf,
    builder: (column) => column,
  );

  GeneratedColumn<int> get hasOriginalScan => $composableBuilder(
    column: $table.hasOriginalScan,
    builder: (column) => column,
  );

  GeneratedColumn<int> get contentVersion => $composableBuilder(
    column: $table.contentVersion,
    builder: (column) => column,
  );

  GeneratedColumn<int> get numberVerified => $composableBuilder(
    column: $table.numberVerified,
    builder: (column) => column,
  );

  GeneratedColumn<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => column,
  );

  $ArchiveCollectionsAnnotationComposer get collectionId {
    final $ArchiveCollectionsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.collectionId,
      referencedTable: $db.archiveCollections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ArchiveCollectionsAnnotationComposer(
            $db: $db,
            $table: $db.archiveCollections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> documentBlocksRefs<T extends Object>(
    Expression<T> Function($DocumentBlocksAnnotationComposer a) f,
  ) {
    final $DocumentBlocksAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.documentBlocks,
      getReferencedColumn: (t) => t.documentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $DocumentBlocksAnnotationComposer(
            $db: $db,
            $table: $db.documentBlocks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> documentFilesRefs<T extends Object>(
    Expression<T> Function($DocumentFilesAnnotationComposer a) f,
  ) {
    final $DocumentFilesAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.documentFiles,
      getReferencedColumn: (t) => t.documentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $DocumentFilesAnnotationComposer(
            $db: $db,
            $table: $db.documentFiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> bibleVersesRefs<T extends Object>(
    Expression<T> Function($BibleVersesAnnotationComposer a) f,
  ) {
    final $BibleVersesAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bibleVerses,
      getReferencedColumn: (t) => t.documentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $BibleVersesAnnotationComposer(
            $db: $db,
            $table: $db.bibleVerses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> documentTopicsRefs<T extends Object>(
    Expression<T> Function($DocumentTopicsAnnotationComposer a) f,
  ) {
    final $DocumentTopicsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.documentTopics,
      getReferencedColumn: (t) => t.documentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $DocumentTopicsAnnotationComposer(
            $db: $db,
            $table: $db.documentTopics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> scriptureReferencesRefs<T extends Object>(
    Expression<T> Function($ScriptureReferencesAnnotationComposer a) f,
  ) {
    final $ScriptureReferencesAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.scriptureReferences,
      getReferencedColumn: (t) => t.documentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ScriptureReferencesAnnotationComposer(
            $db: $db,
            $table: $db.scriptureReferences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> scriptureReferenceSpansRefs<T extends Object>(
    Expression<T> Function($ScriptureReferenceSpansAnnotationComposer a) f,
  ) {
    final $ScriptureReferenceSpansAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.scriptureReferenceSpans,
          getReferencedColumn: (t) => t.documentId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $ScriptureReferenceSpansAnnotationComposer(
                $db: $db,
                $table: $db.scriptureReferenceSpans,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> scriptureVerseOccurrencesRefs<T extends Object>(
    Expression<T> Function($ScriptureVerseOccurrencesAnnotationComposer a) f,
  ) {
    final $ScriptureVerseOccurrencesAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.scriptureVerseOccurrences,
          getReferencedColumn: (t) => t.documentId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $ScriptureVerseOccurrencesAnnotationComposer(
                $db: $db,
                $table: $db.scriptureVerseOccurrences,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> crossReferencesRefs<T extends Object>(
    Expression<T> Function($CrossReferencesAnnotationComposer a) f,
  ) {
    final $CrossReferencesAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.crossReferences,
      getReferencedColumn: (t) => t.sourceDocumentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $CrossReferencesAnnotationComposer(
            $db: $db,
            $table: $db.crossReferences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> timelineEntriesRefs<T extends Object>(
    Expression<T> Function($TimelineEntriesAnnotationComposer a) f,
  ) {
    final $TimelineEntriesAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.timelineEntries,
      getReferencedColumn: (t) => t.documentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $TimelineEntriesAnnotationComposer(
            $db: $db,
            $table: $db.timelineEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $DocumentsTableManager
    extends
        RootTableManager<
          _$ArchiveDatabase,
          Documents,
          Document,
          $DocumentsFilterComposer,
          $DocumentsOrderingComposer,
          $DocumentsAnnotationComposer,
          $DocumentsCreateCompanionBuilder,
          $DocumentsUpdateCompanionBuilder,
          (Document, $DocumentsReferences),
          Document,
          PrefetchHooks Function({
            bool collectionId,
            bool documentBlocksRefs,
            bool documentFilesRefs,
            bool bibleVersesRefs,
            bool documentTopicsRefs,
            bool scriptureReferencesRefs,
            bool scriptureReferenceSpansRefs,
            bool scriptureVerseOccurrencesRefs,
            bool crossReferencesRefs,
            bool timelineEntriesRefs,
          })
        > {
  $DocumentsTableManager(_$ArchiveDatabase db, Documents table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $DocumentsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $DocumentsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $DocumentsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> collectionId = const Value.absent(),
                Value<String> slug = const Value.absent(),
                Value<String> displayTitle = const Value.absent(),
                Value<String> documentType = const Value.absent(),
                Value<int?> documentNumber = const Value.absent(),
                Value<int?> parentNumber = const Value.absent(),
                Value<int?> partNumber = const Value.absent(),
                Value<String?> partLabel = const Value.absent(),
                Value<String?> subtitle = const Value.absent(),
                Value<String?> author = const Value.absent(),
                Value<String?> speaker = const Value.absent(),
                Value<String?> publicationDate = const Value.absent(),
                Value<int?> year = const Value.absent(),
                Value<int?> month = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> hasResponsiveText = const Value.absent(),
                Value<int> hasCleanPdf = const Value.absent(),
                Value<int> hasOriginalScan = const Value.absent(),
                Value<int> contentVersion = const Value.absent(),
                Value<int> numberVerified = const Value.absent(),
                Value<String> metadataJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DocumentsCompanion(
                id: id,
                collectionId: collectionId,
                slug: slug,
                displayTitle: displayTitle,
                documentType: documentType,
                documentNumber: documentNumber,
                parentNumber: parentNumber,
                partNumber: partNumber,
                partLabel: partLabel,
                subtitle: subtitle,
                author: author,
                speaker: speaker,
                publicationDate: publicationDate,
                year: year,
                month: month,
                sortOrder: sortOrder,
                hasResponsiveText: hasResponsiveText,
                hasCleanPdf: hasCleanPdf,
                hasOriginalScan: hasOriginalScan,
                contentVersion: contentVersion,
                numberVerified: numberVerified,
                metadataJson: metadataJson,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String collectionId,
                required String slug,
                required String displayTitle,
                required String documentType,
                Value<int?> documentNumber = const Value.absent(),
                Value<int?> parentNumber = const Value.absent(),
                Value<int?> partNumber = const Value.absent(),
                Value<String?> partLabel = const Value.absent(),
                Value<String?> subtitle = const Value.absent(),
                Value<String?> author = const Value.absent(),
                Value<String?> speaker = const Value.absent(),
                Value<String?> publicationDate = const Value.absent(),
                Value<int?> year = const Value.absent(),
                Value<int?> month = const Value.absent(),
                required int sortOrder,
                Value<int> hasResponsiveText = const Value.absent(),
                Value<int> hasCleanPdf = const Value.absent(),
                Value<int> hasOriginalScan = const Value.absent(),
                required int contentVersion,
                Value<int> numberVerified = const Value.absent(),
                Value<String> metadataJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DocumentsCompanion.insert(
                id: id,
                collectionId: collectionId,
                slug: slug,
                displayTitle: displayTitle,
                documentType: documentType,
                documentNumber: documentNumber,
                parentNumber: parentNumber,
                partNumber: partNumber,
                partLabel: partLabel,
                subtitle: subtitle,
                author: author,
                speaker: speaker,
                publicationDate: publicationDate,
                year: year,
                month: month,
                sortOrder: sortOrder,
                hasResponsiveText: hasResponsiveText,
                hasCleanPdf: hasCleanPdf,
                hasOriginalScan: hasOriginalScan,
                contentVersion: contentVersion,
                numberVerified: numberVerified,
                metadataJson: metadataJson,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (e.readTable(table), $DocumentsReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                collectionId = false,
                documentBlocksRefs = false,
                documentFilesRefs = false,
                bibleVersesRefs = false,
                documentTopicsRefs = false,
                scriptureReferencesRefs = false,
                scriptureReferenceSpansRefs = false,
                scriptureVerseOccurrencesRefs = false,
                crossReferencesRefs = false,
                timelineEntriesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (documentBlocksRefs) db.documentBlocks,
                    if (documentFilesRefs) db.documentFiles,
                    if (bibleVersesRefs) db.bibleVerses,
                    if (documentTopicsRefs) db.documentTopics,
                    if (scriptureReferencesRefs) db.scriptureReferences,
                    if (scriptureReferenceSpansRefs) db.scriptureReferenceSpans,
                    if (scriptureVerseOccurrencesRefs)
                      db.scriptureVerseOccurrences,
                    if (crossReferencesRefs) db.crossReferences,
                    if (timelineEntriesRefs) db.timelineEntries,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (collectionId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.collectionId,
                                    referencedTable: $DocumentsReferences
                                        ._collectionIdTable(db),
                                    referencedColumn: $DocumentsReferences
                                        ._collectionIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (documentBlocksRefs)
                        await $_getPrefetchedData<
                          Document,
                          Documents,
                          DocumentBlock
                        >(
                          currentTable: table,
                          referencedTable: $DocumentsReferences
                              ._documentBlocksRefsTable(db),
                          managerFromTypedResult: (p0) => $DocumentsReferences(
                            db,
                            table,
                            p0,
                          ).documentBlocksRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.documentId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (documentFilesRefs)
                        await $_getPrefetchedData<
                          Document,
                          Documents,
                          DocumentFile
                        >(
                          currentTable: table,
                          referencedTable: $DocumentsReferences
                              ._documentFilesRefsTable(db),
                          managerFromTypedResult: (p0) => $DocumentsReferences(
                            db,
                            table,
                            p0,
                          ).documentFilesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.documentId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (bibleVersesRefs)
                        await $_getPrefetchedData<
                          Document,
                          Documents,
                          BibleVerse
                        >(
                          currentTable: table,
                          referencedTable: $DocumentsReferences
                              ._bibleVersesRefsTable(db),
                          managerFromTypedResult: (p0) => $DocumentsReferences(
                            db,
                            table,
                            p0,
                          ).bibleVersesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.documentId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (documentTopicsRefs)
                        await $_getPrefetchedData<
                          Document,
                          Documents,
                          DocumentTopic
                        >(
                          currentTable: table,
                          referencedTable: $DocumentsReferences
                              ._documentTopicsRefsTable(db),
                          managerFromTypedResult: (p0) => $DocumentsReferences(
                            db,
                            table,
                            p0,
                          ).documentTopicsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.documentId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (scriptureReferencesRefs)
                        await $_getPrefetchedData<
                          Document,
                          Documents,
                          ScriptureReference
                        >(
                          currentTable: table,
                          referencedTable: $DocumentsReferences
                              ._scriptureReferencesRefsTable(db),
                          managerFromTypedResult: (p0) => $DocumentsReferences(
                            db,
                            table,
                            p0,
                          ).scriptureReferencesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.documentId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (scriptureReferenceSpansRefs)
                        await $_getPrefetchedData<
                          Document,
                          Documents,
                          ScriptureReferenceSpan
                        >(
                          currentTable: table,
                          referencedTable: $DocumentsReferences
                              ._scriptureReferenceSpansRefsTable(db),
                          managerFromTypedResult: (p0) => $DocumentsReferences(
                            db,
                            table,
                            p0,
                          ).scriptureReferenceSpansRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.documentId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (scriptureVerseOccurrencesRefs)
                        await $_getPrefetchedData<
                          Document,
                          Documents,
                          ScriptureVerseOccurrence
                        >(
                          currentTable: table,
                          referencedTable: $DocumentsReferences
                              ._scriptureVerseOccurrencesRefsTable(db),
                          managerFromTypedResult: (p0) => $DocumentsReferences(
                            db,
                            table,
                            p0,
                          ).scriptureVerseOccurrencesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.documentId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (crossReferencesRefs)
                        await $_getPrefetchedData<
                          Document,
                          Documents,
                          CrossReference
                        >(
                          currentTable: table,
                          referencedTable: $DocumentsReferences
                              ._crossReferencesRefsTable(db),
                          managerFromTypedResult: (p0) => $DocumentsReferences(
                            db,
                            table,
                            p0,
                          ).crossReferencesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.sourceDocumentId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (timelineEntriesRefs)
                        await $_getPrefetchedData<
                          Document,
                          Documents,
                          TimelineEntry
                        >(
                          currentTable: table,
                          referencedTable: $DocumentsReferences
                              ._timelineEntriesRefsTable(db),
                          managerFromTypedResult: (p0) => $DocumentsReferences(
                            db,
                            table,
                            p0,
                          ).timelineEntriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.documentId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $DocumentsProcessedTableManager =
    ProcessedTableManager<
      _$ArchiveDatabase,
      Documents,
      Document,
      $DocumentsFilterComposer,
      $DocumentsOrderingComposer,
      $DocumentsAnnotationComposer,
      $DocumentsCreateCompanionBuilder,
      $DocumentsUpdateCompanionBuilder,
      (Document, $DocumentsReferences),
      Document,
      PrefetchHooks Function({
        bool collectionId,
        bool documentBlocksRefs,
        bool documentFilesRefs,
        bool bibleVersesRefs,
        bool documentTopicsRefs,
        bool scriptureReferencesRefs,
        bool scriptureReferenceSpansRefs,
        bool scriptureVerseOccurrencesRefs,
        bool crossReferencesRefs,
        bool timelineEntriesRefs,
      })
    >;
typedef $DocumentBlocksCreateCompanionBuilder =
    DocumentBlocksCompanion Function({
      required String id,
      required String documentId,
      required int orderIndex,
      required String blockType,
      required String blockText,
      Value<String?> numberLabel,
      Value<int?> headingLevel,
      Value<String> metadataJson,
      Value<int> rowid,
    });
typedef $DocumentBlocksUpdateCompanionBuilder =
    DocumentBlocksCompanion Function({
      Value<String> id,
      Value<String> documentId,
      Value<int> orderIndex,
      Value<String> blockType,
      Value<String> blockText,
      Value<String?> numberLabel,
      Value<int?> headingLevel,
      Value<String> metadataJson,
      Value<int> rowid,
    });

final class $DocumentBlocksReferences
    extends BaseReferences<_$ArchiveDatabase, DocumentBlocks, DocumentBlock> {
  $DocumentBlocksReferences(super.$_db, super.$_table, super.$_typedResult);

  static Documents _documentIdTable(_$ArchiveDatabase db) =>
      db.documents.createAlias('document_blocks__document_id__documents__id');

  $DocumentsProcessedTableManager get documentId {
    final $_column = $_itemColumn<String>('document_id')!;

    final manager = $DocumentsTableManager(
      $_db,
      $_db.documents,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_documentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<BibleVerses, List<BibleVerse>>
  _bibleVersesRefsTable(_$ArchiveDatabase db) => MultiTypedResultKey.fromTable(
    db.bibleVerses,
    aliasName: 'document_blocks__id__bible_verses__block_id',
  );

  $BibleVersesProcessedTableManager get bibleVersesRefs {
    final manager = $BibleVersesTableManager(
      $_db,
      $_db.bibleVerses,
    ).filter((f) => f.blockId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_bibleVersesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<ScriptureReferences, List<ScriptureReference>>
  _scriptureReferencesRefsTable(_$ArchiveDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.scriptureReferences,
        aliasName: 'document_blocks__id__scripture_references__block_id',
      );

  $ScriptureReferencesProcessedTableManager get scriptureReferencesRefs {
    final manager = $ScriptureReferencesTableManager(
      $_db,
      $_db.scriptureReferences,
    ).filter((f) => f.blockId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _scriptureReferencesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    ScriptureReferenceSpans,
    List<ScriptureReferenceSpan>
  >
  _scriptureReferenceSpansRefsTable(_$ArchiveDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.scriptureReferenceSpans,
        aliasName: 'document_blocks__id__scripture_reference_spans__block_id',
      );

  $ScriptureReferenceSpansProcessedTableManager
  get scriptureReferenceSpansRefs {
    final manager = $ScriptureReferenceSpansTableManager(
      $_db,
      $_db.scriptureReferenceSpans,
    ).filter((f) => f.blockId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _scriptureReferenceSpansRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    ScriptureVerseOccurrences,
    List<ScriptureVerseOccurrence>
  >
  _scriptureVerseOccurrencesRefsTable(_$ArchiveDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.scriptureVerseOccurrences,
        aliasName: 'document_blocks__id__scripture_verse_occurrences__block_id',
      );

  $ScriptureVerseOccurrencesProcessedTableManager
  get scriptureVerseOccurrencesRefs {
    final manager = $ScriptureVerseOccurrencesTableManager(
      $_db,
      $_db.scriptureVerseOccurrences,
    ).filter((f) => f.blockId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _scriptureVerseOccurrencesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $DocumentBlocksFilterComposer
    extends Composer<_$ArchiveDatabase, DocumentBlocks> {
  $DocumentBlocksFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get blockType => $composableBuilder(
    column: $table.blockType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get blockText => $composableBuilder(
    column: $table.blockText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get numberLabel => $composableBuilder(
    column: $table.numberLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get headingLevel => $composableBuilder(
    column: $table.headingLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => ColumnFilters(column),
  );

  $DocumentsFilterComposer get documentId {
    final $DocumentsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $DocumentsFilterComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> bibleVersesRefs(
    Expression<bool> Function($BibleVersesFilterComposer f) f,
  ) {
    final $BibleVersesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bibleVerses,
      getReferencedColumn: (t) => t.blockId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $BibleVersesFilterComposer(
            $db: $db,
            $table: $db.bibleVerses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> scriptureReferencesRefs(
    Expression<bool> Function($ScriptureReferencesFilterComposer f) f,
  ) {
    final $ScriptureReferencesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.scriptureReferences,
      getReferencedColumn: (t) => t.blockId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ScriptureReferencesFilterComposer(
            $db: $db,
            $table: $db.scriptureReferences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> scriptureReferenceSpansRefs(
    Expression<bool> Function($ScriptureReferenceSpansFilterComposer f) f,
  ) {
    final $ScriptureReferenceSpansFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.scriptureReferenceSpans,
      getReferencedColumn: (t) => t.blockId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ScriptureReferenceSpansFilterComposer(
            $db: $db,
            $table: $db.scriptureReferenceSpans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> scriptureVerseOccurrencesRefs(
    Expression<bool> Function($ScriptureVerseOccurrencesFilterComposer f) f,
  ) {
    final $ScriptureVerseOccurrencesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.scriptureVerseOccurrences,
      getReferencedColumn: (t) => t.blockId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ScriptureVerseOccurrencesFilterComposer(
            $db: $db,
            $table: $db.scriptureVerseOccurrences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $DocumentBlocksOrderingComposer
    extends Composer<_$ArchiveDatabase, DocumentBlocks> {
  $DocumentBlocksOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get blockType => $composableBuilder(
    column: $table.blockType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get blockText => $composableBuilder(
    column: $table.blockText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get numberLabel => $composableBuilder(
    column: $table.numberLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get headingLevel => $composableBuilder(
    column: $table.headingLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => ColumnOrderings(column),
  );

  $DocumentsOrderingComposer get documentId {
    final $DocumentsOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $DocumentsOrderingComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $DocumentBlocksAnnotationComposer
    extends Composer<_$ArchiveDatabase, DocumentBlocks> {
  $DocumentBlocksAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => column,
  );

  GeneratedColumn<String> get blockType =>
      $composableBuilder(column: $table.blockType, builder: (column) => column);

  GeneratedColumn<String> get blockText =>
      $composableBuilder(column: $table.blockText, builder: (column) => column);

  GeneratedColumn<String> get numberLabel => $composableBuilder(
    column: $table.numberLabel,
    builder: (column) => column,
  );

  GeneratedColumn<int> get headingLevel => $composableBuilder(
    column: $table.headingLevel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => column,
  );

  $DocumentsAnnotationComposer get documentId {
    final $DocumentsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $DocumentsAnnotationComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> bibleVersesRefs<T extends Object>(
    Expression<T> Function($BibleVersesAnnotationComposer a) f,
  ) {
    final $BibleVersesAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bibleVerses,
      getReferencedColumn: (t) => t.blockId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $BibleVersesAnnotationComposer(
            $db: $db,
            $table: $db.bibleVerses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> scriptureReferencesRefs<T extends Object>(
    Expression<T> Function($ScriptureReferencesAnnotationComposer a) f,
  ) {
    final $ScriptureReferencesAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.scriptureReferences,
      getReferencedColumn: (t) => t.blockId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ScriptureReferencesAnnotationComposer(
            $db: $db,
            $table: $db.scriptureReferences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> scriptureReferenceSpansRefs<T extends Object>(
    Expression<T> Function($ScriptureReferenceSpansAnnotationComposer a) f,
  ) {
    final $ScriptureReferenceSpansAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.scriptureReferenceSpans,
          getReferencedColumn: (t) => t.blockId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $ScriptureReferenceSpansAnnotationComposer(
                $db: $db,
                $table: $db.scriptureReferenceSpans,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> scriptureVerseOccurrencesRefs<T extends Object>(
    Expression<T> Function($ScriptureVerseOccurrencesAnnotationComposer a) f,
  ) {
    final $ScriptureVerseOccurrencesAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.scriptureVerseOccurrences,
          getReferencedColumn: (t) => t.blockId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $ScriptureVerseOccurrencesAnnotationComposer(
                $db: $db,
                $table: $db.scriptureVerseOccurrences,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $DocumentBlocksTableManager
    extends
        RootTableManager<
          _$ArchiveDatabase,
          DocumentBlocks,
          DocumentBlock,
          $DocumentBlocksFilterComposer,
          $DocumentBlocksOrderingComposer,
          $DocumentBlocksAnnotationComposer,
          $DocumentBlocksCreateCompanionBuilder,
          $DocumentBlocksUpdateCompanionBuilder,
          (DocumentBlock, $DocumentBlocksReferences),
          DocumentBlock,
          PrefetchHooks Function({
            bool documentId,
            bool bibleVersesRefs,
            bool scriptureReferencesRefs,
            bool scriptureReferenceSpansRefs,
            bool scriptureVerseOccurrencesRefs,
          })
        > {
  $DocumentBlocksTableManager(_$ArchiveDatabase db, DocumentBlocks table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $DocumentBlocksFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $DocumentBlocksOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $DocumentBlocksAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> documentId = const Value.absent(),
                Value<int> orderIndex = const Value.absent(),
                Value<String> blockType = const Value.absent(),
                Value<String> blockText = const Value.absent(),
                Value<String?> numberLabel = const Value.absent(),
                Value<int?> headingLevel = const Value.absent(),
                Value<String> metadataJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DocumentBlocksCompanion(
                id: id,
                documentId: documentId,
                orderIndex: orderIndex,
                blockType: blockType,
                blockText: blockText,
                numberLabel: numberLabel,
                headingLevel: headingLevel,
                metadataJson: metadataJson,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String documentId,
                required int orderIndex,
                required String blockType,
                required String blockText,
                Value<String?> numberLabel = const Value.absent(),
                Value<int?> headingLevel = const Value.absent(),
                Value<String> metadataJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DocumentBlocksCompanion.insert(
                id: id,
                documentId: documentId,
                orderIndex: orderIndex,
                blockType: blockType,
                blockText: blockText,
                numberLabel: numberLabel,
                headingLevel: headingLevel,
                metadataJson: metadataJson,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $DocumentBlocksReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                documentId = false,
                bibleVersesRefs = false,
                scriptureReferencesRefs = false,
                scriptureReferenceSpansRefs = false,
                scriptureVerseOccurrencesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (bibleVersesRefs) db.bibleVerses,
                    if (scriptureReferencesRefs) db.scriptureReferences,
                    if (scriptureReferenceSpansRefs) db.scriptureReferenceSpans,
                    if (scriptureVerseOccurrencesRefs)
                      db.scriptureVerseOccurrences,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (documentId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.documentId,
                                    referencedTable: $DocumentBlocksReferences
                                        ._documentIdTable(db),
                                    referencedColumn: $DocumentBlocksReferences
                                        ._documentIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (bibleVersesRefs)
                        await $_getPrefetchedData<
                          DocumentBlock,
                          DocumentBlocks,
                          BibleVerse
                        >(
                          currentTable: table,
                          referencedTable: $DocumentBlocksReferences
                              ._bibleVersesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $DocumentBlocksReferences(
                                db,
                                table,
                                p0,
                              ).bibleVersesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.blockId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (scriptureReferencesRefs)
                        await $_getPrefetchedData<
                          DocumentBlock,
                          DocumentBlocks,
                          ScriptureReference
                        >(
                          currentTable: table,
                          referencedTable: $DocumentBlocksReferences
                              ._scriptureReferencesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $DocumentBlocksReferences(
                                db,
                                table,
                                p0,
                              ).scriptureReferencesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.blockId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (scriptureReferenceSpansRefs)
                        await $_getPrefetchedData<
                          DocumentBlock,
                          DocumentBlocks,
                          ScriptureReferenceSpan
                        >(
                          currentTable: table,
                          referencedTable: $DocumentBlocksReferences
                              ._scriptureReferenceSpansRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $DocumentBlocksReferences(
                                db,
                                table,
                                p0,
                              ).scriptureReferenceSpansRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.blockId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (scriptureVerseOccurrencesRefs)
                        await $_getPrefetchedData<
                          DocumentBlock,
                          DocumentBlocks,
                          ScriptureVerseOccurrence
                        >(
                          currentTable: table,
                          referencedTable: $DocumentBlocksReferences
                              ._scriptureVerseOccurrencesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $DocumentBlocksReferences(
                                db,
                                table,
                                p0,
                              ).scriptureVerseOccurrencesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.blockId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $DocumentBlocksProcessedTableManager =
    ProcessedTableManager<
      _$ArchiveDatabase,
      DocumentBlocks,
      DocumentBlock,
      $DocumentBlocksFilterComposer,
      $DocumentBlocksOrderingComposer,
      $DocumentBlocksAnnotationComposer,
      $DocumentBlocksCreateCompanionBuilder,
      $DocumentBlocksUpdateCompanionBuilder,
      (DocumentBlock, $DocumentBlocksReferences),
      DocumentBlock,
      PrefetchHooks Function({
        bool documentId,
        bool bibleVersesRefs,
        bool scriptureReferencesRefs,
        bool scriptureReferenceSpansRefs,
        bool scriptureVerseOccurrencesRefs,
      })
    >;
typedef $DocumentFilesCreateCompanionBuilder =
    DocumentFilesCompanion Function({
      required String id,
      required String documentId,
      required String fileType,
      Value<String?> remoteUrl,
      Value<String?> assetPath,
      Value<String?> localPath,
      Value<int?> fileSize,
      Value<String?> sha256,
      Value<int?> durationSeconds,
      Value<String> metadataJson,
      required int version,
      Value<String> downloadState,
      Value<int> rowid,
    });
typedef $DocumentFilesUpdateCompanionBuilder =
    DocumentFilesCompanion Function({
      Value<String> id,
      Value<String> documentId,
      Value<String> fileType,
      Value<String?> remoteUrl,
      Value<String?> assetPath,
      Value<String?> localPath,
      Value<int?> fileSize,
      Value<String?> sha256,
      Value<int?> durationSeconds,
      Value<String> metadataJson,
      Value<int> version,
      Value<String> downloadState,
      Value<int> rowid,
    });

final class $DocumentFilesReferences
    extends BaseReferences<_$ArchiveDatabase, DocumentFiles, DocumentFile> {
  $DocumentFilesReferences(super.$_db, super.$_table, super.$_typedResult);

  static Documents _documentIdTable(_$ArchiveDatabase db) =>
      db.documents.createAlias('document_files__document_id__documents__id');

  $DocumentsProcessedTableManager get documentId {
    final $_column = $_itemColumn<String>('document_id')!;

    final manager = $DocumentsTableManager(
      $_db,
      $_db.documents,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_documentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $DocumentFilesFilterComposer
    extends Composer<_$ArchiveDatabase, DocumentFiles> {
  $DocumentFilesFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fileType => $composableBuilder(
    column: $table.fileType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remoteUrl => $composableBuilder(
    column: $table.remoteUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get assetPath => $composableBuilder(
    column: $table.assetPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fileSize => $composableBuilder(
    column: $table.fileSize,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sha256 => $composableBuilder(
    column: $table.sha256,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get downloadState => $composableBuilder(
    column: $table.downloadState,
    builder: (column) => ColumnFilters(column),
  );

  $DocumentsFilterComposer get documentId {
    final $DocumentsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $DocumentsFilterComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $DocumentFilesOrderingComposer
    extends Composer<_$ArchiveDatabase, DocumentFiles> {
  $DocumentFilesOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fileType => $composableBuilder(
    column: $table.fileType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remoteUrl => $composableBuilder(
    column: $table.remoteUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get assetPath => $composableBuilder(
    column: $table.assetPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fileSize => $composableBuilder(
    column: $table.fileSize,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sha256 => $composableBuilder(
    column: $table.sha256,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get downloadState => $composableBuilder(
    column: $table.downloadState,
    builder: (column) => ColumnOrderings(column),
  );

  $DocumentsOrderingComposer get documentId {
    final $DocumentsOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $DocumentsOrderingComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $DocumentFilesAnnotationComposer
    extends Composer<_$ArchiveDatabase, DocumentFiles> {
  $DocumentFilesAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fileType =>
      $composableBuilder(column: $table.fileType, builder: (column) => column);

  GeneratedColumn<String> get remoteUrl =>
      $composableBuilder(column: $table.remoteUrl, builder: (column) => column);

  GeneratedColumn<String> get assetPath =>
      $composableBuilder(column: $table.assetPath, builder: (column) => column);

  GeneratedColumn<String> get localPath =>
      $composableBuilder(column: $table.localPath, builder: (column) => column);

  GeneratedColumn<int> get fileSize =>
      $composableBuilder(column: $table.fileSize, builder: (column) => column);

  GeneratedColumn<String> get sha256 =>
      $composableBuilder(column: $table.sha256, builder: (column) => column);

  GeneratedColumn<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => column,
  );

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get downloadState => $composableBuilder(
    column: $table.downloadState,
    builder: (column) => column,
  );

  $DocumentsAnnotationComposer get documentId {
    final $DocumentsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $DocumentsAnnotationComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $DocumentFilesTableManager
    extends
        RootTableManager<
          _$ArchiveDatabase,
          DocumentFiles,
          DocumentFile,
          $DocumentFilesFilterComposer,
          $DocumentFilesOrderingComposer,
          $DocumentFilesAnnotationComposer,
          $DocumentFilesCreateCompanionBuilder,
          $DocumentFilesUpdateCompanionBuilder,
          (DocumentFile, $DocumentFilesReferences),
          DocumentFile,
          PrefetchHooks Function({bool documentId})
        > {
  $DocumentFilesTableManager(_$ArchiveDatabase db, DocumentFiles table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $DocumentFilesFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $DocumentFilesOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $DocumentFilesAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> documentId = const Value.absent(),
                Value<String> fileType = const Value.absent(),
                Value<String?> remoteUrl = const Value.absent(),
                Value<String?> assetPath = const Value.absent(),
                Value<String?> localPath = const Value.absent(),
                Value<int?> fileSize = const Value.absent(),
                Value<String?> sha256 = const Value.absent(),
                Value<int?> durationSeconds = const Value.absent(),
                Value<String> metadataJson = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> downloadState = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DocumentFilesCompanion(
                id: id,
                documentId: documentId,
                fileType: fileType,
                remoteUrl: remoteUrl,
                assetPath: assetPath,
                localPath: localPath,
                fileSize: fileSize,
                sha256: sha256,
                durationSeconds: durationSeconds,
                metadataJson: metadataJson,
                version: version,
                downloadState: downloadState,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String documentId,
                required String fileType,
                Value<String?> remoteUrl = const Value.absent(),
                Value<String?> assetPath = const Value.absent(),
                Value<String?> localPath = const Value.absent(),
                Value<int?> fileSize = const Value.absent(),
                Value<String?> sha256 = const Value.absent(),
                Value<int?> durationSeconds = const Value.absent(),
                Value<String> metadataJson = const Value.absent(),
                required int version,
                Value<String> downloadState = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DocumentFilesCompanion.insert(
                id: id,
                documentId: documentId,
                fileType: fileType,
                remoteUrl: remoteUrl,
                assetPath: assetPath,
                localPath: localPath,
                fileSize: fileSize,
                sha256: sha256,
                durationSeconds: durationSeconds,
                metadataJson: metadataJson,
                version: version,
                downloadState: downloadState,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $DocumentFilesReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({documentId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (documentId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.documentId,
                                referencedTable: $DocumentFilesReferences
                                    ._documentIdTable(db),
                                referencedColumn: $DocumentFilesReferences
                                    ._documentIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $DocumentFilesProcessedTableManager =
    ProcessedTableManager<
      _$ArchiveDatabase,
      DocumentFiles,
      DocumentFile,
      $DocumentFilesFilterComposer,
      $DocumentFilesOrderingComposer,
      $DocumentFilesAnnotationComposer,
      $DocumentFilesCreateCompanionBuilder,
      $DocumentFilesUpdateCompanionBuilder,
      (DocumentFile, $DocumentFilesReferences),
      DocumentFile,
      PrefetchHooks Function({bool documentId})
    >;
typedef $BibleVersesCreateCompanionBuilder =
    BibleVersesCompanion Function({
      required String id,
      required String collectionId,
      required String translationCode,
      required String bookId,
      required String bookName,
      required int bookOrder,
      required String testament,
      required int chapter,
      required int verse,
      required String verseText,
      required String documentId,
      required String blockId,
      Value<int> rowid,
    });
typedef $BibleVersesUpdateCompanionBuilder =
    BibleVersesCompanion Function({
      Value<String> id,
      Value<String> collectionId,
      Value<String> translationCode,
      Value<String> bookId,
      Value<String> bookName,
      Value<int> bookOrder,
      Value<String> testament,
      Value<int> chapter,
      Value<int> verse,
      Value<String> verseText,
      Value<String> documentId,
      Value<String> blockId,
      Value<int> rowid,
    });

final class $BibleVersesReferences
    extends BaseReferences<_$ArchiveDatabase, BibleVerses, BibleVerse> {
  $BibleVersesReferences(super.$_db, super.$_table, super.$_typedResult);

  static ArchiveCollections _collectionIdTable(_$ArchiveDatabase db) => db
      .archiveCollections
      .createAlias('bible_verses__collection_id__archive_collections__id');

  $ArchiveCollectionsProcessedTableManager get collectionId {
    final $_column = $_itemColumn<String>('collection_id')!;

    final manager = $ArchiveCollectionsTableManager(
      $_db,
      $_db.archiveCollections,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_collectionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static Documents _documentIdTable(_$ArchiveDatabase db) =>
      db.documents.createAlias('bible_verses__document_id__documents__id');

  $DocumentsProcessedTableManager get documentId {
    final $_column = $_itemColumn<String>('document_id')!;

    final manager = $DocumentsTableManager(
      $_db,
      $_db.documents,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_documentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static DocumentBlocks _blockIdTable(_$ArchiveDatabase db) => db.documentBlocks
      .createAlias('bible_verses__block_id__document_blocks__id');

  $DocumentBlocksProcessedTableManager get blockId {
    final $_column = $_itemColumn<String>('block_id')!;

    final manager = $DocumentBlocksTableManager(
      $_db,
      $_db.documentBlocks,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_blockIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $BibleVersesFilterComposer
    extends Composer<_$ArchiveDatabase, BibleVerses> {
  $BibleVersesFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get translationCode => $composableBuilder(
    column: $table.translationCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bookId => $composableBuilder(
    column: $table.bookId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bookName => $composableBuilder(
    column: $table.bookName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bookOrder => $composableBuilder(
    column: $table.bookOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get testament => $composableBuilder(
    column: $table.testament,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get chapter => $composableBuilder(
    column: $table.chapter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get verse => $composableBuilder(
    column: $table.verse,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get verseText => $composableBuilder(
    column: $table.verseText,
    builder: (column) => ColumnFilters(column),
  );

  $ArchiveCollectionsFilterComposer get collectionId {
    final $ArchiveCollectionsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.collectionId,
      referencedTable: $db.archiveCollections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ArchiveCollectionsFilterComposer(
            $db: $db,
            $table: $db.archiveCollections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $DocumentsFilterComposer get documentId {
    final $DocumentsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $DocumentsFilterComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $DocumentBlocksFilterComposer get blockId {
    final $DocumentBlocksFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.blockId,
      referencedTable: $db.documentBlocks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $DocumentBlocksFilterComposer(
            $db: $db,
            $table: $db.documentBlocks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $BibleVersesOrderingComposer
    extends Composer<_$ArchiveDatabase, BibleVerses> {
  $BibleVersesOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get translationCode => $composableBuilder(
    column: $table.translationCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bookId => $composableBuilder(
    column: $table.bookId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bookName => $composableBuilder(
    column: $table.bookName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bookOrder => $composableBuilder(
    column: $table.bookOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get testament => $composableBuilder(
    column: $table.testament,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get chapter => $composableBuilder(
    column: $table.chapter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get verse => $composableBuilder(
    column: $table.verse,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get verseText => $composableBuilder(
    column: $table.verseText,
    builder: (column) => ColumnOrderings(column),
  );

  $ArchiveCollectionsOrderingComposer get collectionId {
    final $ArchiveCollectionsOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.collectionId,
      referencedTable: $db.archiveCollections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ArchiveCollectionsOrderingComposer(
            $db: $db,
            $table: $db.archiveCollections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $DocumentsOrderingComposer get documentId {
    final $DocumentsOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $DocumentsOrderingComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $DocumentBlocksOrderingComposer get blockId {
    final $DocumentBlocksOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.blockId,
      referencedTable: $db.documentBlocks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $DocumentBlocksOrderingComposer(
            $db: $db,
            $table: $db.documentBlocks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $BibleVersesAnnotationComposer
    extends Composer<_$ArchiveDatabase, BibleVerses> {
  $BibleVersesAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get translationCode => $composableBuilder(
    column: $table.translationCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get bookId =>
      $composableBuilder(column: $table.bookId, builder: (column) => column);

  GeneratedColumn<String> get bookName =>
      $composableBuilder(column: $table.bookName, builder: (column) => column);

  GeneratedColumn<int> get bookOrder =>
      $composableBuilder(column: $table.bookOrder, builder: (column) => column);

  GeneratedColumn<String> get testament =>
      $composableBuilder(column: $table.testament, builder: (column) => column);

  GeneratedColumn<int> get chapter =>
      $composableBuilder(column: $table.chapter, builder: (column) => column);

  GeneratedColumn<int> get verse =>
      $composableBuilder(column: $table.verse, builder: (column) => column);

  GeneratedColumn<String> get verseText =>
      $composableBuilder(column: $table.verseText, builder: (column) => column);

  $ArchiveCollectionsAnnotationComposer get collectionId {
    final $ArchiveCollectionsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.collectionId,
      referencedTable: $db.archiveCollections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ArchiveCollectionsAnnotationComposer(
            $db: $db,
            $table: $db.archiveCollections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $DocumentsAnnotationComposer get documentId {
    final $DocumentsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $DocumentsAnnotationComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $DocumentBlocksAnnotationComposer get blockId {
    final $DocumentBlocksAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.blockId,
      referencedTable: $db.documentBlocks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $DocumentBlocksAnnotationComposer(
            $db: $db,
            $table: $db.documentBlocks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $BibleVersesTableManager
    extends
        RootTableManager<
          _$ArchiveDatabase,
          BibleVerses,
          BibleVerse,
          $BibleVersesFilterComposer,
          $BibleVersesOrderingComposer,
          $BibleVersesAnnotationComposer,
          $BibleVersesCreateCompanionBuilder,
          $BibleVersesUpdateCompanionBuilder,
          (BibleVerse, $BibleVersesReferences),
          BibleVerse,
          PrefetchHooks Function({
            bool collectionId,
            bool documentId,
            bool blockId,
          })
        > {
  $BibleVersesTableManager(_$ArchiveDatabase db, BibleVerses table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $BibleVersesFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $BibleVersesOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $BibleVersesAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> collectionId = const Value.absent(),
                Value<String> translationCode = const Value.absent(),
                Value<String> bookId = const Value.absent(),
                Value<String> bookName = const Value.absent(),
                Value<int> bookOrder = const Value.absent(),
                Value<String> testament = const Value.absent(),
                Value<int> chapter = const Value.absent(),
                Value<int> verse = const Value.absent(),
                Value<String> verseText = const Value.absent(),
                Value<String> documentId = const Value.absent(),
                Value<String> blockId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BibleVersesCompanion(
                id: id,
                collectionId: collectionId,
                translationCode: translationCode,
                bookId: bookId,
                bookName: bookName,
                bookOrder: bookOrder,
                testament: testament,
                chapter: chapter,
                verse: verse,
                verseText: verseText,
                documentId: documentId,
                blockId: blockId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String collectionId,
                required String translationCode,
                required String bookId,
                required String bookName,
                required int bookOrder,
                required String testament,
                required int chapter,
                required int verse,
                required String verseText,
                required String documentId,
                required String blockId,
                Value<int> rowid = const Value.absent(),
              }) => BibleVersesCompanion.insert(
                id: id,
                collectionId: collectionId,
                translationCode: translationCode,
                bookId: bookId,
                bookName: bookName,
                bookOrder: bookOrder,
                testament: testament,
                chapter: chapter,
                verse: verse,
                verseText: verseText,
                documentId: documentId,
                blockId: blockId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $BibleVersesReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({collectionId = false, documentId = false, blockId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (collectionId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.collectionId,
                                    referencedTable: $BibleVersesReferences
                                        ._collectionIdTable(db),
                                    referencedColumn: $BibleVersesReferences
                                        ._collectionIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (documentId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.documentId,
                                    referencedTable: $BibleVersesReferences
                                        ._documentIdTable(db),
                                    referencedColumn: $BibleVersesReferences
                                        ._documentIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (blockId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.blockId,
                                    referencedTable: $BibleVersesReferences
                                        ._blockIdTable(db),
                                    referencedColumn: $BibleVersesReferences
                                        ._blockIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $BibleVersesProcessedTableManager =
    ProcessedTableManager<
      _$ArchiveDatabase,
      BibleVerses,
      BibleVerse,
      $BibleVersesFilterComposer,
      $BibleVersesOrderingComposer,
      $BibleVersesAnnotationComposer,
      $BibleVersesCreateCompanionBuilder,
      $BibleVersesUpdateCompanionBuilder,
      (BibleVerse, $BibleVersesReferences),
      BibleVerse,
      PrefetchHooks Function({bool collectionId, bool documentId, bool blockId})
    >;
typedef $TopicsCreateCompanionBuilder =
    TopicsCompanion Function({
      required String id,
      required String name,
      Value<String?> description,
      Value<int> rowid,
    });
typedef $TopicsUpdateCompanionBuilder =
    TopicsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String?> description,
      Value<int> rowid,
    });

final class $TopicsReferences
    extends BaseReferences<_$ArchiveDatabase, Topics, Topic> {
  $TopicsReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<DocumentTopics, List<DocumentTopic>>
  _documentTopicsRefsTable(_$ArchiveDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.documentTopics,
        aliasName: 'topics__id__document_topics__topic_id',
      );

  $DocumentTopicsProcessedTableManager get documentTopicsRefs {
    final manager = $DocumentTopicsTableManager(
      $_db,
      $_db.documentTopics,
    ).filter((f) => f.topicId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_documentTopicsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $TopicsFilterComposer extends Composer<_$ArchiveDatabase, Topics> {
  $TopicsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> documentTopicsRefs(
    Expression<bool> Function($DocumentTopicsFilterComposer f) f,
  ) {
    final $DocumentTopicsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.documentTopics,
      getReferencedColumn: (t) => t.topicId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $DocumentTopicsFilterComposer(
            $db: $db,
            $table: $db.documentTopics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $TopicsOrderingComposer extends Composer<_$ArchiveDatabase, Topics> {
  $TopicsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );
}

class $TopicsAnnotationComposer extends Composer<_$ArchiveDatabase, Topics> {
  $TopicsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  Expression<T> documentTopicsRefs<T extends Object>(
    Expression<T> Function($DocumentTopicsAnnotationComposer a) f,
  ) {
    final $DocumentTopicsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.documentTopics,
      getReferencedColumn: (t) => t.topicId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $DocumentTopicsAnnotationComposer(
            $db: $db,
            $table: $db.documentTopics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $TopicsTableManager
    extends
        RootTableManager<
          _$ArchiveDatabase,
          Topics,
          Topic,
          $TopicsFilterComposer,
          $TopicsOrderingComposer,
          $TopicsAnnotationComposer,
          $TopicsCreateCompanionBuilder,
          $TopicsUpdateCompanionBuilder,
          (Topic, $TopicsReferences),
          Topic,
          PrefetchHooks Function({bool documentTopicsRefs})
        > {
  $TopicsTableManager(_$ArchiveDatabase db, Topics table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $TopicsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $TopicsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $TopicsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TopicsCompanion(
                id: id,
                name: name,
                description: description,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> description = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TopicsCompanion.insert(
                id: id,
                name: name,
                description: description,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), $TopicsReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({documentTopicsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (documentTopicsRefs) db.documentTopics,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (documentTopicsRefs)
                    await $_getPrefetchedData<Topic, Topics, DocumentTopic>(
                      currentTable: table,
                      referencedTable: $TopicsReferences
                          ._documentTopicsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $TopicsReferences(db, table, p0).documentTopicsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.topicId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $TopicsProcessedTableManager =
    ProcessedTableManager<
      _$ArchiveDatabase,
      Topics,
      Topic,
      $TopicsFilterComposer,
      $TopicsOrderingComposer,
      $TopicsAnnotationComposer,
      $TopicsCreateCompanionBuilder,
      $TopicsUpdateCompanionBuilder,
      (Topic, $TopicsReferences),
      Topic,
      PrefetchHooks Function({bool documentTopicsRefs})
    >;
typedef $DocumentTopicsCreateCompanionBuilder =
    DocumentTopicsCompanion Function({
      required String documentId,
      required String topicId,
      Value<int> rowid,
    });
typedef $DocumentTopicsUpdateCompanionBuilder =
    DocumentTopicsCompanion Function({
      Value<String> documentId,
      Value<String> topicId,
      Value<int> rowid,
    });

final class $DocumentTopicsReferences
    extends BaseReferences<_$ArchiveDatabase, DocumentTopics, DocumentTopic> {
  $DocumentTopicsReferences(super.$_db, super.$_table, super.$_typedResult);

  static Documents _documentIdTable(_$ArchiveDatabase db) =>
      db.documents.createAlias('document_topics__document_id__documents__id');

  $DocumentsProcessedTableManager get documentId {
    final $_column = $_itemColumn<String>('document_id')!;

    final manager = $DocumentsTableManager(
      $_db,
      $_db.documents,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_documentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static Topics _topicIdTable(_$ArchiveDatabase db) =>
      db.topics.createAlias('document_topics__topic_id__topics__id');

  $TopicsProcessedTableManager get topicId {
    final $_column = $_itemColumn<String>('topic_id')!;

    final manager = $TopicsTableManager(
      $_db,
      $_db.topics,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_topicIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $DocumentTopicsFilterComposer
    extends Composer<_$ArchiveDatabase, DocumentTopics> {
  $DocumentTopicsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $DocumentsFilterComposer get documentId {
    final $DocumentsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $DocumentsFilterComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $TopicsFilterComposer get topicId {
    final $TopicsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.topicId,
      referencedTable: $db.topics,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $TopicsFilterComposer(
            $db: $db,
            $table: $db.topics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $DocumentTopicsOrderingComposer
    extends Composer<_$ArchiveDatabase, DocumentTopics> {
  $DocumentTopicsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $DocumentsOrderingComposer get documentId {
    final $DocumentsOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $DocumentsOrderingComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $TopicsOrderingComposer get topicId {
    final $TopicsOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.topicId,
      referencedTable: $db.topics,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $TopicsOrderingComposer(
            $db: $db,
            $table: $db.topics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $DocumentTopicsAnnotationComposer
    extends Composer<_$ArchiveDatabase, DocumentTopics> {
  $DocumentTopicsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $DocumentsAnnotationComposer get documentId {
    final $DocumentsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $DocumentsAnnotationComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $TopicsAnnotationComposer get topicId {
    final $TopicsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.topicId,
      referencedTable: $db.topics,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $TopicsAnnotationComposer(
            $db: $db,
            $table: $db.topics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $DocumentTopicsTableManager
    extends
        RootTableManager<
          _$ArchiveDatabase,
          DocumentTopics,
          DocumentTopic,
          $DocumentTopicsFilterComposer,
          $DocumentTopicsOrderingComposer,
          $DocumentTopicsAnnotationComposer,
          $DocumentTopicsCreateCompanionBuilder,
          $DocumentTopicsUpdateCompanionBuilder,
          (DocumentTopic, $DocumentTopicsReferences),
          DocumentTopic,
          PrefetchHooks Function({bool documentId, bool topicId})
        > {
  $DocumentTopicsTableManager(_$ArchiveDatabase db, DocumentTopics table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $DocumentTopicsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $DocumentTopicsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $DocumentTopicsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> documentId = const Value.absent(),
                Value<String> topicId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DocumentTopicsCompanion(
                documentId: documentId,
                topicId: topicId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String documentId,
                required String topicId,
                Value<int> rowid = const Value.absent(),
              }) => DocumentTopicsCompanion.insert(
                documentId: documentId,
                topicId: topicId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $DocumentTopicsReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({documentId = false, topicId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (documentId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.documentId,
                                referencedTable: $DocumentTopicsReferences
                                    ._documentIdTable(db),
                                referencedColumn: $DocumentTopicsReferences
                                    ._documentIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (topicId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.topicId,
                                referencedTable: $DocumentTopicsReferences
                                    ._topicIdTable(db),
                                referencedColumn: $DocumentTopicsReferences
                                    ._topicIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $DocumentTopicsProcessedTableManager =
    ProcessedTableManager<
      _$ArchiveDatabase,
      DocumentTopics,
      DocumentTopic,
      $DocumentTopicsFilterComposer,
      $DocumentTopicsOrderingComposer,
      $DocumentTopicsAnnotationComposer,
      $DocumentTopicsCreateCompanionBuilder,
      $DocumentTopicsUpdateCompanionBuilder,
      (DocumentTopic, $DocumentTopicsReferences),
      DocumentTopic,
      PrefetchHooks Function({bool documentId, bool topicId})
    >;
typedef $ScriptureReferencesCreateCompanionBuilder =
    ScriptureReferencesCompanion Function({
      Value<int> id,
      required String documentId,
      required String blockId,
      required String book,
      required int chapter,
      required int verseStart,
      Value<int?> verseEnd,
      required String canonicalReference,
    });
typedef $ScriptureReferencesUpdateCompanionBuilder =
    ScriptureReferencesCompanion Function({
      Value<int> id,
      Value<String> documentId,
      Value<String> blockId,
      Value<String> book,
      Value<int> chapter,
      Value<int> verseStart,
      Value<int?> verseEnd,
      Value<String> canonicalReference,
    });

final class $ScriptureReferencesReferences
    extends
        BaseReferences<
          _$ArchiveDatabase,
          ScriptureReferences,
          ScriptureReference
        > {
  $ScriptureReferencesReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static Documents _documentIdTable(_$ArchiveDatabase db) => db.documents
      .createAlias('scripture_references__document_id__documents__id');

  $DocumentsProcessedTableManager get documentId {
    final $_column = $_itemColumn<String>('document_id')!;

    final manager = $DocumentsTableManager(
      $_db,
      $_db.documents,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_documentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static DocumentBlocks _blockIdTable(_$ArchiveDatabase db) => db.documentBlocks
      .createAlias('scripture_references__block_id__document_blocks__id');

  $DocumentBlocksProcessedTableManager get blockId {
    final $_column = $_itemColumn<String>('block_id')!;

    final manager = $DocumentBlocksTableManager(
      $_db,
      $_db.documentBlocks,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_blockIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $ScriptureReferencesFilterComposer
    extends Composer<_$ArchiveDatabase, ScriptureReferences> {
  $ScriptureReferencesFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get book => $composableBuilder(
    column: $table.book,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get chapter => $composableBuilder(
    column: $table.chapter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get verseStart => $composableBuilder(
    column: $table.verseStart,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get verseEnd => $composableBuilder(
    column: $table.verseEnd,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get canonicalReference => $composableBuilder(
    column: $table.canonicalReference,
    builder: (column) => ColumnFilters(column),
  );

  $DocumentsFilterComposer get documentId {
    final $DocumentsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $DocumentsFilterComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $DocumentBlocksFilterComposer get blockId {
    final $DocumentBlocksFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.blockId,
      referencedTable: $db.documentBlocks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $DocumentBlocksFilterComposer(
            $db: $db,
            $table: $db.documentBlocks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $ScriptureReferencesOrderingComposer
    extends Composer<_$ArchiveDatabase, ScriptureReferences> {
  $ScriptureReferencesOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get book => $composableBuilder(
    column: $table.book,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get chapter => $composableBuilder(
    column: $table.chapter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get verseStart => $composableBuilder(
    column: $table.verseStart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get verseEnd => $composableBuilder(
    column: $table.verseEnd,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get canonicalReference => $composableBuilder(
    column: $table.canonicalReference,
    builder: (column) => ColumnOrderings(column),
  );

  $DocumentsOrderingComposer get documentId {
    final $DocumentsOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $DocumentsOrderingComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $DocumentBlocksOrderingComposer get blockId {
    final $DocumentBlocksOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.blockId,
      referencedTable: $db.documentBlocks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $DocumentBlocksOrderingComposer(
            $db: $db,
            $table: $db.documentBlocks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $ScriptureReferencesAnnotationComposer
    extends Composer<_$ArchiveDatabase, ScriptureReferences> {
  $ScriptureReferencesAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get book =>
      $composableBuilder(column: $table.book, builder: (column) => column);

  GeneratedColumn<int> get chapter =>
      $composableBuilder(column: $table.chapter, builder: (column) => column);

  GeneratedColumn<int> get verseStart => $composableBuilder(
    column: $table.verseStart,
    builder: (column) => column,
  );

  GeneratedColumn<int> get verseEnd =>
      $composableBuilder(column: $table.verseEnd, builder: (column) => column);

  GeneratedColumn<String> get canonicalReference => $composableBuilder(
    column: $table.canonicalReference,
    builder: (column) => column,
  );

  $DocumentsAnnotationComposer get documentId {
    final $DocumentsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $DocumentsAnnotationComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $DocumentBlocksAnnotationComposer get blockId {
    final $DocumentBlocksAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.blockId,
      referencedTable: $db.documentBlocks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $DocumentBlocksAnnotationComposer(
            $db: $db,
            $table: $db.documentBlocks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $ScriptureReferencesTableManager
    extends
        RootTableManager<
          _$ArchiveDatabase,
          ScriptureReferences,
          ScriptureReference,
          $ScriptureReferencesFilterComposer,
          $ScriptureReferencesOrderingComposer,
          $ScriptureReferencesAnnotationComposer,
          $ScriptureReferencesCreateCompanionBuilder,
          $ScriptureReferencesUpdateCompanionBuilder,
          (ScriptureReference, $ScriptureReferencesReferences),
          ScriptureReference,
          PrefetchHooks Function({bool documentId, bool blockId})
        > {
  $ScriptureReferencesTableManager(
    _$ArchiveDatabase db,
    ScriptureReferences table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $ScriptureReferencesFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $ScriptureReferencesOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $ScriptureReferencesAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> documentId = const Value.absent(),
                Value<String> blockId = const Value.absent(),
                Value<String> book = const Value.absent(),
                Value<int> chapter = const Value.absent(),
                Value<int> verseStart = const Value.absent(),
                Value<int?> verseEnd = const Value.absent(),
                Value<String> canonicalReference = const Value.absent(),
              }) => ScriptureReferencesCompanion(
                id: id,
                documentId: documentId,
                blockId: blockId,
                book: book,
                chapter: chapter,
                verseStart: verseStart,
                verseEnd: verseEnd,
                canonicalReference: canonicalReference,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String documentId,
                required String blockId,
                required String book,
                required int chapter,
                required int verseStart,
                Value<int?> verseEnd = const Value.absent(),
                required String canonicalReference,
              }) => ScriptureReferencesCompanion.insert(
                id: id,
                documentId: documentId,
                blockId: blockId,
                book: book,
                chapter: chapter,
                verseStart: verseStart,
                verseEnd: verseEnd,
                canonicalReference: canonicalReference,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $ScriptureReferencesReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({documentId = false, blockId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (documentId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.documentId,
                                referencedTable: $ScriptureReferencesReferences
                                    ._documentIdTable(db),
                                referencedColumn: $ScriptureReferencesReferences
                                    ._documentIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (blockId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.blockId,
                                referencedTable: $ScriptureReferencesReferences
                                    ._blockIdTable(db),
                                referencedColumn: $ScriptureReferencesReferences
                                    ._blockIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $ScriptureReferencesProcessedTableManager =
    ProcessedTableManager<
      _$ArchiveDatabase,
      ScriptureReferences,
      ScriptureReference,
      $ScriptureReferencesFilterComposer,
      $ScriptureReferencesOrderingComposer,
      $ScriptureReferencesAnnotationComposer,
      $ScriptureReferencesCreateCompanionBuilder,
      $ScriptureReferencesUpdateCompanionBuilder,
      (ScriptureReference, $ScriptureReferencesReferences),
      ScriptureReference,
      PrefetchHooks Function({bool documentId, bool blockId})
    >;
typedef $ScriptureReferenceSpansCreateCompanionBuilder =
    ScriptureReferenceSpansCompanion Function({
      required String id,
      required String collectionId,
      required String documentId,
      required String blockId,
      required int startOffset,
      required int endOffset,
      required String rawText,
      required String canonicalReference,
      required String confidence,
      required int parserVersion,
      Value<int?> overrideVersion,
      Value<int> rowid,
    });
typedef $ScriptureReferenceSpansUpdateCompanionBuilder =
    ScriptureReferenceSpansCompanion Function({
      Value<String> id,
      Value<String> collectionId,
      Value<String> documentId,
      Value<String> blockId,
      Value<int> startOffset,
      Value<int> endOffset,
      Value<String> rawText,
      Value<String> canonicalReference,
      Value<String> confidence,
      Value<int> parserVersion,
      Value<int?> overrideVersion,
      Value<int> rowid,
    });

final class $ScriptureReferenceSpansReferences
    extends
        BaseReferences<
          _$ArchiveDatabase,
          ScriptureReferenceSpans,
          ScriptureReferenceSpan
        > {
  $ScriptureReferenceSpansReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static ArchiveCollections _collectionIdTable(_$ArchiveDatabase db) =>
      db.archiveCollections.createAlias(
        'scripture_reference_spans__collection_id__archive_collections__id',
      );

  $ArchiveCollectionsProcessedTableManager get collectionId {
    final $_column = $_itemColumn<String>('collection_id')!;

    final manager = $ArchiveCollectionsTableManager(
      $_db,
      $_db.archiveCollections,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_collectionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static Documents _documentIdTable(_$ArchiveDatabase db) => db.documents
      .createAlias('scripture_reference_spans__document_id__documents__id');

  $DocumentsProcessedTableManager get documentId {
    final $_column = $_itemColumn<String>('document_id')!;

    final manager = $DocumentsTableManager(
      $_db,
      $_db.documents,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_documentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static DocumentBlocks _blockIdTable(_$ArchiveDatabase db) => db.documentBlocks
      .createAlias('scripture_reference_spans__block_id__document_blocks__id');

  $DocumentBlocksProcessedTableManager get blockId {
    final $_column = $_itemColumn<String>('block_id')!;

    final manager = $DocumentBlocksTableManager(
      $_db,
      $_db.documentBlocks,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_blockIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    ScriptureReferenceSegments,
    List<ScriptureReferenceSegment>
  >
  _scriptureReferenceSegmentsRefsTable(
    _$ArchiveDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.scriptureReferenceSegments,
    aliasName:
        'scripture_reference_spans__id__scripture_reference_segments__span_id',
  );

  $ScriptureReferenceSegmentsProcessedTableManager
  get scriptureReferenceSegmentsRefs {
    final manager = $ScriptureReferenceSegmentsTableManager(
      $_db,
      $_db.scriptureReferenceSegments,
    ).filter((f) => f.spanId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _scriptureReferenceSegmentsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    ScriptureVerseOccurrences,
    List<ScriptureVerseOccurrence>
  >
  _scriptureVerseOccurrencesRefsTable(
    _$ArchiveDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.scriptureVerseOccurrences,
    aliasName:
        'scripture_reference_spans__id__scripture_verse_occurrences__span_id',
  );

  $ScriptureVerseOccurrencesProcessedTableManager
  get scriptureVerseOccurrencesRefs {
    final manager = $ScriptureVerseOccurrencesTableManager(
      $_db,
      $_db.scriptureVerseOccurrences,
    ).filter((f) => f.spanId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _scriptureVerseOccurrencesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $ScriptureReferenceSpansFilterComposer
    extends Composer<_$ArchiveDatabase, ScriptureReferenceSpans> {
  $ScriptureReferenceSpansFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get startOffset => $composableBuilder(
    column: $table.startOffset,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get endOffset => $composableBuilder(
    column: $table.endOffset,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rawText => $composableBuilder(
    column: $table.rawText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get canonicalReference => $composableBuilder(
    column: $table.canonicalReference,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get parserVersion => $composableBuilder(
    column: $table.parserVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get overrideVersion => $composableBuilder(
    column: $table.overrideVersion,
    builder: (column) => ColumnFilters(column),
  );

  $ArchiveCollectionsFilterComposer get collectionId {
    final $ArchiveCollectionsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.collectionId,
      referencedTable: $db.archiveCollections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ArchiveCollectionsFilterComposer(
            $db: $db,
            $table: $db.archiveCollections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $DocumentsFilterComposer get documentId {
    final $DocumentsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $DocumentsFilterComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $DocumentBlocksFilterComposer get blockId {
    final $DocumentBlocksFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.blockId,
      referencedTable: $db.documentBlocks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $DocumentBlocksFilterComposer(
            $db: $db,
            $table: $db.documentBlocks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> scriptureReferenceSegmentsRefs(
    Expression<bool> Function($ScriptureReferenceSegmentsFilterComposer f) f,
  ) {
    final $ScriptureReferenceSegmentsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.scriptureReferenceSegments,
      getReferencedColumn: (t) => t.spanId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ScriptureReferenceSegmentsFilterComposer(
            $db: $db,
            $table: $db.scriptureReferenceSegments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> scriptureVerseOccurrencesRefs(
    Expression<bool> Function($ScriptureVerseOccurrencesFilterComposer f) f,
  ) {
    final $ScriptureVerseOccurrencesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.scriptureVerseOccurrences,
      getReferencedColumn: (t) => t.spanId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ScriptureVerseOccurrencesFilterComposer(
            $db: $db,
            $table: $db.scriptureVerseOccurrences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $ScriptureReferenceSpansOrderingComposer
    extends Composer<_$ArchiveDatabase, ScriptureReferenceSpans> {
  $ScriptureReferenceSpansOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startOffset => $composableBuilder(
    column: $table.startOffset,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get endOffset => $composableBuilder(
    column: $table.endOffset,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rawText => $composableBuilder(
    column: $table.rawText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get canonicalReference => $composableBuilder(
    column: $table.canonicalReference,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get parserVersion => $composableBuilder(
    column: $table.parserVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get overrideVersion => $composableBuilder(
    column: $table.overrideVersion,
    builder: (column) => ColumnOrderings(column),
  );

  $ArchiveCollectionsOrderingComposer get collectionId {
    final $ArchiveCollectionsOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.collectionId,
      referencedTable: $db.archiveCollections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ArchiveCollectionsOrderingComposer(
            $db: $db,
            $table: $db.archiveCollections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $DocumentsOrderingComposer get documentId {
    final $DocumentsOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $DocumentsOrderingComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $DocumentBlocksOrderingComposer get blockId {
    final $DocumentBlocksOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.blockId,
      referencedTable: $db.documentBlocks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $DocumentBlocksOrderingComposer(
            $db: $db,
            $table: $db.documentBlocks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $ScriptureReferenceSpansAnnotationComposer
    extends Composer<_$ArchiveDatabase, ScriptureReferenceSpans> {
  $ScriptureReferenceSpansAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get startOffset => $composableBuilder(
    column: $table.startOffset,
    builder: (column) => column,
  );

  GeneratedColumn<int> get endOffset =>
      $composableBuilder(column: $table.endOffset, builder: (column) => column);

  GeneratedColumn<String> get rawText =>
      $composableBuilder(column: $table.rawText, builder: (column) => column);

  GeneratedColumn<String> get canonicalReference => $composableBuilder(
    column: $table.canonicalReference,
    builder: (column) => column,
  );

  GeneratedColumn<String> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => column,
  );

  GeneratedColumn<int> get parserVersion => $composableBuilder(
    column: $table.parserVersion,
    builder: (column) => column,
  );

  GeneratedColumn<int> get overrideVersion => $composableBuilder(
    column: $table.overrideVersion,
    builder: (column) => column,
  );

  $ArchiveCollectionsAnnotationComposer get collectionId {
    final $ArchiveCollectionsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.collectionId,
      referencedTable: $db.archiveCollections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ArchiveCollectionsAnnotationComposer(
            $db: $db,
            $table: $db.archiveCollections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $DocumentsAnnotationComposer get documentId {
    final $DocumentsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $DocumentsAnnotationComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $DocumentBlocksAnnotationComposer get blockId {
    final $DocumentBlocksAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.blockId,
      referencedTable: $db.documentBlocks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $DocumentBlocksAnnotationComposer(
            $db: $db,
            $table: $db.documentBlocks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> scriptureReferenceSegmentsRefs<T extends Object>(
    Expression<T> Function($ScriptureReferenceSegmentsAnnotationComposer a) f,
  ) {
    final $ScriptureReferenceSegmentsAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.scriptureReferenceSegments,
          getReferencedColumn: (t) => t.spanId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $ScriptureReferenceSegmentsAnnotationComposer(
                $db: $db,
                $table: $db.scriptureReferenceSegments,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> scriptureVerseOccurrencesRefs<T extends Object>(
    Expression<T> Function($ScriptureVerseOccurrencesAnnotationComposer a) f,
  ) {
    final $ScriptureVerseOccurrencesAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.scriptureVerseOccurrences,
          getReferencedColumn: (t) => t.spanId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $ScriptureVerseOccurrencesAnnotationComposer(
                $db: $db,
                $table: $db.scriptureVerseOccurrences,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $ScriptureReferenceSpansTableManager
    extends
        RootTableManager<
          _$ArchiveDatabase,
          ScriptureReferenceSpans,
          ScriptureReferenceSpan,
          $ScriptureReferenceSpansFilterComposer,
          $ScriptureReferenceSpansOrderingComposer,
          $ScriptureReferenceSpansAnnotationComposer,
          $ScriptureReferenceSpansCreateCompanionBuilder,
          $ScriptureReferenceSpansUpdateCompanionBuilder,
          (ScriptureReferenceSpan, $ScriptureReferenceSpansReferences),
          ScriptureReferenceSpan,
          PrefetchHooks Function({
            bool collectionId,
            bool documentId,
            bool blockId,
            bool scriptureReferenceSegmentsRefs,
            bool scriptureVerseOccurrencesRefs,
          })
        > {
  $ScriptureReferenceSpansTableManager(
    _$ArchiveDatabase db,
    ScriptureReferenceSpans table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $ScriptureReferenceSpansFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $ScriptureReferenceSpansOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $ScriptureReferenceSpansAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> collectionId = const Value.absent(),
                Value<String> documentId = const Value.absent(),
                Value<String> blockId = const Value.absent(),
                Value<int> startOffset = const Value.absent(),
                Value<int> endOffset = const Value.absent(),
                Value<String> rawText = const Value.absent(),
                Value<String> canonicalReference = const Value.absent(),
                Value<String> confidence = const Value.absent(),
                Value<int> parserVersion = const Value.absent(),
                Value<int?> overrideVersion = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ScriptureReferenceSpansCompanion(
                id: id,
                collectionId: collectionId,
                documentId: documentId,
                blockId: blockId,
                startOffset: startOffset,
                endOffset: endOffset,
                rawText: rawText,
                canonicalReference: canonicalReference,
                confidence: confidence,
                parserVersion: parserVersion,
                overrideVersion: overrideVersion,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String collectionId,
                required String documentId,
                required String blockId,
                required int startOffset,
                required int endOffset,
                required String rawText,
                required String canonicalReference,
                required String confidence,
                required int parserVersion,
                Value<int?> overrideVersion = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ScriptureReferenceSpansCompanion.insert(
                id: id,
                collectionId: collectionId,
                documentId: documentId,
                blockId: blockId,
                startOffset: startOffset,
                endOffset: endOffset,
                rawText: rawText,
                canonicalReference: canonicalReference,
                confidence: confidence,
                parserVersion: parserVersion,
                overrideVersion: overrideVersion,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $ScriptureReferenceSpansReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                collectionId = false,
                documentId = false,
                blockId = false,
                scriptureReferenceSegmentsRefs = false,
                scriptureVerseOccurrencesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (scriptureReferenceSegmentsRefs)
                      db.scriptureReferenceSegments,
                    if (scriptureVerseOccurrencesRefs)
                      db.scriptureVerseOccurrences,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (collectionId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.collectionId,
                                    referencedTable:
                                        $ScriptureReferenceSpansReferences
                                            ._collectionIdTable(db),
                                    referencedColumn:
                                        $ScriptureReferenceSpansReferences
                                            ._collectionIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (documentId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.documentId,
                                    referencedTable:
                                        $ScriptureReferenceSpansReferences
                                            ._documentIdTable(db),
                                    referencedColumn:
                                        $ScriptureReferenceSpansReferences
                                            ._documentIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (blockId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.blockId,
                                    referencedTable:
                                        $ScriptureReferenceSpansReferences
                                            ._blockIdTable(db),
                                    referencedColumn:
                                        $ScriptureReferenceSpansReferences
                                            ._blockIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (scriptureReferenceSegmentsRefs)
                        await $_getPrefetchedData<
                          ScriptureReferenceSpan,
                          ScriptureReferenceSpans,
                          ScriptureReferenceSegment
                        >(
                          currentTable: table,
                          referencedTable: $ScriptureReferenceSpansReferences
                              ._scriptureReferenceSegmentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $ScriptureReferenceSpansReferences(
                                db,
                                table,
                                p0,
                              ).scriptureReferenceSegmentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.spanId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (scriptureVerseOccurrencesRefs)
                        await $_getPrefetchedData<
                          ScriptureReferenceSpan,
                          ScriptureReferenceSpans,
                          ScriptureVerseOccurrence
                        >(
                          currentTable: table,
                          referencedTable: $ScriptureReferenceSpansReferences
                              ._scriptureVerseOccurrencesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $ScriptureReferenceSpansReferences(
                                db,
                                table,
                                p0,
                              ).scriptureVerseOccurrencesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.spanId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $ScriptureReferenceSpansProcessedTableManager =
    ProcessedTableManager<
      _$ArchiveDatabase,
      ScriptureReferenceSpans,
      ScriptureReferenceSpan,
      $ScriptureReferenceSpansFilterComposer,
      $ScriptureReferenceSpansOrderingComposer,
      $ScriptureReferenceSpansAnnotationComposer,
      $ScriptureReferenceSpansCreateCompanionBuilder,
      $ScriptureReferenceSpansUpdateCompanionBuilder,
      (ScriptureReferenceSpan, $ScriptureReferenceSpansReferences),
      ScriptureReferenceSpan,
      PrefetchHooks Function({
        bool collectionId,
        bool documentId,
        bool blockId,
        bool scriptureReferenceSegmentsRefs,
        bool scriptureVerseOccurrencesRefs,
      })
    >;
typedef $ScriptureReferenceSegmentsCreateCompanionBuilder =
    ScriptureReferenceSegmentsCompanion Function({
      required String spanId,
      required String bookId,
      required int chapter,
      Value<int?> verseStart,
      Value<int?> verseEnd,
      required int segmentOrder,
      Value<int> rowid,
    });
typedef $ScriptureReferenceSegmentsUpdateCompanionBuilder =
    ScriptureReferenceSegmentsCompanion Function({
      Value<String> spanId,
      Value<String> bookId,
      Value<int> chapter,
      Value<int?> verseStart,
      Value<int?> verseEnd,
      Value<int> segmentOrder,
      Value<int> rowid,
    });

final class $ScriptureReferenceSegmentsReferences
    extends
        BaseReferences<
          _$ArchiveDatabase,
          ScriptureReferenceSegments,
          ScriptureReferenceSegment
        > {
  $ScriptureReferenceSegmentsReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static ScriptureReferenceSpans _spanIdTable(_$ArchiveDatabase db) =>
      db.scriptureReferenceSpans.createAlias(
        'scripture_reference_segments__span_id__scripture_reference_spans__id',
      );

  $ScriptureReferenceSpansProcessedTableManager get spanId {
    final $_column = $_itemColumn<String>('span_id')!;

    final manager = $ScriptureReferenceSpansTableManager(
      $_db,
      $_db.scriptureReferenceSpans,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_spanIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $ScriptureReferenceSegmentsFilterComposer
    extends Composer<_$ArchiveDatabase, ScriptureReferenceSegments> {
  $ScriptureReferenceSegmentsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get bookId => $composableBuilder(
    column: $table.bookId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get chapter => $composableBuilder(
    column: $table.chapter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get verseStart => $composableBuilder(
    column: $table.verseStart,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get verseEnd => $composableBuilder(
    column: $table.verseEnd,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get segmentOrder => $composableBuilder(
    column: $table.segmentOrder,
    builder: (column) => ColumnFilters(column),
  );

  $ScriptureReferenceSpansFilterComposer get spanId {
    final $ScriptureReferenceSpansFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.spanId,
      referencedTable: $db.scriptureReferenceSpans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ScriptureReferenceSpansFilterComposer(
            $db: $db,
            $table: $db.scriptureReferenceSpans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $ScriptureReferenceSegmentsOrderingComposer
    extends Composer<_$ArchiveDatabase, ScriptureReferenceSegments> {
  $ScriptureReferenceSegmentsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get bookId => $composableBuilder(
    column: $table.bookId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get chapter => $composableBuilder(
    column: $table.chapter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get verseStart => $composableBuilder(
    column: $table.verseStart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get verseEnd => $composableBuilder(
    column: $table.verseEnd,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get segmentOrder => $composableBuilder(
    column: $table.segmentOrder,
    builder: (column) => ColumnOrderings(column),
  );

  $ScriptureReferenceSpansOrderingComposer get spanId {
    final $ScriptureReferenceSpansOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.spanId,
      referencedTable: $db.scriptureReferenceSpans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ScriptureReferenceSpansOrderingComposer(
            $db: $db,
            $table: $db.scriptureReferenceSpans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $ScriptureReferenceSegmentsAnnotationComposer
    extends Composer<_$ArchiveDatabase, ScriptureReferenceSegments> {
  $ScriptureReferenceSegmentsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get bookId =>
      $composableBuilder(column: $table.bookId, builder: (column) => column);

  GeneratedColumn<int> get chapter =>
      $composableBuilder(column: $table.chapter, builder: (column) => column);

  GeneratedColumn<int> get verseStart => $composableBuilder(
    column: $table.verseStart,
    builder: (column) => column,
  );

  GeneratedColumn<int> get verseEnd =>
      $composableBuilder(column: $table.verseEnd, builder: (column) => column);

  GeneratedColumn<int> get segmentOrder => $composableBuilder(
    column: $table.segmentOrder,
    builder: (column) => column,
  );

  $ScriptureReferenceSpansAnnotationComposer get spanId {
    final $ScriptureReferenceSpansAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.spanId,
          referencedTable: $db.scriptureReferenceSpans,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $ScriptureReferenceSpansAnnotationComposer(
                $db: $db,
                $table: $db.scriptureReferenceSpans,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $ScriptureReferenceSegmentsTableManager
    extends
        RootTableManager<
          _$ArchiveDatabase,
          ScriptureReferenceSegments,
          ScriptureReferenceSegment,
          $ScriptureReferenceSegmentsFilterComposer,
          $ScriptureReferenceSegmentsOrderingComposer,
          $ScriptureReferenceSegmentsAnnotationComposer,
          $ScriptureReferenceSegmentsCreateCompanionBuilder,
          $ScriptureReferenceSegmentsUpdateCompanionBuilder,
          (ScriptureReferenceSegment, $ScriptureReferenceSegmentsReferences),
          ScriptureReferenceSegment,
          PrefetchHooks Function({bool spanId})
        > {
  $ScriptureReferenceSegmentsTableManager(
    _$ArchiveDatabase db,
    ScriptureReferenceSegments table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $ScriptureReferenceSegmentsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $ScriptureReferenceSegmentsOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $ScriptureReferenceSegmentsAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> spanId = const Value.absent(),
                Value<String> bookId = const Value.absent(),
                Value<int> chapter = const Value.absent(),
                Value<int?> verseStart = const Value.absent(),
                Value<int?> verseEnd = const Value.absent(),
                Value<int> segmentOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ScriptureReferenceSegmentsCompanion(
                spanId: spanId,
                bookId: bookId,
                chapter: chapter,
                verseStart: verseStart,
                verseEnd: verseEnd,
                segmentOrder: segmentOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String spanId,
                required String bookId,
                required int chapter,
                Value<int?> verseStart = const Value.absent(),
                Value<int?> verseEnd = const Value.absent(),
                required int segmentOrder,
                Value<int> rowid = const Value.absent(),
              }) => ScriptureReferenceSegmentsCompanion.insert(
                spanId: spanId,
                bookId: bookId,
                chapter: chapter,
                verseStart: verseStart,
                verseEnd: verseEnd,
                segmentOrder: segmentOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $ScriptureReferenceSegmentsReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({spanId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (spanId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.spanId,
                                referencedTable:
                                    $ScriptureReferenceSegmentsReferences
                                        ._spanIdTable(db),
                                referencedColumn:
                                    $ScriptureReferenceSegmentsReferences
                                        ._spanIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $ScriptureReferenceSegmentsProcessedTableManager =
    ProcessedTableManager<
      _$ArchiveDatabase,
      ScriptureReferenceSegments,
      ScriptureReferenceSegment,
      $ScriptureReferenceSegmentsFilterComposer,
      $ScriptureReferenceSegmentsOrderingComposer,
      $ScriptureReferenceSegmentsAnnotationComposer,
      $ScriptureReferenceSegmentsCreateCompanionBuilder,
      $ScriptureReferenceSegmentsUpdateCompanionBuilder,
      (ScriptureReferenceSegment, $ScriptureReferenceSegmentsReferences),
      ScriptureReferenceSegment,
      PrefetchHooks Function({bool spanId})
    >;
typedef $ScriptureVerseOccurrencesCreateCompanionBuilder =
    ScriptureVerseOccurrencesCompanion Function({
      required String spanId,
      required String collectionId,
      required String documentId,
      required String blockId,
      required String bookId,
      required int chapter,
      required int verse,
      Value<int> rowid,
    });
typedef $ScriptureVerseOccurrencesUpdateCompanionBuilder =
    ScriptureVerseOccurrencesCompanion Function({
      Value<String> spanId,
      Value<String> collectionId,
      Value<String> documentId,
      Value<String> blockId,
      Value<String> bookId,
      Value<int> chapter,
      Value<int> verse,
      Value<int> rowid,
    });

final class $ScriptureVerseOccurrencesReferences
    extends
        BaseReferences<
          _$ArchiveDatabase,
          ScriptureVerseOccurrences,
          ScriptureVerseOccurrence
        > {
  $ScriptureVerseOccurrencesReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static ScriptureReferenceSpans _spanIdTable(_$ArchiveDatabase db) =>
      db.scriptureReferenceSpans.createAlias(
        'scripture_verse_occurrences__span_id__scripture_reference_spans__id',
      );

  $ScriptureReferenceSpansProcessedTableManager get spanId {
    final $_column = $_itemColumn<String>('span_id')!;

    final manager = $ScriptureReferenceSpansTableManager(
      $_db,
      $_db.scriptureReferenceSpans,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_spanIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static ArchiveCollections _collectionIdTable(_$ArchiveDatabase db) =>
      db.archiveCollections.createAlias(
        'scripture_verse_occurrences__collection_id__archive_collections__id',
      );

  $ArchiveCollectionsProcessedTableManager get collectionId {
    final $_column = $_itemColumn<String>('collection_id')!;

    final manager = $ArchiveCollectionsTableManager(
      $_db,
      $_db.archiveCollections,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_collectionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static Documents _documentIdTable(_$ArchiveDatabase db) => db.documents
      .createAlias('scripture_verse_occurrences__document_id__documents__id');

  $DocumentsProcessedTableManager get documentId {
    final $_column = $_itemColumn<String>('document_id')!;

    final manager = $DocumentsTableManager(
      $_db,
      $_db.documents,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_documentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static DocumentBlocks _blockIdTable(_$ArchiveDatabase db) =>
      db.documentBlocks.createAlias(
        'scripture_verse_occurrences__block_id__document_blocks__id',
      );

  $DocumentBlocksProcessedTableManager get blockId {
    final $_column = $_itemColumn<String>('block_id')!;

    final manager = $DocumentBlocksTableManager(
      $_db,
      $_db.documentBlocks,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_blockIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $ScriptureVerseOccurrencesFilterComposer
    extends Composer<_$ArchiveDatabase, ScriptureVerseOccurrences> {
  $ScriptureVerseOccurrencesFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get bookId => $composableBuilder(
    column: $table.bookId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get chapter => $composableBuilder(
    column: $table.chapter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get verse => $composableBuilder(
    column: $table.verse,
    builder: (column) => ColumnFilters(column),
  );

  $ScriptureReferenceSpansFilterComposer get spanId {
    final $ScriptureReferenceSpansFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.spanId,
      referencedTable: $db.scriptureReferenceSpans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ScriptureReferenceSpansFilterComposer(
            $db: $db,
            $table: $db.scriptureReferenceSpans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $ArchiveCollectionsFilterComposer get collectionId {
    final $ArchiveCollectionsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.collectionId,
      referencedTable: $db.archiveCollections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ArchiveCollectionsFilterComposer(
            $db: $db,
            $table: $db.archiveCollections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $DocumentsFilterComposer get documentId {
    final $DocumentsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $DocumentsFilterComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $DocumentBlocksFilterComposer get blockId {
    final $DocumentBlocksFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.blockId,
      referencedTable: $db.documentBlocks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $DocumentBlocksFilterComposer(
            $db: $db,
            $table: $db.documentBlocks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $ScriptureVerseOccurrencesOrderingComposer
    extends Composer<_$ArchiveDatabase, ScriptureVerseOccurrences> {
  $ScriptureVerseOccurrencesOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get bookId => $composableBuilder(
    column: $table.bookId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get chapter => $composableBuilder(
    column: $table.chapter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get verse => $composableBuilder(
    column: $table.verse,
    builder: (column) => ColumnOrderings(column),
  );

  $ScriptureReferenceSpansOrderingComposer get spanId {
    final $ScriptureReferenceSpansOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.spanId,
      referencedTable: $db.scriptureReferenceSpans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ScriptureReferenceSpansOrderingComposer(
            $db: $db,
            $table: $db.scriptureReferenceSpans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $ArchiveCollectionsOrderingComposer get collectionId {
    final $ArchiveCollectionsOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.collectionId,
      referencedTable: $db.archiveCollections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ArchiveCollectionsOrderingComposer(
            $db: $db,
            $table: $db.archiveCollections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $DocumentsOrderingComposer get documentId {
    final $DocumentsOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $DocumentsOrderingComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $DocumentBlocksOrderingComposer get blockId {
    final $DocumentBlocksOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.blockId,
      referencedTable: $db.documentBlocks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $DocumentBlocksOrderingComposer(
            $db: $db,
            $table: $db.documentBlocks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $ScriptureVerseOccurrencesAnnotationComposer
    extends Composer<_$ArchiveDatabase, ScriptureVerseOccurrences> {
  $ScriptureVerseOccurrencesAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get bookId =>
      $composableBuilder(column: $table.bookId, builder: (column) => column);

  GeneratedColumn<int> get chapter =>
      $composableBuilder(column: $table.chapter, builder: (column) => column);

  GeneratedColumn<int> get verse =>
      $composableBuilder(column: $table.verse, builder: (column) => column);

  $ScriptureReferenceSpansAnnotationComposer get spanId {
    final $ScriptureReferenceSpansAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.spanId,
          referencedTable: $db.scriptureReferenceSpans,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $ScriptureReferenceSpansAnnotationComposer(
                $db: $db,
                $table: $db.scriptureReferenceSpans,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $ArchiveCollectionsAnnotationComposer get collectionId {
    final $ArchiveCollectionsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.collectionId,
      referencedTable: $db.archiveCollections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ArchiveCollectionsAnnotationComposer(
            $db: $db,
            $table: $db.archiveCollections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $DocumentsAnnotationComposer get documentId {
    final $DocumentsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $DocumentsAnnotationComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $DocumentBlocksAnnotationComposer get blockId {
    final $DocumentBlocksAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.blockId,
      referencedTable: $db.documentBlocks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $DocumentBlocksAnnotationComposer(
            $db: $db,
            $table: $db.documentBlocks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $ScriptureVerseOccurrencesTableManager
    extends
        RootTableManager<
          _$ArchiveDatabase,
          ScriptureVerseOccurrences,
          ScriptureVerseOccurrence,
          $ScriptureVerseOccurrencesFilterComposer,
          $ScriptureVerseOccurrencesOrderingComposer,
          $ScriptureVerseOccurrencesAnnotationComposer,
          $ScriptureVerseOccurrencesCreateCompanionBuilder,
          $ScriptureVerseOccurrencesUpdateCompanionBuilder,
          (ScriptureVerseOccurrence, $ScriptureVerseOccurrencesReferences),
          ScriptureVerseOccurrence,
          PrefetchHooks Function({
            bool spanId,
            bool collectionId,
            bool documentId,
            bool blockId,
          })
        > {
  $ScriptureVerseOccurrencesTableManager(
    _$ArchiveDatabase db,
    ScriptureVerseOccurrences table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $ScriptureVerseOccurrencesFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $ScriptureVerseOccurrencesOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $ScriptureVerseOccurrencesAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> spanId = const Value.absent(),
                Value<String> collectionId = const Value.absent(),
                Value<String> documentId = const Value.absent(),
                Value<String> blockId = const Value.absent(),
                Value<String> bookId = const Value.absent(),
                Value<int> chapter = const Value.absent(),
                Value<int> verse = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ScriptureVerseOccurrencesCompanion(
                spanId: spanId,
                collectionId: collectionId,
                documentId: documentId,
                blockId: blockId,
                bookId: bookId,
                chapter: chapter,
                verse: verse,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String spanId,
                required String collectionId,
                required String documentId,
                required String blockId,
                required String bookId,
                required int chapter,
                required int verse,
                Value<int> rowid = const Value.absent(),
              }) => ScriptureVerseOccurrencesCompanion.insert(
                spanId: spanId,
                collectionId: collectionId,
                documentId: documentId,
                blockId: blockId,
                bookId: bookId,
                chapter: chapter,
                verse: verse,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $ScriptureVerseOccurrencesReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                spanId = false,
                collectionId = false,
                documentId = false,
                blockId = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (spanId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.spanId,
                                    referencedTable:
                                        $ScriptureVerseOccurrencesReferences
                                            ._spanIdTable(db),
                                    referencedColumn:
                                        $ScriptureVerseOccurrencesReferences
                                            ._spanIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (collectionId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.collectionId,
                                    referencedTable:
                                        $ScriptureVerseOccurrencesReferences
                                            ._collectionIdTable(db),
                                    referencedColumn:
                                        $ScriptureVerseOccurrencesReferences
                                            ._collectionIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (documentId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.documentId,
                                    referencedTable:
                                        $ScriptureVerseOccurrencesReferences
                                            ._documentIdTable(db),
                                    referencedColumn:
                                        $ScriptureVerseOccurrencesReferences
                                            ._documentIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (blockId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.blockId,
                                    referencedTable:
                                        $ScriptureVerseOccurrencesReferences
                                            ._blockIdTable(db),
                                    referencedColumn:
                                        $ScriptureVerseOccurrencesReferences
                                            ._blockIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $ScriptureVerseOccurrencesProcessedTableManager =
    ProcessedTableManager<
      _$ArchiveDatabase,
      ScriptureVerseOccurrences,
      ScriptureVerseOccurrence,
      $ScriptureVerseOccurrencesFilterComposer,
      $ScriptureVerseOccurrencesOrderingComposer,
      $ScriptureVerseOccurrencesAnnotationComposer,
      $ScriptureVerseOccurrencesCreateCompanionBuilder,
      $ScriptureVerseOccurrencesUpdateCompanionBuilder,
      (ScriptureVerseOccurrence, $ScriptureVerseOccurrencesReferences),
      ScriptureVerseOccurrence,
      PrefetchHooks Function({
        bool spanId,
        bool collectionId,
        bool documentId,
        bool blockId,
      })
    >;
typedef $CrossReferencesCreateCompanionBuilder =
    CrossReferencesCompanion Function({
      required String id,
      required String sourceDocumentId,
      Value<String?> sourceBlockId,
      required String targetDocumentId,
      required String relationshipType,
      required String displayText,
      Value<int> verified,
      Value<int> rowid,
    });
typedef $CrossReferencesUpdateCompanionBuilder =
    CrossReferencesCompanion Function({
      Value<String> id,
      Value<String> sourceDocumentId,
      Value<String?> sourceBlockId,
      Value<String> targetDocumentId,
      Value<String> relationshipType,
      Value<String> displayText,
      Value<int> verified,
      Value<int> rowid,
    });

final class $CrossReferencesReferences
    extends BaseReferences<_$ArchiveDatabase, CrossReferences, CrossReference> {
  $CrossReferencesReferences(super.$_db, super.$_table, super.$_typedResult);

  static Documents _sourceDocumentIdTable(_$ArchiveDatabase db) => db.documents
      .createAlias('cross_references__source_document_id__documents__id');

  $DocumentsProcessedTableManager get sourceDocumentId {
    final $_column = $_itemColumn<String>('source_document_id')!;

    final manager = $DocumentsTableManager(
      $_db,
      $_db.documents,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sourceDocumentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $CrossReferencesFilterComposer
    extends Composer<_$ArchiveDatabase, CrossReferences> {
  $CrossReferencesFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceBlockId => $composableBuilder(
    column: $table.sourceBlockId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get targetDocumentId => $composableBuilder(
    column: $table.targetDocumentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get relationshipType => $composableBuilder(
    column: $table.relationshipType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayText => $composableBuilder(
    column: $table.displayText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get verified => $composableBuilder(
    column: $table.verified,
    builder: (column) => ColumnFilters(column),
  );

  $DocumentsFilterComposer get sourceDocumentId {
    final $DocumentsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceDocumentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $DocumentsFilterComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $CrossReferencesOrderingComposer
    extends Composer<_$ArchiveDatabase, CrossReferences> {
  $CrossReferencesOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceBlockId => $composableBuilder(
    column: $table.sourceBlockId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get targetDocumentId => $composableBuilder(
    column: $table.targetDocumentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get relationshipType => $composableBuilder(
    column: $table.relationshipType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayText => $composableBuilder(
    column: $table.displayText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get verified => $composableBuilder(
    column: $table.verified,
    builder: (column) => ColumnOrderings(column),
  );

  $DocumentsOrderingComposer get sourceDocumentId {
    final $DocumentsOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceDocumentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $DocumentsOrderingComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $CrossReferencesAnnotationComposer
    extends Composer<_$ArchiveDatabase, CrossReferences> {
  $CrossReferencesAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sourceBlockId => $composableBuilder(
    column: $table.sourceBlockId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get targetDocumentId => $composableBuilder(
    column: $table.targetDocumentId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get relationshipType => $composableBuilder(
    column: $table.relationshipType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get displayText => $composableBuilder(
    column: $table.displayText,
    builder: (column) => column,
  );

  GeneratedColumn<int> get verified =>
      $composableBuilder(column: $table.verified, builder: (column) => column);

  $DocumentsAnnotationComposer get sourceDocumentId {
    final $DocumentsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceDocumentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $DocumentsAnnotationComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $CrossReferencesTableManager
    extends
        RootTableManager<
          _$ArchiveDatabase,
          CrossReferences,
          CrossReference,
          $CrossReferencesFilterComposer,
          $CrossReferencesOrderingComposer,
          $CrossReferencesAnnotationComposer,
          $CrossReferencesCreateCompanionBuilder,
          $CrossReferencesUpdateCompanionBuilder,
          (CrossReference, $CrossReferencesReferences),
          CrossReference,
          PrefetchHooks Function({bool sourceDocumentId})
        > {
  $CrossReferencesTableManager(_$ArchiveDatabase db, CrossReferences table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $CrossReferencesFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $CrossReferencesOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $CrossReferencesAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> sourceDocumentId = const Value.absent(),
                Value<String?> sourceBlockId = const Value.absent(),
                Value<String> targetDocumentId = const Value.absent(),
                Value<String> relationshipType = const Value.absent(),
                Value<String> displayText = const Value.absent(),
                Value<int> verified = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CrossReferencesCompanion(
                id: id,
                sourceDocumentId: sourceDocumentId,
                sourceBlockId: sourceBlockId,
                targetDocumentId: targetDocumentId,
                relationshipType: relationshipType,
                displayText: displayText,
                verified: verified,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String sourceDocumentId,
                Value<String?> sourceBlockId = const Value.absent(),
                required String targetDocumentId,
                required String relationshipType,
                required String displayText,
                Value<int> verified = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CrossReferencesCompanion.insert(
                id: id,
                sourceDocumentId: sourceDocumentId,
                sourceBlockId: sourceBlockId,
                targetDocumentId: targetDocumentId,
                relationshipType: relationshipType,
                displayText: displayText,
                verified: verified,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $CrossReferencesReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sourceDocumentId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (sourceDocumentId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.sourceDocumentId,
                                referencedTable: $CrossReferencesReferences
                                    ._sourceDocumentIdTable(db),
                                referencedColumn: $CrossReferencesReferences
                                    ._sourceDocumentIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $CrossReferencesProcessedTableManager =
    ProcessedTableManager<
      _$ArchiveDatabase,
      CrossReferences,
      CrossReference,
      $CrossReferencesFilterComposer,
      $CrossReferencesOrderingComposer,
      $CrossReferencesAnnotationComposer,
      $CrossReferencesCreateCompanionBuilder,
      $CrossReferencesUpdateCompanionBuilder,
      (CrossReference, $CrossReferencesReferences),
      CrossReference,
      PrefetchHooks Function({bool sourceDocumentId})
    >;
typedef $TimelineEntriesCreateCompanionBuilder =
    TimelineEntriesCompanion Function({
      required String id,
      required String documentId,
      required String date,
      required String dateType,
      required String displayLabel,
      Value<int> rowid,
    });
typedef $TimelineEntriesUpdateCompanionBuilder =
    TimelineEntriesCompanion Function({
      Value<String> id,
      Value<String> documentId,
      Value<String> date,
      Value<String> dateType,
      Value<String> displayLabel,
      Value<int> rowid,
    });

final class $TimelineEntriesReferences
    extends BaseReferences<_$ArchiveDatabase, TimelineEntries, TimelineEntry> {
  $TimelineEntriesReferences(super.$_db, super.$_table, super.$_typedResult);

  static Documents _documentIdTable(_$ArchiveDatabase db) =>
      db.documents.createAlias('timeline_entries__document_id__documents__id');

  $DocumentsProcessedTableManager get documentId {
    final $_column = $_itemColumn<String>('document_id')!;

    final manager = $DocumentsTableManager(
      $_db,
      $_db.documents,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_documentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $TimelineEntriesFilterComposer
    extends Composer<_$ArchiveDatabase, TimelineEntries> {
  $TimelineEntriesFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dateType => $composableBuilder(
    column: $table.dateType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayLabel => $composableBuilder(
    column: $table.displayLabel,
    builder: (column) => ColumnFilters(column),
  );

  $DocumentsFilterComposer get documentId {
    final $DocumentsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $DocumentsFilterComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $TimelineEntriesOrderingComposer
    extends Composer<_$ArchiveDatabase, TimelineEntries> {
  $TimelineEntriesOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dateType => $composableBuilder(
    column: $table.dateType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayLabel => $composableBuilder(
    column: $table.displayLabel,
    builder: (column) => ColumnOrderings(column),
  );

  $DocumentsOrderingComposer get documentId {
    final $DocumentsOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $DocumentsOrderingComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $TimelineEntriesAnnotationComposer
    extends Composer<_$ArchiveDatabase, TimelineEntries> {
  $TimelineEntriesAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get dateType =>
      $composableBuilder(column: $table.dateType, builder: (column) => column);

  GeneratedColumn<String> get displayLabel => $composableBuilder(
    column: $table.displayLabel,
    builder: (column) => column,
  );

  $DocumentsAnnotationComposer get documentId {
    final $DocumentsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $DocumentsAnnotationComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $TimelineEntriesTableManager
    extends
        RootTableManager<
          _$ArchiveDatabase,
          TimelineEntries,
          TimelineEntry,
          $TimelineEntriesFilterComposer,
          $TimelineEntriesOrderingComposer,
          $TimelineEntriesAnnotationComposer,
          $TimelineEntriesCreateCompanionBuilder,
          $TimelineEntriesUpdateCompanionBuilder,
          (TimelineEntry, $TimelineEntriesReferences),
          TimelineEntry,
          PrefetchHooks Function({bool documentId})
        > {
  $TimelineEntriesTableManager(_$ArchiveDatabase db, TimelineEntries table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $TimelineEntriesFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $TimelineEntriesOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $TimelineEntriesAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> documentId = const Value.absent(),
                Value<String> date = const Value.absent(),
                Value<String> dateType = const Value.absent(),
                Value<String> displayLabel = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TimelineEntriesCompanion(
                id: id,
                documentId: documentId,
                date: date,
                dateType: dateType,
                displayLabel: displayLabel,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String documentId,
                required String date,
                required String dateType,
                required String displayLabel,
                Value<int> rowid = const Value.absent(),
              }) => TimelineEntriesCompanion.insert(
                id: id,
                documentId: documentId,
                date: date,
                dateType: dateType,
                displayLabel: displayLabel,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $TimelineEntriesReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({documentId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (documentId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.documentId,
                                referencedTable: $TimelineEntriesReferences
                                    ._documentIdTable(db),
                                referencedColumn: $TimelineEntriesReferences
                                    ._documentIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $TimelineEntriesProcessedTableManager =
    ProcessedTableManager<
      _$ArchiveDatabase,
      TimelineEntries,
      TimelineEntry,
      $TimelineEntriesFilterComposer,
      $TimelineEntriesOrderingComposer,
      $TimelineEntriesAnnotationComposer,
      $TimelineEntriesCreateCompanionBuilder,
      $TimelineEntriesUpdateCompanionBuilder,
      (TimelineEntry, $TimelineEntriesReferences),
      TimelineEntry,
      PrefetchHooks Function({bool documentId})
    >;
typedef $SearchIndexCreateCompanionBuilder =
    SearchIndexCompanion Function({
      required String collectionId,
      required String collectionName,
      required String documentId,
      required String documentTitle,
      required String blockId,
      required String blockLabel,
      required String body,
      Value<int> rowid,
    });
typedef $SearchIndexUpdateCompanionBuilder =
    SearchIndexCompanion Function({
      Value<String> collectionId,
      Value<String> collectionName,
      Value<String> documentId,
      Value<String> documentTitle,
      Value<String> blockId,
      Value<String> blockLabel,
      Value<String> body,
      Value<int> rowid,
    });

class $SearchIndexFilterComposer
    extends Composer<_$ArchiveDatabase, SearchIndex> {
  $SearchIndexFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get collectionId => $composableBuilder(
    column: $table.collectionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get collectionName => $composableBuilder(
    column: $table.collectionName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get documentId => $composableBuilder(
    column: $table.documentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get documentTitle => $composableBuilder(
    column: $table.documentTitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get blockId => $composableBuilder(
    column: $table.blockId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get blockLabel => $composableBuilder(
    column: $table.blockLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnFilters(column),
  );
}

class $SearchIndexOrderingComposer
    extends Composer<_$ArchiveDatabase, SearchIndex> {
  $SearchIndexOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get collectionId => $composableBuilder(
    column: $table.collectionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get collectionName => $composableBuilder(
    column: $table.collectionName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get documentId => $composableBuilder(
    column: $table.documentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get documentTitle => $composableBuilder(
    column: $table.documentTitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get blockId => $composableBuilder(
    column: $table.blockId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get blockLabel => $composableBuilder(
    column: $table.blockLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnOrderings(column),
  );
}

class $SearchIndexAnnotationComposer
    extends Composer<_$ArchiveDatabase, SearchIndex> {
  $SearchIndexAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get collectionId => $composableBuilder(
    column: $table.collectionId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get collectionName => $composableBuilder(
    column: $table.collectionName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get documentId => $composableBuilder(
    column: $table.documentId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get documentTitle => $composableBuilder(
    column: $table.documentTitle,
    builder: (column) => column,
  );

  GeneratedColumn<String> get blockId =>
      $composableBuilder(column: $table.blockId, builder: (column) => column);

  GeneratedColumn<String> get blockLabel => $composableBuilder(
    column: $table.blockLabel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);
}

class $SearchIndexTableManager
    extends
        RootTableManager<
          _$ArchiveDatabase,
          SearchIndex,
          SearchIndexData,
          $SearchIndexFilterComposer,
          $SearchIndexOrderingComposer,
          $SearchIndexAnnotationComposer,
          $SearchIndexCreateCompanionBuilder,
          $SearchIndexUpdateCompanionBuilder,
          (
            SearchIndexData,
            BaseReferences<_$ArchiveDatabase, SearchIndex, SearchIndexData>,
          ),
          SearchIndexData,
          PrefetchHooks Function()
        > {
  $SearchIndexTableManager(_$ArchiveDatabase db, SearchIndex table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $SearchIndexFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $SearchIndexOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $SearchIndexAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> collectionId = const Value.absent(),
                Value<String> collectionName = const Value.absent(),
                Value<String> documentId = const Value.absent(),
                Value<String> documentTitle = const Value.absent(),
                Value<String> blockId = const Value.absent(),
                Value<String> blockLabel = const Value.absent(),
                Value<String> body = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SearchIndexCompanion(
                collectionId: collectionId,
                collectionName: collectionName,
                documentId: documentId,
                documentTitle: documentTitle,
                blockId: blockId,
                blockLabel: blockLabel,
                body: body,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String collectionId,
                required String collectionName,
                required String documentId,
                required String documentTitle,
                required String blockId,
                required String blockLabel,
                required String body,
                Value<int> rowid = const Value.absent(),
              }) => SearchIndexCompanion.insert(
                collectionId: collectionId,
                collectionName: collectionName,
                documentId: documentId,
                documentTitle: documentTitle,
                blockId: blockId,
                blockLabel: blockLabel,
                body: body,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $SearchIndexProcessedTableManager =
    ProcessedTableManager<
      _$ArchiveDatabase,
      SearchIndex,
      SearchIndexData,
      $SearchIndexFilterComposer,
      $SearchIndexOrderingComposer,
      $SearchIndexAnnotationComposer,
      $SearchIndexCreateCompanionBuilder,
      $SearchIndexUpdateCompanionBuilder,
      (
        SearchIndexData,
        BaseReferences<_$ArchiveDatabase, SearchIndex, SearchIndexData>,
      ),
      SearchIndexData,
      PrefetchHooks Function()
    >;

class $ArchiveDatabaseManager {
  final _$ArchiveDatabase _db;
  $ArchiveDatabaseManager(this._db);
  $ArchiveCollectionsTableManager get archiveCollections =>
      $ArchiveCollectionsTableManager(_db, _db.archiveCollections);
  $DocumentsTableManager get documents =>
      $DocumentsTableManager(_db, _db.documents);
  $DocumentBlocksTableManager get documentBlocks =>
      $DocumentBlocksTableManager(_db, _db.documentBlocks);
  $DocumentFilesTableManager get documentFiles =>
      $DocumentFilesTableManager(_db, _db.documentFiles);
  $BibleVersesTableManager get bibleVerses =>
      $BibleVersesTableManager(_db, _db.bibleVerses);
  $TopicsTableManager get topics => $TopicsTableManager(_db, _db.topics);
  $DocumentTopicsTableManager get documentTopics =>
      $DocumentTopicsTableManager(_db, _db.documentTopics);
  $ScriptureReferencesTableManager get scriptureReferences =>
      $ScriptureReferencesTableManager(_db, _db.scriptureReferences);
  $ScriptureReferenceSpansTableManager get scriptureReferenceSpans =>
      $ScriptureReferenceSpansTableManager(_db, _db.scriptureReferenceSpans);
  $ScriptureReferenceSegmentsTableManager get scriptureReferenceSegments =>
      $ScriptureReferenceSegmentsTableManager(
        _db,
        _db.scriptureReferenceSegments,
      );
  $ScriptureVerseOccurrencesTableManager get scriptureVerseOccurrences =>
      $ScriptureVerseOccurrencesTableManager(
        _db,
        _db.scriptureVerseOccurrences,
      );
  $CrossReferencesTableManager get crossReferences =>
      $CrossReferencesTableManager(_db, _db.crossReferences);
  $TimelineEntriesTableManager get timelineEntries =>
      $TimelineEntriesTableManager(_db, _db.timelineEntries);
  $SearchIndexTableManager get searchIndex =>
      $SearchIndexTableManager(_db, _db.searchIndex);
}

class CatalogueCache extends Table
    with TableInfo<CatalogueCache, CatalogueCacheData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  CatalogueCache(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL PRIMARY KEY CHECK (id = 1)',
  );
  static const VerificationMeta _catalogueJsonMeta = const VerificationMeta(
    'catalogueJson',
  );
  late final GeneratedColumn<String> catalogueJson = GeneratedColumn<String>(
    'catalogue_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _etagMeta = const VerificationMeta('etag');
  late final GeneratedColumn<String> etag = GeneratedColumn<String>(
    'etag',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _fetchedAtMeta = const VerificationMeta(
    'fetchedAt',
  );
  late final GeneratedColumn<String> fetchedAt = GeneratedColumn<String>(
    'fetched_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [id, catalogueJson, etag, fetchedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'catalogue_cache';
  @override
  VerificationContext validateIntegrity(
    Insertable<CatalogueCacheData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('catalogue_json')) {
      context.handle(
        _catalogueJsonMeta,
        catalogueJson.isAcceptableOrUnknown(
          data['catalogue_json']!,
          _catalogueJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_catalogueJsonMeta);
    }
    if (data.containsKey('etag')) {
      context.handle(
        _etagMeta,
        etag.isAcceptableOrUnknown(data['etag']!, _etagMeta),
      );
    }
    if (data.containsKey('fetched_at')) {
      context.handle(
        _fetchedAtMeta,
        fetchedAt.isAcceptableOrUnknown(data['fetched_at']!, _fetchedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_fetchedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CatalogueCacheData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CatalogueCacheData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      catalogueJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}catalogue_json'],
      )!,
      etag: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}etag'],
      ),
      fetchedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fetched_at'],
      )!,
    );
  }

  @override
  CatalogueCache createAlias(String alias) {
    return CatalogueCache(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class CatalogueCacheData extends DataClass
    implements Insertable<CatalogueCacheData> {
  final int id;
  final String catalogueJson;
  final String? etag;
  final String fetchedAt;
  const CatalogueCacheData({
    required this.id,
    required this.catalogueJson,
    this.etag,
    required this.fetchedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['catalogue_json'] = Variable<String>(catalogueJson);
    if (!nullToAbsent || etag != null) {
      map['etag'] = Variable<String>(etag);
    }
    map['fetched_at'] = Variable<String>(fetchedAt);
    return map;
  }

  CatalogueCacheCompanion toCompanion(bool nullToAbsent) {
    return CatalogueCacheCompanion(
      id: Value(id),
      catalogueJson: Value(catalogueJson),
      etag: etag == null && nullToAbsent ? const Value.absent() : Value(etag),
      fetchedAt: Value(fetchedAt),
    );
  }

  factory CatalogueCacheData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CatalogueCacheData(
      id: serializer.fromJson<int>(json['id']),
      catalogueJson: serializer.fromJson<String>(json['catalogue_json']),
      etag: serializer.fromJson<String?>(json['etag']),
      fetchedAt: serializer.fromJson<String>(json['fetched_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'catalogue_json': serializer.toJson<String>(catalogueJson),
      'etag': serializer.toJson<String?>(etag),
      'fetched_at': serializer.toJson<String>(fetchedAt),
    };
  }

  CatalogueCacheData copyWith({
    int? id,
    String? catalogueJson,
    Value<String?> etag = const Value.absent(),
    String? fetchedAt,
  }) => CatalogueCacheData(
    id: id ?? this.id,
    catalogueJson: catalogueJson ?? this.catalogueJson,
    etag: etag.present ? etag.value : this.etag,
    fetchedAt: fetchedAt ?? this.fetchedAt,
  );
  CatalogueCacheData copyWithCompanion(CatalogueCacheCompanion data) {
    return CatalogueCacheData(
      id: data.id.present ? data.id.value : this.id,
      catalogueJson: data.catalogueJson.present
          ? data.catalogueJson.value
          : this.catalogueJson,
      etag: data.etag.present ? data.etag.value : this.etag,
      fetchedAt: data.fetchedAt.present ? data.fetchedAt.value : this.fetchedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CatalogueCacheData(')
          ..write('id: $id, ')
          ..write('catalogueJson: $catalogueJson, ')
          ..write('etag: $etag, ')
          ..write('fetchedAt: $fetchedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, catalogueJson, etag, fetchedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CatalogueCacheData &&
          other.id == this.id &&
          other.catalogueJson == this.catalogueJson &&
          other.etag == this.etag &&
          other.fetchedAt == this.fetchedAt);
}

class CatalogueCacheCompanion extends UpdateCompanion<CatalogueCacheData> {
  final Value<int> id;
  final Value<String> catalogueJson;
  final Value<String?> etag;
  final Value<String> fetchedAt;
  const CatalogueCacheCompanion({
    this.id = const Value.absent(),
    this.catalogueJson = const Value.absent(),
    this.etag = const Value.absent(),
    this.fetchedAt = const Value.absent(),
  });
  CatalogueCacheCompanion.insert({
    this.id = const Value.absent(),
    required String catalogueJson,
    this.etag = const Value.absent(),
    required String fetchedAt,
  }) : catalogueJson = Value(catalogueJson),
       fetchedAt = Value(fetchedAt);
  static Insertable<CatalogueCacheData> custom({
    Expression<int>? id,
    Expression<String>? catalogueJson,
    Expression<String>? etag,
    Expression<String>? fetchedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (catalogueJson != null) 'catalogue_json': catalogueJson,
      if (etag != null) 'etag': etag,
      if (fetchedAt != null) 'fetched_at': fetchedAt,
    });
  }

  CatalogueCacheCompanion copyWith({
    Value<int>? id,
    Value<String>? catalogueJson,
    Value<String?>? etag,
    Value<String>? fetchedAt,
  }) {
    return CatalogueCacheCompanion(
      id: id ?? this.id,
      catalogueJson: catalogueJson ?? this.catalogueJson,
      etag: etag ?? this.etag,
      fetchedAt: fetchedAt ?? this.fetchedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (catalogueJson.present) {
      map['catalogue_json'] = Variable<String>(catalogueJson.value);
    }
    if (etag.present) {
      map['etag'] = Variable<String>(etag.value);
    }
    if (fetchedAt.present) {
      map['fetched_at'] = Variable<String>(fetchedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CatalogueCacheCompanion(')
          ..write('id: $id, ')
          ..write('catalogueJson: $catalogueJson, ')
          ..write('etag: $etag, ')
          ..write('fetchedAt: $fetchedAt')
          ..write(')'))
        .toString();
  }
}

class DownloadedCollections extends Table
    with TableInfo<DownloadedCollections, DownloadedCollection> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  DownloadedCollections(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _collectionIdMeta = const VerificationMeta(
    'collectionId',
  );
  late final GeneratedColumn<String> collectionId = GeneratedColumn<String>(
    'collection_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _contentVersionMeta = const VerificationMeta(
    'contentVersion',
  );
  late final GeneratedColumn<int> contentVersion = GeneratedColumn<int>(
    'content_version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _stateMeta = const VerificationMeta('state');
  late final GeneratedColumn<String> state = GeneratedColumn<String>(
    'state',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _downloadedBytesMeta = const VerificationMeta(
    'downloadedBytes',
  );
  late final GeneratedColumn<int> downloadedBytes = GeneratedColumn<int>(
    'downloaded_bytes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT 0',
    defaultValue: const CustomExpression('0'),
  );
  static const VerificationMeta _totalBytesMeta = const VerificationMeta(
    'totalBytes',
  );
  late final GeneratedColumn<int> totalBytes = GeneratedColumn<int>(
    'total_bytes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT 0',
    defaultValue: const CustomExpression('0'),
  );
  static const VerificationMeta _errorMessageMeta = const VerificationMeta(
    'errorMessage',
  );
  late final GeneratedColumn<String> errorMessage = GeneratedColumn<String>(
    'error_message',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _installedAtMeta = const VerificationMeta(
    'installedAt',
  );
  late final GeneratedColumn<String> installedAt = GeneratedColumn<String>(
    'installed_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  @override
  List<GeneratedColumn> get $columns => [
    collectionId,
    contentVersion,
    state,
    downloadedBytes,
    totalBytes,
    errorMessage,
    installedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'downloaded_collections';
  @override
  VerificationContext validateIntegrity(
    Insertable<DownloadedCollection> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('collection_id')) {
      context.handle(
        _collectionIdMeta,
        collectionId.isAcceptableOrUnknown(
          data['collection_id']!,
          _collectionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_collectionIdMeta);
    }
    if (data.containsKey('content_version')) {
      context.handle(
        _contentVersionMeta,
        contentVersion.isAcceptableOrUnknown(
          data['content_version']!,
          _contentVersionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contentVersionMeta);
    }
    if (data.containsKey('state')) {
      context.handle(
        _stateMeta,
        state.isAcceptableOrUnknown(data['state']!, _stateMeta),
      );
    } else if (isInserting) {
      context.missing(_stateMeta);
    }
    if (data.containsKey('downloaded_bytes')) {
      context.handle(
        _downloadedBytesMeta,
        downloadedBytes.isAcceptableOrUnknown(
          data['downloaded_bytes']!,
          _downloadedBytesMeta,
        ),
      );
    }
    if (data.containsKey('total_bytes')) {
      context.handle(
        _totalBytesMeta,
        totalBytes.isAcceptableOrUnknown(data['total_bytes']!, _totalBytesMeta),
      );
    }
    if (data.containsKey('error_message')) {
      context.handle(
        _errorMessageMeta,
        errorMessage.isAcceptableOrUnknown(
          data['error_message']!,
          _errorMessageMeta,
        ),
      );
    }
    if (data.containsKey('installed_at')) {
      context.handle(
        _installedAtMeta,
        installedAt.isAcceptableOrUnknown(
          data['installed_at']!,
          _installedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {collectionId};
  @override
  DownloadedCollection map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DownloadedCollection(
      collectionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}collection_id'],
      )!,
      contentVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}content_version'],
      )!,
      state: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}state'],
      )!,
      downloadedBytes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}downloaded_bytes'],
      )!,
      totalBytes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_bytes'],
      )!,
      errorMessage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}error_message'],
      ),
      installedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}installed_at'],
      ),
    );
  }

  @override
  DownloadedCollections createAlias(String alias) {
    return DownloadedCollections(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class DownloadedCollection extends DataClass
    implements Insertable<DownloadedCollection> {
  final String collectionId;
  final int contentVersion;
  final String state;
  final int downloadedBytes;
  final int totalBytes;
  final String? errorMessage;
  final String? installedAt;
  const DownloadedCollection({
    required this.collectionId,
    required this.contentVersion,
    required this.state,
    required this.downloadedBytes,
    required this.totalBytes,
    this.errorMessage,
    this.installedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['collection_id'] = Variable<String>(collectionId);
    map['content_version'] = Variable<int>(contentVersion);
    map['state'] = Variable<String>(state);
    map['downloaded_bytes'] = Variable<int>(downloadedBytes);
    map['total_bytes'] = Variable<int>(totalBytes);
    if (!nullToAbsent || errorMessage != null) {
      map['error_message'] = Variable<String>(errorMessage);
    }
    if (!nullToAbsent || installedAt != null) {
      map['installed_at'] = Variable<String>(installedAt);
    }
    return map;
  }

  DownloadedCollectionsCompanion toCompanion(bool nullToAbsent) {
    return DownloadedCollectionsCompanion(
      collectionId: Value(collectionId),
      contentVersion: Value(contentVersion),
      state: Value(state),
      downloadedBytes: Value(downloadedBytes),
      totalBytes: Value(totalBytes),
      errorMessage: errorMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(errorMessage),
      installedAt: installedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(installedAt),
    );
  }

  factory DownloadedCollection.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DownloadedCollection(
      collectionId: serializer.fromJson<String>(json['collection_id']),
      contentVersion: serializer.fromJson<int>(json['content_version']),
      state: serializer.fromJson<String>(json['state']),
      downloadedBytes: serializer.fromJson<int>(json['downloaded_bytes']),
      totalBytes: serializer.fromJson<int>(json['total_bytes']),
      errorMessage: serializer.fromJson<String?>(json['error_message']),
      installedAt: serializer.fromJson<String?>(json['installed_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'collection_id': serializer.toJson<String>(collectionId),
      'content_version': serializer.toJson<int>(contentVersion),
      'state': serializer.toJson<String>(state),
      'downloaded_bytes': serializer.toJson<int>(downloadedBytes),
      'total_bytes': serializer.toJson<int>(totalBytes),
      'error_message': serializer.toJson<String?>(errorMessage),
      'installed_at': serializer.toJson<String?>(installedAt),
    };
  }

  DownloadedCollection copyWith({
    String? collectionId,
    int? contentVersion,
    String? state,
    int? downloadedBytes,
    int? totalBytes,
    Value<String?> errorMessage = const Value.absent(),
    Value<String?> installedAt = const Value.absent(),
  }) => DownloadedCollection(
    collectionId: collectionId ?? this.collectionId,
    contentVersion: contentVersion ?? this.contentVersion,
    state: state ?? this.state,
    downloadedBytes: downloadedBytes ?? this.downloadedBytes,
    totalBytes: totalBytes ?? this.totalBytes,
    errorMessage: errorMessage.present ? errorMessage.value : this.errorMessage,
    installedAt: installedAt.present ? installedAt.value : this.installedAt,
  );
  DownloadedCollection copyWithCompanion(DownloadedCollectionsCompanion data) {
    return DownloadedCollection(
      collectionId: data.collectionId.present
          ? data.collectionId.value
          : this.collectionId,
      contentVersion: data.contentVersion.present
          ? data.contentVersion.value
          : this.contentVersion,
      state: data.state.present ? data.state.value : this.state,
      downloadedBytes: data.downloadedBytes.present
          ? data.downloadedBytes.value
          : this.downloadedBytes,
      totalBytes: data.totalBytes.present
          ? data.totalBytes.value
          : this.totalBytes,
      errorMessage: data.errorMessage.present
          ? data.errorMessage.value
          : this.errorMessage,
      installedAt: data.installedAt.present
          ? data.installedAt.value
          : this.installedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DownloadedCollection(')
          ..write('collectionId: $collectionId, ')
          ..write('contentVersion: $contentVersion, ')
          ..write('state: $state, ')
          ..write('downloadedBytes: $downloadedBytes, ')
          ..write('totalBytes: $totalBytes, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('installedAt: $installedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    collectionId,
    contentVersion,
    state,
    downloadedBytes,
    totalBytes,
    errorMessage,
    installedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DownloadedCollection &&
          other.collectionId == this.collectionId &&
          other.contentVersion == this.contentVersion &&
          other.state == this.state &&
          other.downloadedBytes == this.downloadedBytes &&
          other.totalBytes == this.totalBytes &&
          other.errorMessage == this.errorMessage &&
          other.installedAt == this.installedAt);
}

class DownloadedCollectionsCompanion
    extends UpdateCompanion<DownloadedCollection> {
  final Value<String> collectionId;
  final Value<int> contentVersion;
  final Value<String> state;
  final Value<int> downloadedBytes;
  final Value<int> totalBytes;
  final Value<String?> errorMessage;
  final Value<String?> installedAt;
  final Value<int> rowid;
  const DownloadedCollectionsCompanion({
    this.collectionId = const Value.absent(),
    this.contentVersion = const Value.absent(),
    this.state = const Value.absent(),
    this.downloadedBytes = const Value.absent(),
    this.totalBytes = const Value.absent(),
    this.errorMessage = const Value.absent(),
    this.installedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DownloadedCollectionsCompanion.insert({
    required String collectionId,
    required int contentVersion,
    required String state,
    this.downloadedBytes = const Value.absent(),
    this.totalBytes = const Value.absent(),
    this.errorMessage = const Value.absent(),
    this.installedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : collectionId = Value(collectionId),
       contentVersion = Value(contentVersion),
       state = Value(state);
  static Insertable<DownloadedCollection> custom({
    Expression<String>? collectionId,
    Expression<int>? contentVersion,
    Expression<String>? state,
    Expression<int>? downloadedBytes,
    Expression<int>? totalBytes,
    Expression<String>? errorMessage,
    Expression<String>? installedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (collectionId != null) 'collection_id': collectionId,
      if (contentVersion != null) 'content_version': contentVersion,
      if (state != null) 'state': state,
      if (downloadedBytes != null) 'downloaded_bytes': downloadedBytes,
      if (totalBytes != null) 'total_bytes': totalBytes,
      if (errorMessage != null) 'error_message': errorMessage,
      if (installedAt != null) 'installed_at': installedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DownloadedCollectionsCompanion copyWith({
    Value<String>? collectionId,
    Value<int>? contentVersion,
    Value<String>? state,
    Value<int>? downloadedBytes,
    Value<int>? totalBytes,
    Value<String?>? errorMessage,
    Value<String?>? installedAt,
    Value<int>? rowid,
  }) {
    return DownloadedCollectionsCompanion(
      collectionId: collectionId ?? this.collectionId,
      contentVersion: contentVersion ?? this.contentVersion,
      state: state ?? this.state,
      downloadedBytes: downloadedBytes ?? this.downloadedBytes,
      totalBytes: totalBytes ?? this.totalBytes,
      errorMessage: errorMessage ?? this.errorMessage,
      installedAt: installedAt ?? this.installedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (collectionId.present) {
      map['collection_id'] = Variable<String>(collectionId.value);
    }
    if (contentVersion.present) {
      map['content_version'] = Variable<int>(contentVersion.value);
    }
    if (state.present) {
      map['state'] = Variable<String>(state.value);
    }
    if (downloadedBytes.present) {
      map['downloaded_bytes'] = Variable<int>(downloadedBytes.value);
    }
    if (totalBytes.present) {
      map['total_bytes'] = Variable<int>(totalBytes.value);
    }
    if (errorMessage.present) {
      map['error_message'] = Variable<String>(errorMessage.value);
    }
    if (installedAt.present) {
      map['installed_at'] = Variable<String>(installedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DownloadedCollectionsCompanion(')
          ..write('collectionId: $collectionId, ')
          ..write('contentVersion: $contentVersion, ')
          ..write('state: $state, ')
          ..write('downloadedBytes: $downloadedBytes, ')
          ..write('totalBytes: $totalBytes, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('installedAt: $installedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class DownloadedAssets extends Table
    with TableInfo<DownloadedAssets, DownloadedAsset> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  DownloadedAssets(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _assetIdMeta = const VerificationMeta(
    'assetId',
  );
  late final GeneratedColumn<String> assetId = GeneratedColumn<String>(
    'asset_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _documentIdMeta = const VerificationMeta(
    'documentId',
  );
  late final GeneratedColumn<String> documentId = GeneratedColumn<String>(
    'document_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _fileTypeMeta = const VerificationMeta(
    'fileType',
  );
  late final GeneratedColumn<String> fileType = GeneratedColumn<String>(
    'file_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _localPathMeta = const VerificationMeta(
    'localPath',
  );
  late final GeneratedColumn<String> localPath = GeneratedColumn<String>(
    'local_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _fileSizeMeta = const VerificationMeta(
    'fileSize',
  );
  late final GeneratedColumn<int> fileSize = GeneratedColumn<int>(
    'file_size',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _sha256Meta = const VerificationMeta('sha256');
  late final GeneratedColumn<String> sha256 = GeneratedColumn<String>(
    'sha256',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _installedAtMeta = const VerificationMeta(
    'installedAt',
  );
  late final GeneratedColumn<String> installedAt = GeneratedColumn<String>(
    'installed_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [
    assetId,
    documentId,
    fileType,
    localPath,
    fileSize,
    sha256,
    version,
    installedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'downloaded_assets';
  @override
  VerificationContext validateIntegrity(
    Insertable<DownloadedAsset> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('asset_id')) {
      context.handle(
        _assetIdMeta,
        assetId.isAcceptableOrUnknown(data['asset_id']!, _assetIdMeta),
      );
    } else if (isInserting) {
      context.missing(_assetIdMeta);
    }
    if (data.containsKey('document_id')) {
      context.handle(
        _documentIdMeta,
        documentId.isAcceptableOrUnknown(data['document_id']!, _documentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_documentIdMeta);
    }
    if (data.containsKey('file_type')) {
      context.handle(
        _fileTypeMeta,
        fileType.isAcceptableOrUnknown(data['file_type']!, _fileTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_fileTypeMeta);
    }
    if (data.containsKey('local_path')) {
      context.handle(
        _localPathMeta,
        localPath.isAcceptableOrUnknown(data['local_path']!, _localPathMeta),
      );
    } else if (isInserting) {
      context.missing(_localPathMeta);
    }
    if (data.containsKey('file_size')) {
      context.handle(
        _fileSizeMeta,
        fileSize.isAcceptableOrUnknown(data['file_size']!, _fileSizeMeta),
      );
    } else if (isInserting) {
      context.missing(_fileSizeMeta);
    }
    if (data.containsKey('sha256')) {
      context.handle(
        _sha256Meta,
        sha256.isAcceptableOrUnknown(data['sha256']!, _sha256Meta),
      );
    } else if (isInserting) {
      context.missing(_sha256Meta);
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    } else if (isInserting) {
      context.missing(_versionMeta);
    }
    if (data.containsKey('installed_at')) {
      context.handle(
        _installedAtMeta,
        installedAt.isAcceptableOrUnknown(
          data['installed_at']!,
          _installedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_installedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {assetId};
  @override
  DownloadedAsset map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DownloadedAsset(
      assetId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}asset_id'],
      )!,
      documentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}document_id'],
      )!,
      fileType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_type'],
      )!,
      localPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_path'],
      )!,
      fileSize: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}file_size'],
      )!,
      sha256: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sha256'],
      )!,
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      installedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}installed_at'],
      )!,
    );
  }

  @override
  DownloadedAssets createAlias(String alias) {
    return DownloadedAssets(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class DownloadedAsset extends DataClass implements Insertable<DownloadedAsset> {
  final String assetId;
  final String documentId;
  final String fileType;
  final String localPath;
  final int fileSize;
  final String sha256;
  final int version;
  final String installedAt;
  const DownloadedAsset({
    required this.assetId,
    required this.documentId,
    required this.fileType,
    required this.localPath,
    required this.fileSize,
    required this.sha256,
    required this.version,
    required this.installedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['asset_id'] = Variable<String>(assetId);
    map['document_id'] = Variable<String>(documentId);
    map['file_type'] = Variable<String>(fileType);
    map['local_path'] = Variable<String>(localPath);
    map['file_size'] = Variable<int>(fileSize);
    map['sha256'] = Variable<String>(sha256);
    map['version'] = Variable<int>(version);
    map['installed_at'] = Variable<String>(installedAt);
    return map;
  }

  DownloadedAssetsCompanion toCompanion(bool nullToAbsent) {
    return DownloadedAssetsCompanion(
      assetId: Value(assetId),
      documentId: Value(documentId),
      fileType: Value(fileType),
      localPath: Value(localPath),
      fileSize: Value(fileSize),
      sha256: Value(sha256),
      version: Value(version),
      installedAt: Value(installedAt),
    );
  }

  factory DownloadedAsset.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DownloadedAsset(
      assetId: serializer.fromJson<String>(json['asset_id']),
      documentId: serializer.fromJson<String>(json['document_id']),
      fileType: serializer.fromJson<String>(json['file_type']),
      localPath: serializer.fromJson<String>(json['local_path']),
      fileSize: serializer.fromJson<int>(json['file_size']),
      sha256: serializer.fromJson<String>(json['sha256']),
      version: serializer.fromJson<int>(json['version']),
      installedAt: serializer.fromJson<String>(json['installed_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'asset_id': serializer.toJson<String>(assetId),
      'document_id': serializer.toJson<String>(documentId),
      'file_type': serializer.toJson<String>(fileType),
      'local_path': serializer.toJson<String>(localPath),
      'file_size': serializer.toJson<int>(fileSize),
      'sha256': serializer.toJson<String>(sha256),
      'version': serializer.toJson<int>(version),
      'installed_at': serializer.toJson<String>(installedAt),
    };
  }

  DownloadedAsset copyWith({
    String? assetId,
    String? documentId,
    String? fileType,
    String? localPath,
    int? fileSize,
    String? sha256,
    int? version,
    String? installedAt,
  }) => DownloadedAsset(
    assetId: assetId ?? this.assetId,
    documentId: documentId ?? this.documentId,
    fileType: fileType ?? this.fileType,
    localPath: localPath ?? this.localPath,
    fileSize: fileSize ?? this.fileSize,
    sha256: sha256 ?? this.sha256,
    version: version ?? this.version,
    installedAt: installedAt ?? this.installedAt,
  );
  DownloadedAsset copyWithCompanion(DownloadedAssetsCompanion data) {
    return DownloadedAsset(
      assetId: data.assetId.present ? data.assetId.value : this.assetId,
      documentId: data.documentId.present
          ? data.documentId.value
          : this.documentId,
      fileType: data.fileType.present ? data.fileType.value : this.fileType,
      localPath: data.localPath.present ? data.localPath.value : this.localPath,
      fileSize: data.fileSize.present ? data.fileSize.value : this.fileSize,
      sha256: data.sha256.present ? data.sha256.value : this.sha256,
      version: data.version.present ? data.version.value : this.version,
      installedAt: data.installedAt.present
          ? data.installedAt.value
          : this.installedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DownloadedAsset(')
          ..write('assetId: $assetId, ')
          ..write('documentId: $documentId, ')
          ..write('fileType: $fileType, ')
          ..write('localPath: $localPath, ')
          ..write('fileSize: $fileSize, ')
          ..write('sha256: $sha256, ')
          ..write('version: $version, ')
          ..write('installedAt: $installedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    assetId,
    documentId,
    fileType,
    localPath,
    fileSize,
    sha256,
    version,
    installedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DownloadedAsset &&
          other.assetId == this.assetId &&
          other.documentId == this.documentId &&
          other.fileType == this.fileType &&
          other.localPath == this.localPath &&
          other.fileSize == this.fileSize &&
          other.sha256 == this.sha256 &&
          other.version == this.version &&
          other.installedAt == this.installedAt);
}

class DownloadedAssetsCompanion extends UpdateCompanion<DownloadedAsset> {
  final Value<String> assetId;
  final Value<String> documentId;
  final Value<String> fileType;
  final Value<String> localPath;
  final Value<int> fileSize;
  final Value<String> sha256;
  final Value<int> version;
  final Value<String> installedAt;
  final Value<int> rowid;
  const DownloadedAssetsCompanion({
    this.assetId = const Value.absent(),
    this.documentId = const Value.absent(),
    this.fileType = const Value.absent(),
    this.localPath = const Value.absent(),
    this.fileSize = const Value.absent(),
    this.sha256 = const Value.absent(),
    this.version = const Value.absent(),
    this.installedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DownloadedAssetsCompanion.insert({
    required String assetId,
    required String documentId,
    required String fileType,
    required String localPath,
    required int fileSize,
    required String sha256,
    required int version,
    required String installedAt,
    this.rowid = const Value.absent(),
  }) : assetId = Value(assetId),
       documentId = Value(documentId),
       fileType = Value(fileType),
       localPath = Value(localPath),
       fileSize = Value(fileSize),
       sha256 = Value(sha256),
       version = Value(version),
       installedAt = Value(installedAt);
  static Insertable<DownloadedAsset> custom({
    Expression<String>? assetId,
    Expression<String>? documentId,
    Expression<String>? fileType,
    Expression<String>? localPath,
    Expression<int>? fileSize,
    Expression<String>? sha256,
    Expression<int>? version,
    Expression<String>? installedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (assetId != null) 'asset_id': assetId,
      if (documentId != null) 'document_id': documentId,
      if (fileType != null) 'file_type': fileType,
      if (localPath != null) 'local_path': localPath,
      if (fileSize != null) 'file_size': fileSize,
      if (sha256 != null) 'sha256': sha256,
      if (version != null) 'version': version,
      if (installedAt != null) 'installed_at': installedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DownloadedAssetsCompanion copyWith({
    Value<String>? assetId,
    Value<String>? documentId,
    Value<String>? fileType,
    Value<String>? localPath,
    Value<int>? fileSize,
    Value<String>? sha256,
    Value<int>? version,
    Value<String>? installedAt,
    Value<int>? rowid,
  }) {
    return DownloadedAssetsCompanion(
      assetId: assetId ?? this.assetId,
      documentId: documentId ?? this.documentId,
      fileType: fileType ?? this.fileType,
      localPath: localPath ?? this.localPath,
      fileSize: fileSize ?? this.fileSize,
      sha256: sha256 ?? this.sha256,
      version: version ?? this.version,
      installedAt: installedAt ?? this.installedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (assetId.present) {
      map['asset_id'] = Variable<String>(assetId.value);
    }
    if (documentId.present) {
      map['document_id'] = Variable<String>(documentId.value);
    }
    if (fileType.present) {
      map['file_type'] = Variable<String>(fileType.value);
    }
    if (localPath.present) {
      map['local_path'] = Variable<String>(localPath.value);
    }
    if (fileSize.present) {
      map['file_size'] = Variable<int>(fileSize.value);
    }
    if (sha256.present) {
      map['sha256'] = Variable<String>(sha256.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (installedAt.present) {
      map['installed_at'] = Variable<String>(installedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DownloadedAssetsCompanion(')
          ..write('assetId: $assetId, ')
          ..write('documentId: $documentId, ')
          ..write('fileType: $fileType, ')
          ..write('localPath: $localPath, ')
          ..write('fileSize: $fileSize, ')
          ..write('sha256: $sha256, ')
          ..write('version: $version, ')
          ..write('installedAt: $installedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class Bookmarks extends Table with TableInfo<Bookmarks, Bookmark> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Bookmarks(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _documentIdMeta = const VerificationMeta(
    'documentId',
  );
  late final GeneratedColumn<String> documentId = GeneratedColumn<String>(
    'document_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _documentTitleMeta = const VerificationMeta(
    'documentTitle',
  );
  late final GeneratedColumn<String> documentTitle = GeneratedColumn<String>(
    'document_title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _blockIdMeta = const VerificationMeta(
    'blockId',
  );
  late final GeneratedColumn<String> blockId = GeneratedColumn<String>(
    'block_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    documentId,
    documentTitle,
    blockId,
    label,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bookmarks';
  @override
  VerificationContext validateIntegrity(
    Insertable<Bookmark> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('document_id')) {
      context.handle(
        _documentIdMeta,
        documentId.isAcceptableOrUnknown(data['document_id']!, _documentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_documentIdMeta);
    }
    if (data.containsKey('document_title')) {
      context.handle(
        _documentTitleMeta,
        documentTitle.isAcceptableOrUnknown(
          data['document_title']!,
          _documentTitleMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_documentTitleMeta);
    }
    if (data.containsKey('block_id')) {
      context.handle(
        _blockIdMeta,
        blockId.isAcceptableOrUnknown(data['block_id']!, _blockIdMeta),
      );
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {documentId, blockId},
  ];
  @override
  Bookmark map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Bookmark(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      documentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}document_id'],
      )!,
      documentTitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}document_title'],
      )!,
      blockId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}block_id'],
      ),
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  Bookmarks createAlias(String alias) {
    return Bookmarks(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const ['UNIQUE(document_id, block_id)'];
  @override
  bool get dontWriteConstraints => true;
}

class Bookmark extends DataClass implements Insertable<Bookmark> {
  final String id;
  final String documentId;
  final String documentTitle;
  final String? blockId;
  final String? label;
  final String createdAt;
  const Bookmark({
    required this.id,
    required this.documentId,
    required this.documentTitle,
    this.blockId,
    this.label,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['document_id'] = Variable<String>(documentId);
    map['document_title'] = Variable<String>(documentTitle);
    if (!nullToAbsent || blockId != null) {
      map['block_id'] = Variable<String>(blockId);
    }
    if (!nullToAbsent || label != null) {
      map['label'] = Variable<String>(label);
    }
    map['created_at'] = Variable<String>(createdAt);
    return map;
  }

  BookmarksCompanion toCompanion(bool nullToAbsent) {
    return BookmarksCompanion(
      id: Value(id),
      documentId: Value(documentId),
      documentTitle: Value(documentTitle),
      blockId: blockId == null && nullToAbsent
          ? const Value.absent()
          : Value(blockId),
      label: label == null && nullToAbsent
          ? const Value.absent()
          : Value(label),
      createdAt: Value(createdAt),
    );
  }

  factory Bookmark.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Bookmark(
      id: serializer.fromJson<String>(json['id']),
      documentId: serializer.fromJson<String>(json['document_id']),
      documentTitle: serializer.fromJson<String>(json['document_title']),
      blockId: serializer.fromJson<String?>(json['block_id']),
      label: serializer.fromJson<String?>(json['label']),
      createdAt: serializer.fromJson<String>(json['created_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'document_id': serializer.toJson<String>(documentId),
      'document_title': serializer.toJson<String>(documentTitle),
      'block_id': serializer.toJson<String?>(blockId),
      'label': serializer.toJson<String?>(label),
      'created_at': serializer.toJson<String>(createdAt),
    };
  }

  Bookmark copyWith({
    String? id,
    String? documentId,
    String? documentTitle,
    Value<String?> blockId = const Value.absent(),
    Value<String?> label = const Value.absent(),
    String? createdAt,
  }) => Bookmark(
    id: id ?? this.id,
    documentId: documentId ?? this.documentId,
    documentTitle: documentTitle ?? this.documentTitle,
    blockId: blockId.present ? blockId.value : this.blockId,
    label: label.present ? label.value : this.label,
    createdAt: createdAt ?? this.createdAt,
  );
  Bookmark copyWithCompanion(BookmarksCompanion data) {
    return Bookmark(
      id: data.id.present ? data.id.value : this.id,
      documentId: data.documentId.present
          ? data.documentId.value
          : this.documentId,
      documentTitle: data.documentTitle.present
          ? data.documentTitle.value
          : this.documentTitle,
      blockId: data.blockId.present ? data.blockId.value : this.blockId,
      label: data.label.present ? data.label.value : this.label,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Bookmark(')
          ..write('id: $id, ')
          ..write('documentId: $documentId, ')
          ..write('documentTitle: $documentTitle, ')
          ..write('blockId: $blockId, ')
          ..write('label: $label, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, documentId, documentTitle, blockId, label, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Bookmark &&
          other.id == this.id &&
          other.documentId == this.documentId &&
          other.documentTitle == this.documentTitle &&
          other.blockId == this.blockId &&
          other.label == this.label &&
          other.createdAt == this.createdAt);
}

class BookmarksCompanion extends UpdateCompanion<Bookmark> {
  final Value<String> id;
  final Value<String> documentId;
  final Value<String> documentTitle;
  final Value<String?> blockId;
  final Value<String?> label;
  final Value<String> createdAt;
  final Value<int> rowid;
  const BookmarksCompanion({
    this.id = const Value.absent(),
    this.documentId = const Value.absent(),
    this.documentTitle = const Value.absent(),
    this.blockId = const Value.absent(),
    this.label = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BookmarksCompanion.insert({
    required String id,
    required String documentId,
    required String documentTitle,
    this.blockId = const Value.absent(),
    this.label = const Value.absent(),
    required String createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       documentId = Value(documentId),
       documentTitle = Value(documentTitle),
       createdAt = Value(createdAt);
  static Insertable<Bookmark> custom({
    Expression<String>? id,
    Expression<String>? documentId,
    Expression<String>? documentTitle,
    Expression<String>? blockId,
    Expression<String>? label,
    Expression<String>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (documentId != null) 'document_id': documentId,
      if (documentTitle != null) 'document_title': documentTitle,
      if (blockId != null) 'block_id': blockId,
      if (label != null) 'label': label,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BookmarksCompanion copyWith({
    Value<String>? id,
    Value<String>? documentId,
    Value<String>? documentTitle,
    Value<String?>? blockId,
    Value<String?>? label,
    Value<String>? createdAt,
    Value<int>? rowid,
  }) {
    return BookmarksCompanion(
      id: id ?? this.id,
      documentId: documentId ?? this.documentId,
      documentTitle: documentTitle ?? this.documentTitle,
      blockId: blockId ?? this.blockId,
      label: label ?? this.label,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (documentId.present) {
      map['document_id'] = Variable<String>(documentId.value);
    }
    if (documentTitle.present) {
      map['document_title'] = Variable<String>(documentTitle.value);
    }
    if (blockId.present) {
      map['block_id'] = Variable<String>(blockId.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BookmarksCompanion(')
          ..write('id: $id, ')
          ..write('documentId: $documentId, ')
          ..write('documentTitle: $documentTitle, ')
          ..write('blockId: $blockId, ')
          ..write('label: $label, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class Highlights extends Table with TableInfo<Highlights, Highlight> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Highlights(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _documentIdMeta = const VerificationMeta(
    'documentId',
  );
  late final GeneratedColumn<String> documentId = GeneratedColumn<String>(
    'document_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _blockIdMeta = const VerificationMeta(
    'blockId',
  );
  late final GeneratedColumn<String> blockId = GeneratedColumn<String>(
    'block_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _startOffsetMeta = const VerificationMeta(
    'startOffset',
  );
  late final GeneratedColumn<int> startOffset = GeneratedColumn<int>(
    'start_offset',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _endOffsetMeta = const VerificationMeta(
    'endOffset',
  );
  late final GeneratedColumn<int> endOffset = GeneratedColumn<int>(
    'end_offset',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _selectedTextMeta = const VerificationMeta(
    'selectedText',
  );
  late final GeneratedColumn<String> selectedText = GeneratedColumn<String>(
    'selected_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _styleMeta = const VerificationMeta('style');
  late final GeneratedColumn<String> style = GeneratedColumn<String>(
    'style',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    documentId,
    blockId,
    startOffset,
    endOffset,
    selectedText,
    style,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'highlights';
  @override
  VerificationContext validateIntegrity(
    Insertable<Highlight> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('document_id')) {
      context.handle(
        _documentIdMeta,
        documentId.isAcceptableOrUnknown(data['document_id']!, _documentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_documentIdMeta);
    }
    if (data.containsKey('block_id')) {
      context.handle(
        _blockIdMeta,
        blockId.isAcceptableOrUnknown(data['block_id']!, _blockIdMeta),
      );
    } else if (isInserting) {
      context.missing(_blockIdMeta);
    }
    if (data.containsKey('start_offset')) {
      context.handle(
        _startOffsetMeta,
        startOffset.isAcceptableOrUnknown(
          data['start_offset']!,
          _startOffsetMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_startOffsetMeta);
    }
    if (data.containsKey('end_offset')) {
      context.handle(
        _endOffsetMeta,
        endOffset.isAcceptableOrUnknown(data['end_offset']!, _endOffsetMeta),
      );
    } else if (isInserting) {
      context.missing(_endOffsetMeta);
    }
    if (data.containsKey('selected_text')) {
      context.handle(
        _selectedTextMeta,
        selectedText.isAcceptableOrUnknown(
          data['selected_text']!,
          _selectedTextMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_selectedTextMeta);
    }
    if (data.containsKey('style')) {
      context.handle(
        _styleMeta,
        style.isAcceptableOrUnknown(data['style']!, _styleMeta),
      );
    } else if (isInserting) {
      context.missing(_styleMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Highlight map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Highlight(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      documentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}document_id'],
      )!,
      blockId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}block_id'],
      )!,
      startOffset: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}start_offset'],
      )!,
      endOffset: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}end_offset'],
      )!,
      selectedText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}selected_text'],
      )!,
      style: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}style'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  Highlights createAlias(String alias) {
    return Highlights(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class Highlight extends DataClass implements Insertable<Highlight> {
  final String id;
  final String documentId;
  final String blockId;
  final int startOffset;
  final int endOffset;
  final String selectedText;
  final String style;
  final String createdAt;
  final String updatedAt;
  const Highlight({
    required this.id,
    required this.documentId,
    required this.blockId,
    required this.startOffset,
    required this.endOffset,
    required this.selectedText,
    required this.style,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['document_id'] = Variable<String>(documentId);
    map['block_id'] = Variable<String>(blockId);
    map['start_offset'] = Variable<int>(startOffset);
    map['end_offset'] = Variable<int>(endOffset);
    map['selected_text'] = Variable<String>(selectedText);
    map['style'] = Variable<String>(style);
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    return map;
  }

  HighlightsCompanion toCompanion(bool nullToAbsent) {
    return HighlightsCompanion(
      id: Value(id),
      documentId: Value(documentId),
      blockId: Value(blockId),
      startOffset: Value(startOffset),
      endOffset: Value(endOffset),
      selectedText: Value(selectedText),
      style: Value(style),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Highlight.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Highlight(
      id: serializer.fromJson<String>(json['id']),
      documentId: serializer.fromJson<String>(json['document_id']),
      blockId: serializer.fromJson<String>(json['block_id']),
      startOffset: serializer.fromJson<int>(json['start_offset']),
      endOffset: serializer.fromJson<int>(json['end_offset']),
      selectedText: serializer.fromJson<String>(json['selected_text']),
      style: serializer.fromJson<String>(json['style']),
      createdAt: serializer.fromJson<String>(json['created_at']),
      updatedAt: serializer.fromJson<String>(json['updated_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'document_id': serializer.toJson<String>(documentId),
      'block_id': serializer.toJson<String>(blockId),
      'start_offset': serializer.toJson<int>(startOffset),
      'end_offset': serializer.toJson<int>(endOffset),
      'selected_text': serializer.toJson<String>(selectedText),
      'style': serializer.toJson<String>(style),
      'created_at': serializer.toJson<String>(createdAt),
      'updated_at': serializer.toJson<String>(updatedAt),
    };
  }

  Highlight copyWith({
    String? id,
    String? documentId,
    String? blockId,
    int? startOffset,
    int? endOffset,
    String? selectedText,
    String? style,
    String? createdAt,
    String? updatedAt,
  }) => Highlight(
    id: id ?? this.id,
    documentId: documentId ?? this.documentId,
    blockId: blockId ?? this.blockId,
    startOffset: startOffset ?? this.startOffset,
    endOffset: endOffset ?? this.endOffset,
    selectedText: selectedText ?? this.selectedText,
    style: style ?? this.style,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Highlight copyWithCompanion(HighlightsCompanion data) {
    return Highlight(
      id: data.id.present ? data.id.value : this.id,
      documentId: data.documentId.present
          ? data.documentId.value
          : this.documentId,
      blockId: data.blockId.present ? data.blockId.value : this.blockId,
      startOffset: data.startOffset.present
          ? data.startOffset.value
          : this.startOffset,
      endOffset: data.endOffset.present ? data.endOffset.value : this.endOffset,
      selectedText: data.selectedText.present
          ? data.selectedText.value
          : this.selectedText,
      style: data.style.present ? data.style.value : this.style,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Highlight(')
          ..write('id: $id, ')
          ..write('documentId: $documentId, ')
          ..write('blockId: $blockId, ')
          ..write('startOffset: $startOffset, ')
          ..write('endOffset: $endOffset, ')
          ..write('selectedText: $selectedText, ')
          ..write('style: $style, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    documentId,
    blockId,
    startOffset,
    endOffset,
    selectedText,
    style,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Highlight &&
          other.id == this.id &&
          other.documentId == this.documentId &&
          other.blockId == this.blockId &&
          other.startOffset == this.startOffset &&
          other.endOffset == this.endOffset &&
          other.selectedText == this.selectedText &&
          other.style == this.style &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class HighlightsCompanion extends UpdateCompanion<Highlight> {
  final Value<String> id;
  final Value<String> documentId;
  final Value<String> blockId;
  final Value<int> startOffset;
  final Value<int> endOffset;
  final Value<String> selectedText;
  final Value<String> style;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<int> rowid;
  const HighlightsCompanion({
    this.id = const Value.absent(),
    this.documentId = const Value.absent(),
    this.blockId = const Value.absent(),
    this.startOffset = const Value.absent(),
    this.endOffset = const Value.absent(),
    this.selectedText = const Value.absent(),
    this.style = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HighlightsCompanion.insert({
    required String id,
    required String documentId,
    required String blockId,
    required int startOffset,
    required int endOffset,
    required String selectedText,
    required String style,
    required String createdAt,
    required String updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       documentId = Value(documentId),
       blockId = Value(blockId),
       startOffset = Value(startOffset),
       endOffset = Value(endOffset),
       selectedText = Value(selectedText),
       style = Value(style),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Highlight> custom({
    Expression<String>? id,
    Expression<String>? documentId,
    Expression<String>? blockId,
    Expression<int>? startOffset,
    Expression<int>? endOffset,
    Expression<String>? selectedText,
    Expression<String>? style,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (documentId != null) 'document_id': documentId,
      if (blockId != null) 'block_id': blockId,
      if (startOffset != null) 'start_offset': startOffset,
      if (endOffset != null) 'end_offset': endOffset,
      if (selectedText != null) 'selected_text': selectedText,
      if (style != null) 'style': style,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HighlightsCompanion copyWith({
    Value<String>? id,
    Value<String>? documentId,
    Value<String>? blockId,
    Value<int>? startOffset,
    Value<int>? endOffset,
    Value<String>? selectedText,
    Value<String>? style,
    Value<String>? createdAt,
    Value<String>? updatedAt,
    Value<int>? rowid,
  }) {
    return HighlightsCompanion(
      id: id ?? this.id,
      documentId: documentId ?? this.documentId,
      blockId: blockId ?? this.blockId,
      startOffset: startOffset ?? this.startOffset,
      endOffset: endOffset ?? this.endOffset,
      selectedText: selectedText ?? this.selectedText,
      style: style ?? this.style,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (documentId.present) {
      map['document_id'] = Variable<String>(documentId.value);
    }
    if (blockId.present) {
      map['block_id'] = Variable<String>(blockId.value);
    }
    if (startOffset.present) {
      map['start_offset'] = Variable<int>(startOffset.value);
    }
    if (endOffset.present) {
      map['end_offset'] = Variable<int>(endOffset.value);
    }
    if (selectedText.present) {
      map['selected_text'] = Variable<String>(selectedText.value);
    }
    if (style.present) {
      map['style'] = Variable<String>(style.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HighlightsCompanion(')
          ..write('id: $id, ')
          ..write('documentId: $documentId, ')
          ..write('blockId: $blockId, ')
          ..write('startOffset: $startOffset, ')
          ..write('endOffset: $endOffset, ')
          ..write('selectedText: $selectedText, ')
          ..write('style: $style, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class Notes extends Table with TableInfo<Notes, Note> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Notes(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _documentIdMeta = const VerificationMeta(
    'documentId',
  );
  late final GeneratedColumn<String> documentId = GeneratedColumn<String>(
    'document_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _documentTitleMeta = const VerificationMeta(
    'documentTitle',
  );
  late final GeneratedColumn<String> documentTitle = GeneratedColumn<String>(
    'document_title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _blockIdMeta = const VerificationMeta(
    'blockId',
  );
  late final GeneratedColumn<String> blockId = GeneratedColumn<String>(
    'block_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _highlightIdMeta = const VerificationMeta(
    'highlightId',
  );
  late final GeneratedColumn<String> highlightId = GeneratedColumn<String>(
    'highlight_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
    'body',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    documentId,
    documentTitle,
    blockId,
    highlightId,
    body,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notes';
  @override
  VerificationContext validateIntegrity(
    Insertable<Note> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('document_id')) {
      context.handle(
        _documentIdMeta,
        documentId.isAcceptableOrUnknown(data['document_id']!, _documentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_documentIdMeta);
    }
    if (data.containsKey('document_title')) {
      context.handle(
        _documentTitleMeta,
        documentTitle.isAcceptableOrUnknown(
          data['document_title']!,
          _documentTitleMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_documentTitleMeta);
    }
    if (data.containsKey('block_id')) {
      context.handle(
        _blockIdMeta,
        blockId.isAcceptableOrUnknown(data['block_id']!, _blockIdMeta),
      );
    }
    if (data.containsKey('highlight_id')) {
      context.handle(
        _highlightIdMeta,
        highlightId.isAcceptableOrUnknown(
          data['highlight_id']!,
          _highlightIdMeta,
        ),
      );
    }
    if (data.containsKey('body')) {
      context.handle(
        _bodyMeta,
        body.isAcceptableOrUnknown(data['body']!, _bodyMeta),
      );
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Note map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Note(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      documentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}document_id'],
      )!,
      documentTitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}document_title'],
      )!,
      blockId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}block_id'],
      ),
      highlightId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}highlight_id'],
      ),
      body: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  Notes createAlias(String alias) {
    return Notes(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class Note extends DataClass implements Insertable<Note> {
  final String id;
  final String documentId;
  final String documentTitle;
  final String? blockId;
  final String? highlightId;
  final String body;
  final String createdAt;
  final String updatedAt;
  const Note({
    required this.id,
    required this.documentId,
    required this.documentTitle,
    this.blockId,
    this.highlightId,
    required this.body,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['document_id'] = Variable<String>(documentId);
    map['document_title'] = Variable<String>(documentTitle);
    if (!nullToAbsent || blockId != null) {
      map['block_id'] = Variable<String>(blockId);
    }
    if (!nullToAbsent || highlightId != null) {
      map['highlight_id'] = Variable<String>(highlightId);
    }
    map['body'] = Variable<String>(body);
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    return map;
  }

  NotesCompanion toCompanion(bool nullToAbsent) {
    return NotesCompanion(
      id: Value(id),
      documentId: Value(documentId),
      documentTitle: Value(documentTitle),
      blockId: blockId == null && nullToAbsent
          ? const Value.absent()
          : Value(blockId),
      highlightId: highlightId == null && nullToAbsent
          ? const Value.absent()
          : Value(highlightId),
      body: Value(body),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Note.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Note(
      id: serializer.fromJson<String>(json['id']),
      documentId: serializer.fromJson<String>(json['document_id']),
      documentTitle: serializer.fromJson<String>(json['document_title']),
      blockId: serializer.fromJson<String?>(json['block_id']),
      highlightId: serializer.fromJson<String?>(json['highlight_id']),
      body: serializer.fromJson<String>(json['body']),
      createdAt: serializer.fromJson<String>(json['created_at']),
      updatedAt: serializer.fromJson<String>(json['updated_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'document_id': serializer.toJson<String>(documentId),
      'document_title': serializer.toJson<String>(documentTitle),
      'block_id': serializer.toJson<String?>(blockId),
      'highlight_id': serializer.toJson<String?>(highlightId),
      'body': serializer.toJson<String>(body),
      'created_at': serializer.toJson<String>(createdAt),
      'updated_at': serializer.toJson<String>(updatedAt),
    };
  }

  Note copyWith({
    String? id,
    String? documentId,
    String? documentTitle,
    Value<String?> blockId = const Value.absent(),
    Value<String?> highlightId = const Value.absent(),
    String? body,
    String? createdAt,
    String? updatedAt,
  }) => Note(
    id: id ?? this.id,
    documentId: documentId ?? this.documentId,
    documentTitle: documentTitle ?? this.documentTitle,
    blockId: blockId.present ? blockId.value : this.blockId,
    highlightId: highlightId.present ? highlightId.value : this.highlightId,
    body: body ?? this.body,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Note copyWithCompanion(NotesCompanion data) {
    return Note(
      id: data.id.present ? data.id.value : this.id,
      documentId: data.documentId.present
          ? data.documentId.value
          : this.documentId,
      documentTitle: data.documentTitle.present
          ? data.documentTitle.value
          : this.documentTitle,
      blockId: data.blockId.present ? data.blockId.value : this.blockId,
      highlightId: data.highlightId.present
          ? data.highlightId.value
          : this.highlightId,
      body: data.body.present ? data.body.value : this.body,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Note(')
          ..write('id: $id, ')
          ..write('documentId: $documentId, ')
          ..write('documentTitle: $documentTitle, ')
          ..write('blockId: $blockId, ')
          ..write('highlightId: $highlightId, ')
          ..write('body: $body, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    documentId,
    documentTitle,
    blockId,
    highlightId,
    body,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Note &&
          other.id == this.id &&
          other.documentId == this.documentId &&
          other.documentTitle == this.documentTitle &&
          other.blockId == this.blockId &&
          other.highlightId == this.highlightId &&
          other.body == this.body &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class NotesCompanion extends UpdateCompanion<Note> {
  final Value<String> id;
  final Value<String> documentId;
  final Value<String> documentTitle;
  final Value<String?> blockId;
  final Value<String?> highlightId;
  final Value<String> body;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<int> rowid;
  const NotesCompanion({
    this.id = const Value.absent(),
    this.documentId = const Value.absent(),
    this.documentTitle = const Value.absent(),
    this.blockId = const Value.absent(),
    this.highlightId = const Value.absent(),
    this.body = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NotesCompanion.insert({
    required String id,
    required String documentId,
    required String documentTitle,
    this.blockId = const Value.absent(),
    this.highlightId = const Value.absent(),
    required String body,
    required String createdAt,
    required String updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       documentId = Value(documentId),
       documentTitle = Value(documentTitle),
       body = Value(body),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Note> custom({
    Expression<String>? id,
    Expression<String>? documentId,
    Expression<String>? documentTitle,
    Expression<String>? blockId,
    Expression<String>? highlightId,
    Expression<String>? body,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (documentId != null) 'document_id': documentId,
      if (documentTitle != null) 'document_title': documentTitle,
      if (blockId != null) 'block_id': blockId,
      if (highlightId != null) 'highlight_id': highlightId,
      if (body != null) 'body': body,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NotesCompanion copyWith({
    Value<String>? id,
    Value<String>? documentId,
    Value<String>? documentTitle,
    Value<String?>? blockId,
    Value<String?>? highlightId,
    Value<String>? body,
    Value<String>? createdAt,
    Value<String>? updatedAt,
    Value<int>? rowid,
  }) {
    return NotesCompanion(
      id: id ?? this.id,
      documentId: documentId ?? this.documentId,
      documentTitle: documentTitle ?? this.documentTitle,
      blockId: blockId ?? this.blockId,
      highlightId: highlightId ?? this.highlightId,
      body: body ?? this.body,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (documentId.present) {
      map['document_id'] = Variable<String>(documentId.value);
    }
    if (documentTitle.present) {
      map['document_title'] = Variable<String>(documentTitle.value);
    }
    if (blockId.present) {
      map['block_id'] = Variable<String>(blockId.value);
    }
    if (highlightId.present) {
      map['highlight_id'] = Variable<String>(highlightId.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotesCompanion(')
          ..write('id: $id, ')
          ..write('documentId: $documentId, ')
          ..write('documentTitle: $documentTitle, ')
          ..write('blockId: $blockId, ')
          ..write('highlightId: $highlightId, ')
          ..write('body: $body, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class ReadingProgress extends Table
    with TableInfo<ReadingProgress, ReadingProgressData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  ReadingProgress(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _documentIdMeta = const VerificationMeta(
    'documentId',
  );
  late final GeneratedColumn<String> documentId = GeneratedColumn<String>(
    'document_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _documentTitleMeta = const VerificationMeta(
    'documentTitle',
  );
  late final GeneratedColumn<String> documentTitle = GeneratedColumn<String>(
    'document_title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _lastBlockIdMeta = const VerificationMeta(
    'lastBlockId',
  );
  late final GeneratedColumn<String> lastBlockId = GeneratedColumn<String>(
    'last_block_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _percentageMeta = const VerificationMeta(
    'percentage',
  );
  late final GeneratedColumn<double> percentage = GeneratedColumn<double>(
    'percentage',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT 0',
    defaultValue: const CustomExpression('0'),
  );
  static const VerificationMeta _lastOpenedAtMeta = const VerificationMeta(
    'lastOpenedAt',
  );
  late final GeneratedColumn<String> lastOpenedAt = GeneratedColumn<String>(
    'last_opened_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _completedMeta = const VerificationMeta(
    'completed',
  );
  late final GeneratedColumn<int> completed = GeneratedColumn<int>(
    'completed',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT 0 CHECK (completed IN (0, 1))',
    defaultValue: const CustomExpression('0'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    documentId,
    documentTitle,
    lastBlockId,
    percentage,
    lastOpenedAt,
    completed,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reading_progress';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReadingProgressData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('document_id')) {
      context.handle(
        _documentIdMeta,
        documentId.isAcceptableOrUnknown(data['document_id']!, _documentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_documentIdMeta);
    }
    if (data.containsKey('document_title')) {
      context.handle(
        _documentTitleMeta,
        documentTitle.isAcceptableOrUnknown(
          data['document_title']!,
          _documentTitleMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_documentTitleMeta);
    }
    if (data.containsKey('last_block_id')) {
      context.handle(
        _lastBlockIdMeta,
        lastBlockId.isAcceptableOrUnknown(
          data['last_block_id']!,
          _lastBlockIdMeta,
        ),
      );
    }
    if (data.containsKey('percentage')) {
      context.handle(
        _percentageMeta,
        percentage.isAcceptableOrUnknown(data['percentage']!, _percentageMeta),
      );
    }
    if (data.containsKey('last_opened_at')) {
      context.handle(
        _lastOpenedAtMeta,
        lastOpenedAt.isAcceptableOrUnknown(
          data['last_opened_at']!,
          _lastOpenedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastOpenedAtMeta);
    }
    if (data.containsKey('completed')) {
      context.handle(
        _completedMeta,
        completed.isAcceptableOrUnknown(data['completed']!, _completedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {documentId};
  @override
  ReadingProgressData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReadingProgressData(
      documentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}document_id'],
      )!,
      documentTitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}document_title'],
      )!,
      lastBlockId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_block_id'],
      ),
      percentage: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}percentage'],
      )!,
      lastOpenedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_opened_at'],
      )!,
      completed: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}completed'],
      )!,
    );
  }

  @override
  ReadingProgress createAlias(String alias) {
    return ReadingProgress(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class ReadingProgressData extends DataClass
    implements Insertable<ReadingProgressData> {
  final String documentId;
  final String documentTitle;
  final String? lastBlockId;
  final double percentage;
  final String lastOpenedAt;
  final int completed;
  const ReadingProgressData({
    required this.documentId,
    required this.documentTitle,
    this.lastBlockId,
    required this.percentage,
    required this.lastOpenedAt,
    required this.completed,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['document_id'] = Variable<String>(documentId);
    map['document_title'] = Variable<String>(documentTitle);
    if (!nullToAbsent || lastBlockId != null) {
      map['last_block_id'] = Variable<String>(lastBlockId);
    }
    map['percentage'] = Variable<double>(percentage);
    map['last_opened_at'] = Variable<String>(lastOpenedAt);
    map['completed'] = Variable<int>(completed);
    return map;
  }

  ReadingProgressCompanion toCompanion(bool nullToAbsent) {
    return ReadingProgressCompanion(
      documentId: Value(documentId),
      documentTitle: Value(documentTitle),
      lastBlockId: lastBlockId == null && nullToAbsent
          ? const Value.absent()
          : Value(lastBlockId),
      percentage: Value(percentage),
      lastOpenedAt: Value(lastOpenedAt),
      completed: Value(completed),
    );
  }

  factory ReadingProgressData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReadingProgressData(
      documentId: serializer.fromJson<String>(json['document_id']),
      documentTitle: serializer.fromJson<String>(json['document_title']),
      lastBlockId: serializer.fromJson<String?>(json['last_block_id']),
      percentage: serializer.fromJson<double>(json['percentage']),
      lastOpenedAt: serializer.fromJson<String>(json['last_opened_at']),
      completed: serializer.fromJson<int>(json['completed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'document_id': serializer.toJson<String>(documentId),
      'document_title': serializer.toJson<String>(documentTitle),
      'last_block_id': serializer.toJson<String?>(lastBlockId),
      'percentage': serializer.toJson<double>(percentage),
      'last_opened_at': serializer.toJson<String>(lastOpenedAt),
      'completed': serializer.toJson<int>(completed),
    };
  }

  ReadingProgressData copyWith({
    String? documentId,
    String? documentTitle,
    Value<String?> lastBlockId = const Value.absent(),
    double? percentage,
    String? lastOpenedAt,
    int? completed,
  }) => ReadingProgressData(
    documentId: documentId ?? this.documentId,
    documentTitle: documentTitle ?? this.documentTitle,
    lastBlockId: lastBlockId.present ? lastBlockId.value : this.lastBlockId,
    percentage: percentage ?? this.percentage,
    lastOpenedAt: lastOpenedAt ?? this.lastOpenedAt,
    completed: completed ?? this.completed,
  );
  ReadingProgressData copyWithCompanion(ReadingProgressCompanion data) {
    return ReadingProgressData(
      documentId: data.documentId.present
          ? data.documentId.value
          : this.documentId,
      documentTitle: data.documentTitle.present
          ? data.documentTitle.value
          : this.documentTitle,
      lastBlockId: data.lastBlockId.present
          ? data.lastBlockId.value
          : this.lastBlockId,
      percentage: data.percentage.present
          ? data.percentage.value
          : this.percentage,
      lastOpenedAt: data.lastOpenedAt.present
          ? data.lastOpenedAt.value
          : this.lastOpenedAt,
      completed: data.completed.present ? data.completed.value : this.completed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReadingProgressData(')
          ..write('documentId: $documentId, ')
          ..write('documentTitle: $documentTitle, ')
          ..write('lastBlockId: $lastBlockId, ')
          ..write('percentage: $percentage, ')
          ..write('lastOpenedAt: $lastOpenedAt, ')
          ..write('completed: $completed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    documentId,
    documentTitle,
    lastBlockId,
    percentage,
    lastOpenedAt,
    completed,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReadingProgressData &&
          other.documentId == this.documentId &&
          other.documentTitle == this.documentTitle &&
          other.lastBlockId == this.lastBlockId &&
          other.percentage == this.percentage &&
          other.lastOpenedAt == this.lastOpenedAt &&
          other.completed == this.completed);
}

class ReadingProgressCompanion extends UpdateCompanion<ReadingProgressData> {
  final Value<String> documentId;
  final Value<String> documentTitle;
  final Value<String?> lastBlockId;
  final Value<double> percentage;
  final Value<String> lastOpenedAt;
  final Value<int> completed;
  final Value<int> rowid;
  const ReadingProgressCompanion({
    this.documentId = const Value.absent(),
    this.documentTitle = const Value.absent(),
    this.lastBlockId = const Value.absent(),
    this.percentage = const Value.absent(),
    this.lastOpenedAt = const Value.absent(),
    this.completed = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReadingProgressCompanion.insert({
    required String documentId,
    required String documentTitle,
    this.lastBlockId = const Value.absent(),
    this.percentage = const Value.absent(),
    required String lastOpenedAt,
    this.completed = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : documentId = Value(documentId),
       documentTitle = Value(documentTitle),
       lastOpenedAt = Value(lastOpenedAt);
  static Insertable<ReadingProgressData> custom({
    Expression<String>? documentId,
    Expression<String>? documentTitle,
    Expression<String>? lastBlockId,
    Expression<double>? percentage,
    Expression<String>? lastOpenedAt,
    Expression<int>? completed,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (documentId != null) 'document_id': documentId,
      if (documentTitle != null) 'document_title': documentTitle,
      if (lastBlockId != null) 'last_block_id': lastBlockId,
      if (percentage != null) 'percentage': percentage,
      if (lastOpenedAt != null) 'last_opened_at': lastOpenedAt,
      if (completed != null) 'completed': completed,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReadingProgressCompanion copyWith({
    Value<String>? documentId,
    Value<String>? documentTitle,
    Value<String?>? lastBlockId,
    Value<double>? percentage,
    Value<String>? lastOpenedAt,
    Value<int>? completed,
    Value<int>? rowid,
  }) {
    return ReadingProgressCompanion(
      documentId: documentId ?? this.documentId,
      documentTitle: documentTitle ?? this.documentTitle,
      lastBlockId: lastBlockId ?? this.lastBlockId,
      percentage: percentage ?? this.percentage,
      lastOpenedAt: lastOpenedAt ?? this.lastOpenedAt,
      completed: completed ?? this.completed,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (documentId.present) {
      map['document_id'] = Variable<String>(documentId.value);
    }
    if (documentTitle.present) {
      map['document_title'] = Variable<String>(documentTitle.value);
    }
    if (lastBlockId.present) {
      map['last_block_id'] = Variable<String>(lastBlockId.value);
    }
    if (percentage.present) {
      map['percentage'] = Variable<double>(percentage.value);
    }
    if (lastOpenedAt.present) {
      map['last_opened_at'] = Variable<String>(lastOpenedAt.value);
    }
    if (completed.present) {
      map['completed'] = Variable<int>(completed.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReadingProgressCompanion(')
          ..write('documentId: $documentId, ')
          ..write('documentTitle: $documentTitle, ')
          ..write('lastBlockId: $lastBlockId, ')
          ..write('percentage: $percentage, ')
          ..write('lastOpenedAt: $lastOpenedAt, ')
          ..write('completed: $completed, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class Settings extends Table with TableInfo<Settings, Setting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Settings(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _settingKeyMeta = const VerificationMeta(
    'settingKey',
  );
  late final GeneratedColumn<String> settingKey = GeneratedColumn<String>(
    'setting_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [settingKey, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<Setting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('setting_key')) {
      context.handle(
        _settingKeyMeta,
        settingKey.isAcceptableOrUnknown(data['setting_key']!, _settingKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_settingKeyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {settingKey};
  @override
  Setting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Setting(
      settingKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}setting_key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  Settings createAlias(String alias) {
    return Settings(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class Setting extends DataClass implements Insertable<Setting> {
  final String settingKey;
  final String value;
  const Setting({required this.settingKey, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['setting_key'] = Variable<String>(settingKey);
    map['value'] = Variable<String>(value);
    return map;
  }

  SettingsCompanion toCompanion(bool nullToAbsent) {
    return SettingsCompanion(
      settingKey: Value(settingKey),
      value: Value(value),
    );
  }

  factory Setting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Setting(
      settingKey: serializer.fromJson<String>(json['setting_key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'setting_key': serializer.toJson<String>(settingKey),
      'value': serializer.toJson<String>(value),
    };
  }

  Setting copyWith({String? settingKey, String? value}) => Setting(
    settingKey: settingKey ?? this.settingKey,
    value: value ?? this.value,
  );
  Setting copyWithCompanion(SettingsCompanion data) {
    return Setting(
      settingKey: data.settingKey.present
          ? data.settingKey.value
          : this.settingKey,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Setting(')
          ..write('settingKey: $settingKey, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(settingKey, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Setting &&
          other.settingKey == this.settingKey &&
          other.value == this.value);
}

class SettingsCompanion extends UpdateCompanion<Setting> {
  final Value<String> settingKey;
  final Value<String> value;
  final Value<int> rowid;
  const SettingsCompanion({
    this.settingKey = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SettingsCompanion.insert({
    required String settingKey,
    required String value,
    this.rowid = const Value.absent(),
  }) : settingKey = Value(settingKey),
       value = Value(value);
  static Insertable<Setting> custom({
    Expression<String>? settingKey,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (settingKey != null) 'setting_key': settingKey,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SettingsCompanion copyWith({
    Value<String>? settingKey,
    Value<String>? value,
    Value<int>? rowid,
  }) {
    return SettingsCompanion(
      settingKey: settingKey ?? this.settingKey,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (settingKey.present) {
      map['setting_key'] = Variable<String>(settingKey.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsCompanion(')
          ..write('settingKey: $settingKey, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final CatalogueCache catalogueCache = CatalogueCache(this);
  late final DownloadedCollections downloadedCollections =
      DownloadedCollections(this);
  late final DownloadedAssets downloadedAssets = DownloadedAssets(this);
  late final Bookmarks bookmarks = Bookmarks(this);
  late final Highlights highlights = Highlights(this);
  late final Notes notes = Notes(this);
  late final ReadingProgress readingProgress = ReadingProgress(this);
  late final Settings settings = Settings(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    catalogueCache,
    downloadedCollections,
    downloadedAssets,
    bookmarks,
    highlights,
    notes,
    readingProgress,
    settings,
  ];
}

typedef $CatalogueCacheCreateCompanionBuilder =
    CatalogueCacheCompanion Function({
      Value<int> id,
      required String catalogueJson,
      Value<String?> etag,
      required String fetchedAt,
    });
typedef $CatalogueCacheUpdateCompanionBuilder =
    CatalogueCacheCompanion Function({
      Value<int> id,
      Value<String> catalogueJson,
      Value<String?> etag,
      Value<String> fetchedAt,
    });

class $CatalogueCacheFilterComposer
    extends Composer<_$AppDatabase, CatalogueCache> {
  $CatalogueCacheFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get catalogueJson => $composableBuilder(
    column: $table.catalogueJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get etag => $composableBuilder(
    column: $table.etag,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $CatalogueCacheOrderingComposer
    extends Composer<_$AppDatabase, CatalogueCache> {
  $CatalogueCacheOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get catalogueJson => $composableBuilder(
    column: $table.catalogueJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get etag => $composableBuilder(
    column: $table.etag,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $CatalogueCacheAnnotationComposer
    extends Composer<_$AppDatabase, CatalogueCache> {
  $CatalogueCacheAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get catalogueJson => $composableBuilder(
    column: $table.catalogueJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get etag =>
      $composableBuilder(column: $table.etag, builder: (column) => column);

  GeneratedColumn<String> get fetchedAt =>
      $composableBuilder(column: $table.fetchedAt, builder: (column) => column);
}

class $CatalogueCacheTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          CatalogueCache,
          CatalogueCacheData,
          $CatalogueCacheFilterComposer,
          $CatalogueCacheOrderingComposer,
          $CatalogueCacheAnnotationComposer,
          $CatalogueCacheCreateCompanionBuilder,
          $CatalogueCacheUpdateCompanionBuilder,
          (
            CatalogueCacheData,
            BaseReferences<_$AppDatabase, CatalogueCache, CatalogueCacheData>,
          ),
          CatalogueCacheData,
          PrefetchHooks Function()
        > {
  $CatalogueCacheTableManager(_$AppDatabase db, CatalogueCache table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $CatalogueCacheFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $CatalogueCacheOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $CatalogueCacheAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> catalogueJson = const Value.absent(),
                Value<String?> etag = const Value.absent(),
                Value<String> fetchedAt = const Value.absent(),
              }) => CatalogueCacheCompanion(
                id: id,
                catalogueJson: catalogueJson,
                etag: etag,
                fetchedAt: fetchedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String catalogueJson,
                Value<String?> etag = const Value.absent(),
                required String fetchedAt,
              }) => CatalogueCacheCompanion.insert(
                id: id,
                catalogueJson: catalogueJson,
                etag: etag,
                fetchedAt: fetchedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $CatalogueCacheProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      CatalogueCache,
      CatalogueCacheData,
      $CatalogueCacheFilterComposer,
      $CatalogueCacheOrderingComposer,
      $CatalogueCacheAnnotationComposer,
      $CatalogueCacheCreateCompanionBuilder,
      $CatalogueCacheUpdateCompanionBuilder,
      (
        CatalogueCacheData,
        BaseReferences<_$AppDatabase, CatalogueCache, CatalogueCacheData>,
      ),
      CatalogueCacheData,
      PrefetchHooks Function()
    >;
typedef $DownloadedCollectionsCreateCompanionBuilder =
    DownloadedCollectionsCompanion Function({
      required String collectionId,
      required int contentVersion,
      required String state,
      Value<int> downloadedBytes,
      Value<int> totalBytes,
      Value<String?> errorMessage,
      Value<String?> installedAt,
      Value<int> rowid,
    });
typedef $DownloadedCollectionsUpdateCompanionBuilder =
    DownloadedCollectionsCompanion Function({
      Value<String> collectionId,
      Value<int> contentVersion,
      Value<String> state,
      Value<int> downloadedBytes,
      Value<int> totalBytes,
      Value<String?> errorMessage,
      Value<String?> installedAt,
      Value<int> rowid,
    });

class $DownloadedCollectionsFilterComposer
    extends Composer<_$AppDatabase, DownloadedCollections> {
  $DownloadedCollectionsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get collectionId => $composableBuilder(
    column: $table.collectionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get contentVersion => $composableBuilder(
    column: $table.contentVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get downloadedBytes => $composableBuilder(
    column: $table.downloadedBytes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalBytes => $composableBuilder(
    column: $table.totalBytes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get installedAt => $composableBuilder(
    column: $table.installedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $DownloadedCollectionsOrderingComposer
    extends Composer<_$AppDatabase, DownloadedCollections> {
  $DownloadedCollectionsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get collectionId => $composableBuilder(
    column: $table.collectionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get contentVersion => $composableBuilder(
    column: $table.contentVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get downloadedBytes => $composableBuilder(
    column: $table.downloadedBytes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalBytes => $composableBuilder(
    column: $table.totalBytes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get installedAt => $composableBuilder(
    column: $table.installedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $DownloadedCollectionsAnnotationComposer
    extends Composer<_$AppDatabase, DownloadedCollections> {
  $DownloadedCollectionsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get collectionId => $composableBuilder(
    column: $table.collectionId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get contentVersion => $composableBuilder(
    column: $table.contentVersion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get state =>
      $composableBuilder(column: $table.state, builder: (column) => column);

  GeneratedColumn<int> get downloadedBytes => $composableBuilder(
    column: $table.downloadedBytes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalBytes => $composableBuilder(
    column: $table.totalBytes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get installedAt => $composableBuilder(
    column: $table.installedAt,
    builder: (column) => column,
  );
}

class $DownloadedCollectionsTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          DownloadedCollections,
          DownloadedCollection,
          $DownloadedCollectionsFilterComposer,
          $DownloadedCollectionsOrderingComposer,
          $DownloadedCollectionsAnnotationComposer,
          $DownloadedCollectionsCreateCompanionBuilder,
          $DownloadedCollectionsUpdateCompanionBuilder,
          (
            DownloadedCollection,
            BaseReferences<
              _$AppDatabase,
              DownloadedCollections,
              DownloadedCollection
            >,
          ),
          DownloadedCollection,
          PrefetchHooks Function()
        > {
  $DownloadedCollectionsTableManager(
    _$AppDatabase db,
    DownloadedCollections table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $DownloadedCollectionsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $DownloadedCollectionsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $DownloadedCollectionsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> collectionId = const Value.absent(),
                Value<int> contentVersion = const Value.absent(),
                Value<String> state = const Value.absent(),
                Value<int> downloadedBytes = const Value.absent(),
                Value<int> totalBytes = const Value.absent(),
                Value<String?> errorMessage = const Value.absent(),
                Value<String?> installedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DownloadedCollectionsCompanion(
                collectionId: collectionId,
                contentVersion: contentVersion,
                state: state,
                downloadedBytes: downloadedBytes,
                totalBytes: totalBytes,
                errorMessage: errorMessage,
                installedAt: installedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String collectionId,
                required int contentVersion,
                required String state,
                Value<int> downloadedBytes = const Value.absent(),
                Value<int> totalBytes = const Value.absent(),
                Value<String?> errorMessage = const Value.absent(),
                Value<String?> installedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DownloadedCollectionsCompanion.insert(
                collectionId: collectionId,
                contentVersion: contentVersion,
                state: state,
                downloadedBytes: downloadedBytes,
                totalBytes: totalBytes,
                errorMessage: errorMessage,
                installedAt: installedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $DownloadedCollectionsProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      DownloadedCollections,
      DownloadedCollection,
      $DownloadedCollectionsFilterComposer,
      $DownloadedCollectionsOrderingComposer,
      $DownloadedCollectionsAnnotationComposer,
      $DownloadedCollectionsCreateCompanionBuilder,
      $DownloadedCollectionsUpdateCompanionBuilder,
      (
        DownloadedCollection,
        BaseReferences<
          _$AppDatabase,
          DownloadedCollections,
          DownloadedCollection
        >,
      ),
      DownloadedCollection,
      PrefetchHooks Function()
    >;
typedef $DownloadedAssetsCreateCompanionBuilder =
    DownloadedAssetsCompanion Function({
      required String assetId,
      required String documentId,
      required String fileType,
      required String localPath,
      required int fileSize,
      required String sha256,
      required int version,
      required String installedAt,
      Value<int> rowid,
    });
typedef $DownloadedAssetsUpdateCompanionBuilder =
    DownloadedAssetsCompanion Function({
      Value<String> assetId,
      Value<String> documentId,
      Value<String> fileType,
      Value<String> localPath,
      Value<int> fileSize,
      Value<String> sha256,
      Value<int> version,
      Value<String> installedAt,
      Value<int> rowid,
    });

class $DownloadedAssetsFilterComposer
    extends Composer<_$AppDatabase, DownloadedAssets> {
  $DownloadedAssetsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get assetId => $composableBuilder(
    column: $table.assetId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get documentId => $composableBuilder(
    column: $table.documentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fileType => $composableBuilder(
    column: $table.fileType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fileSize => $composableBuilder(
    column: $table.fileSize,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sha256 => $composableBuilder(
    column: $table.sha256,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get installedAt => $composableBuilder(
    column: $table.installedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $DownloadedAssetsOrderingComposer
    extends Composer<_$AppDatabase, DownloadedAssets> {
  $DownloadedAssetsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get assetId => $composableBuilder(
    column: $table.assetId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get documentId => $composableBuilder(
    column: $table.documentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fileType => $composableBuilder(
    column: $table.fileType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fileSize => $composableBuilder(
    column: $table.fileSize,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sha256 => $composableBuilder(
    column: $table.sha256,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get installedAt => $composableBuilder(
    column: $table.installedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $DownloadedAssetsAnnotationComposer
    extends Composer<_$AppDatabase, DownloadedAssets> {
  $DownloadedAssetsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get assetId =>
      $composableBuilder(column: $table.assetId, builder: (column) => column);

  GeneratedColumn<String> get documentId => $composableBuilder(
    column: $table.documentId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get fileType =>
      $composableBuilder(column: $table.fileType, builder: (column) => column);

  GeneratedColumn<String> get localPath =>
      $composableBuilder(column: $table.localPath, builder: (column) => column);

  GeneratedColumn<int> get fileSize =>
      $composableBuilder(column: $table.fileSize, builder: (column) => column);

  GeneratedColumn<String> get sha256 =>
      $composableBuilder(column: $table.sha256, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get installedAt => $composableBuilder(
    column: $table.installedAt,
    builder: (column) => column,
  );
}

class $DownloadedAssetsTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          DownloadedAssets,
          DownloadedAsset,
          $DownloadedAssetsFilterComposer,
          $DownloadedAssetsOrderingComposer,
          $DownloadedAssetsAnnotationComposer,
          $DownloadedAssetsCreateCompanionBuilder,
          $DownloadedAssetsUpdateCompanionBuilder,
          (
            DownloadedAsset,
            BaseReferences<_$AppDatabase, DownloadedAssets, DownloadedAsset>,
          ),
          DownloadedAsset,
          PrefetchHooks Function()
        > {
  $DownloadedAssetsTableManager(_$AppDatabase db, DownloadedAssets table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $DownloadedAssetsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $DownloadedAssetsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $DownloadedAssetsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> assetId = const Value.absent(),
                Value<String> documentId = const Value.absent(),
                Value<String> fileType = const Value.absent(),
                Value<String> localPath = const Value.absent(),
                Value<int> fileSize = const Value.absent(),
                Value<String> sha256 = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> installedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DownloadedAssetsCompanion(
                assetId: assetId,
                documentId: documentId,
                fileType: fileType,
                localPath: localPath,
                fileSize: fileSize,
                sha256: sha256,
                version: version,
                installedAt: installedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String assetId,
                required String documentId,
                required String fileType,
                required String localPath,
                required int fileSize,
                required String sha256,
                required int version,
                required String installedAt,
                Value<int> rowid = const Value.absent(),
              }) => DownloadedAssetsCompanion.insert(
                assetId: assetId,
                documentId: documentId,
                fileType: fileType,
                localPath: localPath,
                fileSize: fileSize,
                sha256: sha256,
                version: version,
                installedAt: installedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $DownloadedAssetsProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      DownloadedAssets,
      DownloadedAsset,
      $DownloadedAssetsFilterComposer,
      $DownloadedAssetsOrderingComposer,
      $DownloadedAssetsAnnotationComposer,
      $DownloadedAssetsCreateCompanionBuilder,
      $DownloadedAssetsUpdateCompanionBuilder,
      (
        DownloadedAsset,
        BaseReferences<_$AppDatabase, DownloadedAssets, DownloadedAsset>,
      ),
      DownloadedAsset,
      PrefetchHooks Function()
    >;
typedef $BookmarksCreateCompanionBuilder =
    BookmarksCompanion Function({
      required String id,
      required String documentId,
      required String documentTitle,
      Value<String?> blockId,
      Value<String?> label,
      required String createdAt,
      Value<int> rowid,
    });
typedef $BookmarksUpdateCompanionBuilder =
    BookmarksCompanion Function({
      Value<String> id,
      Value<String> documentId,
      Value<String> documentTitle,
      Value<String?> blockId,
      Value<String?> label,
      Value<String> createdAt,
      Value<int> rowid,
    });

class $BookmarksFilterComposer extends Composer<_$AppDatabase, Bookmarks> {
  $BookmarksFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get documentId => $composableBuilder(
    column: $table.documentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get documentTitle => $composableBuilder(
    column: $table.documentTitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get blockId => $composableBuilder(
    column: $table.blockId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $BookmarksOrderingComposer extends Composer<_$AppDatabase, Bookmarks> {
  $BookmarksOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get documentId => $composableBuilder(
    column: $table.documentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get documentTitle => $composableBuilder(
    column: $table.documentTitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get blockId => $composableBuilder(
    column: $table.blockId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $BookmarksAnnotationComposer extends Composer<_$AppDatabase, Bookmarks> {
  $BookmarksAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get documentId => $composableBuilder(
    column: $table.documentId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get documentTitle => $composableBuilder(
    column: $table.documentTitle,
    builder: (column) => column,
  );

  GeneratedColumn<String> get blockId =>
      $composableBuilder(column: $table.blockId, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $BookmarksTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          Bookmarks,
          Bookmark,
          $BookmarksFilterComposer,
          $BookmarksOrderingComposer,
          $BookmarksAnnotationComposer,
          $BookmarksCreateCompanionBuilder,
          $BookmarksUpdateCompanionBuilder,
          (Bookmark, BaseReferences<_$AppDatabase, Bookmarks, Bookmark>),
          Bookmark,
          PrefetchHooks Function()
        > {
  $BookmarksTableManager(_$AppDatabase db, Bookmarks table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $BookmarksFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $BookmarksOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $BookmarksAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> documentId = const Value.absent(),
                Value<String> documentTitle = const Value.absent(),
                Value<String?> blockId = const Value.absent(),
                Value<String?> label = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BookmarksCompanion(
                id: id,
                documentId: documentId,
                documentTitle: documentTitle,
                blockId: blockId,
                label: label,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String documentId,
                required String documentTitle,
                Value<String?> blockId = const Value.absent(),
                Value<String?> label = const Value.absent(),
                required String createdAt,
                Value<int> rowid = const Value.absent(),
              }) => BookmarksCompanion.insert(
                id: id,
                documentId: documentId,
                documentTitle: documentTitle,
                blockId: blockId,
                label: label,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $BookmarksProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      Bookmarks,
      Bookmark,
      $BookmarksFilterComposer,
      $BookmarksOrderingComposer,
      $BookmarksAnnotationComposer,
      $BookmarksCreateCompanionBuilder,
      $BookmarksUpdateCompanionBuilder,
      (Bookmark, BaseReferences<_$AppDatabase, Bookmarks, Bookmark>),
      Bookmark,
      PrefetchHooks Function()
    >;
typedef $HighlightsCreateCompanionBuilder =
    HighlightsCompanion Function({
      required String id,
      required String documentId,
      required String blockId,
      required int startOffset,
      required int endOffset,
      required String selectedText,
      required String style,
      required String createdAt,
      required String updatedAt,
      Value<int> rowid,
    });
typedef $HighlightsUpdateCompanionBuilder =
    HighlightsCompanion Function({
      Value<String> id,
      Value<String> documentId,
      Value<String> blockId,
      Value<int> startOffset,
      Value<int> endOffset,
      Value<String> selectedText,
      Value<String> style,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<int> rowid,
    });

class $HighlightsFilterComposer extends Composer<_$AppDatabase, Highlights> {
  $HighlightsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get documentId => $composableBuilder(
    column: $table.documentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get blockId => $composableBuilder(
    column: $table.blockId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get startOffset => $composableBuilder(
    column: $table.startOffset,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get endOffset => $composableBuilder(
    column: $table.endOffset,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get selectedText => $composableBuilder(
    column: $table.selectedText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get style => $composableBuilder(
    column: $table.style,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $HighlightsOrderingComposer extends Composer<_$AppDatabase, Highlights> {
  $HighlightsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get documentId => $composableBuilder(
    column: $table.documentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get blockId => $composableBuilder(
    column: $table.blockId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startOffset => $composableBuilder(
    column: $table.startOffset,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get endOffset => $composableBuilder(
    column: $table.endOffset,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get selectedText => $composableBuilder(
    column: $table.selectedText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get style => $composableBuilder(
    column: $table.style,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $HighlightsAnnotationComposer
    extends Composer<_$AppDatabase, Highlights> {
  $HighlightsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get documentId => $composableBuilder(
    column: $table.documentId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get blockId =>
      $composableBuilder(column: $table.blockId, builder: (column) => column);

  GeneratedColumn<int> get startOffset => $composableBuilder(
    column: $table.startOffset,
    builder: (column) => column,
  );

  GeneratedColumn<int> get endOffset =>
      $composableBuilder(column: $table.endOffset, builder: (column) => column);

  GeneratedColumn<String> get selectedText => $composableBuilder(
    column: $table.selectedText,
    builder: (column) => column,
  );

  GeneratedColumn<String> get style =>
      $composableBuilder(column: $table.style, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $HighlightsTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          Highlights,
          Highlight,
          $HighlightsFilterComposer,
          $HighlightsOrderingComposer,
          $HighlightsAnnotationComposer,
          $HighlightsCreateCompanionBuilder,
          $HighlightsUpdateCompanionBuilder,
          (Highlight, BaseReferences<_$AppDatabase, Highlights, Highlight>),
          Highlight,
          PrefetchHooks Function()
        > {
  $HighlightsTableManager(_$AppDatabase db, Highlights table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $HighlightsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $HighlightsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $HighlightsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> documentId = const Value.absent(),
                Value<String> blockId = const Value.absent(),
                Value<int> startOffset = const Value.absent(),
                Value<int> endOffset = const Value.absent(),
                Value<String> selectedText = const Value.absent(),
                Value<String> style = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HighlightsCompanion(
                id: id,
                documentId: documentId,
                blockId: blockId,
                startOffset: startOffset,
                endOffset: endOffset,
                selectedText: selectedText,
                style: style,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String documentId,
                required String blockId,
                required int startOffset,
                required int endOffset,
                required String selectedText,
                required String style,
                required String createdAt,
                required String updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => HighlightsCompanion.insert(
                id: id,
                documentId: documentId,
                blockId: blockId,
                startOffset: startOffset,
                endOffset: endOffset,
                selectedText: selectedText,
                style: style,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $HighlightsProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      Highlights,
      Highlight,
      $HighlightsFilterComposer,
      $HighlightsOrderingComposer,
      $HighlightsAnnotationComposer,
      $HighlightsCreateCompanionBuilder,
      $HighlightsUpdateCompanionBuilder,
      (Highlight, BaseReferences<_$AppDatabase, Highlights, Highlight>),
      Highlight,
      PrefetchHooks Function()
    >;
typedef $NotesCreateCompanionBuilder =
    NotesCompanion Function({
      required String id,
      required String documentId,
      required String documentTitle,
      Value<String?> blockId,
      Value<String?> highlightId,
      required String body,
      required String createdAt,
      required String updatedAt,
      Value<int> rowid,
    });
typedef $NotesUpdateCompanionBuilder =
    NotesCompanion Function({
      Value<String> id,
      Value<String> documentId,
      Value<String> documentTitle,
      Value<String?> blockId,
      Value<String?> highlightId,
      Value<String> body,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<int> rowid,
    });

class $NotesFilterComposer extends Composer<_$AppDatabase, Notes> {
  $NotesFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get documentId => $composableBuilder(
    column: $table.documentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get documentTitle => $composableBuilder(
    column: $table.documentTitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get blockId => $composableBuilder(
    column: $table.blockId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get highlightId => $composableBuilder(
    column: $table.highlightId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $NotesOrderingComposer extends Composer<_$AppDatabase, Notes> {
  $NotesOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get documentId => $composableBuilder(
    column: $table.documentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get documentTitle => $composableBuilder(
    column: $table.documentTitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get blockId => $composableBuilder(
    column: $table.blockId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get highlightId => $composableBuilder(
    column: $table.highlightId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $NotesAnnotationComposer extends Composer<_$AppDatabase, Notes> {
  $NotesAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get documentId => $composableBuilder(
    column: $table.documentId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get documentTitle => $composableBuilder(
    column: $table.documentTitle,
    builder: (column) => column,
  );

  GeneratedColumn<String> get blockId =>
      $composableBuilder(column: $table.blockId, builder: (column) => column);

  GeneratedColumn<String> get highlightId => $composableBuilder(
    column: $table.highlightId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $NotesTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          Notes,
          Note,
          $NotesFilterComposer,
          $NotesOrderingComposer,
          $NotesAnnotationComposer,
          $NotesCreateCompanionBuilder,
          $NotesUpdateCompanionBuilder,
          (Note, BaseReferences<_$AppDatabase, Notes, Note>),
          Note,
          PrefetchHooks Function()
        > {
  $NotesTableManager(_$AppDatabase db, Notes table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $NotesFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $NotesOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $NotesAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> documentId = const Value.absent(),
                Value<String> documentTitle = const Value.absent(),
                Value<String?> blockId = const Value.absent(),
                Value<String?> highlightId = const Value.absent(),
                Value<String> body = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NotesCompanion(
                id: id,
                documentId: documentId,
                documentTitle: documentTitle,
                blockId: blockId,
                highlightId: highlightId,
                body: body,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String documentId,
                required String documentTitle,
                Value<String?> blockId = const Value.absent(),
                Value<String?> highlightId = const Value.absent(),
                required String body,
                required String createdAt,
                required String updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => NotesCompanion.insert(
                id: id,
                documentId: documentId,
                documentTitle: documentTitle,
                blockId: blockId,
                highlightId: highlightId,
                body: body,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $NotesProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      Notes,
      Note,
      $NotesFilterComposer,
      $NotesOrderingComposer,
      $NotesAnnotationComposer,
      $NotesCreateCompanionBuilder,
      $NotesUpdateCompanionBuilder,
      (Note, BaseReferences<_$AppDatabase, Notes, Note>),
      Note,
      PrefetchHooks Function()
    >;
typedef $ReadingProgressCreateCompanionBuilder =
    ReadingProgressCompanion Function({
      required String documentId,
      required String documentTitle,
      Value<String?> lastBlockId,
      Value<double> percentage,
      required String lastOpenedAt,
      Value<int> completed,
      Value<int> rowid,
    });
typedef $ReadingProgressUpdateCompanionBuilder =
    ReadingProgressCompanion Function({
      Value<String> documentId,
      Value<String> documentTitle,
      Value<String?> lastBlockId,
      Value<double> percentage,
      Value<String> lastOpenedAt,
      Value<int> completed,
      Value<int> rowid,
    });

class $ReadingProgressFilterComposer
    extends Composer<_$AppDatabase, ReadingProgress> {
  $ReadingProgressFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get documentId => $composableBuilder(
    column: $table.documentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get documentTitle => $composableBuilder(
    column: $table.documentTitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastBlockId => $composableBuilder(
    column: $table.lastBlockId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get percentage => $composableBuilder(
    column: $table.percentage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastOpenedAt => $composableBuilder(
    column: $table.lastOpenedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnFilters(column),
  );
}

class $ReadingProgressOrderingComposer
    extends Composer<_$AppDatabase, ReadingProgress> {
  $ReadingProgressOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get documentId => $composableBuilder(
    column: $table.documentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get documentTitle => $composableBuilder(
    column: $table.documentTitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastBlockId => $composableBuilder(
    column: $table.lastBlockId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get percentage => $composableBuilder(
    column: $table.percentage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastOpenedAt => $composableBuilder(
    column: $table.lastOpenedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnOrderings(column),
  );
}

class $ReadingProgressAnnotationComposer
    extends Composer<_$AppDatabase, ReadingProgress> {
  $ReadingProgressAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get documentId => $composableBuilder(
    column: $table.documentId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get documentTitle => $composableBuilder(
    column: $table.documentTitle,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastBlockId => $composableBuilder(
    column: $table.lastBlockId,
    builder: (column) => column,
  );

  GeneratedColumn<double> get percentage => $composableBuilder(
    column: $table.percentage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastOpenedAt => $composableBuilder(
    column: $table.lastOpenedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get completed =>
      $composableBuilder(column: $table.completed, builder: (column) => column);
}

class $ReadingProgressTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          ReadingProgress,
          ReadingProgressData,
          $ReadingProgressFilterComposer,
          $ReadingProgressOrderingComposer,
          $ReadingProgressAnnotationComposer,
          $ReadingProgressCreateCompanionBuilder,
          $ReadingProgressUpdateCompanionBuilder,
          (
            ReadingProgressData,
            BaseReferences<_$AppDatabase, ReadingProgress, ReadingProgressData>,
          ),
          ReadingProgressData,
          PrefetchHooks Function()
        > {
  $ReadingProgressTableManager(_$AppDatabase db, ReadingProgress table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $ReadingProgressFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $ReadingProgressOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $ReadingProgressAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> documentId = const Value.absent(),
                Value<String> documentTitle = const Value.absent(),
                Value<String?> lastBlockId = const Value.absent(),
                Value<double> percentage = const Value.absent(),
                Value<String> lastOpenedAt = const Value.absent(),
                Value<int> completed = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReadingProgressCompanion(
                documentId: documentId,
                documentTitle: documentTitle,
                lastBlockId: lastBlockId,
                percentage: percentage,
                lastOpenedAt: lastOpenedAt,
                completed: completed,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String documentId,
                required String documentTitle,
                Value<String?> lastBlockId = const Value.absent(),
                Value<double> percentage = const Value.absent(),
                required String lastOpenedAt,
                Value<int> completed = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReadingProgressCompanion.insert(
                documentId: documentId,
                documentTitle: documentTitle,
                lastBlockId: lastBlockId,
                percentage: percentage,
                lastOpenedAt: lastOpenedAt,
                completed: completed,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $ReadingProgressProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      ReadingProgress,
      ReadingProgressData,
      $ReadingProgressFilterComposer,
      $ReadingProgressOrderingComposer,
      $ReadingProgressAnnotationComposer,
      $ReadingProgressCreateCompanionBuilder,
      $ReadingProgressUpdateCompanionBuilder,
      (
        ReadingProgressData,
        BaseReferences<_$AppDatabase, ReadingProgress, ReadingProgressData>,
      ),
      ReadingProgressData,
      PrefetchHooks Function()
    >;
typedef $SettingsCreateCompanionBuilder =
    SettingsCompanion Function({
      required String settingKey,
      required String value,
      Value<int> rowid,
    });
typedef $SettingsUpdateCompanionBuilder =
    SettingsCompanion Function({
      Value<String> settingKey,
      Value<String> value,
      Value<int> rowid,
    });

class $SettingsFilterComposer extends Composer<_$AppDatabase, Settings> {
  $SettingsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get settingKey => $composableBuilder(
    column: $table.settingKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $SettingsOrderingComposer extends Composer<_$AppDatabase, Settings> {
  $SettingsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get settingKey => $composableBuilder(
    column: $table.settingKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $SettingsAnnotationComposer extends Composer<_$AppDatabase, Settings> {
  $SettingsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get settingKey => $composableBuilder(
    column: $table.settingKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $SettingsTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          Settings,
          Setting,
          $SettingsFilterComposer,
          $SettingsOrderingComposer,
          $SettingsAnnotationComposer,
          $SettingsCreateCompanionBuilder,
          $SettingsUpdateCompanionBuilder,
          (Setting, BaseReferences<_$AppDatabase, Settings, Setting>),
          Setting,
          PrefetchHooks Function()
        > {
  $SettingsTableManager(_$AppDatabase db, Settings table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $SettingsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $SettingsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $SettingsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> settingKey = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SettingsCompanion(
                settingKey: settingKey,
                value: value,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String settingKey,
                required String value,
                Value<int> rowid = const Value.absent(),
              }) => SettingsCompanion.insert(
                settingKey: settingKey,
                value: value,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $SettingsProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      Settings,
      Setting,
      $SettingsFilterComposer,
      $SettingsOrderingComposer,
      $SettingsAnnotationComposer,
      $SettingsCreateCompanionBuilder,
      $SettingsUpdateCompanionBuilder,
      (Setting, BaseReferences<_$AppDatabase, Settings, Setting>),
      Setting,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $CatalogueCacheTableManager get catalogueCache =>
      $CatalogueCacheTableManager(_db, _db.catalogueCache);
  $DownloadedCollectionsTableManager get downloadedCollections =>
      $DownloadedCollectionsTableManager(_db, _db.downloadedCollections);
  $DownloadedAssetsTableManager get downloadedAssets =>
      $DownloadedAssetsTableManager(_db, _db.downloadedAssets);
  $BookmarksTableManager get bookmarks =>
      $BookmarksTableManager(_db, _db.bookmarks);
  $HighlightsTableManager get highlights =>
      $HighlightsTableManager(_db, _db.highlights);
  $NotesTableManager get notes => $NotesTableManager(_db, _db.notes);
  $ReadingProgressTableManager get readingProgress =>
      $ReadingProgressTableManager(_db, _db.readingProgress);
  $SettingsTableManager get settings =>
      $SettingsTableManager(_db, _db.settings);
}
