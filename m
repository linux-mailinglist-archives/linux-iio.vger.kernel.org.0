Return-Path: <linux-iio+bounces-27279-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E0BCD4390
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 19:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88FFD30084E6
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 18:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744C63019DC;
	Sun, 21 Dec 2025 18:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2Mj/XfA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D1C3A1E72;
	Sun, 21 Dec 2025 18:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766340029; cv=none; b=JxLCqcGfwxJ2qQO31BzRZTkuDuBmXrwk91IRcQ1xsvc3wRibj1+CkBaqD6BwWHzzegZ2Tr4eyNERwOo3CO6bFL53b4v149MvtFo4Z6us8kCYpgaoBgNfh7Lsh5x0HnQ6bzMZDUmV0H7w8n1JfDh66PV9sxcvGG/IRKDimucQ/6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766340029; c=relaxed/simple;
	bh=AglZt3tZupYqSNzCTUmoK+7PJBBPWAQ9WujwdD2rvyw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nxTJnIqGVe3mRyw4LKh/MmqESexk4pWH4u4TMKgFlbTa/yFfAgD0gvQ15YqZozk9ETxqFXFP7ztf6cnynQ7mq89K0VOF0/iLKGFcXpNa8Tgs5sa7aPJdKgqukP9zbB9D0RTT7oj3NM63HwPo8Vvs9wzT3TNtkPhWf2XzH9bYyM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2Mj/XfA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA155C4CEFB;
	Sun, 21 Dec 2025 18:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766340028;
	bh=AglZt3tZupYqSNzCTUmoK+7PJBBPWAQ9WujwdD2rvyw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U2Mj/XfAF2jxDUAT6ljm+JY/nJFEQgNBDAe7Izq3oQS0bdUKhOLvRg1DukbnbwH3E
	 QeVGGGLQbOYnHo/qJi01nIRBCbBBd4Oe6dTj9RlUug4v/Gjxktcfn4jJU1lMQWVM52
	 CwUu3aXFh3g306az9E9X/RXsFrd0m9uuVPehAXZ07OBtFzhZ+4c6ybs+POgKZ29dof
	 5MzFcU6kqDPM1NnIKmAmWtB74CqEd/vn8tMupqzsnE4wgAq168ASMU+fmhpC6cCVCh
	 fnE1OThQ79Jz+7fuiL6huKcLHz01QRJcZckTgX9dLQr+YeSbfKfI1JyiXOUcnYsNtg
	 NYhPe84wDkS3Q==
Date: Sun, 21 Dec 2025 18:00:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2 5/6] docs: iio: add documentation for adf41513 driver
Message-ID: <20251221180018.488cbac5@jic23-huawei>
In-Reply-To: <20251219-adf41513-iio-driver-v2-5-be29a83d5793@analog.com>
References: <20251219-adf41513-iio-driver-v2-0-be29a83d5793@analog.com>
	<20251219-adf41513-iio-driver-v2-5-be29a83d5793@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 19 Dec 2025 12:34:52 +0000
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org=
> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
>=20
> add documentation for ADF41513 driver which describes the device
Add

> driver files and shows how userspace may consume the ABI for various
> tasks
.

>=20
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
>  Documentation/iio/adf41513.rst | 255 +++++++++++++++++++++++++++++++++++=
++++++
>  Documentation/iio/index.rst    |   1 +
>  MAINTAINERS                    |   1 +
>  3 files changed, 257 insertions(+)
>=20
> diff --git a/Documentation/iio/adf41513.rst b/Documentation/iio/adf41513.=
rst
> new file mode 100644
> index 000000000000..568e71bc21e4
> --- /dev/null
> +++ b/Documentation/iio/adf41513.rst
> @@ -0,0 +1,255 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +ADF41513 driver
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +This driver supports Analog Devices' ADF41513 and ADF41510 PLL frequency
> +synthesizers on SPI bus.
Avoid lists of part numbers inline with text. Those become very noisy
if more parts are added in future. Given next block has bullet point list
of parts no need to mention them here.  Instead use
ADF41513 and similar SPI PLL frequency synthesizers.
> +
> +1. Supported devices
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +* `ADF41510 <https://www.analog.com/ADF41510>`_
> +* `ADF41513 <https://www.analog.com/ADF41513>`_
> +
> +The ADF41513 is an ultralow noise frequency synthesizer that can be used=
 to
> +implement local oscillators (LOs) as high as 26.5 GHz in the upconversio=
n and
> +downconversion sections of wireless receivers and transmitters. The ADF4=
1510
> +is a similar device that supports frequencies up to 10 GHz.
> +
> +Both devices support integer-N and fractional-N operation modes, providi=
ng
> +excellent phase noise performance and flexible frequency generation
> +capabilities.
> +
> +Key Features:
> +
> +- **ADF41513**: 1 GHz to 26.5 GHz frequency range
> +- **ADF41510**: 1 GHz to 10 GHz frequency range
Keep them in alphanumeric order. Makes it easier to add more parts by
keeping the placement obvious.

