#!/bin/bash

for stfi in `sed -n '2,$p' uscounties.txt | cut -d, -f1-2 | uniq` ; do
    stabb=`echo $stfi | cut -d, -f1`
    stfips=`echo $stfi | cut -d, -f2`
    #stabb='PR'; stfips='72'
    echo $stabb, $stfips
js >${stabb}1.json <<EOF
    module.paths.push('./')
    var f1 = require('gz_2010_us_050_00_20m.json');
    //f1.features[0].properties.STATE
    var f2 = {};
    for( var j in f1 ) if( j != 'features' ) f2[j] = f1[j] ;
    f2.features = [] ;
    for( var i=0; i < f1.features.length; i++ ) if( f1.features[i].properties.STATE == '${stfips}' ) f2.features.push( f1.features[i] ) ;
    process.stdout.write(JSON.stringify( f2 )+'\n') ;
EOF
done

