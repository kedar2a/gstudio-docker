#!/bin/bash

# Mrunal : 20161123 : below part is added by Mrunal as suggested by Nagarjuna, Ulhas and Kedar

# Following variables are used to store the color codes for displaying the content on terminal
# red="\033[0;31m" ;
# green="\033[0;32m" ;
# brown="\033[0;33m" ;
# blue="\033[0;34m" ;
# cyan="\033[0;36m" ;
# reset="\033[0m" ;

black="\033[0;90m" ;
red="\033[0;91m" ;
green="\033[0;92m" ;
brown="\033[0;93m" ;
blue="\033[0;94m" ;
purple="\033[0;95m" ;
cyan="\033[0;96m" ;
grey="\033[0;97m" ;
white="\033[0;98m" ;
reset="\033[0m" ;

filename=$(basename $(ls -dr /home/docker/code/update_*/ |  head -n 1));
update_patch="${filename%.*.*}";
update_patch="update_patch-06a676e-r2.1-20171013"

# git offline update docker code - started
#git_commit_no_docker="15f7287ea2b6dfefd127038c732402aff293de16";             # Earlier commit no
git_commit_no_docker="06a676e4998b444d0f8b818f668a08982daa218c";              # Commit on 13-10-2017

echo -e "\n${cyan}change the directory to /home/docker/code/ ${reset}"
cd /home/docker/code/

echo -e "\n${cyan}fetching git details from /home/docker/code/${update_patch}/code-updates/gstudio-docker ${reset}"
git fetch /home/docker/code/${update_patch}/code-updates/gstudio-docker 

echo -e "\n${cyan}merging till specified commit number (${git_commit_no_docker}) from /home/docker/code/${update_patch}/code-updates/gstudio-docker ${reset}"
git merge $git_commit_no_docker

# git offline update docker code - ended


# git offline update gstudio code - started

#git_commit_no_gstudio="84457e980ae4133245bfa5c6970fb6969dd0dab1";             # Earlier commit no
git_commit_no_gstudio="5d5ed8acd48950f9eb850590bef068f853a42fb5";              # Commit on 29-09-2017

#--- One time for 20170912 update - started
echo -e "\n${cyan}change the directory to /home/docker/code/gstudio ${reset}"
cd /home/docker/code/gstudio/gnowsys-ndf/

echo -e "\n${cyan}change branch to master ${reset}"
git checkout master

# echo -e "\n${cyan}pulling the latest code from master ${reset}"
# git pull origin master
#--- One time for 20170912 update - ended

echo -e "\n${cyan}change the directory to /home/docker/code/gstudio ${reset}"
cd /home/docker/code/gstudio/

echo -e "\n${cyan}fetching git details from /home/docker/code/${update_patch}/code-updates/gstudio ${reset}"
git fetch /home/docker/code/${update_patch}/code-updates/gstudio 

echo -e "\n${cyan}merging till specified commit number (${git-commit-no}) from /home/docker/code/${update_patch}/code-updates/gstudio ${reset}"
git merge $git_commit_no_gstudio

# git offline update gstudio code - ended


# git offline update qbank-lite code - started

#git_commit_no_qbank_lite="";             # Earlier commit no
git_commit_no_qbank_lite="1b488926a4d609dcde017e4fe7a47b8a4b541339";              # Commit on 06-08-2017

echo -e "\n${cyan}change the directory to /home/docker/code/gstudio/gnowsys-ndf/qbank-lite ${reset}"
cd /home/docker/code/gstudio/gnowsys-ndf/qbank-lite

echo -e "\n${cyan}change branch to clixserver ${reset}"
git checkout clixserver

echo -e "\n${cyan}fetching git details from /home/docker/code/${update_patch}/code-updates/qbank-lite ${reset}"
git fetch /home/docker/code/${update_patch}/code-updates/qbank-lite 

echo -e "\n${cyan}merging till specified commit number (${git-commit-no}) from /home/docker/code/${update_patch}/code-updates/qbank-lite ${reset}"
git merge $git_commit_no_qbank_lite

