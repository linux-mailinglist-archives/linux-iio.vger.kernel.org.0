Return-Path: <linux-iio+bounces-27229-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B316CD1074
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 18:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3C00305C4D9
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 16:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1863363C6C;
	Fri, 19 Dec 2025 16:48:00 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2D3362149;
	Fri, 19 Dec 2025 16:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766162880; cv=none; b=eHo7LXgBpu/1Z+hMXX2ArfOFa/P39D+TK28WtO/n33xmsz40cacNH1ld38fKKLATbvlj9tzZE3Ps9i0EV/W+8gaXSc7zSPrDTfyOnhEAExYUdrNIHL3efwk3ZctZjT16zWBARkK8LYPhnsBCuGELrb8FDQjn3y8CPIXTzZZxPHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766162880; c=relaxed/simple;
	bh=veaI2Hyw5XDkCbLY7TNen/xnQCUK4A9YfVNXGZc4LK4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T411TbTwoyUOTJvrENUD8Ct8vt1wiIPn1gANwYcKP9OiUgFtlW8eGJoeLCE/5LVhOjXBa3gTG4hSm/S2dbrhpsPTu6VMpa2RJp6SaQRb+MmZGqqa4hopCey5hV/6ESlLrLYI0rtDDeVSqA+QPFlrVpstVRkMrXvYiw8Qw4v/qYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dXtk10WVYzJ468s;
	Sat, 20 Dec 2025 00:47:21 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id EC06B40570;
	Sat, 20 Dec 2025 00:47:53 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 19 Dec
 2025 16:47:53 +0000
Date: Fri, 19 Dec 2025 16:47:51 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Janani Sunil <janani.sunil@analog.com>
CC: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
	<Michael.Hennerich@analog.com>, Alexandru Ardelean
	<alexandru.ardelean@analog.com>, Jonathan Cameron <jic23@kernel.org>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 2/3] docs: iio: Add documentation for MAX22007 driver
Message-ID: <20251219164751.000071a1@huawei.com>
In-Reply-To: <20251219-max22007-dev-v1-2-242da2c2b868@analog.com>
References: <20251219-max22007-dev-v1-0-242da2c2b868@analog.com>
	<20251219-max22007-dev-v1-2-242da2c2b868@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri, 19 Dec 2025 16:31:16 +0100
Janani Sunil <janani.sunil@analog.com> wrote:

> Add documentation for MAX22007 driver which describes how the user
> can access the driver using dtoverlays
>=20
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>

Hi Janani,

We've recently had a few comments on whether driver specific docs add value
(for particular drivers, sometimes they definitely do!).  From what I'm
seeing here, I'm not thinking this one needs a document.  Not most drivers
don't have such a file because they make use of standard ABI that is well
documented.  DT stuff always belongs in the dt-binding rather than these
files.  With both those elements gone there isn't much value to this file.
So I'd drop it.  We can easily add a file if something complex shows up
in later patches, that justifies this.

Thanks,

Jonathan

> ---
>  Documentation/iio/index.rst    |   1 +
>  Documentation/iio/max22007.rst | 145 +++++++++++++++++++++++++++++++++++=
++++++
>  MAINTAINERS                    |   1 +
>  3 files changed, 147 insertions(+)
>=20
> diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
> index 315ae37d6fd4..7601bc2882e7 100644
> --- a/Documentation/iio/index.rst
> +++ b/Documentation/iio/index.rst
> @@ -37,4 +37,5 @@ Industrial I/O Kernel Drivers
>     adxl345
>     bno055
>     ep93xx_adc
> +   max22007
>     opt4060
> diff --git a/Documentation/iio/max22007.rst b/Documentation/iio/max22007.=
rst
> new file mode 100644
> index 000000000000..e04c563f1fd0
> --- /dev/null
> +++ b/Documentation/iio/max22007.rst
> @@ -0,0 +1,145 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +MAX22007 driver
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Device driver for Analog Devices Inc. MAX22007 quad-channel industrial D=
AC.
> +The module name is ``max22007``.
> +
> +Supported devices
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +* `MAX22007 <https://www.analog.com/en/products/max22007.html>`_
> +
> +Wiring connections
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The MAX22007 uses a standard SPI interface.
I'd not bother with this section.  Most SPI devices after all use
the standard interface, so we can document this by not documenting anything
else :)

> +
> +Device Tree Configuration
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D

Anything here should be in the dt-binding. As such this section isn't usefu=
l.

> +
> +The device supports both global and per-channel configuration through de=
vice tree.
> +
> +Global Properties:
> +
> +* ``reset-gpios``: GPIO pin for hardware reset (optional, falls back to
> +  software reset if not specified)
> +* ``vdd-supply``: Low-Voltage Power Supply from +2.7V to +5.5V (optional)
> +* ``hvdd-supply``: Positive High-Voltage Power Supply from +8V to (HVSS =
+24V)
> +  for the Output Channels (optional)
> +* ``hvss-supply``: Negative High-Voltage Power Supply from -2V to 0V for=
 the
