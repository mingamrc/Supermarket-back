using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Supermarket_back.Models;

namespace Supermarket_back.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ArticlesController : ControllerBase
    {
        private readonly AppDataContext _context;

        public ArticlesController(AppDataContext context)
        {
            _context = context;
        }

        // GET: api/Articles
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Article>>> GetArticles(string name = "")
        {
            IQueryable<Article> query = _context.Articles.AsQueryable();

            if (name != "")
            {
                query = query.Where<Article>(x =>
                    x.Name.ToLower().Contains(name.ToLower())
                );
            }

            return await query.OrderBy(x => x.Name).ToListAsync();
        }


        //public async Task<ActionResult<IEnumerable<Article>>> GetArticle(string name = "")
        //{
        //    var article = from art in _context.Articles
        //                  select new ArticleDetailDTO()
        //                  {
        //                      Id = art.Id,
        //                      Name = art.Name
        //                  };
        //    if (article == null)
        //    {
        //        return Ok(article);
        //    }

        //    return Ok(article);
        //}

        //public IQueryable<ArticleDTO> GetArticleDTOs()
        //{
        //    var article = from art in _context.Articles
        //                  select new ArticleDTO()
        //                  {
        //                      Id = art.Id,
        //                      Name = art.Name
        //                  };

        //    return article;
        //}




        // GET: api/Articles/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Article>> GetArticle(int id)
        {
            var article = await _context.Articles.FindAsync(id);

            if (article == null)
            {
                return NotFound();
            }

            return article;
        }

        //public async Task<ActionResult<ArticleDetailDTO>> GetArticle(int id)
        //{
        //    var article = await _context.Articles.Include(art => art.Cat).Select(art =>
        //        new ArticleDetailDTO()
        //        {
        //            Id = art.Id,
        //            Name = art.Name,
        //            Code = art.Code,
        //            Price = art.Price,
        //            Expiration = art.Expiration,
        //            CatId = art.CatId
        //        }).SingleOrDefaultAsync(art => art.Id == id);
        //    if (article == null)
        //    {
        //        return NotFound();
        //    }

        //    return Ok(article);
        //}

        // PUT: api/Articles/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutArticle(int id, Article article)
        {
            if (id != article.Id)
            {
                return BadRequest();
            }

            _context.Entry(article).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ArticleExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/Articles
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<Article>> PostArticle(Article article)
        {
            Console.WriteLine("prove");
            Console.WriteLine(String.IsNullOrEmpty(article.Expiration.ToString()));
            Console.WriteLine(article.Expiration.ToString());

            if (article.Code.ToString().Length == 8 && (article.Name.Any(char.IsDigit) == false))
            {
                //if (String.IsNullOrEmpty(article.Expiration.ToString()) || article.Expiration.ToString().Equals(""))
                //{
                //    article.Expiration = null;
                //}
                if (String.IsNullOrEmpty(article.ImgURL))
                {
                    article.ImgURL = "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/300px-No_image_available.svg.png";
                }
                _context.Articles.Add(article);
                await _context.SaveChangesAsync();

                return CreatedAtAction("GetArticle", new { id = article.Id }, article);
            }
            else
            {
                return BadRequest();
            }
        }

        // DELETE: api/Articles/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteArticle(int id)
        {
            var article = await _context.Articles.FindAsync(id);
            if (article == null)
            {
                return NotFound();
            }

            _context.Articles.Remove(article);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool ArticleExists(int id)
        {
            return _context.Articles.Any(e => e.Id == id);
        }
    }
}