> +- Integer-N and fractional-N operation modes
> +- Ultra-low phase noise (-235 dBc/Hz integer-N, -231 dBc/Hz fractional-N)
> +- High maximum PFD frequency (250 MHz integer-N, 125 MHz fractional-N)
> +- 25-bit fixed modulus or 49-bit variable modulus fractional modes
> +- Programmable charge pump currents with 16x range
> +- Digital lock detect functionality
> +- Phase resync capability for consistent output phase
> +
> +2. Device attributes
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The ADF41513 driver provides the following IIO extended attributes for
> +frequency control and monitoring:
> +
> +Each IIO device has a device folder under ``/sys/bus/iio/devices/iio:dev=
iceX``,
> +where X is the IIO index of the device. Under these folders reside a set=
 of
> +device files that provide access to the synthesizer's functionality.
> +
> +The following table shows the ADF41513 related device files:
> +
> ++----------------------+------------------------------------------------=
-------+
> +| Device file          | Description                                    =
       |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D+
> +| frequency            | RF output frequency control and readback (Hz)  =
       |
> ++----------------------+------------------------------------------------=
-------+
> +| frequency_resolution | Target frequency resolution control (Hz)       =
       |
> ++----------------------+------------------------------------------------=
-------+
> +| refin_frequency      | Reference input frequency control and readback =
(Hz)   |
> ++----------------------+------------------------------------------------=
-------+
> +| powerdown            | Power management control (0=3Dactive, 1=3Dpower=
 down)     |
> ++----------------------+------------------------------------------------=
-------+
> +| phase                | RF output phase adjustment and readback (degree=
s)     |
> ++----------------------+------------------------------------------------=
-------+
> +
> +2.1 Frequency Control
> +----------------------
> +
> +The ``frequency`` attribute controls the RF output frequency with sub-Hz
> +precision. The driver automatically selects between integer-N and fracti=
onal-N
> +modes to achieve the requested frequency with the best possible phase no=
ise
> +performance.
> +
> +**Supported ranges:**
> +
> +- **ADF41513**: 1,000,000,000 Hz to 26,500,000,000 Hz (1 GHz to 26.5 GHz)
> +- **ADF41510**: 1,000,000,000 Hz to 10,000,000,000 Hz (1 GHz to 10 GHz)
Alpha numeric order here as well.

> +
> +The frequency is specified in Hz, for sub-Hz precision use decimal notat=
ion.
> +For example, 12.102 GHz would be written as "12102000000.000000".
> +
> +2.2 Frequency Resolution Control
> +--------------------------------
> +
> +The ``frequency_resolution`` attribute controls the target frequency res=
olution
> +that the driver attempts to achieve. This affects the choice between int=
eger-N
> +and fractional-N modes, including fixed modulus (25-bit) and variable mo=
dulus
> +(49-bit) fractional-N modes:
> +
> +- **Integer-N**: Resolution =3D f_PFD
> +- **Fixed modulus**: Resolution =3D f_PFD / 2^25 (~3 Hz with 100 MHz PFD)
> +- **Variable modulus**: Resolution =3D f_PFD / 2^49 (=C2=B5Hz resolution=
 possible)
> +
> +Default resolution is 1 Hz (1,000,000 =C2=B5Hz).
> +
> +2.3 Reference Input Control
> +---------------------------
> +
> +The ``refin_frequency`` attribute allows control of the reference input
> +frequency when using a programmable reference clock. The supported range=
 is
> +10 MHz to 800 MHz.

I'm not really sure why need this as opposed to having a standard clock
provide it.  What's the use case?

> +
> +2.4 Power Management
> +--------------------
> +
> +The ``powerdown`` attribute provides software power control:
> +
> +- **0**: Device active and operational
> +- **1**: Device in power-down mode (low power consumption)

This one is fairly standard for DACs etc. I'd not necessarily bother
documenting it specifically here.

> +
> +2.5 Phase adjustment
> +--------------------
> +
> +The ``phase`` attribute allows adjustment of the output phase in degrees.

As per driver feedback, I don't think this is compliant with existing ABI.

> +Setting this attribute enables phase adjustment. It can be set from 0 to=
 360
> +degrees. Reading this attribute returns the current phase offset of the =
output
> +signal. To create a consistent phase relationship with the reference sig=
nal,
> +the phase resync feature needs to be enabled by setting a non-zero value=
 to the
