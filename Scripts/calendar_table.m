let
    // Dynamically fetch the range based on our application dates
    StartDate = #date(2025, 1, 1),
    EndDate = #date(2026, 12, 31),
    
    // Calculate total days between dates
    NumDays = Duration.Days(Duration.From(EndDate - StartDate)) + 1,
    
    // Generate List of Dates
    Source = List.Dates(StartDate, NumDays, #duration(1, 0, 0, 0)),
    #"Converted to Table" = Table.FromList(Source, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
    #"Renamed Columns" = Table.RenameColumns(#"Converted to Table",{{"Column1", "Date"}}),
    #"Changed Type" = Table.TransformColumnTypes(#"Renamed Columns",{{"Date", type date}}),
    
    // Add Calendar Attributes (Fixed Arguments Error Here)
    #"Add Year" = Table.AddColumn(#"Changed Type", "Year", each Date.Year([Date]), Int64.Type),
    #"Add Month Number" = Table.AddColumn(#"Add Year", "MonthNo", each Date.Month([Date]), Int64.Type),
    #"Add Month Name" = Table.AddColumn(#"Add Month Number", "MonthName", each Date.ToText([Date], "MMMM"), type text),
    #"Add Short Month" = Table.AddColumn(#"Add Month Name", "MonthShort", each Date.ToText([Date], "MMM"), type text),
    #"Add Quarter" = Table.AddColumn(#"Add Short Month", "Quarter", each "Q" & Text.From(Date.QuarterOfYear([Date])), type text),
    #"Add Week Number" = Table.AddColumn(#"Add Quarter", "WeekNo", each Date.WeekOfYear([Date]), Int64.Type),
    #"Add Day of Week" = Table.AddColumn(#"Add Week Number", "DayOfWeekNo", each Date.DayOfWeek([Date]), Int64.Type),
    #"Add Day Name" = Table.AddColumn(#"Add Day of Week", "DayName", each Date.ToText([Date], "dddd"), type text),
    
    // Add Year-Month sorting index to prevent sorting bugs in visuals
    #"Add YearMonthKey" = Table.AddColumn(#"Add Day Name", "YearMonthKey", each [Year] * 100 + [MonthNo], Int64.Type)
in
    #"Add YearMonthKey"