totals = [{'units': 'meters', 'SUM(distance)': 4000.0}, {'units': 'miles', 'SUM(distance)': 2.0}, {'units': 'yards', 'SUM(distance)': 11450.0}]

for total in totals:
    print ('Units: {}   Distance: {}'.format(total['units'], total['SUM(distance)']))
