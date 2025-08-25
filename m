Return-Path: <linux-iio+bounces-23241-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 568D3B342E6
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 16:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A36A1770D7
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 14:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045542EF65F;
	Mon, 25 Aug 2025 14:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVMqiJb/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0296F9C0;
	Mon, 25 Aug 2025 14:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756131262; cv=none; b=bD9pvbjb5JIhvxWzxLpY6r4o09LADIwz6LPCKX2oxyjD0sBvTxPFDfqN+gOC0GX8PcSS/o4mfN2DmvTKIesafJhSZrdn2+sz+ChtkpqD6hiwfkuKiTtqreMT5qu3dzuP+ltCFwu5IthUVSyqMj+K3d4vDFLoam1nJpGjWpFIEEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756131262; c=relaxed/simple;
	bh=O27boypHUmVhtmIw+EGKRt2WuczW77KvPjxjYV//udI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WppG8OozyH1vbvDBdSd4d0Xu2AJm16AMO9nyNFnaw6DxE7wy2NGEQGb+1T1KbMM1+R22pPewKjtzZTASc5bM/aN0XLEzEVyxn+N+MZd4THwo+kCnxB7MafK6U1GVfEXcN2his5UyTZPNVHFVaSSJFB3bfXoHyJ1Le6Qy8w8f03k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KVMqiJb/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FFEEC4CEED;
	Mon, 25 Aug 2025 14:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756131261;
	bh=O27boypHUmVhtmIw+EGKRt2WuczW77KvPjxjYV//udI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KVMqiJb/tJ4nLHwYltL5ujq5Q10ZC2JaODEweCLFO4wD578pQZJbK9Kuqw1I9PviF
	 wyX5fl/AQx8IsLqavU+6DtDn5ydNLdMTZeO0JDsT7JNl4vRRAVx1QPrnu/jWWyDCqb
	 8+z03H6c6RAe/E3dDlvxZRAXLMVMpr55VDuAYoSvCNWbZjZixE1RpVIygLbZxKGSPj
	 MYmFQpckWelqjejH1yg+du1BeKgTVqW4naXp6IbX9p6P5uac0rzzrG31Sv1Xr4GdFD
	 ttqvJ6GaRiT1OCcZoR0wcojtTZZwqu4y5f3tvD9LTmTC6/wf4oL8fPXAlLIgzRyNbx
	 Yfj1b+bTNogIg==
Date: Mon, 25 Aug 2025 15:14:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 5/6] docs: iio: add documentation for ade9000 driver
Message-ID: <20250825151413.2a1e60a8@jic23-huawei>
In-Reply-To: <20250822160157.5092-6-antoniu.miclaus@analog.com>
References: <20250822160157.5092-1-antoniu.miclaus@analog.com>
	<20250822160157.5092-6-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 22 Aug 2025 16:01:54 +0000
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add documentation for ade9000 driver which describes the driver
> device files and shows how the user may use the ABI for various
> scenarios (configuration, measurement, etc.).
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  Documentation/iio/ade9000.rst | 286 ++++++++++++++++++++++++++++++++++
>  Documentation/iio/index.rst   |   1 +
>  2 files changed, 287 insertions(+)
>  create mode 100644 Documentation/iio/ade9000.rst
>=20
> diff --git a/Documentation/iio/ade9000.rst b/Documentation/iio/ade9000.rst
> new file mode 100644
> index 000000000000..fcb4a36c0282
> --- /dev/null
> +++ b/Documentation/iio/ade9000.rst
> @@ -0,0 +1,286 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +ADE9000 driver
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +This driver supports Analog Device's ADE9000 energy measurement IC on SP=
I bus.
> +
> +1. Supported devices
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +* `ADE9000 <https://www.analog.com/media/en/technical-documentation/data=
-sheets/ADE9000.pdf>`_
> +
> +The ADE9000 is a highly accurate, fully integrated, multiphase energy an=
d power
> +quality monitoring device. Superior analog performance and a digital sig=
nal
> +processing (DSP) core enable accurate energy monitoring over a wide dyna=
mic
> +range. An integrated high end reference ensures low drift over temperatu=
re
> +with a combined drift of less than =C2=B125 ppm/=C2=B0C maximum for the =
entire channel
> +including a programmable gain amplifier (PGA) and an analog-to-digital
> +converter (ADC).
> +
> +2. Device attributes
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Power and energy measurements are provided for voltage, current, active =
power,
> +reactive power, apparent power, and power factor across three phases.
> +
> +Each IIO device has a device folder under ``/sys/bus/iio/devices/iio:dev=
iceX``,
> +where X is the IIO index of the device. Under these folders reside a set=
 of
