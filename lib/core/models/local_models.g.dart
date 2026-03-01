// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_models.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetBudgetInfoCollection on Isar {
  IsarCollection<BudgetInfo> get budgetInfos => this.collection();
}

const BudgetInfoSchema = CollectionSchema(
  name: r'BudgetInfo',
  id: 5700676321995979521,
  properties: {
    r'gctRate': PropertySchema(
      id: 0,
      name: r'gctRate',
      type: IsarType.double,
    ),
    r'lastResetDate': PropertySchema(
      id: 1,
      name: r'lastResetDate',
      type: IsarType.dateTime,
    ),
    r'monthlyBudget': PropertySchema(
      id: 2,
      name: r'monthlyBudget',
      type: IsarType.double,
    ),
    r'totalSpent': PropertySchema(
      id: 3,
      name: r'totalSpent',
      type: IsarType.double,
    )
  },
  estimateSize: _budgetInfoEstimateSize,
  serialize: _budgetInfoSerialize,
  deserialize: _budgetInfoDeserialize,
  deserializeProp: _budgetInfoDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _budgetInfoGetId,
  getLinks: _budgetInfoGetLinks,
  attach: _budgetInfoAttach,
  version: '3.1.0+1',
);

int _budgetInfoEstimateSize(
  BudgetInfo object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _budgetInfoSerialize(
  BudgetInfo object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.gctRate);
  writer.writeDateTime(offsets[1], object.lastResetDate);
  writer.writeDouble(offsets[2], object.monthlyBudget);
  writer.writeDouble(offsets[3], object.totalSpent);
}

BudgetInfo _budgetInfoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = BudgetInfo();
  object.gctRate = reader.readDouble(offsets[0]);
  object.id = id;
  object.lastResetDate = reader.readDateTime(offsets[1]);
  object.monthlyBudget = reader.readDouble(offsets[2]);
  object.totalSpent = reader.readDouble(offsets[3]);
  return object;
}

P _budgetInfoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _budgetInfoGetId(BudgetInfo object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _budgetInfoGetLinks(BudgetInfo object) {
  return [];
}

void _budgetInfoAttach(IsarCollection<dynamic> col, Id id, BudgetInfo object) {
  object.id = id;
}

extension BudgetInfoQueryWhereSort
    on QueryBuilder<BudgetInfo, BudgetInfo, QWhere> {
  QueryBuilder<BudgetInfo, BudgetInfo, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension BudgetInfoQueryWhere
    on QueryBuilder<BudgetInfo, BudgetInfo, QWhereClause> {
  QueryBuilder<BudgetInfo, BudgetInfo, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<BudgetInfo, BudgetInfo, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<BudgetInfo, BudgetInfo, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<BudgetInfo, BudgetInfo, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<BudgetInfo, BudgetInfo, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension BudgetInfoQueryFilter
    on QueryBuilder<BudgetInfo, BudgetInfo, QFilterCondition> {
  QueryBuilder<BudgetInfo, BudgetInfo, QAfterFilterCondition> gctRateEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gctRate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BudgetInfo, BudgetInfo, QAfterFilterCondition>
      gctRateGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'gctRate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BudgetInfo, BudgetInfo, QAfterFilterCondition> gctRateLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'gctRate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BudgetInfo, BudgetInfo, QAfterFilterCondition> gctRateBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'gctRate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BudgetInfo, BudgetInfo, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<BudgetInfo, BudgetInfo, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<BudgetInfo, BudgetInfo, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<BudgetInfo, BudgetInfo, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BudgetInfo, BudgetInfo, QAfterFilterCondition>
      lastResetDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastResetDate',
        value: value,
      ));
    });
  }

  QueryBuilder<BudgetInfo, BudgetInfo, QAfterFilterCondition>
      lastResetDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastResetDate',
        value: value,
      ));
    });
  }

  QueryBuilder<BudgetInfo, BudgetInfo, QAfterFilterCondition>
      lastResetDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastResetDate',
        value: value,
      ));
    });
  }

  QueryBuilder<BudgetInfo, BudgetInfo, QAfterFilterCondition>
      lastResetDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastResetDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BudgetInfo, BudgetInfo, QAfterFilterCondition>
      monthlyBudgetEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'monthlyBudget',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BudgetInfo, BudgetInfo, QAfterFilterCondition>
      monthlyBudgetGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'monthlyBudget',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BudgetInfo, BudgetInfo, QAfterFilterCondition>
      monthlyBudgetLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'monthlyBudget',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BudgetInfo, BudgetInfo, QAfterFilterCondition>
      monthlyBudgetBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'monthlyBudget',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BudgetInfo, BudgetInfo, QAfterFilterCondition> totalSpentEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalSpent',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BudgetInfo, BudgetInfo, QAfterFilterCondition>
      totalSpentGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalSpent',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BudgetInfo, BudgetInfo, QAfterFilterCondition>
      totalSpentLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalSpent',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BudgetInfo, BudgetInfo, QAfterFilterCondition> totalSpentBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalSpent',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension BudgetInfoQueryObject
    on QueryBuilder<BudgetInfo, BudgetInfo, QFilterCondition> {}

