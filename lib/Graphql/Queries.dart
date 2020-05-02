
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

String uploadParentProductQuery ="""

mutation x(\$id:ID!,\$prdName:String!,\$brand:String!,\$shortDesc:String!,\$longDesc:String!){
	createParentProduct(typeId:\$id,brand:\$brand,prdName:\$prdName,shortDesc:\$shortDesc,longDesc:\$longDesc)
  {
    prdId
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