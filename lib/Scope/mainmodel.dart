import 'package:scoped_model/scoped_model.dart';
import 'package:simpleinterest/Scope/product_scope_model.dart';

class MainModel extends Model with ProductScopeModel,UserScopeModel,ConnectedScopeModel{

}