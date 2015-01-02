

Template.reading.helpers
  items: () ->
    facilityId = Session.get 'currentSelectedFacilityId'
  evaluation: (kpi)->
    'OK'
    # ...