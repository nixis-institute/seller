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