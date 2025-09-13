Return-Path: <linux-iio+bounces-24046-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0066B560EA
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 14:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B80B3B055D
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 12:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670D92ECE8C;
	Sat, 13 Sep 2025 12:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLpxjKC9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B87C199FB2;
	Sat, 13 Sep 2025 12:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757767625; cv=none; b=IxP8pwgILPaM4Vn/mmA6H/Y34bceOUUBh/vhNFY2/ynGQoywqSOy66B0FMLvlfLecHtpBdGl0mWou8Oa4TiSqNYVUzSx6K7XZQu/cfeZ4tKdC8gS3YK3E9dVd4WP3dLBmHifvIjBaYLREobxszoitFbvYbn3zj/g1cdprM6GBx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757767625; c=relaxed/simple;
	bh=PSWk/YPtYfCAy1iGrsLsCNE9yRRwE7OZS1ECWztHIeI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GrIm6S/JXglcpR7wBrSZYvPOR9P6l6Ug0Qsh+mPeCBSrkbCFdhnE3vj7hPJ/yyWhc90cShCOxzP2GWQEgu7AA2aLcSbSrg7bKSiAESLBzcbW1DlH8DwRbNxg3mxaAxSJ0MmoL7rAlQFIzEs9RV+2MDdUwvel8ThrBj1hPPqw+jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLpxjKC9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27D6C4CEEB;
	Sat, 13 Sep 2025 12:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757767624;
	bh=PSWk/YPtYfCAy1iGrsLsCNE9yRRwE7OZS1ECWztHIeI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YLpxjKC9yc+Op18Rhgh9F3FkXRq/mAurYZlBWqaMwuI/QiL1lmJxFBpsUsdllHO83
	 87/63GbNcLXJZ+UL2Aw9U/bcxL0Cmg+9yW31nfd9ats+3MvG5AwpzDCpsOGNaJRWcC
	 rJfO0JBuqtYG/TXq/OzyEnEp5ZTDgpfmO7pxz0zTWwOn/QEoxTGsGrGw4KKjAy0e13
	 0kQ9NVJ+134oBU2G3FKDi1evv84WQUfZumGervOCucVdOwTlvFVnBjDYUZAzY4s0TM
	 fJ2F+b9ViEkzY+U5xqxgVwjLhDnRtLHfZ05eS+Pe8FGS9Nt6+F132kC+nIyUvcMH+n
	 w7iHboN72gmsQ==
Date: Sat, 13 Sep 2025 13:46:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v7 5/6] docs: iio: add documentation for ade9000 driver
Message-ID: <20250913134656.44964f5f@jic23-huawei>
In-Reply-To: <20250908073531.3639-6-antoniu.miclaus@analog.com>
References: <20250908073531.3639-1-antoniu.miclaus@analog.com>
	<20250908073531.3639-6-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 8 Sep 2025 07:35:25 +0000
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add documentation for ade9000 driver which describes the driver
> device files and shows how the user may use the ABI for various
> scenarios (configuration, measurement, etc.).
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v7:
>  - remove PGA gain documentation section
>  - remove frequency configuration section
>  - remove scale and frequency attributes from device-level attributes tab=
le
>  - update examples to remove PGA gain and frequency configuration
>  Documentation/iio/ade9000.rst | 265 ++++++++++++++++++++++++++++++++++
>  Documentation/iio/index.rst   |   1 +
>  2 files changed, 266 insertions(+)
>  create mode 100644 Documentation/iio/ade9000.rst
>=20
> diff --git a/Documentation/iio/ade9000.rst b/Documentation/iio/ade9000.rst
> new file mode 100644
> index 000000000000..163d36a56be3
> --- /dev/null
> +++ b/Documentation/iio/ade9000.rst
> @@ -0,0 +1,265 @@
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
I thought someone raised this on the previous version, but perhaps I imagin=
ed it.
Missing line break here.