extension BudgetInfoQueryLinks
    on QueryBuilder<BudgetInfo, BudgetInfo, QFilterCondition> {}

extension BudgetInfoQuerySortBy
    on QueryBuilder<BudgetInfo, BudgetInfo, QSortBy> {
  QueryBuilder<BudgetInfo, BudgetInfo, QAfterSortBy> sortByGctRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gctRate', Sort.asc);
    });
  }

  QueryBuilder<BudgetInfo, BudgetInfo, QAfterSortBy> sortByGctRateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gctRate', Sort.desc);
    });
  }

  QueryBuilder<BudgetInfo, BudgetInfo, QAfterSortBy> sortByLastResetDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastResetDate', Sort.asc);
    });
  }

  QueryBuilder<BudgetInfo, BudgetInfo, QAfterSortBy> sortByLastResetDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastResetDate', Sort.desc);
    });
  }

  QueryBuilder<BudgetInfo, BudgetInfo, QAfterSortBy> sortByMonthlyBudget() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monthlyBudget', Sort.asc);
    });
  }

  QueryBuilder<BudgetInfo, BudgetInfo, QAfterSortBy> sortByMonthlyBudgetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monthlyBudget', Sort.desc);
    });
  }

  QueryBuilder<BudgetInfo, BudgetInfo, QAfterSortBy> sortByTotalSpent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalSpent', Sort.asc);
    });
  }

  QueryBuilder<BudgetInfo, BudgetInfo, QAfterSortBy> sortByTotalSpentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalSpent', Sort.desc);
    });
  }
}

extension BudgetInfoQuerySortThenBy
    on QueryBuilder<BudgetInfo, BudgetInfo, QSortThenBy> {
  QueryBuilder<BudgetInfo, BudgetInfo, QAfterSortBy> thenByGctRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gctRate', Sort.asc);
    });
  }

  QueryBuilder<BudgetInfo, BudgetInfo, QAfterSortBy> thenByGctRateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gctRate', Sort.desc);
    });
  }

  QueryBuilder<BudgetInfo, BudgetInfo, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<BudgetInfo, BudgetInfo, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<BudgetInfo, BudgetInfo, QAfterSortBy> thenByLastResetDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastResetDate', Sort.asc);
    });
  }

  QueryBuilder<BudgetInfo, BudgetInfo, QAfterSortBy> thenByLastResetDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastResetDate', Sort.desc);
    });
  }

  QueryBuilder<BudgetInfo, BudgetInfo, QAfterSortBy> thenByMonthlyBudget() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monthlyBudget', Sort.asc);
    });
  }

  QueryBuilder<BudgetInfo, BudgetInfo, QAfterSortBy> thenByMonthlyBudgetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monthlyBudget', Sort.desc);
    });
  }

  QueryBuilder<BudgetInfo, BudgetInfo, QAfterSortBy> thenByTotalSpent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalSpent', Sort.asc);
    });
  }

  QueryBuilder<BudgetInfo, BudgetInfo, QAfterSortBy> thenByTotalSpentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalSpent', Sort.desc);
    });
  }
}

