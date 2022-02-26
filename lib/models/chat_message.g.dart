// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast

extension GetChatMessageCollection on Isar {
  IsarCollection<ChatMessage> get chatMessages {
    return getCollection('ChatMessage');
  }
}

final ChatMessageSchema = CollectionSchema(
  name: 'ChatMessage',
  schema:
      '{"name":"ChatMessage","idName":"id","properties":[{"name":"createdAt","type":"Long"},{"name":"roomId","type":"String"},{"name":"text","type":"String"},{"name":"updatedAt","type":"Long"},{"name":"userId","type":"Long"},{"name":"uuid","type":"String"}],"indexes":[],"links":[]}',
  nativeAdapter: const _ChatMessageNativeAdapter(),
  webAdapter: const _ChatMessageWebAdapter(),
  idName: 'id',
  propertyIds: {
    'createdAt': 0,
    'roomId': 1,
    'text': 2,
    'updatedAt': 3,
    'userId': 4,
    'uuid': 5
  },
  listProperties: {},
  indexIds: {},
  indexTypes: {},
  linkIds: {},
  backlinkIds: {},
  linkedCollections: [],
  getId: (obj) {
    if (obj.id == Isar.autoIncrement) {
      return null;
    } else {
      return obj.id;
    }
  },
  setId: (obj, id) => obj.id = id,
  getLinks: (obj) => [],
  version: 2,
);

class _ChatMessageWebAdapter extends IsarWebTypeAdapter<ChatMessage> {
  const _ChatMessageWebAdapter();

  @override
  Object serialize(IsarCollection<ChatMessage> collection, ChatMessage object) {
    final jsObj = IsarNative.newJsObject();
    IsarNative.jsObjectSet(jsObj, 'createdAt', object.createdAt);
    IsarNative.jsObjectSet(jsObj, 'id', object.id);
    IsarNative.jsObjectSet(jsObj, 'roomId', object.roomId);
    IsarNative.jsObjectSet(jsObj, 'text', object.text);
    IsarNative.jsObjectSet(jsObj, 'updatedAt', object.updatedAt);
    IsarNative.jsObjectSet(jsObj, 'userId', object.userId);
    IsarNative.jsObjectSet(jsObj, 'uuid', object.uuid);
    return jsObj;
  }

  @override
  ChatMessage deserialize(
      IsarCollection<ChatMessage> collection, dynamic jsObj) {
    final object = ChatMessage();
    object.createdAt =
        IsarNative.jsObjectGet(jsObj, 'createdAt') ?? double.negativeInfinity;
    object.id = IsarNative.jsObjectGet(jsObj, 'id');
    object.roomId = IsarNative.jsObjectGet(jsObj, 'roomId') ?? '';
    object.text = IsarNative.jsObjectGet(jsObj, 'text') ?? '';
    object.updatedAt =
        IsarNative.jsObjectGet(jsObj, 'updatedAt') ?? double.negativeInfinity;
    object.userId =
        IsarNative.jsObjectGet(jsObj, 'userId') ?? double.negativeInfinity;
    object.uuid = IsarNative.jsObjectGet(jsObj, 'uuid') ?? '';
    return object;
  }

  @override
  P deserializeProperty<P>(Object jsObj, String propertyName) {
    switch (propertyName) {
      case 'createdAt':
        return (IsarNative.jsObjectGet(jsObj, 'createdAt') ??
            double.negativeInfinity) as P;
      case 'id':
        return (IsarNative.jsObjectGet(jsObj, 'id')) as P;
      case 'roomId':
        return (IsarNative.jsObjectGet(jsObj, 'roomId') ?? '') as P;
      case 'text':
        return (IsarNative.jsObjectGet(jsObj, 'text') ?? '') as P;
      case 'updatedAt':
        return (IsarNative.jsObjectGet(jsObj, 'updatedAt') ??
            double.negativeInfinity) as P;
      case 'userId':
        return (IsarNative.jsObjectGet(jsObj, 'userId') ??
            double.negativeInfinity) as P;
      case 'uuid':
        return (IsarNative.jsObjectGet(jsObj, 'uuid') ?? '') as P;
      default:
        throw 'Illegal propertyName';
    }
  }

  @override
  void attachLinks(Isar isar, int id, ChatMessage object) {}
}

class _ChatMessageNativeAdapter extends IsarNativeTypeAdapter<ChatMessage> {
  const _ChatMessageNativeAdapter();