> +device files, depending on the characteristics and features of the hardw=
are
> +device in question. These files are consistently generalized and documen=
ted in
> +the IIO ABI documentation.
> +
> +The following tables show the ADE9000 related device files, found in the
> +specific device folder path ``/sys/bus/iio/devices/iio:deviceX``.
> +
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| Current measurement related device files          | Description       =
                                       |
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| in_current[0-2]_raw                               | Raw current measur=
ement for phases A, B, C.              |
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| in_current[0-2]_scale                             | Scale for current =
channels.                              |
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| in_current[0-2]_calibscale                        | Calibration gain f=
or current channels (AIGAIN reg).      |
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| in_current[0-2]_offset                            | Offset correction =
for current channels (IRMSOS reg).     |

So this is not an offset of the _raw reading above.  I.e. userspace should =
do (_raw + _offset) * _scale I think?
Even for the RMS calc there is a 2^15 multiplier involved.

So think this one needs a rethink.  Definitely a calibbias not an offset as=
 it's not something for userspace
to apply but rather a calibration tweak. Possibly something new is needed t=
o indicate this only affects
the RMS calculation.  I'm open to suggestions on how to do that.


> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| in_altcurrent[0-2]_rms_raw                        | RMS current measur=
ement for phases A, B, C.              |

Add something kernel on the calc, particularly the influence of what you cu=
rrently have as offset above. That
is not obvious.

> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| Voltage measurement related device files          | Description       =
                                       |
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| in_voltage[0-2]_raw                               | Raw voltage measur=
ement for phases A, B, C.              |
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| in_voltage[0-2]_scale                             | Scale for voltage =
channels.                              |
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| in_voltage[0-2]_calibscale                        | Calibration gain f=
or voltage channels (AVGAIN reg).      |
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| in_voltage[0-2]_offset                            | Offset correction =
for voltage channels (VRMSOS reg).     |

As above.

> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| in_voltage[0-2]_frequency                         | Measured line freq=
uency for phases A, B, C.              |
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| in_altvoltage[0-2]_rms_raw                        | RMS voltage measur=
ement for phases A, B, C.              |
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| Power measurement related device files            | Description       =
                                       |
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| in_power[0-2]_raw                                 | Raw active power m=
easurement for phases A, B, C.         |
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| in_power[0-2]_active_raw                          | Active power measu=
rement for phases A, B, C.             |
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| in_power[0-2]_reactive_raw                        | Reactive power mea=
surement for phases A, B, C.           |
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| in_power[0-2]_apparent_raw                        | Apparent power mea=
surement for phases A, B, C.           |
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| in_power[0-2]_powerfactor                         | Power factor for p=
hases A, B, C.                         |

Currently I'm fairly sure this is _active_powerfactor which is not where it=
 should be.
please check this doc again vs attributes on the running driver.

> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| in_power[0-2]_scale                               | Scale for power ch=
annels.                                |
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| in_power[0-2]_calibscale                          | Calibration gain f=
or power channels (APGAIN reg).        |
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| in_power[0-2]_calibbias                           | Calibration offset=
 for power channels (xWATTOS regs).    |
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| Energy measurement related device files           | Description       =
                                       |
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| in_energy[0-2]_raw                                | Raw energy measure=
ment for phases A, B, C.               |
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| in_energy[0-2]_scale                              | Scale for energy c=
hannels.                               |
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +
> ++------------------------------+----------------------------------------=
--------------------------+
> +| Shared device attributes     | Description                            =
                          |
> ++------------------------------+----------------------------------------=
--------------------------+
> +| name                         | Name of the IIO device.                =
                          |
> ++------------------------------+----------------------------------------=
--------------------------+
> +| frequency                    | System line frequency configuration (50=
Hz/60Hz).                |
> ++------------------------------+----------------------------------------=
--------------------------+
> +| scale                        | Shared PGA gain setting (1x, 2x, 4x) af=
fecting all channels.   |
> ++------------------------------+----------------------------------------=
--------------------------+

Looks like something odd with formatting in the table here.


> +
> +3. Calibration and scaling
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +
> +The ADE9000 provides multiple levels of gain and offset correction:
> +
> +**PGA Gain (shared)**
> +  The programmable gain amplifier affects the analog input stage for all=
 channels.
