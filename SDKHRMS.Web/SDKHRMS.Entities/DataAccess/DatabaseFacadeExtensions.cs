using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using System.Linq;

namespace SDKHRMS.Entities.DataAccess
{
    public static class DatabaseFacadeExtensions
    {
        public static IQueryable<T> SqlQuery<T>(this DatabaseFacade database, string sql, params object[] parameters)
        {
            return database.SqlQueryRaw<T>(sql, parameters);
        }
    }
}
