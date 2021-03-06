#!/bin/bash
ventas=0
factura=0
while [ $factura -eq 0 ]; do
    g=0
    clear
    echo ""
    echo "*********************************************"
    echo "* Bienvenidos al sistema de faturacion      *"
    echo "*********************************************"
    echo ""

    l=0
    k=0
    re='^[0-9]+$'
    DIA=`date +"%d/%m/%Y"`
    HORA=`date +"%H:%M"`


    while [ $l -eq 0 ]; do
        N=0
        A=0
        B=0
        D=0

        ((k++))

        echo "__________________________________________________________________"
        while [ $N -eq 0 ]; do

            echo "ingrese nombre del producto $k"
            read -p '-> ' Name
            read -p "Nota: si quiere ingresar otro valor ingrese 0 sino ENTER " c
            if [ -z $Name ]; then
                echo ""

            else
                if [[ $Name =~ $re ]]; then
                echo ""
                else
                    if [ -z ${c} ]; then
                        ((N=N+1))

                        Nom[$k]=$Name
                    elif [ $c -ne 0 ]; then
                        ((N=N+1))

                        Nom[$k]=$Name
                    elif [ $c -eq 0 ]; then
                        echo ""
                    fi
                fi
            fi
        done

        echo "__________________________________________________________________"

        while [ $A -eq 0 ]; do
            echo "ingrese cantidad de ${Nom[$k]}"
            read -p '-> ' can
            read -p "Nota: si quiere ingresar otro valor ingrese 0 sino ENTER " h
            if [ -z ${can} ]; then
                echo ""
            else
                if [[ $can =~ $re ]]; then
                    if [ -z ${h} ]; then
                        ((A=A+1))

                        cantidad[$k]=$can
                    elif [ $h -ne 0 ]; then
                        ((A=A+1))

                        cantidad[$k]=$can
                    elif [ $h -eq 0 ]; then
                        echo ""
                    fi
                else
                    echo ""
                fi
            fi
        done

        echo "__________________________________________________________________"

        while [ $B -eq 0 ]; do
            echo "Ingrese valor de ${Nom[$k]}"
            read -p '-> ' valor
            read -p "Nota: si quiere ingresar otro valor ingrese 0 sino ENTER " m
            if [ -z ${valor} ]; then
                echo ""
            else
                if [[ $valor =~ $re ]]; then
                    if [ -z ${m} ]; then
                        ((B=B+1))

                        precio[$k]=$valor
                    elif [ $m -ne 0 ]; then
                        ((B=B+1))
                        precio[$k]=$valor
                    elif [ $m -eq 0 ]; then
                        echo ""
                    fi
                else
                    echo ""
                fi
            fi
        done
        echo "__________________________________________________________________"
        echo ""
        while [ $D -eq 0 ]; do
            echo "*******************************************"
            echo "*  Desea registrar otro producto [Yes/No] *"
            echo "*******************************************"
            read -p '-> ' Desicion

            if [ -z $Desicion ]; then
                echo ""

            else
                if [[ $Desicion =~ $re ]]; then
                    echo ""
                else
                    if [ ${Desicion:0:1} = N ]; then
                        ((D=D+1))
                        ((l=l+1))
                    elif [ ${Desicion:0:2} = No ]; then
                        ((D=D+1))
                        ((l=l+1))
                        #echo "adios..."
                    elif [ ${Desicion:0:1} = n ]; then
                        ((D=D+1))
                        ((l=l+1))
                        #echo "adios..."
                    elif [ ${Desicion:0:2} = no ]; then
                        ((D=D+1))
                        ((l=l+1))
                        #echo "adios..."
                    else
                        ((D=D+1))
                    fi
                fi
            fi
        done
    done

    echo ""
    while [ $g -eq 0 ]; do
        echo "======================================="
        echo "*  Desea imprimir la factura[Yes/No]  *"
        echo "======================================="
        read -p "-> " salir
        if [ -z $salir ]; then
            echo ""

        else
            if [[ $salir =~ $re ]]; then
                echo ""
            else
                if [ ${salir:0:1} = N ]; then
                    ((g=g+1))
                elif [ ${salir:0:2} = No ]; then
                    ((g=g+1))
                elif [ ${salir:0:1} = no ]; then
                    ((g=g+1))
                elif [ ${salir:0:2} = n ]; then
                    ((g=g+1))
                else
                    ((g=g+1))
                    ((factura=factura+1))
                fi
            fi
        fi
    done
