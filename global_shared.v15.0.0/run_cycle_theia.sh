#!/bin/sh --login

#PBS -l nodes=1:ppn=24
#PBS -l walltime=00:02:00
#PBS -A fv3-cpu
#PBS -N chgres_fv3
#PBS -q debug
#PBS -o log.cycle
#PBS -e log.cycle

set -x

module use -a /scratch3/NCEPDEV/nwprod/lib/modulefiles
module load netcdf/4.3.0 hdf5/1.8.14
module list

export OMP_NUM_THREADS_CY=24
export machine=THEIA
export APRUNCY=" "

export global_shared_ver="v15.0.0"
export BASEDIR=/scratch4/NCEPDEV/da/save/George.Gayno/fv3gfs/branches/cycle_fv3
export HOMEglobal=$BASEDIR/global_shared.${global_shared_ver}

export CYCLEXEC=$HOMEglobal/exec/global_cycle

export CDATE=2016092900
export FHOUR=00

export CRES=384

export SFCGES=/scratch4/NCEPDEV/nems/noscrub/emc.nemspara/FV3GFS_V0_RELEASE/baseline/fv3gfs_nh_32bit/C${CRES}/gfs.20160929/00/RESTART/sfc_data.tile1.nc
export SFCANL="./gdas1.t00z.sfcanl"

export FNTSFA=/scratch4/NCEPDEV/global/noscrub/dump/$CDATE/gdas/rtgssthr.grb.gdas.$CDATE
export FNSNOA=' '
export FNACNA=/scratch4/NCEPDEV/global/noscrub/dump/$CDATE/gdas/seaice.5min.blend.grb.gdas.$CDATE

export JCAP=1534
export LONB=3072
export LATB=1536

export FNGRID=$HOMEglobal/fix/fix_fv3/C${CRES}/C${CRES}_grid.tile1.nc
export FNOROG=$HOMEglobal/fix/fix_fv3/C${CRES}/C${CRES}_oro_data.tile1.nc

export FIXgsm=$HOMEglobal/fix/fix_am

export NWPROD=/nwprod

export FILESTYLE=L
export VERBOSE=YES
export CYCLVARS=FSNOL=99999.,FSNOS=99999.,FSLPL=99999.,FVETL=99999.,FSOTL=99999.,

export DATA=/scratch3/NCEPDEV/stmp1/George.Gayno/cycle
rm -fr $DATA

$HOMEglobal/ush/global_cycle.sh $SFCGES $SFCANL

exit