extension BudgetInfoQueryWhereDistinct
    on QueryBuilder<BudgetInfo, BudgetInfo, QDistinct> {
  QueryBuilder<BudgetInfo, BudgetInfo, QDistinct> distinctByGctRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'gctRate');
    });
  }

  QueryBuilder<BudgetInfo, BudgetInfo, QDistinct> distinctByLastResetDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastResetDate');
    });
  }

  QueryBuilder<BudgetInfo, BudgetInfo, QDistinct> distinctByMonthlyBudget() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'monthlyBudget');
    });
  }

  QueryBuilder<BudgetInfo, BudgetInfo, QDistinct> distinctByTotalSpent() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalSpent');
    });
  }
}

extension BudgetInfoQueryProperty
    on QueryBuilder<BudgetInfo, BudgetInfo, QQueryProperty> {
  QueryBuilder<BudgetInfo, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<BudgetInfo, double, QQueryOperations> gctRateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'gctRate');
    });
  }

  QueryBuilder<BudgetInfo, DateTime, QQueryOperations> lastResetDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastResetDate');
    });
  }

  QueryBuilder<BudgetInfo, double, QQueryOperations> monthlyBudgetProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'monthlyBudget');
    });
  }

  QueryBuilder<BudgetInfo, double, QQueryOperations> totalSpentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalSpent');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCheckoutTransactionCollection on Isar {
  IsarCollection<CheckoutTransaction> get checkoutTransactions =>
      this.collection();
}

const CheckoutTransactionSchema = CollectionSchema(
  name: r'CheckoutTransaction',
  id: 5683193343551094051,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'finalTotal': PropertySchema(
      id: 1,
      name: r'finalTotal',
      type: IsarType.double,
    ),
    r'gct': PropertySchema(
      id: 2,
      name: r'gct',
      type: IsarType.double,
    ),
    r'gctRate': PropertySchema(
      id: 3,
      name: r'gctRate',
      type: IsarType.double,
    ),
    r'items': PropertySchema(
      id: 4,
      name: r'items',
      type: IsarType.objectList,
      target: r'CheckoutLineItem',
    ),
    r'itemsSubtotal': PropertySchema(
      id: 5,
      name: r'itemsSubtotal',
      type: IsarType.double,
    ),
    r'storeName': PropertySchema(
      id: 6,
      name: r'storeName',
      type: IsarType.string,
    ),
    r'subtotal': PropertySchema(
      id: 7,
      name: r'subtotal',
      type: IsarType.double,
    ),
    r'taxableBase': PropertySchema(
      id: 8,
      name: r'taxableBase',
      type: IsarType.double,
    ),
    r'totalDiscount': PropertySchema(
      id: 9,
      name: r'totalDiscount',
      type: IsarType.double,
    )
  },
  estimateSize: _checkoutTransactionEstimateSize,
  serialize: _checkoutTransactionSerialize,
  deserialize: _checkoutTransactionDeserialize,
  deserializeProp: _checkoutTransactionDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {r'CheckoutLineItem': CheckoutLineItemSchema},
  getId: _checkoutTransactionGetId,
  getLinks: _checkoutTransactionGetLinks,
  attach: _checkoutTransactionAttach,
  version: '3.1.0+1',
);

