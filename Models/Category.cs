using System;
using System.Collections.Generic;

#nullable disable

namespace Supermarket_back.Models
{
    public partial class Category
    {
        public Category()
        {
            Articles = new HashSet<Article>();
        }

        public int CatId { get; set; }
        public string Category1 { get; set; }
        public string Description { get; set; }

        public virtual ICollection<Article> Articles { get; set; }
    }
}