echo -e "\n${cyan}remove all the file and sub-driectories in directory (/home/docker/code/gstudio/gnowsys-ndf/qbank-lite/*) ${reset}"
rm -rf /home/docker/code/gstudio/gnowsys-ndf/qbank-lite/*

echo -e "\n${cyan}rsync /home/docker/code/${update_patch}/code-updates/qbank-lite/* in /home/docker/code/gstudio/gnowsys-ndf/qbank-lite/ ${reset}"
rsync -avzPh /home/docker/code/${update_patch}/code-updates/qbank-lite/* /home/docker/code/gstudio/gnowsys-ndf/qbank-lite/

# git offline update qbank-lite code - ended


# git offline update OpenAssessmentsClient code - started

# #git_commit_no_OpenAssessmentsClient="462ba9c29e6e8874386c5e76138909193e90240e";             # Earlier commit no
# git_commit_no_OpenAssessmentsClient="acfed44c30b421a49fa2ec43b361ff11653e9d31";              # Commit on 18-09-2017

# echo -e "\n${cyan}change the directory to /home/docker/code/OpenAssessmentsClient ${reset}"
# cd /home/docker/code/OpenAssessmentsClient/

# echo -e "\n${cyan}change branch to clixserver ${reset}"
# git checkout clixserver

# echo -e "\n${cyan}fetching git details from /home/docker/code/${update_patch}/code-updates/OpenAssessmentsClient ${reset}"
# git fetch /home/docker/code/${update_patch}/code-updates/OpenAssessmentsClient 

# echo -e "\n${cyan}merging till specified commit number (${git-commit-no}) from /home/docker/code/${update_patch}/code-updates/OpenAssessmentsClient ${reset}"
# git merge $git_commit_no_OpenAssessmentsClient

# git offline update OpenAssessmentsClient code - ended


# prefix and suffix double quotes " in server code - started

# get server id (Remove single quote {'} and Remove double quote {"})
ss_id=`echo  $(echo $(more /home/docker/code/gstudio/gnowsys-ndf/gnowsys_ndf/server_settings.py | grep -w GSTUDIO_INSTITUTE_ID | sed 's/.*=//g')) | sed "s/'//g" | sed 's/"//g'`
#ss_id=$(more /home/docker/code/gstudio/gnowsys-ndf/gnowsys_ndf/server_settings.py | sed -n '/.*=/{p;q;}' | sed 's/.*= //g' | sed "s/'//g" | sed 's/"//g')

# Trim leading  whitespaces 
ss_id=$(echo ${ss_id##*( )})
# Trim trailing  whitespaces 
ss_id=$(echo ${ss_id%%*( )})

# update server id
if grep -Fq "GSTUDIO_INSTITUTE_ID" /home/docker/code/gstudio/gnowsys-ndf/gnowsys_ndf/server_settings.py
then
    # code if found
    sed -e "/GSTUDIO_INSTITUTE_ID/ s/=.*/='${ss_id}'/" -i  /home/docker/code/gstudio/gnowsys-ndf/gnowsys_ndf/server_settings.py;
else
    # code if not found
    echo -e "GSTUDIO_INSTITUTE_ID ='${ss_id}'" >>  /home/docker/code/gstudio/gnowsys-ndf/gnowsys_ndf/server_settings.py;
fi

# update school code
ss_code=$(grep -irw "$ss_id" /home/docker/code/All_States_School_CLIx_Code_+_School_server_Code_-_TS_Intervention_Schools.csv | awk -F ';' '{print $3}')