int _checkoutTransactionEstimateSize(
  CheckoutTransaction object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.items.length * 3;
  {
    final offsets = allOffsets[CheckoutLineItem]!;
    for (var i = 0; i < object.items.length; i++) {
      final value = object.items[i];
      bytesCount +=
          CheckoutLineItemSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  {
    final value = object.storeName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _checkoutTransactionSerialize(
  CheckoutTransaction object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeDouble(offsets[1], object.finalTotal);
  writer.writeDouble(offsets[2], object.gct);
  writer.writeDouble(offsets[3], object.gctRate);
  writer.writeObjectList<CheckoutLineItem>(
    offsets[4],
    allOffsets,
    CheckoutLineItemSchema.serialize,
    object.items,
  );
  writer.writeDouble(offsets[5], object.itemsSubtotal);
  writer.writeString(offsets[6], object.storeName);
  writer.writeDouble(offsets[7], object.subtotal);
  writer.writeDouble(offsets[8], object.taxableBase);
  writer.writeDouble(offsets[9], object.totalDiscount);
}

CheckoutTransaction _checkoutTransactionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CheckoutTransaction();
  object.createdAt = reader.readDateTime(offsets[0]);
  object.finalTotal = reader.readDouble(offsets[1]);
  object.gct = reader.readDouble(offsets[2]);
  object.gctRate = reader.readDouble(offsets[3]);
  object.id = id;
  object.items = reader.readObjectList<CheckoutLineItem>(
        offsets[4],
        CheckoutLineItemSchema.deserialize,
        allOffsets,
        CheckoutLineItem(),
      ) ??
      [];
  object.itemsSubtotal = reader.readDouble(offsets[5]);
  object.storeName = reader.readStringOrNull(offsets[6]);
  object.subtotal = reader.readDouble(offsets[7]);
  object.taxableBase = reader.readDouble(offsets[8]);
  object.totalDiscount = reader.readDouble(offsets[9]);
  return object;
}

P _checkoutTransactionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readDouble(offset)) as P;
    case 4:
      return (reader.readObjectList<CheckoutLineItem>(
            offset,
            CheckoutLineItemSchema.deserialize,
            allOffsets,
            CheckoutLineItem(),
          ) ??
          []) as P;
    case 5:
      return (reader.readDouble(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readDouble(offset)) as P;
    case 8:
      return (reader.readDouble(offset)) as P;
    case 9:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _checkoutTransactionGetId(CheckoutTransaction object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _checkoutTransactionGetLinks(
    CheckoutTransaction object) {
  return [];
}

void _checkoutTransactionAttach(
    IsarCollection<dynamic> col, Id id, CheckoutTransaction object) {
  object.id = id;
}

extension CheckoutTransactionQueryWhereSort
    on QueryBuilder<CheckoutTransaction, CheckoutTransaction, QWhere> {
  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CheckoutTransactionQueryWhere
    on QueryBuilder<CheckoutTransaction, CheckoutTransaction, QWhereClause> {
  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterWhereClause>
      idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CheckoutTransactionQueryFilter on QueryBuilder<CheckoutTransaction,
    CheckoutTransaction, QFilterCondition> {
  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterFilterCondition>
      createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterFilterCondition>
      createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterFilterCondition>
      finalTotalEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'finalTotal',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterFilterCondition>
      finalTotalGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'finalTotal',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterFilterCondition>
      finalTotalLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'finalTotal',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterFilterCondition>
      finalTotalBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'finalTotal',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterFilterCondition>
      gctEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gct',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterFilterCondition>
      gctGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'gct',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterFilterCondition>
      gctLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'gct',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterFilterCondition>
      gctBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'gct',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterFilterCondition>
      gctRateEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gctRate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterFilterCondition>
      gctRateGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'gctRate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterFilterCondition>
      gctRateLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'gctRate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterFilterCondition>
      gctRateBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'gctRate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterFilterCondition>
      itemsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'items',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterFilterCondition>
      itemsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'items',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterFilterCondition>
      itemsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'items',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterFilterCondition>
      itemsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'items',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterFilterCondition>
      itemsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'items',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterFilterCondition>
      itemsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'items',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterFilterCondition>
      itemsSubtotalEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'itemsSubtotal',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterFilterCondition>
      itemsSubtotalGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'itemsSubtotal',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterFilterCondition>
      itemsSubtotalLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'itemsSubtotal',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterFilterCondition>
      itemsSubtotalBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'itemsSubtotal',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterFilterCondition>
      storeNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'storeName',
      ));
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterFilterCondition>
      storeNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'storeName',
      ));
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterFilterCondition>
      storeNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'storeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterFilterCondition>
      storeNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'storeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterFilterCondition>
      storeNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'storeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterFilterCondition>
      storeNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'storeName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterFilterCondition>
      storeNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'storeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterFilterCondition>
      storeNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'storeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterFilterCondition>
      storeNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'storeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterFilterCondition>
      storeNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'storeName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterFilterCondition>
      storeNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'storeName',
        value: '',
      ));
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterFilterCondition>
      storeNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'storeName',
        value: '',
      ));
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterFilterCondition>
      subtotalEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subtotal',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterFilterCondition>
      subtotalGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'subtotal',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterFilterCondition>
      subtotalLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'subtotal',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterFilterCondition>
      subtotalBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'subtotal',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterFilterCondition>
      taxableBaseEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'taxableBase',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterFilterCondition>
      taxableBaseGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'taxableBase',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterFilterCondition>
      taxableBaseLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'taxableBase',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterFilterCondition>
      taxableBaseBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'taxableBase',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterFilterCondition>
      totalDiscountEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalDiscount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterFilterCondition>
      totalDiscountGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalDiscount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterFilterCondition>
      totalDiscountLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalDiscount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterFilterCondition>
      totalDiscountBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalDiscount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension CheckoutTransactionQueryObject on QueryBuilder<CheckoutTransaction,
    CheckoutTransaction, QFilterCondition> {
  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterFilterCondition>
      itemsElement(FilterQuery<CheckoutLineItem> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'items');
    });
  }
}