> +| in_altcurrent[0-2]_rms_raw                        | RMS current measur=
ement for phases A, B, C.              |
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| in_altcurrent[0-2]_rms_scale                      | Scale for RMS curr=
ent channels.                          |
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| in_altcurrent[0-2]_rms_calibbias                  | RMS offset correct=
ion for current channels (IRMSOS reg). |
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
> +| in_voltage[0-2]_frequency                         | Measured line freq=
uency from instantaneous voltage.      |
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| in_altvoltage[0-2]_rms_raw                        | RMS voltage measur=
ement for phases A, B, C.              |
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| in_altvoltage[0-2]_rms_scale                      | Scale for RMS volt=
age channels.                          |
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| in_altvoltage[0-2]_rms_calibbias                  | RMS offset correct=
ion for voltage channels (VRMSOS reg). |
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| Power measurement related device files            | Description       =
                                       |
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| in_power[0-2]_active_raw                          | Active power measu=
rement for phases A, B, C.             |
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| in_power[0-2]_active_scale                        | Scale for active p=
ower channels.                         |
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| in_power[0-2]_active_calibbias                    | Calibration offset=
 for active power (xWATTOS regs).      |
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| in_power[0-2]_active_calibscale                   | Calibration gain f=
or active power (APGAIN reg).          |
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| in_power[0-2]_reactive_raw                        | Reactive power mea=
surement for phases A, B, C.           |
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| in_power[0-2]_reactive_scale                      | Scale for reactive=
 power channels.                       |
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| in_power[0-2]_reactive_calibbias                  | Calibration offset=
 for reactive power (xVAROS regs).     |
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| in_power[0-2]_apparent_raw                        | Apparent power mea=
surement for phases A, B, C.           |
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| in_power[0-2]_apparent_scale                      | Scale for apparent=
 power channels.                       |
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| in_power[0-2]_powerfactor                         | Power factor for p=
hases A, B, C.                         |
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| Energy measurement related device files           | Description       =
                                       |
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| in_energy[0-2]_active_raw                         | Active energy meas=
urement for phases A, B, C.            |
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| in_energy[0-2]_reactive_raw                       | Reactive energy me=
asurement for phases A, B, C.          |
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| in_energy[0-2]_apparent_raw                       | Apparent energy me=
asurement for phases A, B, C.          |
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
> +| filter_type                  | Waveform buffer filter type (sinc4, sin=
c4+lp).                   |
> ++------------------------------+----------------------------------------=
--------------------------+
> +| filter_type_available        | Available filter types for waveform buf=
fer.                      |
> ++------------------------------+----------------------------------------=
--------------------------+
> +
> +3. Calibration and scaling
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +
> +The ADE9000 provides multiple levels of gain and offset correction:
> +
> +**Calibration Gain (per-channel)**
> +  Fine-tuning calibration gains applied in the digital domain for each c=
hannel type.
> +  Controlled via ``calibscale`` attributes (AIGAIN, AVGAIN, APGAIN regis=
ters).
> +
> +**Calibration Bias (per-channel)**
> +  Hardware calibration offsets applied by the device internally:
> +
> +  - Power measurements: Controlled via ``calibbias`` attributes for powe=
r channels (xWATTOS, xVAROS registers).
> +  - RMS measurements: Controlled via ``calibbias`` attributes for RMS ch=
annels (IRMSOS, VRMSOS registers).
> +
> +  These are internal chip calibrations, not userspace-applied offsets.
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
> +| in_voltage[0-2]_thresh_either_en                  | Zero crossing dete=
ction interrupt (ZXVx)                 |
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| in_altvoltage[0-2]_rms_thresh_rising_en           | RMS swell detectio=
n interrupt (SWELLx)                   |
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| in_altvoltage[0-2]_rms_thresh_rising_value        | RMS swell threshol=
d (SWELL_LVL register)                 |
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| in_altvoltage[0-2]_rms_thresh_falling_en          | RMS sag/dip detect=
ion interrupt (DIPx)                   |
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| in_altvoltage[0-2]_rms_thresh_falling_value       | RMS sag/dip thresh=
old (DIP_LVL register)                 |
> ++---------------------------------------------------+-------------------=
---------------------------------------+
> +| in_current[0-2]_thresh_either_en                  | Current zero cross=
ing detection interrupt (ZXIx)         |
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
> +Configure RMS voltage event thresholds (requires interrupts):
> +
> +.. code-block:: bash
> +
> +        # Set RMS sag detection threshold
> +        root:/sys/bus/iio/devices/iio:device0> echo 180000 > events/in_a=
ltvoltage0_rms_thresh_falling_value
> +        # Enable RMS sag detection
> +        root:/sys/bus/iio/devices/iio:device0> echo 1 > events/in_altvol=
tage0_rms_thresh_falling_en
> +
> +        # Set RMS swell detection threshold
> +        root:/sys/bus/iio/devices/iio:device0> echo 260000 > events/in_a=
ltvoltage0_rms_thresh_rising_value
> +        # Enable RMS swell detection
> +        root:/sys/bus/iio/devices/iio:device0> echo 1 > events/in_altvol=
tage0_rms_thresh_rising_en
> +
> +8. IIO Interfacing Tools
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +See ``Documentation/iio/iio_tools.rst`` for the description of the avail=
able IIO
> +interfacing tools.
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


