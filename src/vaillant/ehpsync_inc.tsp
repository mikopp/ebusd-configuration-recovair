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
  model SystemParams {
    /** max. pre-deactivation time */
    maxpredeactivation: minutes0;

    /** frost protection delay (same value as uih FrostOverRideTime) */
    frostdelay: hours;

    /** fast temperature increase */
    @unit("K")
    tempincrease: UCH;

    @maxLength(3)
    raw: HEX;
  }

  /** data block 0x31, unknown content */
  @inherit(rm)
  @ext(0x31)
  model Block31 {
    @maxLength(2)
    value: HEX;
  }

  /** data block 0x32 with circuit state and 24h outside temperature average */
  @inherit(rm)
  @ext(0x32)
  model Block32 {
    @maxLength(5)
    raw: HEX;

    /** circuit state: 0=not served, 1=heating, 2=cooling */
    state: UCH;

    /** 24h outside temperature average (same value as mc Tot24hHc2) */
    tot24h: temp2;

    @maxLength(2)
    raw_1: HEX;
  }
}
