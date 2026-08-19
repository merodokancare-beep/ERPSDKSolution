using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Linq;


namespace SDKHRMS.Web.Utility
{
    public class ConvertListToDT
    {
        public DataTable ConvertIEnumerableToDataTable<T>(IEnumerable<T> ItemList)
        {
            DataTable dtTable = new DataTable();
            Type temp = typeof(T);
            PropertyDescriptorCollection props = TypeDescriptor.GetProperties(typeof(T));
            foreach (PropertyDescriptor pd in props)
            {
                //create a data column for each employee attendance
                DataColumn dc = new DataColumn(pd.Name, Nullable.GetUnderlyingType(pd.PropertyType) ?? pd.PropertyType);//check if nullable datatype (e.g datetime)
                dtTable.Columns.Add(dc);
            }
            //now we iterate through all the items, take the corresponding values and add a new row in dt
            foreach (T item in ItemList)
            {
                DataRow dr = dtTable.NewRow();
                for (int property = 0; property < props.Count; property++)
                {
                    dr[property] = props[property].GetValue(item) ?? DBNull.Value;
                }
                dtTable.Rows.Add(dr);
            }
            return dtTable;
        }
        public DataTable ConvertIEnumerableToDataTableRoles<T>(IEnumerable<T> ItemList)
        {
            DataTable dtTable = new DataTable();
            Type temp = typeof(T);
            PropertyDescriptorCollection props = TypeDescriptor.GetProperties(typeof(T));

            DataColumn dc = new DataColumn("UserRole");
            dtTable.Columns.Add(dc);
            //now we iterate through all the items, take the corresponding values and add a new row in dt
            foreach (T item in ItemList)
            {
                DataRow dr = dtTable.NewRow();
                for (int property = 0; property < props.Count; property++)
                {
                    dr[property] = item;
                }
                dtTable.Rows.Add(dr);
            }
            return dtTable;
        }
        public DataTable ConvertInvoiceItemsToDataTable(IEnumerable<SDKHRMS.Entities.ViewModels.CustomInvoiceItems> itemList)
        {
            DataTable dtTable = new DataTable();
            dtTable.Columns.Add("ItemDtlID", typeof(string));
            dtTable.Columns.Add("SaleInvoiceID", typeof(string));
            dtTable.Columns.Add("ItemName", typeof(string));
            dtTable.Columns.Add("ItemHSNCode", typeof(string));
            dtTable.Columns.Add("GSTPercentage", typeof(int));
            dtTable.Columns.Add("IGSTPercentage", typeof(double));
            dtTable.Columns.Add("CGSTPercentage", typeof(double));
            dtTable.Columns.Add("SGSTPercentage", typeof(double));
            dtTable.Columns.Add("Qty", typeof(int));
            dtTable.Columns.Add("Rate", typeof(decimal));
            dtTable.Columns.Add("Amount", typeof(decimal));

            if (itemList != null)
            {
                foreach (var item in itemList)
                {
                    DataRow dr = dtTable.NewRow();
                    dr["ItemDtlID"] = (object)item.ItemDtlID ?? DBNull.Value;
                    dr["SaleInvoiceID"] = (object)item.SaleInvoiceID ?? DBNull.Value;
                    dr["ItemName"] = item.ItemName ?? "";
                    dr["ItemHSNCode"] = item.ItemHSNCode ?? "";
                    dr["GSTPercentage"] = item.GSTPercentage;
                    dr["IGSTPercentage"] = item.IGSTPercentage;
                    dr["CGSTPercentage"] = item.CGSTPercentage;
                    dr["SGSTPercentage"] = item.SGSTPercentage;
                    dr["Qty"] = item.Qty;
                    dr["Rate"] = item.Rate;
                    dr["Amount"] = item.Amount;
                    dtTable.Rows.Add(dr);
                }
            }
            return dtTable;
        }

        public DataTable ConvertChallanItemsToDataTable(IEnumerable<SDKHRMS.Entities.Models.utblChallanItem> itemList)
        {
            DataTable dtTable = new DataTable();
            dtTable.Columns.Add("ItemName", typeof(string));
            dtTable.Columns.Add("Quantity", typeof(int));
            dtTable.Columns.Add("UnitID", typeof(long));
            dtTable.Columns.Add("SlNo", typeof(int));

            if (itemList != null)
            {
                int sl = 1;
                foreach (var item in itemList)
                {
                    DataRow dr = dtTable.NewRow();
                    dr["ItemName"] = item.ItemName ?? "";
                    dr["Quantity"] = item.Quantity;
                    dr["UnitID"] = item.UnitID;
                    dr["SlNo"] = (object)item.SlNo ?? sl++;
                    dtTable.Rows.Add(dr);
                }
            }
            return dtTable;
        }
    }
}