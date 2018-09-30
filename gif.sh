#!/bin/sh -eu
gif_roll() {
    PAD_TO=200%
    CUT_TO=50%
    DELAY=2x100
    NUM_FRAMES=1
    REVOLUTIONS=1
    FINAL_SIZE=128x128
    while getopts p:c:d:n:r:s:h name
    do
        case $name in
        p) PAD_TO="$OPTARG" ;;
        c) CUT_TO="$OPTARG" ;;
        d) DELAY="$OPTARG";;
        n) NUM_FRAMES="$OPTARG";;
        r) REVOLUTIONS="$OPTARG";;
        s) FINAL_SIZE="$OPTARG";;
        *)
            >&2 echo "roll [-p PAD_TO] [ -c CUT_TO ] [ -d DELAY ] [ -n NUM_FRAMES ] [ -r REVOLUTIONS ] [ -s FINAL_SIZE ] INPUT"
            >&2 echo "defaults:
    PAD_TO=$PAD_TO
    CUT_TO=$CUT_TO
    DELAY=$DELAY
    NUM_FRAMES=$NUM_FRAMES
    REVOLUTIONS=$REVOLUTIONS
    FINAL_SIZE=$FINAL_SIZE"
            return
        ;;
        esac
    done
    shift $((OPTIND - 1))
    INPUT="${1:--}"
    (
        set -x
        convert -background transparent -dispose background \
                "$INPUT" -background transparent \
                -gravity center -extent "$PAD_TO" \
                -duplicate "$NUM_FRAMES" -loop 0 \
                -distort SRT "%[fx:360*(($REVOLUTIONS)*t/n)]" \
                -extent "$CUT_TO" -resize "$FINAL_SIZE" \
                -set delay "$DELAY" \
                GIF:-
    )
}
gif_wobble() {
    PAD_TO=200%
    CUT_TO=50%
    DELAY=2x100
    NUM_FRAMES=1
    AMPLITUDE=8
    FREQUENCY=1
    FINAL_SIZE=128x128
    while getopts p:c:d:n:a:f:s:h name
    do
        case $name in
        p) PAD_TO="$OPTARG" ;;
        c) CUT_TO="$OPTARG" ;;
        d) DELAY="$OPTARG";;
        n) NUM_FRAMES="$OPTARG";;
        a) AMPLITUDE="$OPTARG";;
        f) FREQUENCY="$OPTARG";;
        s) FINAL_SIZE="$OPTARG";;
        *)
            >&2 echo "wobble [-p PAD_TO] [ -c CUT_TO ] [ -d DELAY ] [ -n NUM_FRAMES ] [ -a AMPLITUDE ] [ -f FREQUENCY ] [ -s FINAL_SIZE ] INPUT"
            >&2 echo "defaults:
    PAD_TO=$PAD_TO
    CUT_TO=$CUT_TO
    DELAY=$DELAY
    NUM_FRAMES=$NUM_FRAMES
    AMPLITUDE=$AMPLITUDE
    FREQUENCY=$FREQUENCY
    FINAL_SIZE=$FINAL_SIZE
    "
            return
        ;;

        esac
    done
    shift $((OPTIND - 1))
    INPUT="${1:--}"
    (
        set -x
        convert -background transparent -dispose background \
                "$INPUT" -background transparent \
                -gravity center -extent "$PAD_TO" \
                -duplicate "$NUM_FRAMES" -loop 0 \
                -distort SRT "%[fx:($AMPLITUDE)*sin(2*($FREQUENCY)*pi*t/n)]" \
                -extent "$CUT_TO" -resize "$FINAL_SIZE" \
                -set delay "$DELAY" \
                GIF:-
    )
}
gif_pulse() {
    PAD_TO=200%
    CUT_TO=50%
    DELAY=2x100
    NUM_FRAMES=1
    SCALE_MIN=0.5
    SCALE_MAX=1.0
    FREQUENCY=1
    FINAL_SIZE=128x128
    while getopts p:c:d:n:0:1:f:s:h name
    do
        case $name in
        p) PAD_TO="$OPTARG" ;;
        c) CUT_TO="$OPTARG" ;;
        d) DELAY="$OPTARG";;
        n) NUM_FRAMES="$OPTARG";;
        0) SCALE_MIN="$OPTARG";;
        1) SCALE_MAX="$OPTARG";;
        f) FREQUENCY="$OPTARG";;
        s) FINAL_SIZE="$OPTARG";;
        *)
            >&2 echo "pulse [-p PAD_TO] [ -c CUT_TO ] [ -d DELAY ] [ -n NUM_FRAMES ] [ -0 SCALE_MIN ] [ -1 SCALE_MAX ] [ -f FREQUENCY ] [ -s FINAL_SIZE ] INPUT"
            >&2 echo "defaults:
    PAD_TO=$PAD_TO
    CUT_TO=$CUT_TO
    DELAY=$DELAY
    NUM_FRAMES=$NUM_FRAMES
    SCALE_MIN=$SCALE_MIN
    SCALE_MAX=$SCALE_MAX
    FREQUENCY=$FREQUENCY
    FINAL_SIZE=$FINAL_SIZE"
            return
        ;;
        esac
    done
    shift $((OPTIND - 1))
    INPUT="${1:--}"
    (
        set -x
        convert -background transparent -dispose background \
                "$INPUT" -background transparent \
                -gravity center -extent "$PAD_TO" \
                -duplicate "$NUM_FRAMES" -loop 0 \
                -distort SRT "%[fx:(($SCALE_MAX)+($SCALE_MIN))/2+(($SCALE_MAX)-($SCALE_MIN))*sin(2*($FREQUENCY)*pi*t/n)/2],0" \
                -extent "$CUT_TO" -resize "$FINAL_SIZE" \
                -set delay "$DELAY" \
                GIF:-
    )
}
gif_zoom() {
    PAD_TO=200%
    CUT_TO=50%
    DELAY=2x100
    NUM_FRAMES=1
    SCALE_MIN=0.5
    SCALE_MAX=1.0
    POWER=2.0
    FINAL_SIZE=128x128
    while getopts p:c:d:n:0:1:e:s:h name
    do
        case $name in
        p) PAD_TO="$OPTARG" ;;
        c) CUT_TO="$OPTARG" ;;
        d) DELAY="$OPTARG";;
        n) NUM_FRAMES="$OPTARG";;
        0) SCALE_MIN="$OPTARG";;
        1) SCALE_MAX="$OPTARG";;
        e) POWER="$OPTARG";;
        s) FINAL_SIZE="$OPTARG";;
        *)
            >&2 echo "zoom [-p PAD_TO] [ -c CUT_TO ] [ -d DELAY ] [ -n NUM_FRAMES ] [ -0 SCALE_MIN ] [ -1 SCALE_MAX ] [ -e POWER ] [ -s FINAL_SIZE ] INPUT"
            >&2 echo "defaults:
    PAD_TO=$PAD_TO
    CUT_TO=$CUT_TO
    DELAY=$DELAY
    NUM_FRAMES=$NUM_FRAMES
    SCALE_MIN=$SCALE_MIN
    SCALE_MAX=$SCALE_MAX
    POWER=$POWER
    FINAL_SIZE=$FINAL_SIZE"
            return
        ;;
        esac
    done
    shift $((OPTIND - 1))
    INPUT="${1:--}"
    (
        set -x
        convert -background transparent -dispose background \
                "$INPUT" -background transparent \
                -gravity center -extent "$PAD_TO" \
                -duplicate "$NUM_FRAMES" -loop 0 \
                -distort SRT "%[fx:(1-((t/n)^($POWER)))*($SCALE_MIN) + ((t/n)^($POWER))*($SCALE_MAX)],0" \
                -extent "$CUT_TO" -resize "$FINAL_SIZE" \
                -set delay "$DELAY" \
                GIF:-
    )
}
gif_shake() {
    PAD_TO=200%
    CUT_TO=50%
    DELAY=2x100
    NUM_FRAMES=1
    AMPLITUDE_X=10
    AMPLITUDE_Y=10
    FREQUENCY_X=2
    FREQUENCY_Y=2
    PHASE_X=0
    PHASE_Y=pi/2
    PHASE_RANDOM=pi
    FINAL_SIZE=128x128
    while getopts p:c:d:n:x:y:f:g:o:r:s:h name
    do
        case $name in
        p) PAD_TO="$OPTARG" ;;
        c) CUT_TO="$OPTARG" ;;
        d) DELAY="$OPTARG";;
        n) NUM_FRAMES="$OPTARG";;
        x) AMPLITUDE_X="$OPTARG";;
        y) AMPLITUDE_Y="$OPTARG";;
        f) FREQUENCY_X="$OPTARG";;
        g) FREQUENCY_Y="$OPTARG";;
        o) PHASE_Y="$OPTARG";;
        r) PHASE_RANDOM="$OPTARG";;
        s) FINAL_SIZE="$OPTARG";;
        *)
            >&2 echo "shake [-p PAD_TO] [ -c CUT_TO ] [ -d DELAY ] [ -n NUM_FRAMES ] [ -x AMPLITUDE_X ] [ -y AMPLITUDE_Y ] [ -f FREQUENCY_X ] [ -g FREQUENCY_Y ] [ -o PHASE_Y ] [ -r PHASE_RANDOM ] [ -s FINAL_SIZE ] INPUT"
            >&2 echo "defaults:
    PAD_TO=$PAD_TO
    CUT_TO=$CUT_TO
    DELAY=$DELAY
    NUM_FRAMES=$NUM_FRAMES
    AMPLITUDE_X=$AMPLITUDE_X
    AMPLITUDE_Y=$AMPLITUDE_Y
    FREQUENCY_X=$FREQUENCY_X
    FREQUENCY_Y=$FREQUENCY_Y
    PHASE_Y=$PHASE_Y
    FINAL_SIZE=$FINAL_SIZE
    PHASE_RANDOM=$PHASE_RANDOM"
            false
            return
        ;;

        esac
    done
    shift $((OPTIND - 1))
    INPUT="${1:--}"
    (
        set -x
        convert -background transparent -dispose background \
                "$INPUT" -background transparent \
                -gravity center -extent "$PAD_TO" \
                -duplicate "$NUM_FRAMES" -loop 0 \
                -distort SRT "0,0 1,1 0%[fx:($AMPLITUDE_X)*sin(($PHASE_X)+2*($FREQUENCY_X)*pi*(t/n)+($PHASE_RANDOM)*rand())],%[fx:($AMPLITUDE_Y)*sin(($PHASE_Y)+2*($FREQUENCY_Y)*pi*(t/n)+($PHASE_RANDOM)*rand())]" \
                -extent "$CUT_TO" -resize "$FINAL_SIZE" \
                -set delay "$DELAY" \
                GIF:-
    )
}
gif_optimize_for_slack() { # requires gifsicle with --lossy option (brew install giflossy)
    TARGET_GEOMETRY=128x128
    TARGET_SIZE_KB=128
    while getopts g:s:h name
    do
        case $name in
        g) TARGET_GEOMETRY="$OPTARG";;
        s) TARGET_SIZE_KB="$OPTARG";;
        *)
            >&2 echo "optimize [ -g TARGET_GEOMETRY ] [ -s TARGET_SIZE_KB ] [ INPUT ]"
            >&2 echo "defaults:
    TARGET_GEOMETRY=$TARGET_GEOMETRY
    TARGET_SIZE_KB=$TARGET_SIZE_KB"
            return
        esac
    done
    shift $((OPTIND - 1))
    INPUT="${1:--}"
    INPUT_TEMP_FILE=$(mktemp)
    cat "$INPUT" > "$INPUT_TEMP_FILE"
    INPUT="$INPUT_TEMP_FILE"
    TEMP_FILE=$(mktemp)
    size=$(du -k "$INPUT" | xargs printf "%s%0.s")
    if [ "$size" -le "$TARGET_SIZE_KB" ]; then
        cat "$INPUT"
        rm -f "$INPUT_TEMP_FILE"
        rm -f "$TEMP_FILE"
        return
    fi
    >&2 echo original: "$size"KB
    for c in "" "--colors=256" "--colors=128" "--colors=64" "--colors=32" "--colors=16"; do
    for l in 0 5 10 20 30 40 50 60 70 80 90 100 110 120 130 140 150 160 170 180 190 200; do
        >&2 printf "%s --lossy=%3s" "$c" "$l"
        2>/dev/null gifsicle -j $c --resize "$TARGET_GEOMETRY" --lossy="$l" <"$INPUT" >"$TEMP_FILE"
        size=$(du -k "$TEMP_FILE" | xargs printf "%s%0.s")
        >&2 printf ": %sKB\\n" "$size"
        if [ "$size" -le "$TARGET_SIZE_KB" ]; then
            cat "$TEMP_FILE"
            rm -f "$INPUT_TEMP_FILE"
            rm -f "$TEMP_FILE"
            return
        fi
    done
    done
    >&2 echo "could not get size below $TARGET_SIZE_KB"KB
    cat "$INPUT"
    rm -f "$INPUT_TEMP_FILE"
    rm -f "$TEMP_FILE"
    false
}

main() {
    command="${1:-help}"
    if [ $# -gt 0 ]; then
        shift
    fi
    case $command in
        roll) gif_roll "$@" ;;
        wobble) gif_wobble "$@" ;;
        pulse) gif_pulse "$@" ;;
        zoom) gif_zoom "$@" ;;
        shake) gif_shake "$@" ;;
        optimize) gif_optimize_for_slack "$@" ;;
        *)
            name=$(basename "$0")
            >&2 echo "Usage:"
            >&2 echo "    $name (roll | wobble | pulse | zoom | shake | optimize) [ -h ] [ OPTIONS ]"
    esac
}

main "$@"
