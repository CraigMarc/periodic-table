#! /bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
then 
echo Please provide an element as an argument.
fi
# if symbol is input
 if [[ $1 == [A-Z][a-z] || $1 == [A-Z] ]]
 then 
 
 ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol = '$1'")
 echo $ATOMIC_NUMBER
 fi
 #if atomic_number is input
 if [[ $1 == [0-9] || $1 == [0-9][0-9] ]]
 then
 ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number = '$1'")
 
 echo $ATOMIC_NUMBER
 fi
# element is input
if [[ -z $ATOMIC_NUMBER ]]
then
ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name = '$1'")
echo $ATOMIC_NUMBER element wrtong
fi
# not found
if [[ -z $ATOMIC_NUMBER ]]
then

echo I could not find that element in the database.
exit
 fi 
NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number = $ATOMIC_NUMBER")
SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number = $ATOMIC_NUMBER")
ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
TYPE=$($PSQL "SELECT type FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
echo -e "\nThe element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). Its a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."

