document = {}

local default = { msg = 'this is the default'}

function document.setup(options)

  if options then
    M.options = options
  else
    M.options = default
  end

end

function document.print()

  print(default.msg)

end

-- thing to try and get ordinal numbers on date
function day_ordinal(dayn)
    last_digit = dayn % 10
    if last_digit == 1 and dayn ~= 11
        then return 'st'
    elseif last_digit == 2 and dayn ~= 12
        then return 'nd'
    elseif last_digit == 3 and dayn ~= 13
        then return 'rd'
    else 
        return 'th'
    end
end

function timef(datestr,date)
    datestr = string.gsub(datestr,"%%o",day_ordinal(date.day))
    return os.date(datestr,os.time(datedate))
end 

date = os.date("*t",os.time())
cTime = timef("%A, %d%o %B %Y %r",date)
vim.g.modifiedDate = timef("%A, %d%o %B %Y %r",date)

local timetable = {currentTime = timef("%A, %d%o %B %Y %r",date)} 

function document.this()

  print(timetable.currentTime)

end