extension CheckoutTransactionQueryLinks on QueryBuilder<CheckoutTransaction,
    CheckoutTransaction, QFilterCondition> {}

extension CheckoutTransactionQuerySortBy
    on QueryBuilder<CheckoutTransaction, CheckoutTransaction, QSortBy> {
  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterSortBy>
      sortByFinalTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'finalTotal', Sort.asc);
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterSortBy>
      sortByFinalTotalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'finalTotal', Sort.desc);
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterSortBy>
      sortByGct() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gct', Sort.asc);
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterSortBy>
      sortByGctDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gct', Sort.desc);
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterSortBy>
      sortByGctRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gctRate', Sort.asc);
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterSortBy>
      sortByGctRateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gctRate', Sort.desc);
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterSortBy>
      sortByItemsSubtotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'itemsSubtotal', Sort.asc);
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterSortBy>
      sortByItemsSubtotalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'itemsSubtotal', Sort.desc);
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterSortBy>
      sortByStoreName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'storeName', Sort.asc);
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterSortBy>
      sortByStoreNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'storeName', Sort.desc);
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterSortBy>
      sortBySubtotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subtotal', Sort.asc);
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterSortBy>
      sortBySubtotalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subtotal', Sort.desc);
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterSortBy>
      sortByTaxableBase() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taxableBase', Sort.asc);
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterSortBy>
      sortByTaxableBaseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taxableBase', Sort.desc);
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterSortBy>
      sortByTotalDiscount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalDiscount', Sort.asc);
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterSortBy>
      sortByTotalDiscountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalDiscount', Sort.desc);
    });
  }
}

extension CheckoutTransactionQuerySortThenBy
    on QueryBuilder<CheckoutTransaction, CheckoutTransaction, QSortThenBy> {
  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterSortBy>
      thenByFinalTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'finalTotal', Sort.asc);
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterSortBy>
      thenByFinalTotalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'finalTotal', Sort.desc);
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterSortBy>
      thenByGct() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gct', Sort.asc);
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterSortBy>
      thenByGctDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gct', Sort.desc);
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterSortBy>
      thenByGctRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gctRate', Sort.asc);
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterSortBy>
      thenByGctRateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gctRate', Sort.desc);
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterSortBy>
      thenByItemsSubtotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'itemsSubtotal', Sort.asc);
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterSortBy>
      thenByItemsSubtotalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'itemsSubtotal', Sort.desc);
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterSortBy>
      thenByStoreName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'storeName', Sort.asc);
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterSortBy>
      thenByStoreNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'storeName', Sort.desc);
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterSortBy>
      thenBySubtotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subtotal', Sort.asc);
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterSortBy>
      thenBySubtotalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subtotal', Sort.desc);
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterSortBy>
      thenByTaxableBase() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taxableBase', Sort.asc);
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterSortBy>
      thenByTaxableBaseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taxableBase', Sort.desc);
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterSortBy>
      thenByTotalDiscount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalDiscount', Sort.asc);
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QAfterSortBy>
      thenByTotalDiscountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalDiscount', Sort.desc);
    });
  }
}

