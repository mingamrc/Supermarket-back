using System;
using System.Collections.Generic;

#nullable disable

namespace Supermarket_back.Models
{
    public partial class Article
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int Code { get; set; }
        public double Price { get; set; }
        public DateTime? Expiration { get; set; }
        public int CatId { get; set; }
        public string ImgURL { get; set; }
        public virtual Category Cat { get; set; }
    }

    public partial class ArticleDTO
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public double Price { get; set; }
        public string ImgURL { get; set; }
    }

    public partial class ArticleDetailDTO
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int Code { get; set; }
        public double Price { get; set; }
        public DateTime? Expiration { get; set; }
        public int CatId { get; set; }
        public string ImgURL { get; set; }

    }
}