> +  Output Channels (optional)
> +
> +Per-channel properties:
> +
> +* ``adi,type``: Specify the channel output type - must be either "voltag=
e" or "current" (mandatory)
> +
> +Note: The driver operates in transparent mode (immediate register-to-out=
put updates).
> +Channel mode is determined by the ``adi,type`` property:
> +
> +* ``adi,type =3D "current"``: the channel operates in current mode
> +* ``adi,type =3D "voltage"``: the channel operates in voltage mode
> +
> +Device attributes
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The MAX22007 driver provides IIO DAC interfaces that vary based on the
> +configured channel mode. Each channel appears as a separate IIO device
> +attribute:
> +
> +* ``out_voltage_raw`` (voltage mode channels)
> +* ``out_current_raw`` (current mode channels)
> +* ``out_voltage_scale`` / ``out_current_scale`` (channel scaling factors)
> +* ``out_voltage_powerdown`` / ``out_current_powerdown`` (channel power c=
ontrol)
> +
> +The driver automatically configures the IIO channel type based on the co=
nfigured
> +channel mode from device tree.
This bit feels very standard and so not in need of extra documentation.

> +
> +Power Mode Control
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Each channel provides standard IIO ``powerdown`` attributes for runtime =
power
> +control:
> +
> +* Write ``1`` to power down (disable) the channel output
> +* Write ``0`` to power up (enable) the channel output
> +* Read the attribute to get the current power state (1=3Dpowered down, 0=
=3Dpowered up)
> +
> +This allows individual channels to be powered on/off independently for p=
ower
> +management and safety purposes.

Likewise, this is very standard.

> +
> +Usage Examples
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Setting DAC output values:
> +
> +.. code-block:: bash
> +
> +   # Set channel 0 (voltage mode) to raw value 655 (=E2=89=882V)
> +   # Output is updated immediately in transparent mode
> +   echo 655 > /sys/bus/iio/devices/iio:deviceX/out_voltage0_raw
> +
> +   # Set channel 1 (current mode)
> +   # Output is updated immediately in transparent mode
> +   echo 1024 > /sys/bus/iio/devices/iio:deviceX/out_current1_raw
> +
> +Controlling channel power modes:
> +
> +.. code-block:: bash
> +
> +   # Enable channel 0 (power up)
> +   echo 0 > /sys/bus/iio/devices/iio:deviceX/out_voltage0_powerdown
> +
> +   # Disable channel 1 (power down)
> +   echo 1 > /sys/bus/iio/devices/iio:deviceX/out_current1_powerdown
> +
> +   # Check current power state (0=3Dpowered up, 1=3Dpowered down)
> +   cat /sys/bus/iio/devices/iio:deviceX/out_voltage0_powerdown
> +
> +Reading channel values and scale factors:
> +
> +.. code-block:: bash
> +
> +   # Read raw DAC value
> +   cat /sys/bus/iio/devices/iio:deviceX/out_voltage0_raw
> +
> +   # Read scale factor (volts per LSB)
> +   cat /sys/bus/iio/devices/iio:deviceX/out_voltage0_scale
> +
> +Check available channels:
> +
> +.. code-block:: bash
> +
> +   ls /sys/bus/iio/devices/iio:deviceX/out_*_raw
> +
> +Scale Calculations
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The driver provides accurate scale factors based on the hardware configu=
ration:

This information doesn't need to be provided explicitly.  Anyone who
wonders in detail about it can check the driver. For most users the fact
it obeys the standard ABI rules is eough.

> +
> +**Voltage Mode:**
> +
> +- Scale =3D (5 =C3=97 2.5V) / 4096 =3D 0.003051757 V per LSB
> +- Range: 0V to 12.5V over 12-bit (0-4095)
> +- Formula: Output =3D Raw_Value =C3=97 Scale
> +
> +**Current Mode:**
> +
> +- Scale =3D (2.5V / (2 =C3=97 50=CE=A9)) / 4096 =3D 0.000006103515625 A =
per LSB
> +- Range: 0A to 0.025A over 12-bit (0-4095)
> +- Formula: Output =3D Raw_Value =C3=97 Scale
> +
> +Driver Architecture
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The driver implements:
> +
> +* **CRC8 Error Checking**: Always-enabled CRC8 for SPI data integrity
> +* **Channel Configuration**: Supports per-channel mode and power configu=
ration
> +
> +Channel configuration (voltage/current mode) is set via the ``adi,type``
> +device tree property and cannot be changed dynamically The driver requir=
es
> +proper device tree configuration with mandatory ``adi,type`` property fo=
r each
> +channel.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e1addbd21562..6561455732c9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1599,6 +1599,7 @@ L:	linux-iio@vger.kernel.org
>  S:	Supported
>  W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/iio/dac/adi,max22007.yaml
> +F:	Documentation/iio/max22007.rst
> =20
>  ANALOG DEVICES INC ADA4250 DRIVER
>  M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
>=20