extension CheckoutTransactionQueryWhereDistinct
    on QueryBuilder<CheckoutTransaction, CheckoutTransaction, QDistinct> {
  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QDistinct>
      distinctByFinalTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'finalTotal');
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QDistinct>
      distinctByGct() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'gct');
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QDistinct>
      distinctByGctRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'gctRate');
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QDistinct>
      distinctByItemsSubtotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'itemsSubtotal');
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QDistinct>
      distinctByStoreName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'storeName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QDistinct>
      distinctBySubtotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'subtotal');
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QDistinct>
      distinctByTaxableBase() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'taxableBase');
    });
  }

  QueryBuilder<CheckoutTransaction, CheckoutTransaction, QDistinct>
      distinctByTotalDiscount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalDiscount');
    });
  }
}

extension CheckoutTransactionQueryProperty
    on QueryBuilder<CheckoutTransaction, CheckoutTransaction, QQueryProperty> {
  QueryBuilder<CheckoutTransaction, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CheckoutTransaction, DateTime, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<CheckoutTransaction, double, QQueryOperations>
      finalTotalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'finalTotal');
    });
  }

  QueryBuilder<CheckoutTransaction, double, QQueryOperations> gctProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'gct');
    });
  }

  QueryBuilder<CheckoutTransaction, double, QQueryOperations>
      gctRateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'gctRate');
    });
  }

  QueryBuilder<CheckoutTransaction, List<CheckoutLineItem>, QQueryOperations>
      itemsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'items');
    });
  }

  QueryBuilder<CheckoutTransaction, double, QQueryOperations>
      itemsSubtotalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'itemsSubtotal');
    });
  }

  QueryBuilder<CheckoutTransaction, String?, QQueryOperations>
      storeNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'storeName');
    });
  }

  QueryBuilder<CheckoutTransaction, double, QQueryOperations>
      subtotalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'subtotal');
    });
  }

  QueryBuilder<CheckoutTransaction, double, QQueryOperations>
      taxableBaseProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'taxableBase');
    });
  }

  QueryBuilder<CheckoutTransaction, double, QQueryOperations>
      totalDiscountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalDiscount');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const CheckoutLineItemSchema = Schema(
  name: r'CheckoutLineItem',
  id: -1507349497274694868,
  properties: {
    r'category': PropertySchema(
      id: 0,
      name: r'category',
      type: IsarType.string,
    ),
    r'isPerWeight': PropertySchema(
      id: 1,
      name: r'isPerWeight',
      type: IsarType.bool,
    ),
    r'isTaxable': PropertySchema(
      id: 2,
      name: r'isTaxable',
      type: IsarType.bool,
    ),
    r'name': PropertySchema(
      id: 3,
      name: r'name',
      type: IsarType.string,
    ),
    r'quantity': PropertySchema(
      id: 4,
      name: r'quantity',
      type: IsarType.double,
    ),
    r'unitDiscount': PropertySchema(
      id: 5,
      name: r'unitDiscount',
      type: IsarType.double,
    ),
    r'unitPrice': PropertySchema(
      id: 6,
      name: r'unitPrice',
      type: IsarType.double,
    )
  },
  estimateSize: _checkoutLineItemEstimateSize,
  serialize: _checkoutLineItemSerialize,
  deserialize: _checkoutLineItemDeserialize,
  deserializeProp: _checkoutLineItemDeserializeProp,
);

int _checkoutLineItemEstimateSize(
  CheckoutLineItem object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.category.length * 3;
  bytesCount += 3 + object.name.length * 3;
  return bytesCount;
}

void _checkoutLineItemSerialize(
  CheckoutLineItem object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.category);
  writer.writeBool(offsets[1], object.isPerWeight);
  writer.writeBool(offsets[2], object.isTaxable);
  writer.writeString(offsets[3], object.name);
  writer.writeDouble(offsets[4], object.quantity);
  writer.writeDouble(offsets[5], object.unitDiscount);
  writer.writeDouble(offsets[6], object.unitPrice);
}