# Trim leading  whitespaces 
ss_code=$(echo ${ss_code##*( )})
# Trim trailing  whitespaces 
ss_code=$(echo ${ss_code%%*( )})

if grep -Fq "GSTUDIO_INSTITUTE_ID_SECONDARY" /home/docker/code/gstudio/gnowsys-ndf/gnowsys_ndf/server_settings.py
then
    # code if found
    sed -e "/GSTUDIO_INSTITUTE_ID_SECONDARY/ s/=.*/='${ss_code}'/" -i  /home/docker/code/gstudio/gnowsys-ndf/gnowsys_ndf/server_settings.py;
else
    # code if not found
    echo -e "GSTUDIO_INSTITUTE_ID_SECONDARY ='${ss_code}'" >>  /home/docker/code/gstudio/gnowsys-ndf/gnowsys_ndf/server_settings.py;
fi

# update school name
ss_name=$(grep -irw "$ss_id" /home/docker/code/All_States_School_CLIx_Code_+_School_server_Code_-_TS_Intervention_Schools.csv | awk -F ';' '{print $2}' | sed 's/"//g')

# Trim leading  whitespaces 
ss_name=$(echo ${ss_name##*( )})
# Trim trailing  whitespaces 
ss_name=$(echo ${ss_name%%*( )})

if grep -Fq "GSTUDIO_INSTITUTE_NAME" /home/docker/code/gstudio/gnowsys-ndf/gnowsys_ndf/server_settings.py
then
    # code if found
    sed -e "/GSTUDIO_INSTITUTE_NAME/ s/=.*/='${ss_name}'/" -i  /home/docker/code/gstudio/gnowsys-ndf/gnowsys_ndf/server_settings.py;
else
    # code if not found
    echo -e "GSTUDIO_INSTITUTE_NAME ='${ss_name}'" >>  /home/docker/code/gstudio/gnowsys-ndf/gnowsys_ndf/server_settings.py;
fi

# prefix and suffix double quotes " in server code - ended


# extra scripts - started

echo -e "\n${cyan}change the directory to /home/docker/code/gstudio ${reset}"
cd /home/docker/code/gstudio/gnowsys-ndf/

echo -e "\n${cyan}apply fab update_data ${reset}"
fab update_data

echo -e "\n${cyan}apply bower components - datatables-rowsgroup ${reset}"
rsync -avzPh /home/docker/code/${update_patch}/code-updates/datatables-rowsgroup /home/docker/code/gstudio/gnowsys-ndf/gnowsys_ndf/ndf/static/ndf/bower_components/

echo -e "\n${cyan}add few variables and there value so replace the same - local_settings ${reset}"
rsync -avzPh /home/docker/code/${update_patch}/code-updates/gstudio-docker/confs/local_settings.py.default /home/docker/code/gstudio/gnowsys-ndf/gnowsys_ndf/local_settings.py

# Variables related to "set_language" function (setting default language)
state_code=${ss_id:0:2};
language="Not Idea";
if [ ${state_code} == "ct" ] || [ ${state_code} == "rj" ]; then
    echo -e "\n${cyan}State code is ${state_code}. Hence setting hi as language.${reset}"
    language="hi";
elif [ ${state_code} == "mz" ]; then
    echo -e "\n${cyan}State code is ${state_code}. Hence setting en as language.${reset}"
    language="en";
elif [ ${state_code} == "tg" ]; then
    echo -e "\n${cyan}State code is ${state_code}. Hence setting te as language.${reset}"
    language="te";
else
    echo -e "\n${red}Error: Oops something went wrong. Contact system administator or CLIx technical team - Mumbai. ($directoryname)${reset}" ;
fi  
sed -e "/GSTUDIO_PRIMARY_COURSE_LANGUAGE/ s/=.*/= u'${language}'/" -i /home/docker/code/gstudio/gnowsys-ndf/gnowsys_ndf/local_settings.py

echo -e "\n${cyan}apply requirements - copying dlkit dist-packages ${reset}"
# if [[ -d /usr/local/lib/python2.7/dist-packages-old ]]; then
#     mv -v /usr/local/lib/python2.7/dist-packages-old /tmp/
#     rm -rf /tmp/dist-packages-old
# fi
# mv -v /usr/local/lib/python2.7/dist-packages /usr/local/lib/python2.7/dist-packages-old
# rsync -avzPh /home/docker/code/${update_patch}/code-updates/dist-packages /usr/local/lib/python2.7/
mv -v /usr/local/lib/python2.7/dist-packages/dlkit* /tmp/
rm -rf /tmp/dlkit*
rsync -avzPh /home/docker/code/${update_patch}/code-updates/dist-packages/dlkit* /usr/local/lib/python2.7/dist-packages/


echo -e "\n${cyan}updating teacher' s agency type ${reset}"
python manage.py teacher_agency_type_update

echo -e "\n${cyan}collectstatic ${reset}"
echo yes | python manage.py collectstatic

# extra scripts - ended

# modify logrotate for nginx
rsync -avzPh /home/docker/code/${update_patch}/code-updates/nginx /etc/logrotate.d/

# set newly updated crontab - started

echo -e "\n${cyan}Applying newly updated cron jobs in crontab ${reset}"
crontab /home/docker/code/confs/mycron

# set newly updated crontab - ended
