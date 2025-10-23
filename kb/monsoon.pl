% Monsoon/avoid rules (simple examples)
avoid_month(mirissa, may).
avoid_region(mirissa, monsoon_southwest).
% Southwest monsoon: May-Sep affects west/south; Northeast: Nov-Feb affects north/east
avoid_month_region(west, may).
avoid_month_region(west, jun).
avoid_month_region(west, jul).
avoid_month_region(west, aug).
avoid_month_region(west, sep).
avoid_month_region(south, may).
avoid_month_region(south, jun).
avoid_month_region(south, jul).
avoid_month_region(south, aug).
avoid_month_region(south, sep).
avoid_month_region(east, nov).
avoid_month_region(east, dec).
avoid_month_region(east, jan).
avoid_month_region(east, feb).
avoid_month_region(north, nov).
avoid_month_region(north, dec).
avoid_month_region(north, jan).
avoid_month_region(north, feb).