  @override
  void serialize(
      IsarCollection<ChatMessage> collection,
      IsarRawObject rawObj,
      ChatMessage object,
      int staticSize,
      List<int> offsets,
      AdapterAlloc alloc) {
    var dynamicSize = 0;
    final value0 = object.createdAt;
    final _createdAt = value0;
    final value1 = object.roomId;
    final _roomId = IsarBinaryWriter.utf8Encoder.convert(value1);
    dynamicSize += (_roomId.length) as int;
    final value2 = object.text;
    final _text = IsarBinaryWriter.utf8Encoder.convert(value2);
    dynamicSize += (_text.length) as int;
    final value3 = object.updatedAt;
    final _updatedAt = value3;
    final value4 = object.userId;
    final _userId = value4;
    final value5 = object.uuid;
    final _uuid = IsarBinaryWriter.utf8Encoder.convert(value5);
    dynamicSize += (_uuid.length) as int;
    final size = staticSize + dynamicSize;

    rawObj.buffer = alloc(size);
    rawObj.buffer_length = size;
    final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
    final writer = IsarBinaryWriter(buffer, staticSize);
    writer.writeLong(offsets[0], _createdAt);
    writer.writeBytes(offsets[1], _roomId);
    writer.writeBytes(offsets[2], _text);
    writer.writeLong(offsets[3], _updatedAt);
    writer.writeLong(offsets[4], _userId);
    writer.writeBytes(offsets[5], _uuid);
  }

  @override
  ChatMessage deserialize(IsarCollection<ChatMessage> collection, int id,
      IsarBinaryReader reader, List<int> offsets) {
    final object = ChatMessage();
    object.createdAt = reader.readLong(offsets[0]);
    object.id = id;
    object.roomId = reader.readString(offsets[1]);
    object.text = reader.readString(offsets[2]);
    object.updatedAt = reader.readLong(offsets[3]);
    object.userId = reader.readLong(offsets[4]);
    object.uuid = reader.readString(offsets[5]);
    return object;
  }