> +``adi,phase-resync-period-ns`` device property, which triggers a phase
> +resynchronization after locking is achieved.
> +
> +3. Operating modes
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +3.1 Integer-N Mode
> +------------------
> +
> +When the requested frequency can be achieved as an integer multiple of t=
he PFD
> +frequency (within the specified resolution tolerance), the driver automa=
tically
> +selects integer-N mode for optimal phase noise performance.
> +
> +In integer-N mode:
> +
> +- Phase noise: -235 dBc/Hz normalized floor
> +- Frequency resolution: f_PFD (same as PFD frequency)
> +- Maximum PFD frequency: 250 MHz
> +- Bleed current: Disabled for best performance
> +
> +3.2 Fractional-N Mode
> +---------------------
> +
> +When sub-integer frequency steps are required, the driver automatically =
selects
> +fractional-N mode using either fixed or variable modulus.
> +
> +**Fixed Modulus (25-bit)**:
> +
> +- Used when variable modulus is not required
> +- Resolution: f_PFD / 2^25
> +- Simpler implementation, faster settling
> +
> +**Variable Modulus (49-bit)**:
> +
> +- Used for maximum resolution requirements
> +- Resolution: f_PFD / 2^49 (theoretical)
> +- Exact frequency synthesis capability
> +
> +In fractional-N mode:
> +
> +- Phase noise: -231 dBc/Hz normalized floor
> +- Maximum PFD frequency: 125 MHz
> +- Bleed current: Automatically enabled and optimized
> +- Dithering: Enabled to reduce fractional spurs
> +
> +3.3 Automatic Mode Selection
> +----------------------------
> +
> +The driver automatically selects the optimal operating mode based on:
> +
> +1. **Frequency accuracy requirements**: Determined by frequency_resoluti=
on setting
> +2. **Phase noise optimization**: Integer-N preferred when possible
> +3. **PFD frequency constraints**: Different limits for integer vs fracti=
onal modes
> +4. **Prescaler selection**: Automatic 4/5 vs 8/9 prescaler selection bas=
ed on frequency
> +
> +4. Usage examples
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +4.1 Basic Frequency Setting
> +----------------------------
> +
> +Set output frequency to 12.102 GHz:
> +
> +.. code-block:: bash
> +
> +    root:/sys/bus/iio/devices/iio:device0> echo 12102000000 > out_altvol=
tage0_frequency
> +
> +Read current frequency:
> +
> +.. code-block:: bash
> +
> +    root:/sys/bus/iio/devices/iio:device0> cat out_altvoltage0_frequency
> +    12101999999.582767
> +
> +4.2 High Resolution Frequency Control
> +-------------------------------------
> +
> +Configure for sub-Hz resolution and set a precise frequency:
> +
> +.. code-block:: bash
> +
> +    # Set resolution to 0.1 Hz (100,000 =C2=B5Hz)
> +    root:/sys/bus/iio/devices/iio:device0> echo 0.1 > out_altvoltage0_fr=
equency_resolution
> +
> +    # Set frequency to 12.102 GHz (1 =C2=B5Hz precision)
> +    root:/sys/bus/iio/devices/iio:device0> echo 12102000000 > out_altvol=
tage0_frequency
> +    root:/sys/bus/iio/devices/iio:device0> cat out_altvoltage0_frequency
> +    12101999999.980131
> +
> +4.3 Reference Frequency Control
> +-------------------------------
> +
> +Change reference input frequency (if using programmable reference):
> +
> +.. code-block:: bash
> +
> +    # Set reference to 122.88 MHz
> +    root:/sys/bus/iio/devices/iio:device0> echo 122880000 > out_altvolta=
ge0_refin_frequency
> +
> +    # Verify the change
> +    root:/sys/bus/iio/devices/iio:device0> cat out_altvoltage0_refin_fre=
quency
> +    122880000
> +
> +4.4 Power Management
> +--------------------
> +
> +Power down the device:
> +
> +.. code-block:: bash
> +
> +    root:/sys/bus/iio/devices/iio:device0> echo 1 > out_altvoltage0_powe=
rdown
> +
> +    # Power back up
> +    root:/sys/bus/iio/devices/iio:device0> echo 0 > out_altvoltage0_powe=
rdown

I'd skip this section as being very standard.

> +
> +4.5 PFD Frequency Monitoring
> +----------------------------
> +
> +Read the current PFD frequency:
> +
> +.. code-block:: bash
> +
> +    root:/sys/bus/iio/devices/iio:device0> cat out_altvoltage0_pfd_frequ=
ency

This one isn't standard ABI or in your ABI doc.
Perhaps drop for now?

> +    100000000.000000
> +
> +This shows the PFD is operating at 100 MHz, which means the frequency re=
solution
> +in integer-N mode would be 100 MHz steps.
> +
> +4.6 Monitor Lock Status
> +-----------------------
> +
> +When lock detect GPIO is configured, check if PLL is locked:
> +
> +.. code-block:: bash
> +
> +    # Read frequency - will return error if not locked
> +    root:/sys/bus/iio/devices/iio:device0> cat out_altvoltage0_frequency
> +
> +If the PLL is not locked, the frequency read will return ``-EBUSY`` (Dev=
ice or
> +resource busy).




