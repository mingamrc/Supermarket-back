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
        //Funzione Get senza DTO con ricerca
        public async Task<ActionResult<IEnumerable<Article>>> GetArticles(string name = "", int catId = -1, float priceMin = -1, float priceMax = -1)
        {
            IQueryable<Article> query = _context.Articles.AsQueryable();

            if (name != "")
            {
                query = query.Where<Article>(x =>
                    x.Name.ToLower().Contains(name.ToLower())
                );
            }

            if (catId >= 0)
            {
                query = query.Where<Article>(x => x.CatId == catId);
            }

            if (priceMin > 0 && priceMax == -1)
            {
                query = query.Where<Article>(x => x.Price >= priceMin);
            } 
            else if (priceMin > 0 && priceMax >= priceMin)
            {
                query = query.Where<Article>(x => x.Price >= priceMin && x.Price <= priceMax);
            }
            else if (priceMin == -1 && priceMax > 0)
            {
                query = query.Where<Article>(x => x.Price >= priceMin && x.Price <= priceMax);
            } 
            else if  (priceMax < priceMin)
            {
                return NotFound();
            }

            return await query.OrderBy(x => x.Name).ToListAsync();
        }

        //Funzione Get con DTO
        //public IQueryable<ArticleDTO> GetArticleDTOs(string name = "")
        //{
        //    var article = from art in _context.Articles
        //                  select new ArticleDTO()
        //                  {
        //                      Id = art.Id,
        //                      Name = art.Name,
        //                      Price = art.Price,
        //                      ImgURL = art.ImgURL
        //                  };

        //    return article.OrderBy(x => x.Name);
        //}


        // GET: api/Articles/5
        [HttpGet("{id}")]
        public async Task<ActionResult<ArticleDetailDTO>> GetArticle(int id)
        {
            var article = await _context.Articles.Include(art => art.Cat).Select(art =>
                new ArticleDetailDTO()
                {
                    Id = art.Id,
                    Name = art.Name,
                    Code = art.Code,
                    Price = art.Price,
                    Expiration = art.Expiration,
                    CatId = art.CatId,
                    ImgURL = art.ImgURL

                }).SingleOrDefaultAsync(art => art.Id == id);

            if (article == null)
            {
                return NotFound();
            }

            return Ok(article);
        }

        //public async Task<ActionResult<Article>> GetArticle(int id)
        //{
        //    var article = await _context.Articles.FindAsync(id);

        //    if (article == null)
        //    {
        //        return NotFound();
        //    }

        //    return article;
        //}


        // PUT: api/Articles/5
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
        [HttpPost]
        public async Task<ActionResult<Article>> PostArticle(Article article)
        {
            
            if (article.Code.ToString().Length == 8 && (article.Name.Any(char.IsDigit) == false))
            {
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
