import pandas as pd


def group_by_date(excel_path: str, sheet_name: str, date_column: str = "Fecha"):
    """Read an Excel sheet and group rows by date.

    Parameters
    ----------
    excel_path : str
        Path to the Excel file.
    sheet_name : str
        Name of the sheet containing the table.
    date_column : str
        Column name that contains date information. Default is "Fecha".

    Returns
    -------
    pandas.core.groupby.generic.DataFrameGroupBy
        Grouped data by date.
    """
    df = pd.read_excel(excel_path, sheet_name=sheet_name)
    df[date_column] = pd.to_datetime(df[date_column])
    # Group by the date portion only
    grouped = df.groupby(df[date_column].dt.date)
    return grouped


if __name__ == "__main__":
    import argparse

    parser = argparse.ArgumentParser(description="Agrupa por fecha los items de una tabla de Excel")
    parser.add_argument("excel_path", help="Ruta al archivo Excel")
    parser.add_argument("sheet_name", help="Nombre de la hoja con la tabla")
    parser.add_argument("--date-column", default="Fecha", help="Nombre de la columna con la fecha")
    args = parser.parse_args()

    result = group_by_date(args.excel_path, args.sheet_name, args.date_column)
    for fecha, grupo in result:
        print(f"Fecha: {fecha}")
        print(grupo)
        print()
