using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Text.Json;

namespace Microsoft.AspNetCore.Mvc
{
    public enum JsonRequestBehavior
    {
        AllowGet,
        DenyGet
    }
}

namespace SDKHRMS.Web.Controllers
{
    public class BaseController : Controller
    {
        public SessionWrapper Session => new SessionWrapper(HttpContext?.Session);

        protected JsonResult Json(object data, JsonRequestBehavior behavior)
        {
            return base.Json(data);
        }

        protected JsonResult Json(object data, string contentType, System.Text.Encoding contentEncoding, JsonRequestBehavior behavior)
        {
            return base.Json(data);
        }
    }

    public class SessionWrapper
    {
        private readonly ISession _session;

        public SessionWrapper(ISession session)
        {
            _session = session;
        }

        public object this[string key]
        {
            get
            {
                if (_session == null) return null;
                string val = _session.GetString(key);
                return val;
            }
            set
            {
                if (_session == null) return;
                if (value == null)
                {
                    _session.Remove(key);
                }
                else
                {
                    _session.SetString(key, value.ToString());
                }
            }
        }

        public void Remove(string key)
        {
            _session?.Remove(key);
        }

        public void Clear()
        {
            _session?.Clear();
        }

        public void Abandon()
        {
            _session?.Clear();
        }

        public void RemoveAll()
        {
            _session?.Clear();
        }
    }
}
