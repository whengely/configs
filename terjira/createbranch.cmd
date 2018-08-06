@ECHO OFF

for /f "tokens=* USEBACKQ" %%a in (
`jira issue %1 ^| head -n 4 ^| tail -n 3 ^| sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g" ^|^
 tr -s " " ^| cut -c 5- ^| sed -e "s/...$//g" ^|^
 tr -d "\r" ^| tr -d "\n" ^| cut -d " " -f1^,5- ^| tr "[:upper:]" "[:lower:]" ^|^
 tr -d ":" ^| sed -e "s/[[:space:]]/-/g" ^| tr -s "-" ^| sed -e "s/-$//g"`
) do (
set result=%%a
)

git checkout -b "wh/%result%"
