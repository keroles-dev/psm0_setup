names=$(xrandr | grep " connected " | awk '{ print$1 }');
screens=($names);

len=${#screens[@]};

if (( $len < 2 )); then
    exit;
fi

for (( i=1; i<${len}; i++ ));
do
  xrandr --output ${screens[$i]} --auto --left-of ${screens[($i-1)]};
done