done

    suma=0
    su=0

echo ""
echo " IMPRIMIENDO ......."
echo ""
    for (( j=1; j<=$k; j++)); do

        suma=$[ ((${precio[$j]} * ${cantidad[$j]})) ]
        su=$[ suma + su]

    done


    porcentaje=0
    descuento=0
    porcentaje1=0
    descuento1=0
    porcentaje2=0
    descuento2=0
    if [ $su -ge 50000 -a $su -le 100000 ]; then
        porcentaje=$( echo " scale=3; $su*0.05 " | bc)

        descuento=$( echo " scale=3; $su-$porcentaje " | bc)


    elif [ $su -ge 100001 -a $su -le 150000 ]; then
        porcentaje1=$( echo " scale=3; $su*0.07 " | bc)

        descuento1=$( echo " scale=3; $su-$porcentaje1 " | bc)


    elif [ $su -gt 150000 ]; then
        porcentaje2=$( echo " scale=3; $su*0.09 " | bc)

        descuento2=$( echo " scale=3; $su-$porcentaje2 " | bc)

    fi
    echo "_______________________________________________"
    echo "|                                             |"
    echo "|  ****************************************   |"
    echo "|  *           Facturacion                *   |"
    echo "|  ****************************************   |"
    echo "|                                             |"
    echo "|     Supermercado S.A                        |"
    echo "|     $DIA - Neiva/Huila                |"
    echo "|     Tel: 12345678                           |"
    echo "|     NIT: 879654123                          |"
    echo "|     Numero de factura       AA0001          |"
    echo "|                                             |"
    echo "|   ***********************************       |"
    echo "|   *           Consumo Final          *      |"
    echo "|   ***********************************       |"
    echo "|                                             |"
    echo "|       FECHA   $DIA  $HORA             |"
    echo "|                                             |"
    echo "|    Producto    cantidad    Precio           |"
    echo "|_____________________________________________|"
    echo "|                                             |"
    for (( j=1; j<=$k; j++)); do
        echo -e "|    ${Nom[$j]}\t ${cantidad[$j]}\t    ${precio[$j]}\t      |"
    done
    echo "|                                             |"
    echo "|_____________________________________________|"
    echo "|                                             |"
    if [ $su -ge 50000 -a $su -le 100000 ]; then
        echo -e "|      Descuento\t    $porcentaje\t      |"
        echo -e "|      %Descuento\t    5%\t              |"
        echo -e "|      SubTotal\t\t    $su\t      |"
        echo -e "|      Total\t\t    $descuento\t      |"
    elif [ $su -ge 100001 -a $su -le 150000 ]; then
        echo -e "|      Descuento\t    $porcentaje1\t      |"
        echo -e "|      %Descuento\t    7%\t              |"
        echo -e "|      SubTotal\t\t    $su\t      |"
        echo -e "|      Total\t\t    $descuento1\t      |"
    elif [ $su -gt 150000 ]; then
        echo -e "|      Descuento\t    $porcentaje2\t      |"
        echo -e "|      %Descuento\t    9%\t              |"
        echo -e "|      SubTotal\t\t    $su\t      |"
        echo -e "|      Total\t\t    $descuento2\t      |"
    else
        echo -e "|      Descuento\t    $porcentaje\t\t      |"
        echo -e "|      %Descuento\t    0%\t\t      |"
        echo -e "|      SubTotal\t\t    $su\t\t|"
        echo -e "|      Total\t\t    $su\t\t|"
    fi
    dat=`date +"%d/%m/%Y" --date='+2 year'`

    echo "----------------------------------------------"
    echo "|                                             |"
    echo "| ------------------------------------------- |"
    echo "| |Atendido                                 | |"
    echo "| |Cajero 123456 Alfonso                    | |"
    echo "| |Caja 11                                  | |"
    echo "| |       Gracias por su visitas            | |"
    echo "| | Conserve esta factura - es su garantia  | |"
    echo "| | Necesario para cambios o devoluciones   | |"
    echo "| ------------------------------------------- |"
    echo "|                                             |"
    echo "|            _________________                |"
    echo "|            | Vencimiento   |                |"
    echo "|            |---------------|                |"
    echo "|            | $dat    |                |"
    echo "|            -----------------                |"
    echo "|                                             |"
    echo "-----------------------------------------------"