  @override
  P deserializeProperty<P>(
      int id, IsarBinaryReader reader, int propertyIndex, int offset) {
    switch (propertyIndex) {
      case -1:
        return id as P;
      case 0:
        return (reader.readLong(offset)) as P;
      case 1:
        return (reader.readString(offset)) as P;
      case 2:
        return (reader.readString(offset)) as P;
      case 3:
        return (reader.readLong(offset)) as P;
      case 4:
        return (reader.readLong(offset)) as P;
      case 5:
        return (reader.readString(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }

  @override
  void attachLinks(Isar isar, int id, ChatMessage object) {}
}

extension ChatMessageQueryWhereSort
    on QueryBuilder<ChatMessage, ChatMessage, QWhere> {
  QueryBuilder<ChatMessage, ChatMessage, QAfterWhere> anyId() {
    return addWhereClauseInternal(const WhereClause(indexName: null));
  }
}

extension ChatMessageQueryWhere
    on QueryBuilder<ChatMessage, ChatMessage, QWhereClause> {
  QueryBuilder<ChatMessage, ChatMessage, QAfterWhereClause> idEqualTo(int? id) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [id],
      includeLower: true,
      upper: [id],
      includeUpper: true,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterWhereClause> idNotEqualTo(
      int? id) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(WhereClause(
        indexName: null,
        upper: [id],
        includeUpper: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: null,
        lower: [id],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(WhereClause(
        indexName: null,
        lower: [id],
        includeLower: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: null,
        upper: [id],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterWhereClause> idGreaterThan(
    int? id, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [id],
      includeLower: include,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterWhereClause> idLessThan(
    int? id, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      upper: [id],
      includeUpper: include,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterWhereClause> idBetween(
    int? lowerId,
    int? upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [lowerId],
      includeLower: includeLower,
      upper: [upperId],
      includeUpper: includeUpper,
    ));
  }
}

extension ChatMessageQueryFilter
    on QueryBuilder<ChatMessage, ChatMessage, QFilterCondition> {
  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      createdAtEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'createdAt',
      value: value,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      createdAtGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'createdAt',
      value: value,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      createdAtLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'createdAt',
      value: value,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      createdAtBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'createdAt',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> idIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'id',
      value: null,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> idEqualTo(
      int? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> idGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> idLessThan(
    int? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> idBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'id',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> roomIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'roomId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      roomIdGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'roomId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> roomIdLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'roomId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> roomIdBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'roomId',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      roomIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'roomId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> roomIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'roomId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> roomIdContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'roomId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> roomIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'roomId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> textEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'text',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> textGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'text',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> textLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'text',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> textBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'text',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> textStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'text',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> textEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'text',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> textContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'text',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> textMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'text',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      updatedAtEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'updatedAt',
      value: value,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      updatedAtGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'updatedAt',
      value: value,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      updatedAtLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'updatedAt',
      value: value,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      updatedAtBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'updatedAt',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> userIdEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'userId',
      value: value,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      userIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'userId',
      value: value,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> userIdLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'userId',
      value: value,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> userIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'userId',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> uuidEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'uuid',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> uuidGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'uuid',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> uuidLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'uuid',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> uuidBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'uuid',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> uuidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'uuid',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> uuidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'uuid',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> uuidContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'uuid',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> uuidMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'uuid',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }
}

extension ChatMessageQueryLinks
    on QueryBuilder<ChatMessage, ChatMessage, QFilterCondition> {}

extension ChatMessageQueryWhereSortBy
    on QueryBuilder<ChatMessage, ChatMessage, QSortBy> {
  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortByCreatedAt() {
    return addSortByInternal('createdAt', Sort.asc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortByCreatedAtDesc() {
    return addSortByInternal('createdAt', Sort.desc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortByRoomId() {
    return addSortByInternal('roomId', Sort.asc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortByRoomIdDesc() {
    return addSortByInternal('roomId', Sort.desc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortByText() {
    return addSortByInternal('text', Sort.asc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortByTextDesc() {
    return addSortByInternal('text', Sort.desc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortByUpdatedAt() {
    return addSortByInternal('updatedAt', Sort.asc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortByUpdatedAtDesc() {
    return addSortByInternal('updatedAt', Sort.desc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortByUserId() {
    return addSortByInternal('userId', Sort.asc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortByUserIdDesc() {
    return addSortByInternal('userId', Sort.desc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortByUuid() {
    return addSortByInternal('uuid', Sort.asc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortByUuidDesc() {
    return addSortByInternal('uuid', Sort.desc);
  }
}

extension ChatMessageQueryWhereSortThenBy
    on QueryBuilder<ChatMessage, ChatMessage, QSortThenBy> {
  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenByCreatedAt() {
    return addSortByInternal('createdAt', Sort.asc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenByCreatedAtDesc() {
    return addSortByInternal('createdAt', Sort.desc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenByRoomId() {
    return addSortByInternal('roomId', Sort.asc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenByRoomIdDesc() {
    return addSortByInternal('roomId', Sort.desc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenByText() {
    return addSortByInternal('text', Sort.asc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenByTextDesc() {
    return addSortByInternal('text', Sort.desc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenByUpdatedAt() {
    return addSortByInternal('updatedAt', Sort.asc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenByUpdatedAtDesc() {
    return addSortByInternal('updatedAt', Sort.desc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenByUserId() {
    return addSortByInternal('userId', Sort.asc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenByUserIdDesc() {
    return addSortByInternal('userId', Sort.desc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenByUuid() {
    return addSortByInternal('uuid', Sort.asc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenByUuidDesc() {
    return addSortByInternal('uuid', Sort.desc);
  }
}

extension ChatMessageQueryWhereDistinct
    on QueryBuilder<ChatMessage, ChatMessage, QDistinct> {
  QueryBuilder<ChatMessage, ChatMessage, QDistinct> distinctByCreatedAt() {
    return addDistinctByInternal('createdAt');
  }

  QueryBuilder<ChatMessage, ChatMessage, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<ChatMessage, ChatMessage, QDistinct> distinctByRoomId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('roomId', caseSensitive: caseSensitive);
  }

  QueryBuilder<ChatMessage, ChatMessage, QDistinct> distinctByText(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('text', caseSensitive: caseSensitive);
  }

  QueryBuilder<ChatMessage, ChatMessage, QDistinct> distinctByUpdatedAt() {
    return addDistinctByInternal('updatedAt');
  }

  QueryBuilder<ChatMessage, ChatMessage, QDistinct> distinctByUserId() {
    return addDistinctByInternal('userId');
  }

  QueryBuilder<ChatMessage, ChatMessage, QDistinct> distinctByUuid(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('uuid', caseSensitive: caseSensitive);
  }
}

extension ChatMessageQueryProperty
    on QueryBuilder<ChatMessage, ChatMessage, QQueryProperty> {
  QueryBuilder<ChatMessage, int, QQueryOperations> createdAtProperty() {
    return addPropertyNameInternal('createdAt');
  }

  QueryBuilder<ChatMessage, int?, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<ChatMessage, String, QQueryOperations> roomIdProperty() {
    return addPropertyNameInternal('roomId');
  }

  QueryBuilder<ChatMessage, String, QQueryOperations> textProperty() {
    return addPropertyNameInternal('text');
  }

  QueryBuilder<ChatMessage, int, QQueryOperations> updatedAtProperty() {
    return addPropertyNameInternal('updatedAt');
  }

  QueryBuilder<ChatMessage, int, QQueryOperations> userIdProperty() {
    return addPropertyNameInternal('userId');
  }

  QueryBuilder<ChatMessage, String, QQueryOperations> uuidProperty() {
    return addPropertyNameInternal('uuid');
  }
}
