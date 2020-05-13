
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

String getAllProductsQuery ="""
{
  allProducts{
    edges{
      node{
        id
        name
        listPrice
        productSize
        sizes
        color
        mrp
        instock
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