> +  Controlled via the shared ``scale`` attribute with values 1, 2, or 4.
> +
> +**Calibration Gain (per-channel)**
> +  Fine-tuning calibration gains applied in the digital domain for each c=
hannel type.
> +  Controlled via ``calibscale`` attributes (AIGAIN, AVGAIN, APGAIN regis=
ters).
> +
> +**Calibration Offset (per-channel)**
> +  Hardware calibration offsets applied by the device for power measureme=
nts.
> +  Controlled via ``calibbias`` attributes for power channels.
> +
> +**Correction Offsets (per-channel)**
> +  RMS offset corrections for current and voltage measurements.
> +  Controlled via ``offset`` attributes (IRMSOS, VRMSOS registers).

As per the above - these only affect RMS not the direct measurements so nee=
d a rethink.
=20
> +
> +4. Event attributes
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The ADE9000 provides various interrupts that are mapped to IIO events.
> +Event functionality is only available if the corresponding interrupts are
> +connected in the device tree.
> +
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| IIO Event Attribute                               | ADE9000 Datasheet =
Equivalent                             |
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| in_voltage0_thresh_either_en                      | Zero crossing dete=
ction interrupt (ZXVA)                 |
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| in_voltage0_thresh_rising_en                      | Swell detection in=
terrupt (SWELLA)                       |

These seem to be on something to do with RMS not the main voltage channel. =
 They aren't indicating the peak went
out of range but rather the RMS value did. Given RMS is a channel modifier,=
 maybe in_voltage0_rms_thresh_rising
is enough?  Does the RMS half cycle update change how we should represent t=
his?  I'm not sure and looking for
inputs from others more familiar with energy meters.  I had to dig to find =
what RMS 1/2 was.



> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| in_voltage0_thresh_falling_en                     | Sag/dip detection =
interrupt (DIPA)                       |
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| in_voltage0_thresh_none_en                        | Zero crossing time=
out interrupt (ZXTOVA)                 |

Not seeing how a timeout maps to a threshold without a direction.  This is =
a failure to see an event
for some time.  The 'for sometime' could be done with a period control but =
I'm not sure on what.  Maybe a new
event direction in_voltage0_notthresh_either_en to say a threshold was not =
crossed?

> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| events_mag_none_en                                | Energy ready inter=
rupt (EGYRDY)                          |

Not an event in IIO terms.  Could map this to a trigger as it's indicating =
a data update of small set of the channels.
However we'd have to deal with buffering on our slowest channel.
Do we need to support a dataready on something so slow?  Just poll it enoug=
h?

Also what is the events_ prefix here?


> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| events_change_none_en                             | Sequence error int=
errupt (SEQERR)                        |

Why this mapping?  If this is an error condition then maybe use the EV_TYPE=
_FAULT and add something alongside the openwire
support we have already upstream.

> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| events_thresh_none_value                          | Zero crossing time=
out threshold (ZXTOUT register)        |
I'd group these so the _value entries come right next the _en entries as th=
en we can consider them together.

This smells like period which we already have for events when they need to =
be true for a 'while'. Note the
units though so you'll have to deal with mapping to those.

> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| in_voltage0_thresh_falling_value                  | Sag/dip threshold =
(DIP_LVL register)                     |
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| in_voltage0_thresh_rising_value                   | Swell threshold (S=
WELL_LVL register)                     |
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +
> +Event directions:
> +- ``rising``: Upper threshold crossing (swell detection)
> +- ``falling``: Lower threshold crossing (sag/dip detection)
> +- ``either``: Any threshold crossing (zero crossing detection)
> +- ``none``: Timeout or non-directional events
> +
> +**Note**: Event attributes are only available if the corresponding inter=
rupts
> +(irq0, irq1, dready) are specified in the device tree. The driver works =
without
> +interrupts but with reduced functionality.
> +
> +5. Device buffers
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +This driver supports IIO buffers for waveform capture. Buffer functional=
ity
> +requires the dready interrupt to be connected.
> +
> +The device supports capturing voltage and current waveforms for power qu=
ality
> +analysis. The waveform buffer can be configured to capture data from dif=
ferent
> +channel combinations.
> +
> +Supported channel combinations for buffered capture:
> +- Phase A: voltage and current (IA + VA)
> +- Phase B: voltage and current (IB + VB)
> +- Phase C: voltage and current (IC + VC)
> +- All phases: all voltage and current channels
> +- Individual channels: IA, VA, IB, VB, IC, VC
> +
> +Usage examples
> +--------------
> +
> +Enable waveform capture for Phase A:
> +
> +.. code-block:: bash
> +
> +        root:/sys/bus/iio/devices/iio:device0> echo 1 > scan_elements/in=
_current0_en
> +        root:/sys/bus/iio/devices/iio:device0> echo 1 > scan_elements/in=
_voltage0_en
> +
> +Set buffer length and enable:
> +
> +.. code-block:: bash
> +
> +        root:/sys/bus/iio/devices/iio:device0> echo 100 > buffer/length
> +        root:/sys/bus/iio/devices/iio:device0> echo 1 > buffer/enable
> +
> +6. Clock output
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The ADE9000 can provide a clock output via the CLKOUT pin when using an =
external
> +crystal/clock source. This feature is enabled by specifying ``#clock-cel=
ls =3D <0>``
> +in the device tree. The output clock will be registered as "clkout" and =
can be
> +referenced by other devices.
> +
> +7. Usage examples
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Show device name:
> +
> +.. code-block:: bash
> +
> +	root:/sys/bus/iio/devices/iio:device0> cat name
> +        ade9000
> +
> +Read voltage measurements:
> +
> +.. code-block:: bash
> +
> +        root:/sys/bus/iio/devices/iio:device0> cat in_voltage0_raw
> +        12345
> +        root:/sys/bus/iio/devices/iio:device0> cat in_voltage0_scale
> +        0.000030517
> +
> +- Phase A voltage =3D in_voltage0_raw * in_voltage0_scale =3D 0.3769 V
> +
> +Read power measurements:
> +
> +.. code-block:: bash
> +
> +        root:/sys/bus/iio/devices/iio:device0> cat in_power0_active_raw
> +        5678
> +        root:/sys/bus/iio/devices/iio:device0> cat in_power0_scale
> +        0.000244140
> +
> +- Phase A active power =3D in_power0_active_raw * in_power0_scale =3D 1.=
386 W
> +
> +Configure PGA gain (affects all channels):
> +
> +.. code-block:: bash
> +
> +        # Set PGA gain to 2x
> +        root:/sys/bus/iio/devices/iio:device0> echo 2 > scale
> +        # Read current gain setting
> +        root:/sys/bus/iio/devices/iio:device0> cat scale
> +        2
> +
> +Configure line frequency:
> +
> +.. code-block:: bash
> +
> +        # Set to 60Hz operation
> +        root:/sys/bus/iio/devices/iio:device0> echo 60 > frequency
> +        # Read current frequency setting
> +        root:/sys/bus/iio/devices/iio:device0> cat frequency
> +        60
> +
> +Configure calibration gains:
> +
> +.. code-block:: bash
> +
> +        # Set current channel 0 calibration gain
> +        root:/sys/bus/iio/devices/iio:device0> echo 0x800000 > in_curren=
t0_calibscale
> +        # Set voltage channel 0 calibration gain
> +        root:/sys/bus/iio/devices/iio:device0> echo 0x7FFFFF > in_voltag=
e0_calibscale
> +
> +Configure voltage event thresholds (requires interrupts):
> +
> +.. code-block:: bash
> +
> +        # Set sag detection threshold
> +        root:/sys/bus/iio/devices/iio:device0> echo 180000 > events/in_v=
oltage0_thresh_falling_value
> +        # Enable sag detection
> +        root:/sys/bus/iio/devices/iio:device0> echo 1 > events/in_voltag=
e0_thresh_falling_en
> +
> +        # Set swell detection threshold
> +        root:/sys/bus/iio/devices/iio:device0> echo 260000 > events/in_v=
oltage0_thresh_rising_value
> +        # Enable swell detection
> +        root:/sys/bus/iio/devices/iio:device0> echo 1 > events/in_voltag=
e0_thresh_rising_en
> +
> +8. IIO Interfacing Tools
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +See ``Documentation/iio/iio_tools.rst`` for the description of the avail=
able IIO
> +interfacing tools.
> \ No newline at end of file

fix that.

> diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
> index c106402a91f7..792c815286f4 100644
> --- a/Documentation/iio/index.rst
> +++ b/Documentation/iio/index.rst
> @@ -28,6 +28,7 @@ Industrial I/O Kernel Drivers
>     ad7606
>     ad7625
>     ad7944
> +   ade9000
>     adis16475
>     adis16480
>     adis16550


