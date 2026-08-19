using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using System;
using System.Collections.Generic;
using System.Data;
using Microsoft.Data.SqlClient;
using System.Linq;
using System.Reflection;

namespace SDKHRMS.Entities.DataAccess
{
    public static class DatabaseFacadeExtensions
    {
        public static List<T> SqlQuery<T>(this DatabaseFacade database, string sql, params object[] parameters)
        {
            var list = new List<T>();
            var connection = database.GetDbConnection();
            bool wasOpen = connection.State == ConnectionState.Open;
            if (!wasOpen) connection.Open();

            try
            {
                using (var command = connection.CreateCommand())
                {
                    command.CommandText = sql;
                    command.CommandType = CommandType.Text;
                    if (database.GetCommandTimeout().HasValue)
                    {
                        command.CommandTimeout = database.GetCommandTimeout().Value;
                    }

                    if (parameters != null)
                    {
                        foreach (var param in parameters)
                        {
                            if (param is SqlParameter sqlParam)
                            {
                                var p = (SqlParameter)((ICloneable)sqlParam).Clone();
                                if (p.Value == null)
                                {
                                    p.Value = DBNull.Value;
                                }
                                command.Parameters.Add(p);
                            }
                            else if (param is IDataParameter dataParam)
                            {
                                command.Parameters.Add(dataParam);
                            }
                        }
                    }

                    using (var reader = command.ExecuteReader())
                    {
                        var targetType = typeof(T);
                        var underlyingType = Nullable.GetUnderlyingType(targetType) ?? targetType;

                        if (underlyingType.IsPrimitive || underlyingType == typeof(string) || underlyingType == typeof(decimal) || underlyingType == typeof(DateTime) || underlyingType == typeof(Guid))
                        {
                            while (reader.Read())
                            {
                                if (reader.IsDBNull(0))
                                {
                                    list.Add(default);
                                }
                                else
                                {
                                    var rawVal = reader.GetValue(0);
                                    list.Add((T)Convert.ChangeType(rawVal, underlyingType));
                                }
                            }
                        }
                        else
                        {
                            var props = targetType.GetProperties(BindingFlags.Public | BindingFlags.Instance)
                                                  .Where(p => p.CanWrite)
                                                  .GroupBy(p => p.Name, StringComparer.OrdinalIgnoreCase)
                                                  .ToDictionary(g => g.Key, g => g.First(), StringComparer.OrdinalIgnoreCase);

                            var colMap = new List<(int Index, PropertyInfo Prop)>();
                            for (int i = 0; i < reader.FieldCount; i++)
                            {
                                string colName = reader.GetName(i);
                                if (props.TryGetValue(colName, out var prop))
                                {
                                    colMap.Add((i, prop));
                                }
                            }

                            while (reader.Read())
                            {
                                var item = Activator.CreateInstance<T>();
                                foreach (var (colIndex, prop) in colMap)
                                {
                                    if (!reader.IsDBNull(colIndex))
                                    {
                                        var val = reader.GetValue(colIndex);
                                        var pType = Nullable.GetUnderlyingType(prop.PropertyType) ?? prop.PropertyType;
                                        try
                                        {
                                            if (pType.IsEnum)
                                            {
                                                prop.SetValue(item, Enum.ToObject(pType, val));
                                            }
                                            else
                                            {
                                                prop.SetValue(item, Convert.ChangeType(val, pType));
                                            }
                                        }
                                        catch
                                        {
                                            try { prop.SetValue(item, val); } catch { }
                                        }
                                    }
                                }
                                list.Add(item);
                            }
                        }
                    }

                    if (parameters != null)
                    {
                        foreach (var param in parameters)
                        {
                            if (param is SqlParameter sqlParam && (sqlParam.Direction == ParameterDirection.Output || sqlParam.Direction == ParameterDirection.InputOutput))
                            {
                                if (command.Parameters.Contains(sqlParam.ParameterName))
                                {
                                    var cmdParam = command.Parameters[sqlParam.ParameterName] as IDataParameter;
                                    if (cmdParam != null)
                                    {
                                        sqlParam.Value = cmdParam.Value;
                                    }
                                }
                            }
                        }
                    }
                }
            }
            finally
            {
                if (!wasOpen) connection.Close();
            }

            return list;
        }
    }
}
