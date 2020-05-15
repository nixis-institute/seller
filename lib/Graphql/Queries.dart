
String updateSubProductQuery ="""
mutation x(\$id:ID!,\$mrp:String!,\$list:String!,\$qty:String!){
  updateSubProduct(id:\$id,mrp:\$mrp,listPrice:\$list,qty:\$qty)
  {
    prd{
      size
    }
  }
}
""";

String createSubProductQuery ="""
mutation x(\$id:ID!,\$size:String!,\$color:String!,\$qty:String!,\$mrp:String!,\$list:String!){
  createSubProduct(id:\$id,size:\$size,color:\$color,qty:\$qty,mrp:\$mrp,listPrice:\$list){
    subProduct{
      id
    }
  }
}
""";

String getProductByParentId ="""
query x(\$id:ID!){
  productByParentId(id:\$id)
  {
    edges{
      node{
        id
        listPrice
        mrp
        size
        color
        qty
        productimagesSet{
          edges{
            node{
              id
              largeImage
              normalImage
              thumbnailImage
            }
          }
        }
      }
    }
  }
}

""";


String imageUploadQuery ="""
mutation (\$id: Int!) {
  uploadImages(id: \$id) {
    success
  }
}
""";

String uploadParentProductQuery ="""

mutation x(\$id:ID!,\$prdName:String!,\$brand:String!,\$shortDesc:String!,\$longDesc:String!){
	createParentProduct(typeId:\$id,brand:\$brand,prdName:\$prdName,shortDesc:\$shortDesc,longDesc:\$longDesc)
  {
    prdId
    prd{
      id
      name      
    }
  }
}

""";
String searchByNameQuery ="""
query x(\$match:String!){
  searchResult(match:\$match)
  {
    id
    name
    brand
    productimagesSet{
      edges{
        node{
          id
          thumbnailImage
        }
      }
    }
  }
}

""";

String productBySublistIdQuery="""
query x(\$id:ID!){
  productBySublistId(sublistId:\$id){
    edges{
      node{
        id
        productSize
        brand
        name
        productimagesSet{
          edges{
            node{
              thumbnailImage
            }
          }
        }
      }
    }
  }
}
""";

String searchByCategoryQuery = """
query x(\$match:String!){
  searchCategory(match:\$match){
    name
    id
    productSize
    subCategory{
      name
      mainCategory{
        name
      }
    }
  }
}

""";

String searchByBrandQuery ="""
query x(\$match:String!){
  searchByBrand(match:\$match)
  {
    id
    name
    brand
    productimagesSet{
      edges{
        node{
          id
          thumbnailImage
        }
      }
    }
  }
}
""";

String changeProductStockStatusQuery ="""
mutation x(\$id:ID!,\$status:Int!){
  stockStatusProduct(id:\$id,instock:\$status)
  {
    success
  }
}
""";

String changeProductActivationQuery ="""
mutation x(\$id:ID!,\$status:Int!){
  activateProduct(id:\$id,activate:\$status)
  {
    success
  }
}

""";

String getAllProductsQuery ="""
{
  allProducts{
    edges{
      node{
        id
        brand
        name
        listPrice
        productSize
        sizes
        color
        mrp
        instock
        isActive
        subproductSet{
          edges{
            node{
              id
              listPrice
              size
            }
          }
        }
        productimagesSet{
          edges{
            node{
              id
              normalImage
              thumbnailImage
            }
          }
        }
      }
    }
  }
  }

""";

String getProductByTypeId ="""
query x(\$id:ID!){
  productBySublistId(sublistId:\$id){
    edges{
      node{
        id
        name
        listPrice
        productSize
        sizes
        color
        mrp
        subproductSet{
          edges{
            node{
              id
              listPrice
              size
            }
          }
        }
        productimagesSet{
          edges{
            node{
              id
              normalImage
              thumbnailImage
            }
          }
        }
      }
    }
  }
}

""";



String getTypeProductQuery ="""
query xy(\$id:ID!){
  sublistBySubcategoryId(subCategoryId: \$id) {
    edges {
      node {
        id
        productSize
        name
      }
    }
  }
}
""";



String getSubCategoryQuery ="""
query GetSubCateogry(\$CateogryId:ID!){
  subcateogryByCategoryId(mainCategoryId:\$CateogryId)
  {
    edges{
      node
      {
        id
        productSize
        name
      }
    }
  }
}
""";


String getCategoryQuery = """
{
	allCategory{
    edges{
      node{
        id
        productSize
        name
        image
      }
    }
  }
}

""";
String getProductsQuery ="""
{
  allProducts{
    edges{
      node{
        id
        name
        listPrice
        mrp
        productSize
        productimagesSet{
          edges{
            node{
              normalImage
            }
          }
        }
      }
    }
  }
}

""";

String getTokenQuery ="""
mutation x(\$username:String!,\$password:String!){
  tokenAuth(username:\$username,password:\$password){
    token
  }
}
""";