String getProductByTypeId ="""

query x(\$id:ID!){
  productBySublistId(sublistId:\$id){
    edges{
      node{
        id
        name
        listPrice
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