CheckoutLineItem _checkoutLineItemDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CheckoutLineItem();
  object.category = reader.readString(offsets[0]);
  object.isPerWeight = reader.readBool(offsets[1]);
  object.isTaxable = reader.readBool(offsets[2]);
  object.name = reader.readString(offsets[3]);
  object.quantity = reader.readDouble(offsets[4]);
  object.unitDiscount = reader.readDouble(offsets[5]);
  object.unitPrice = reader.readDouble(offsets[6]);
  return object;
}

P _checkoutLineItemDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readDouble(offset)) as P;
    case 5:
      return (reader.readDouble(offset)) as P;
    case 6:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension CheckoutLineItemQueryFilter
    on QueryBuilder<CheckoutLineItem, CheckoutLineItem, QFilterCondition> {
  QueryBuilder<CheckoutLineItem, CheckoutLineItem, QAfterFilterCondition>
      categoryEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CheckoutLineItem, CheckoutLineItem, QAfterFilterCondition>
      categoryGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CheckoutLineItem, CheckoutLineItem, QAfterFilterCondition>
      categoryLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CheckoutLineItem, CheckoutLineItem, QAfterFilterCondition>
      categoryBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'category',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CheckoutLineItem, CheckoutLineItem, QAfterFilterCondition>
      categoryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CheckoutLineItem, CheckoutLineItem, QAfterFilterCondition>
      categoryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CheckoutLineItem, CheckoutLineItem, QAfterFilterCondition>
      categoryContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CheckoutLineItem, CheckoutLineItem, QAfterFilterCondition>
      categoryMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'category',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CheckoutLineItem, CheckoutLineItem, QAfterFilterCondition>
      categoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<CheckoutLineItem, CheckoutLineItem, QAfterFilterCondition>
      categoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<CheckoutLineItem, CheckoutLineItem, QAfterFilterCondition>
      isPerWeightEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isPerWeight',
        value: value,
      ));
    });
  }

  QueryBuilder<CheckoutLineItem, CheckoutLineItem, QAfterFilterCondition>
      isTaxableEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isTaxable',
        value: value,
      ));
    });
  }

  QueryBuilder<CheckoutLineItem, CheckoutLineItem, QAfterFilterCondition>
      nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CheckoutLineItem, CheckoutLineItem, QAfterFilterCondition>
      nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CheckoutLineItem, CheckoutLineItem, QAfterFilterCondition>
      nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CheckoutLineItem, CheckoutLineItem, QAfterFilterCondition>
      nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CheckoutLineItem, CheckoutLineItem, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CheckoutLineItem, CheckoutLineItem, QAfterFilterCondition>
      nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CheckoutLineItem, CheckoutLineItem, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CheckoutLineItem, CheckoutLineItem, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CheckoutLineItem, CheckoutLineItem, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<CheckoutLineItem, CheckoutLineItem, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<CheckoutLineItem, CheckoutLineItem, QAfterFilterCondition>
      quantityEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quantity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CheckoutLineItem, CheckoutLineItem, QAfterFilterCondition>
      quantityGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quantity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CheckoutLineItem, CheckoutLineItem, QAfterFilterCondition>
      quantityLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quantity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CheckoutLineItem, CheckoutLineItem, QAfterFilterCondition>
      quantityBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quantity',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CheckoutLineItem, CheckoutLineItem, QAfterFilterCondition>
      unitDiscountEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'unitDiscount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CheckoutLineItem, CheckoutLineItem, QAfterFilterCondition>
      unitDiscountGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'unitDiscount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CheckoutLineItem, CheckoutLineItem, QAfterFilterCondition>
      unitDiscountLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'unitDiscount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CheckoutLineItem, CheckoutLineItem, QAfterFilterCondition>
      unitDiscountBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'unitDiscount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CheckoutLineItem, CheckoutLineItem, QAfterFilterCondition>
      unitPriceEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'unitPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CheckoutLineItem, CheckoutLineItem, QAfterFilterCondition>
      unitPriceGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'unitPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CheckoutLineItem, CheckoutLineItem, QAfterFilterCondition>
      unitPriceLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'unitPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CheckoutLineItem, CheckoutLineItem, QAfterFilterCondition>
      unitPriceBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'unitPrice',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension CheckoutLineItemQueryObject
    on QueryBuilder<CheckoutLineItem, CheckoutLineItem, QFilterCondition> {}
