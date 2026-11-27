import "@ebusd/ebus-typespec";
import "./_templates.tsp";
using Ebus;
using Ebus.Num;
using Ebus.Dtm;
using Ebus.Str;
namespace Vaillant;

namespace Ehpsync_inc {
  // EHP: cyclic messages from the system controller UIH (and the VR 90) to the EHP circuits.
  // Seen unasked about every 10 s on a geoTHERM VWS 83/2 (EHP00 SW 0383, UIH00).

  /** default *w */
  @write
  @base(MF, 0x5, 0x2b)
  model w_1 {}

  /** system parameters sent by the system controller */
  @inherit(w_1)
  @ext
  model SetSystemParams {
    /** PreShutDownTime: pre shut down time */
    preshutdowntime: minutes0;

    /** FrostOverRideTime: frost over ride time */
    frostoverridetime: hours;

    /** TempIncrease: temperature increase */
    @unit("K")
    tempincrease: UCH;

    @maxLength(3)
    ign: IGN;
  }

  /** circuit state and 24h outside temperature average */
  @inherit(rm)
  @ext(0x32)
  model Status32 {
    @maxLength(5)
    ign: IGN;

    /** circuit state: 0=not served, 1=heating, 2=cooling; cc and hwc always 0 */
    state: hcpumpmode;

    /** 24h outside temperature average (same value as mc Tot24hHc2) */
    tot24hhc2: temp2;

    @maxLength(2)
    ign_1: IGN;
  }
}
